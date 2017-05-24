GLIB_CFLAGS=$(shell pkg-config --cflags glib-2.0)
  GLIB_LIBS=$(shell pkg-config --libs   glib-2.0)

XLIB_CFLAGS=-I /usr/include/X11

XLIB_LIBS=-L /usr/lib/X11 -lX11 -lXmu

GD_LIBS=-lgd

LIBS=${GLIB_LIBS} ${XLIB_LIBS} ${GD_LIBS}

PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

all: xseticon

xseticon.o: xseticon.c
	gcc -c $^ -o $@ ${GLIB_CFLAGS} ${XLIB_CFLAGS}

xseticon: xseticon.o
	gcc $^ -o $@ ${LIBS}

.PHONY: clean
clean:
	rm -f xseticon.o xseticon

.PHONY: install
install: xseticon
	install -d $(BINDIR)
	install -m 755 xseticon $(BINDIR)
