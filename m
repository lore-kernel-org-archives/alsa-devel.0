From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] add aplaymidi & arecordmidi utils
Date: Mon, 23 Feb 2004 10:18:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231010240.20713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


See man pages for details.


add aplaymidi & arecordmidi utilities

Index: alsa-utils/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/configure.in,v
retrieving revision 1.76
diff -u -r1.76 configure.in
--- alsa-utils/configure.in	26 Jan 2004 19:30:45 -0000	1.76
+++ alsa-utils/configure.in	23 Feb 2004 08:27:54 -0000
@@ -69,4 +69,5 @@
 AC_OUTPUT(Makefile alsactl/Makefile alsamixer/Makefile amidi/Makefile amixer/Makefile \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
-	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile seq/aseqnet/Makefile)
+	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
+	  seq/aplaymidi/Makefile seq/aseqnet/Makefile)
Index: alsa-utils/amidi/amidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/amidi/amidi.1,v
retrieving revision 1.2
diff -u -r1.2 amidi.1
--- alsa-utils/amidi/amidi.1	19 Jan 2004 18:39:12 -0000	1.2
+++ alsa-utils/amidi/amidi.1	23 Feb 2004 08:27:54 -0000
@@ -1,4 +1,4 @@
-.TH AMIDI 1 "18 Jan 2004"
+.TH AMIDI 1 "22 Feb 2004"

 .SH NAME
 amidi \- read from and write to ALSA RawMIDI ports
@@ -16,7 +16,12 @@
 .B amidi
 handles only files containing raw MIDI commands, without timing
 information.
-Standard MIDI (.mid) files are not supported.
+.B amidi
+does not support Standard MIDI (.mid) files, but
+.B aplaymidi(1)
+and
+.B arecordmidi(1)
+do.

 .SH INVOKING
 .B amidi
@@ -68,17 +73,15 @@
 .I -s, --send=filename
 Sends the contents of the specified file to the MIDI port.
 The file must contain raw MIDI commands (e.g. a .syx file);
-you can
-.I not
-use a Standard MIDI (.mid) file for this.
+for Standard MIDI (.mid) files, use
+.B aplaymidi(1).

 .TP
 .I -r, --receive=filename
 Writes data received from the MIDI port into the specified file.
 The file will contain raw MIDI commands (such as in a .syx file);
-this will
-.I not
-create a Standard MIDI (.mid) file.
+to record a Standard MIDI (.mid) file, use
+.B arecordmidi(1).

 .B amidi
 will filter out any Active Sensing bytes (FEh), unless the
@@ -155,6 +158,11 @@
 The
 .I --list-devices
 option pretends that output and input ports are the same.
+
+.SH SEE ALSO
+aplaymidi(1)
+.br
+arecordmidi(1)

 .SH AUTHOR
 Clemens Ladisch <clemens@ladisch.de>
Index: alsa-utils/seq/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/Makefile.am,v
retrieving revision 1.1
diff -u -r1.1 Makefile.am
--- alsa-utils/seq/Makefile.am	4 Jan 2000 12:39:00 -0000	1.1
+++ alsa-utils/seq/Makefile.am	23 Feb 2004 08:27:54 -0000
@@ -1 +1 @@
-SUBDIRS=aconnect aseqnet
+SUBDIRS=aconnect aplaymidi aseqnet
diff -urN ../../oalsa/alsa/alsa-utils/seq/aplaymidi/Makefile.am alsa-utils/seq/aplaymidi/Makefile.am
--- ../../oalsa/alsa/alsa-utils/seq/aplaymidi/Makefile.am	1970-01-01 01:00:00.000000000 +0100
+++ alsa-utils/seq/aplaymidi/Makefile.am	2004-02-23 09:38:11.051239000 +0100
@@ -0,0 +1,5 @@
+INCLUDES = -I$(top_srcdir)/include
+EXTRA_DIST = aplaymidi.1 arecordmidi.1
+
+bin_PROGRAMS = aplaymidi arecordmidi
+man_MANS = aplaymidi.1 arecordmidi.1
diff -urN ../../oalsa/alsa/alsa-utils/seq/aplaymidi/aplaymidi.1 alsa-utils/seq/aplaymidi/aplaymidi.1
--- ../../oalsa/alsa/alsa-utils/seq/aplaymidi/aplaymidi.1	1970-01-01 01:00:00.000000000 +0100
+++ alsa-utils/seq/aplaymidi/aplaymidi.1	2004-02-23 09:38:11.061243000 +0100
@@ -0,0 +1,55 @@
+.TH APLAYMIDI 1 "15 Feb 2004"
+
+.SH NAME
+aplaymidi \- play Standard MIDI Files
+
+.SH SYNOPSIS
+.B aplaymidi
+-p client:port[,...] [-d delay] midifile ...
+
+.SH DESCRIPTION
+.B aplaymidi
+is a command-line utility that plays the specified MIDI file(s) to one
+or more ALSA sequencer ports.
+
+.SH OPTIONS
+
+.TP
+.I -h, --help
+Prints a list of options.
+
+.TP
+.I -V, --version
+Prints the current version.
+
+.TP
+.I -l, --list
+Prints a list of possible output ports.
+
+.TP
+.I -p, --port=client:port,...
+Sets the sequencer port(s) to which the events in the MIDI file(s) are
+sent.
+
+A client can be specified by its number, its name, or a prefix of its
+name. A port is specified by its number; for port 0 of a client, the
+":0" part of the port specification can be omitted.
+
+For compatibility with
+.B pmidi(1),
+the port specification is taken from the
+.I ALSA_OUTPUT_PORTS
+environment variable if none is given on the command line.
+
+.TP
+.I -d, --delay=seconds
+Specifies how long to wait after the end of each MIDI file,
+to allow the last notes to die away.
+
+.SH SEE ALSO
+pmidi(1)
+.br
+playmidi(1)
+
+.SH AUTHOR
+Clemens Ladisch <clemens@ladisch.de>
diff -urN ../../oalsa/alsa/alsa-utils/seq/aplaymidi/aplaymidi.c alsa-utils/seq/aplaymidi/aplaymidi.c
--- ../../oalsa/alsa/alsa-utils/seq/aplaymidi/aplaymidi.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-utils/seq/aplaymidi/aplaymidi.c	2004-02-23 09:38:11.091239000 +0100
@@ -0,0 +1,890 @@
+/*
+ * aplaymidi.c - play Standard MIDI Files to sequencer port(s)
+ *
+ * Copyright (c) 2004 Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+/* TODO: sequencer queue timer selection */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <alsa/asoundlib.h>
+#include "aconfig.h"
+#include "version.h"
+
+/*
+ * A MIDI event after being parsed/loaded from the file.
+ * There could be made a case for using snd_seq_event_t instead.
+ */
+struct event {
+	struct event *next;		/* linked list */
+
+	unsigned char type;		/* SND_SEQ_EVENT_xxx */
+	unsigned char port;		/* port index */
+	unsigned int tick;
+	union {
+		unsigned char d[3];	/* channel and data bytes */
+		int tempo;
+		unsigned int length;	/* length of sysex data */
+	} data;
+	unsigned char sysex[0];
+};
+
+struct track {
+	struct event *first_event;	/* list of all events in this track */
+	int end_tick;			/* length of this track */
+
+	struct event *current_event;	/* used while loading and playing */
+};
+
+static snd_seq_t *seq;
+static int client;
+static int port_count;
+static snd_seq_addr_t *ports;
+static int queue;
+static int end_delay = 2;
+static const char *file_name;
+static FILE *file;
+static int file_offset;		/* current offset in input file */
+static int num_tracks;
+static struct track *tracks;
+static int smpte_timing;
+
+/* prints an error message to stderr */
+static void errormsg(const char *msg, ...)
+{
+	va_list ap;
+
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+}
+
+/* prints an error message to stderr, and dies */
+static void fatal(const char *msg, ...)
+{
+	va_list ap;
+
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	exit(EXIT_FAILURE);
+}
+
+/* memory allocation error handling */
+static void check_mem(void *p)
+{
+	if (!p)
+		fatal("Out of memory");
+}
+
+/* error handling for ALSA functions */
+static void check_snd(const char *operation, int err)
+{
+	if (err < 0)
+		fatal("Cannot %s - %s", operation, snd_strerror(err));
+}
+
+static void init_seq(void)
+{
+	int err;
+	snd_seq_client_info_t *info;
+
+	/* open sequencer */
+	err = snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
+	check_snd("open sequencer", err);
+
+	/* set our name (otherwise it's "Client-xxx") */
+	err = snd_seq_set_client_name(seq, "aplaymidi");
+	check_snd("set client name", err);
+
+	/* find out who we actually are */
+	client = snd_seq_client_id(seq);
+	check_snd("get client id", client);
+}
+
+/* parses one or more port addresses from the string */
+static void parse_ports(const char *arg)
+{
+	char *buf, *s, *port_name;
+	int err;
+
+	/* make a copy of the string because we're going to modify it */
+	buf = strdup(arg);
+	check_mem(buf);
+
+	for (port_name = s = buf; s; port_name = s + 1) {
+		/* Assume that ports are separated by commas.  We don't use
+		 * spaces because those are valid in client names. */
+		s = strchr(port_name, ',');
+		if (s)
+			*s = '\0';
+
+		++port_count;
+		ports = realloc(ports, port_count * sizeof(snd_seq_addr_t));
+		check_mem(ports);
+
+		err = snd_seq_parse_address(seq, &ports[port_count - 1], port_name);
+		if (err < 0)
+			fatal("Invalid port %s - %s", port_name, snd_strerror(err));
+	}
+
+	free(buf);
+}
+
+static void create_source_port(void)
+{
+	snd_seq_port_info_t *pinfo;
+	int err;
+
+	snd_seq_port_info_alloca(&pinfo);
+
+	/* the first created port is 0 anyway, but let's make sure ... */
+	snd_seq_port_info_set_port(pinfo, 0);
+	snd_seq_port_info_set_port_specified(pinfo, 1);
+
+	snd_seq_port_info_set_name(pinfo, "aplaymidi");
+
+	snd_seq_port_info_set_capability(pinfo, 0); /* sic */
+	snd_seq_port_info_set_type(pinfo,
+				   SND_SEQ_PORT_TYPE_MIDI_GENERIC |
+				   SND_SEQ_PORT_TYPE_APPLICATION);
+
+	err = snd_seq_create_port(seq, pinfo);
+	check_snd("create port", err);
+}
+
+static void create_queue(void)
+{
+	queue = snd_seq_alloc_named_queue(seq, "aplaymidi");
+	check_snd("create queue", queue);
+	/* the queue is now locked, which is just fine */
+}
+
+static void connect_ports(void)
+{
+	int i, err;
+
+	/*
+	 * We send MIDI events with explicit destination addresses, so we don't
+	 * need any connections to the playback ports.  But we connect to those
+	 * anyway to force any underlying RawMIDI ports to remain open while
+	 * we're playing - otherwise, ALSA would reset the port after every
+	 * event.
+	 */
+	for (i = 0; i < port_count; ++i) {
+		err = snd_seq_connect_to(seq, 0, ports[i].client, ports[i].port);
+		if (err < 0)
+			fatal("Cannot connect to port %d:%d - %s",
+			      ports[i].client, ports[i].port, snd_strerror(err));
+	}
+}
+
+static int read_byte(void)
+{
+	++file_offset;
+	return getc(file);
+}
+
+/* reads a little-endian 32-bit integer */
+static int read_32_le(void)
+{
+	int value;
+	value = read_byte();
+	value |= read_byte() << 8;
+	value |= read_byte() << 16;
+	value |= read_byte() << 24;
+	return !feof(file) ? value : -1;
+}
+
+/* reads a 4-character identifier */
+static int read_id(void)
+{
+	return read_32_le();
+}
+#define MAKE_ID(c1, c2, c3, c4) ((c1) | ((c2) << 8) | ((c3) << 16) | ((c4) << 24))
+
+/* reads a fixed-size big-endian number */
+static int read_int(int bytes)
+{
+	int c, value = 0;
+
+	do {
+		c = read_byte();
+		if (c == EOF)
+			return -1;
+		value = (value << 8) | c;
+	} while (--bytes);
+	return value;
+}
+
+/* reads a variable-length number */
+static int read_var(void)
+{
+	int value, c;
+
+	c = read_byte();
+	value = c & 0x7f;
+	if (c & 0x80) {
+		c = read_byte();
+		value = (value << 7) | (c & 0x7f);
+		if (c & 0x80) {
+			c = read_byte();
+			value = (value << 7) | (c & 0x7f);
+			if (c & 0x80) {
+				c = read_byte();
+				value = (value << 7) | c;
+				if (c & 0x80)
+					return -1;
+			}
+		}
+	}
+	return !feof(file) ? value : -1;
+}
+
+/* allocates a new event */
+static struct event *new_event(struct track *track, int sysex_length)
+{
+	struct event *event;
+
+	event = malloc(sizeof(struct event) + sysex_length);
+	check_mem(event);
+
+	event->next = NULL;
+
+	/* append at the end of the track's linked list */
+	if (track->current_event)
+		track->current_event->next = event;
+	else
+		track->first_event = event;
+	track->current_event = event;
+
+	return event;
+}
+
+static void skip(int bytes)
+{
+	while (bytes > 0)
+		read_byte(), --bytes;
+}
+
+/* reads one complete track from the file */
+static int read_track(struct track *track, int track_end)
+{
+	int tick = 0;
+	unsigned char last_cmd = 0;
+	unsigned char port = 0;
+
+	/* the current file position is after the track ID and length */
+	while (file_offset < track_end) {
+		unsigned char cmd;
+		struct event *event;
+		int delta_ticks, len, c;
+
+		delta_ticks = read_var();
+		if (delta_ticks < 0)
+			break;
+		tick += delta_ticks;
+
+		c = read_byte();
+		if (c < 0)
+			break;
+
+		if (c & 0x80) {
+			/* have command */
+			cmd = c;
+			if (cmd < 0xf0)
+				last_cmd = cmd;
+		} else {
+			/* running status */
+			ungetc(c, file);
+			file_offset--;
+			cmd = last_cmd;
+			if (!cmd)
+				goto _error;
+		}
+
+		switch (cmd >> 4) {
+			/* maps SMF events to ALSA sequencer events */
+			static unsigned char cmd_type[] = {
+				[0x8] = SND_SEQ_EVENT_NOTEOFF,
+				[0x9] = SND_SEQ_EVENT_NOTEON,
+				[0xa] = SND_SEQ_EVENT_KEYPRESS,
+				[0xb] = SND_SEQ_EVENT_CONTROLLER,
+				[0xc] = SND_SEQ_EVENT_PGMCHANGE,
+				[0xd] = SND_SEQ_EVENT_CHANPRESS,
+				[0xe] = SND_SEQ_EVENT_PITCHBEND
+			};
+
+		case 0x8: /* channel msg with 2 parameter bytes */
+		case 0x9:
+		case 0xa:
+		case 0xb:
+		case 0xe:
+			event = new_event(track, 0);
+			event->type = cmd_type[cmd >> 4];
+			event->port = port;
+			event->tick = tick;
+			event->data.d[0] = cmd & 0x0f;
+			event->data.d[1] = read_byte() & 0x7f;
+			event->data.d[2] = read_byte() & 0x7f;
+			break;
+
+		case 0xc: /* channel msg with 1 parameter byte */
+		case 0xd:
+			event = new_event(track, 0);
+			event->type = cmd_type[cmd >> 4];
+			event->port = port;
+			event->tick = tick;
+			event->data.d[0] = cmd & 0x0f;
+			event->data.d[1] = read_byte() & 0x7f;
+			break;
+
+		case 0xf:
+			switch (cmd) {
+			case 0xf0: /* sysex */
+			case 0xf7: /* continued sysex, or escaped commands */
+				len = read_var();
+				if (len < 0)
+					goto _error;
+				if (cmd == 0xf0)
+					++len;
+				event = new_event(track, len);
+				event->type = SND_SEQ_EVENT_SYSEX;
+				event->port = port;
+				event->tick = tick;
+				event->data.length = len;
+				if (cmd == 0xf0) {
+					event->sysex[0] = 0xf0;
+					c = 1;
+				} else {
+					c = 0;
+				}
+				for (; c < len; ++c)
+					event->sysex[c] = read_byte();
+				break;
+
+			case 0xff: /* meta event */
+				c = read_byte();
+				len = read_var();
+				if (len < 0)
+					goto _error;
+
+				switch (c) {
+				case 0x21: /* port number */
+					if (len < 1)
+						goto _error;
+					port = read_byte() % port_count;
+					skip(len - 1);
+					break;
+
+				case 0x2f: /* end of track */
+					track->end_tick = tick;
+					skip(track_end - file_offset);
+					return 1;
+
+				case 0x51: /* tempo */
+					if (len < 3)
+						goto _error;
+					if (smpte_timing) {
+						/* SMPTE timing doesn't change */
+						skip(len);
+					} else {
+						event = new_event(track, 0);
+						event->type = SND_SEQ_EVENT_TEMPO;
+						event->port = port;
+						event->tick = tick;
+						event->data.tempo = read_byte() << 16;
+						event->data.tempo |= read_byte() << 8;
+						event->data.tempo |= read_byte();
+						skip(len - 3);
+					}
+					break;
+
+				default: /* ignore all other meta events */
+					skip(len);
+					break;
+				}
+				break;
+
+			default: /* invalid Fx command */
+				goto _error;
+			}
+			break;
+
+		default: /* cannot happen */
+			goto _error;
+		}
+	}
+_error:
+	errormsg("%s: invalid MIDI data (offset %#x)", file_name, file_offset);
+	return 0;
+}
+
+/* reads an entire MIDI file */
+static int read_smf(void)
+{
+	int header_len, type, time_division, i, err;
+	snd_seq_queue_tempo_t *queue_tempo;
+
+	/* the curren position is immediately after the "MThd" id */
+	header_len = read_int(4);
+	if (header_len < 6) {
+invalid_format:
+		errormsg("%s: invalid file format", file_name);
+		return 0;
+	}
+
+	type = read_int(2);
+	if (type != 0 && type != 1) {
+		errormsg("%s: type %d format is not supported", file_name, type);
+		return 0;
+	}
+
+	num_tracks = read_int(2);
+	if (num_tracks < 1 || num_tracks > 1000) {
+		errormsg("%s: invalid number of tracks (%d)", file_name, num_tracks);
+		num_tracks = 0;
+		return 0;
+	}
+	tracks = calloc(num_tracks, sizeof(struct track));
+	if (!tracks) {
+		errormsg("out of memory");
+		num_tracks = 0;
+		return 0;
+	}
+
+	time_division = read_int(2);
+	if (time_division < 0)
+		goto invalid_format;
+
+	/* interpret and set tempo */
+	snd_seq_queue_tempo_alloca(&queue_tempo);
+	smpte_timing = !!(time_division & 0x8000);
+	if (!smpte_timing) {
+		/* time_division is ticks per quarter */
+		snd_seq_queue_tempo_set_tempo(queue_tempo, 500000); /* default: 120 bpm */
+		snd_seq_queue_tempo_set_ppq(queue_tempo, time_division);
+	} else {
+		/* upper byte is negative frames per second */
+		i = 0x80 - ((time_division >> 8) & 0x7f);
+		/* lower byte is ticks per frame */
+		time_division &= 0xff;
+		/* now pretend that we have quarter-note based timing */
+		switch (i) {
+		case 24:
+			snd_seq_queue_tempo_set_tempo(queue_tempo, 500000);
+			snd_seq_queue_tempo_set_ppq(queue_tempo, 12 * time_division);
+			break;
+		case 25:
+			snd_seq_queue_tempo_set_tempo(queue_tempo, 400000);
+			snd_seq_queue_tempo_set_ppq(queue_tempo, 10 * time_division);
+			break;
+		case 29: /* 30 drop-frame */
+			snd_seq_queue_tempo_set_tempo(queue_tempo, 100000000);
+			snd_seq_queue_tempo_set_ppq(queue_tempo, 2997 * time_division);
+			break;
+		case 30:
+			snd_seq_queue_tempo_set_tempo(queue_tempo, 500000);
+			snd_seq_queue_tempo_set_ppq(queue_tempo, 15 * time_division);
+			break;
+		default:
+			errormsg("%s: invalid number of SMPTE frames per second (%d)",
+				 file_name, i);
+			return 0;
+		}
+	}
+	err = snd_seq_set_queue_tempo(seq, queue, queue_tempo);
+	if (err < 0) {
+		errormsg("Cannot set queue tempo (%u/%i)",
+			 snd_seq_queue_tempo_get_tempo(queue_tempo),
+			 snd_seq_queue_tempo_get_ppq(queue_tempo));
+		return 0;
+	}
+
+	/* read tracks */
+	for (i = 0; i < num_tracks; ++i) {
+		int len;
+
+		/* search for MTrk chunk */
+		for (;;) {
+			int id = read_id();
+			len = read_int(4);
+			if (feof(file)) {
+				errormsg("%s: unexpected end of file", file_name);
+				return 0;
+			}
+			if (len < 0 || len >= 0x10000000) {
+				errormsg("%s: invalid chunk length %d", file_name, len);
+				return 0;
+			}
+			if (id == MAKE_ID('M', 'T', 'r', 'k'))
+				break;
+			skip(len);
+		}
+		if (!read_track(&tracks[i], file_offset + len))
+			return 0;
+	}
+	return 1;
+}
+
+static int read_riff(void)
+{
+	/* skip file length */
+	read_byte();
+	read_byte();
+	read_byte();
+	read_byte();
+
+	/* check file type ("RMID" = RIFF MIDI) */
+	if (read_id() != MAKE_ID('R', 'M', 'I', 'D')) {
+invalid_format:
+		errormsg("%s: invalid file format", file_name);
+		return 0;
+	}
+	/* search for "data" chunk */
+	for (;;) {
+		int id = read_id();
+		int len = read_32_le();
+		if (feof(file)) {
+data_not_found:
+			errormsg("%s: data chunk not found", file_name);
+			return 0;
+		}
+		if (id == MAKE_ID('d', 'a', 't', 'a'))
+			break;
+		if (len < 0)
+			goto data_not_found;
+		skip((len + 1) & ~1);
+	}
+	/* the "data" chunk must contain data in SMF format */
+	if (read_id() != MAKE_ID('M', 'T', 'h', 'd'))
+		goto invalid_format;
+	return read_smf();
+}
+
+static void cleanup_file_data(void)
+{
+	int i;
+	struct event *event;
+
+	for (i = 0; i < num_tracks; ++i) {
+		event = tracks[i].first_event;
+		while (event) {
+			struct event *next = event->next;
+			free(event);
+			event = next;
+		}
+	}
+	num_tracks = 0;
+	free(tracks);
+	tracks = NULL;
+}
+
+static void play_midi(void)
+{
+	snd_seq_event_t ev;
+	int i, max_tick, err;
+
+	/* calculate length of the entire file */
+	max_tick = -1;
+	for (i = 0; i < num_tracks; ++i) {
+		if (tracks[i].end_tick > max_tick)
+			max_tick = tracks[i].end_tick;
+	}
+
+	/* initialize current position in each track */
+	for (i = 0; i < num_tracks; ++i)
+		tracks[i].current_event = tracks[i].first_event;
+
+	/* common settings for all our events */
+	snd_seq_ev_clear(&ev);
+	ev.queue = queue;
+	ev.source.port = 0;
+	ev.flags = SND_SEQ_TIME_STAMP_TICK;
+
+	err = snd_seq_start_queue(seq, queue, NULL);
+	check_snd("start queue", err);
+	/* The queue won't be started until the START_QUEUE event is
+	 * actually drained to the kernel, which is exactly what we want. */
+
+	for (;;) {
+		struct event* event = NULL;
+		struct track* event_track = NULL;
+		int i, min_tick = max_tick + 1;
+
+		/* search next event */
+		for (i = 0; i < num_tracks; ++i) {
+			struct track *track = &tracks[i];
+			struct event *e2 = track->current_event;
+			if (e2 && e2->tick < min_tick) {
+				min_tick = e2->tick;
+				event = e2;
+				event_track = track;
+			}
+		}
+		if (!event)
+			break; /* end of song reached */
+
+		/* advance pointer to next event */
+		event_track->current_event = event->next;
+
+		/* output the event */
+		ev.type = event->type;
+		ev.time.tick = event->tick;
+		ev.dest = ports[event->port];
+		switch (ev.type) {
+		case SND_SEQ_EVENT_NOTEON:
+		case SND_SEQ_EVENT_NOTEOFF:
+		case SND_SEQ_EVENT_KEYPRESS:
+			snd_seq_ev_set_fixed(&ev);
+			ev.data.note.channel = event->data.d[0];
+			ev.data.note.note = event->data.d[1];
+			ev.data.note.velocity = event->data.d[2];
+			break;
+		case SND_SEQ_EVENT_CONTROLLER:
+			snd_seq_ev_set_fixed(&ev);
+			ev.data.control.channel = event->data.d[0];
+			ev.data.control.param = event->data.d[1];
+			ev.data.control.value = event->data.d[2];
+			break;
+		case SND_SEQ_EVENT_PGMCHANGE:
+		case SND_SEQ_EVENT_CHANPRESS:
+			snd_seq_ev_set_fixed(&ev);
+			ev.data.control.channel = event->data.d[0];
+			ev.data.control.value = event->data.d[1];
+			break;
+		case SND_SEQ_EVENT_PITCHBEND:
+			snd_seq_ev_set_fixed(&ev);
+			ev.data.control.channel = event->data.d[0];
+			ev.data.control.value =
+				((event->data.d[1]) |
+				 ((event->data.d[2]) << 7)) - 0x2000;
+			break;
+		case SND_SEQ_EVENT_SYSEX:
+			snd_seq_ev_set_variable(&ev, event->data.length,
+						event->sysex);
+			break;
+		case SND_SEQ_EVENT_TEMPO:
+			snd_seq_ev_set_fixed(&ev);
+			ev.dest.client = SND_SEQ_CLIENT_SYSTEM;
+			ev.dest.port = SND_SEQ_PORT_SYSTEM_TIMER;
+			ev.data.queue.queue = queue;
+			ev.data.queue.param.value = event->data.tempo;
+			break;
+		default:
+			fatal("Invalid event type %d!", ev.type);
+		}
+
+		/* this blocks when the output pool has been filled */
+		err = snd_seq_event_output(seq, &ev);
+		check_snd("output event", err);
+	}
+
+	/* schedule queue stop at end of song */
+	snd_seq_ev_set_fixed(&ev);
+	ev.type = SND_SEQ_EVENT_STOP;
+	ev.time.tick = max_tick;
+	ev.dest.client = SND_SEQ_CLIENT_SYSTEM;
+	ev.dest.port = SND_SEQ_PORT_SYSTEM_TIMER;
+	ev.data.queue.queue = queue;
+	err = snd_seq_event_output(seq, &ev);
+	check_snd("output event", err);
+
+	/* make sure that the sequencer sees all our events */
+	err = snd_seq_drain_output(seq);
+	check_snd("drain output", err);
+
+	/*
+	 * There are three possibilities how to wait until all events have
+	 * been played:
+	 * 1) send an event back to us (like pmidi does), and wait for it;
+	 * 2) wait for the EVENT_STOP notification for our queue which is sent
+	 *    by the system timer port (this would require a subscription);
+	 * 3) wait until the output pool is empty.
+	 * The last is the simplest.
+	 */
+	err = snd_seq_sync_output_queue(seq);
+	check_snd("sync output", err);
+
+	/* give the last notes time to die away */
+	if (end_delay > 0)
+		sleep(end_delay);
+}
+
+static void play_file(void)
+{
+	int ok;
+
+	if (!strcmp(file_name, "-"))
+		file = stdin;
+	else
+		file = fopen(file_name, "rb");
+	if (!file) {
+		errormsg("Cannot open %s - %s", file_name, strerror(errno));
+		return;
+	}
+
+	file_offset = 0;
+	ok = 0;
+
+	switch (read_id()) {
+	case MAKE_ID('M', 'T', 'h', 'd'):
+		ok = read_smf();
+		break;
+	case MAKE_ID('R', 'I', 'F', 'F'):
+		ok = read_riff();
+		break;
+	default:
+		errormsg("%s is not a Standard MIDI File", file_name);
+		break;
+	}
+
+	if (file != stdin)
+		fclose(file);
+
+	if (ok)
+		play_midi();
+
+	cleanup_file_data();
+}
+
+static void list_ports(void)
+{
+	snd_seq_client_info_t *cinfo;
+	snd_seq_port_info_t *pinfo;
+
+	snd_seq_client_info_alloca(&cinfo);
+	snd_seq_port_info_alloca(&pinfo);
+
+	puts(" Port    Client name                      Port name");
+
+	snd_seq_client_info_set_client(cinfo, -1);
+	while (snd_seq_query_next_client(seq, cinfo) >= 0) {
+		int client = snd_seq_client_info_get_client(cinfo);
+
+		snd_seq_port_info_set_client(pinfo, client);
+		snd_seq_port_info_set_port(pinfo, -1);
+		while (snd_seq_query_next_port(seq, pinfo) >= 0) {
+			/* we need both WRITE and SUBS_WRITE */
+			if ((snd_seq_port_info_get_capability(pinfo)
+			     & (SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE))
+			    != (SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE))
+				continue;
+			printf("%3d:%-3d  %-32.32s %s\n",
+			       snd_seq_port_info_get_client(pinfo),
+			       snd_seq_port_info_get_port(pinfo),
+			       snd_seq_client_info_get_name(cinfo),
+			       snd_seq_port_info_get_name(pinfo));
+		}
+	}
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr,
+		"Usage: %s -p client:port[,...] [-d delay] midifile ...\n"
+		"-h, --help                  this help\n"
+		"-V, --version               print current version\n"
+		"-l, --list                  list all possible output ports\n"
+		"-p, --port=client:port,...  set port(s) to play to\n"
+		"-d, --delay=seconds         delay after song ends\n",
+		argv0);
+}
+
+static void version(void)
+{
+	fputs("aplaymidi version " SND_UTIL_VERSION_STR "\n", stderr);
+}
+
+int main(int argc, char *argv[])
+{
+	static char short_options[] = "hVlp:d:";
+	static struct option long_options[] = {
+		{"help", 0, NULL, 'h'},
+		{"version", 0, NULL, 'V'},
+		{"list", 0, NULL, 'l'},
+		{"port", 1, NULL, 'p'},
+		{"delay", 1, NULL, 'd'},
+		{}
+	};
+	int c;
+	int do_list = 0;
+
+	init_seq();
+
+	while ((c = getopt_long(argc, argv, short_options,
+				long_options, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'V':
+			version();
+			return 0;
+		case 'l':
+			do_list = 1;
+			break;
+		case 'p':
+			parse_ports(optarg);
+			break;
+		case 'd':
+			end_delay = atoi(optarg);
+			break;
+		default:
+			usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (do_list) {
+		list_ports();
+	} else {
+		if (port_count < 1) {
+			/* use env var for compatibility with pmidi */
+			const char *ports_str = getenv("ALSA_OUTPUT_PORTS");
+			if (ports_str)
+				parse_ports(ports_str);
+			if (port_count < 1) {
+				errormsg("Please specify at least one port with --port.");
+				return 1;
+			}
+		}
+		if (optind >= argc) {
+			errormsg("Please specify a file to play.");
+			return 1;
+		}
+
+		create_source_port();
+		create_queue();
+		connect_ports();
+
+		for (; optind < argc; ++optind) {
+			file_name = argv[optind];
+			play_file();
+		}
+	}
+	snd_seq_close(seq);
+	return 0;
+}
diff -urN ../../oalsa/alsa/alsa-utils/seq/aplaymidi/arecordmidi.1 alsa-utils/seq/aplaymidi/arecordmidi.1
--- ../../oalsa/alsa/alsa-utils/seq/aplaymidi/arecordmidi.1	1970-01-01 01:00:00.000000000 +0100
+++ alsa-utils/seq/aplaymidi/arecordmidi.1	2004-02-23 09:38:11.101243000 +0100
@@ -0,0 +1,62 @@
+.TH ARECORDMIDI 1 "22 Feb 2004"
+
+.SH NAME
+arecordmidi - record Standard MIDI Files
+
+.SH SYNOPSIS
+.B arecordmidi
+-p client:port[,...] [options] midifile
+
+.SH DESCRIPTION
+.B arecordmidi
+is a command-line utility that records a Standard MIDI File from one or
+more ALSA sequencer ports.
+
+To stop recording, press Ctrl+C.
+
+.SH OPTIONS
+
+.TP
+.I -h,--help
+Prints a list of options.
+
+.TP
+.I -V,--version
+Prints the current version.
+
+.TP
+.I -l,--list
+Prints a list of possible input ports.
+
+.TP
+.I -p,--port=client:port,...
+Sets the sequencer port(s) from which events are recorded.
+
+A client can be specified by its number, its name, or a prefix of its
+name. A port is specified by its number; for port 0 of a client, the
+":0" part of the port specification can be omitted.
+
+.TP
+.I -b,--bpm=beats
+Sets the musical tempo of the MIDI file, in beats per minute.
+The default value is 120 BPM.
+
+.TP
+.I -f,--fps=frames
+Sets the SMPTE resolution, in frames per second.
+Possible values are 24, 25, 29.97 (for 30 drop-frame), and 30.
+
+.TP
+.I -t,--ticks=ticks
+Sets the resolution of timestamps (ticks) in the MIDI file,
+in ticks per beat (when using musical tempo) or ticks per frame
+(when using SMPTE timing).
+The default value is 384 ticks/beat or 40 ticks/frame, respectively.
+
+.TP
+.I -s,--split-channels
+Specifies that the data for each MIDI channel should be written to a
+separate track in the MIDI file.
+
+.SH AUTHOR
+Clemens Ladisch <clemens@ladisch.de>
diff -urN ../../oalsa/alsa/alsa-utils/seq/aplaymidi/arecordmidi.c alsa-utils/seq/aplaymidi/arecordmidi.c
--- ../../oalsa/alsa/alsa-utils/seq/aplaymidi/arecordmidi.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-utils/seq/aplaymidi/arecordmidi.c	2004-02-23 09:38:11.141242000 +0100
@@ -0,0 +1,723 @@
+/*
+ * arecordmidi.c - record standard MIDI files from sequencer ports
+ *
+ * Copyright (c) 2004 Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+/* TODO: sequencer queue timer selection */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <signal.h>
+#include <getopt.h>
+#include <sys/poll.h>
+#include <alsa/asoundlib.h>
+#include "aconfig.h"
+#include "version.h"
+
+#define BUFFER_SIZE 4088
+
+/* linked list of buffers, stores data as in the .mid file */
+struct buffer {
+	struct buffer *next;
+	unsigned char buf[BUFFER_SIZE];
+};
+
+struct smf_track {
+	int size;			/* size of entire data */
+	int cur_buf_size;		/* size of cur_buf */
+	struct buffer *cur_buf;
+	snd_seq_tick_time_t last_tick;	/* end of track */
+	unsigned char last_command;	/* used for running status */
+	int used;			/* anything record on this track */
+	struct buffer first_buf;	/* list head */
+};
+
+/* timing/sysex + 16 channels */
+#define TRACKS_PER_PORT 17
+
+
+static snd_seq_t *seq;
+static int client;
+static int port_count;
+static snd_seq_addr_t *ports;
+static int queue;
+static int smpte_timing = 0;
+static int beats = 120;
+static int frames;
+static int ticks = 0;
+static FILE *file;
+static int channel_split;
+static int num_tracks;
+static struct smf_track *tracks;
+static volatile sig_atomic_t stop = 0;
+
+
+/* prints an error message to stderr, and dies */
+static void fatal(const char *msg, ...)
+{
+	va_list ap;
+
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	exit(EXIT_FAILURE);
+}
+
+/* memory allocation error handling */
+static void check_mem(void *p)
+{
+	if (!p)
+		fatal("Out of memory");
+}
+
+/* error handling for ALSA functions */
+static void check_snd(const char *operation, int err)
+{
+	if (err < 0)
+		fatal("Cannot %s - %s", operation, snd_strerror(err));
+}
+
+static void init_seq(void)
+{
+	int err;
+
+	/* open sequencer */
+	err = snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);
+	check_snd("open sequencer", err);
+
+	/* find out our client's id */
+	client = snd_seq_client_id(seq);
+	check_snd("get client id", client);
+
+	/* set our client's name */
+	err = snd_seq_set_client_name(seq, "arecordmidi");
+	check_snd("set client name", err);
+}
+
+/* parses one or more port addresses from the string */
+static void parse_ports(const char *arg)
+{
+	char *buf, *s, *port_name;
+	int err;
+
+	/* make a copy of the string because we're going to modify it */
+	buf = strdup(arg);
+	check_mem(buf);
+
+	for (port_name = s = buf; s; port_name = s + 1) {
+		/* Assume that ports are separated by commas.  We don't use
+		 * spaces because those are valid in client names. */
+		s = strchr(port_name, ',');
+		if (s)
+			*s = '\0';
+
+		++port_count;
+		ports = realloc(ports, port_count * sizeof(snd_seq_addr_t));
+		check_mem(ports);
+
+		err = snd_seq_parse_address(seq, &ports[port_count - 1], port_name);
+		if (err < 0)
+			fatal("Invalid port %s - %s", port_name, snd_strerror(err));
+	}
+
+	free(buf);
+}
+
+static void init_tracks(void)
+{
+	int i;
+
+	/* MIDI RP-019 says we need at least one track per port */
+	num_tracks = port_count;
+	/* Allocate one track for each possible channel.
+	 * Empty tracks won't be written to the file. */
+	if (channel_split)
+		num_tracks *= TRACKS_PER_PORT;
+
+	tracks = calloc(num_tracks, sizeof(struct smf_track));
+	check_mem(tracks);
+	for (i = 0; i < num_tracks; ++i)
+		tracks[i].cur_buf = &tracks[i].first_buf;
+}
+
+static void create_queue(void)
+{
+	snd_seq_queue_tempo_t *tempo;
+	int err;
+
+	queue = snd_seq_alloc_named_queue(seq, "arecordmidi");
+	check_snd("create queue", queue);
+
+	snd_seq_queue_tempo_alloca(&tempo);
+	if (!smpte_timing) {
+		snd_seq_queue_tempo_set_tempo(tempo, 60000000 / beats);
+		snd_seq_queue_tempo_set_ppq(tempo, ticks);
+	} else {
+		/*
+		 * ALSA doesn't know about the SMPTE time divisions, so
+		 * we pretend to have a musical tempo with the equivalent
+		 * number of ticks/s.
+		 */
+		switch (frames) {
+		case 24:
+			snd_seq_queue_tempo_set_tempo(tempo, 500000);
+			snd_seq_queue_tempo_set_ppq(tempo, 12 * ticks);
+			break;
+		case 25:
+			snd_seq_queue_tempo_set_tempo(tempo, 400000);
+			snd_seq_queue_tempo_set_ppq(tempo, 10 * ticks);
+			break;
+		case 29:
+			snd_seq_queue_tempo_set_tempo(tempo, 100000000);
+			snd_seq_queue_tempo_set_ppq(tempo, 2997 * ticks);
+			break;
+		case 30:
+			snd_seq_queue_tempo_set_tempo(tempo, 500000);
+			snd_seq_queue_tempo_set_ppq(tempo, 15 * ticks);
+			break;
+		default:
+			fatal("Invalid SMPTE frames %d", frames);
+		}
+	}
+	err = snd_seq_set_queue_tempo(seq, queue, tempo);
+	if (err < 0)
+		fatal("Cannot set queue tempo (%u/%i)",
+		      snd_seq_queue_tempo_get_tempo(tempo),
+		      snd_seq_queue_tempo_get_ppq(tempo));
+}
+
+static void create_ports(void)
+{
+	snd_seq_port_info_t *pinfo;
+	int i, err;
+	char name[32];
+
+	snd_seq_port_info_alloca(&pinfo);
+
+	/* common information for all our ports */
+	snd_seq_port_info_set_capability(pinfo,
+					 SND_SEQ_PORT_CAP_WRITE |
+					 SND_SEQ_PORT_CAP_SUBS_WRITE);
+	snd_seq_port_info_set_type(pinfo,
+				   SND_SEQ_PORT_TYPE_MIDI_GENERIC |
+				   SND_SEQ_PORT_TYPE_APPLICATION);
+	snd_seq_port_info_set_midi_channels(pinfo, 16);
+
+	/* we want to know when the events got delivered to us */
+	snd_seq_port_info_set_timestamping(pinfo, 1);
+	snd_seq_port_info_set_timestamp_queue(pinfo, queue);
+
+	/* our port number is the same as our port index */
+	snd_seq_port_info_set_port_specified(pinfo, 1);
+	for (i = 0; i < port_count; ++i) {
+		snd_seq_port_info_set_port(pinfo, i);
+
+		sprintf(name, "arecordmidi port %i", i);
+		snd_seq_port_info_set_name(pinfo, name);
+
+		err = snd_seq_create_port(seq, pinfo);
+		check_snd("create port", err);
+	}
+}
+
+static void connect_ports(void)
+{
+	int i, err;
+
+	for (i = 0; i < port_count; ++i) {
+		err = snd_seq_connect_from(seq, i, ports[i].client, ports[i].port);
+		if (err < 0)
+			fatal("Cannot connect from port %d:%d - %s",
+			      ports[i].client, ports[i].port, snd_strerror(err));
+	}
+}
+
+/* records a byte to be written to the .mid file */
+static void add_byte(struct smf_track *track, unsigned char byte)
+{
+	/* make sure we have enough room in the current buffer */
+	if (track->cur_buf_size >= BUFFER_SIZE) {
+		track->cur_buf->next = calloc(1, sizeof(struct buffer));
+		if (!track->cur_buf->next)
+			fatal("out of memory");
+		track->cur_buf = track->cur_buf->next;
+		track->cur_buf_size = 0;
+	}
+
+	track->cur_buf->buf[track->cur_buf_size++] = byte;
+	track->size++;
+}
+
+/* record a variable-length quantity */
+static void var_value(struct smf_track *track, int v)
+{
+	if (v >= (1 << 28))
+		add_byte(track, 0x80 | ((v >> 28) & 0x03));
+	if (v >= (1 << 21))
+		add_byte(track, 0x80 | ((v >> 21) & 0x7f));
+	if (v >= (1 << 14))
+		add_byte(track, 0x80 | ((v >> 14) & 0x7f));
+	if (v >= (1 << 7))
+		add_byte(track, 0x80 | ((v >> 7) & 0x7f));
+	add_byte(track, v & 0x7f);
+}
+
+/* record the delta time from the last event */
+static void delta_time(struct smf_track *track, const snd_seq_event_t *ev)
+{
+	int diff = ev->time.tick - track->last_tick;
+	if (diff < 0)
+		diff = 0;
+	var_value(track, diff);
+	track->last_tick = ev->time.tick;
+}
+
+/* record a status byte (or not if we can use running status) */
+static void command(struct smf_track *track, unsigned char cmd)
+{
+	if (cmd != track->last_command)
+		add_byte(track, cmd);
+	track->last_command = cmd < 0xf0 ? cmd : 0;
+}
+
+/* put port numbers into all tracks */
+static void record_port_numbers(void)
+{
+	int i;
+
+	for (i = 0; i < num_tracks; ++i) {
+		var_value(&tracks[i], 0);
+		add_byte(&tracks[i], 0xff);
+		add_byte(&tracks[i], 0x21);
+		var_value(&tracks[i], 1);
+		if (channel_split)
+			add_byte(&tracks[i], i / TRACKS_PER_PORT);
+		else
+			add_byte(&tracks[i], i);
+	}
+}
+
+static void record_event(const snd_seq_event_t *ev)
+{
+	unsigned int i;
+	struct smf_track *track;
+
+	/* ignore events without proper timestamps */
+	if (ev->queue != queue || !snd_seq_ev_is_tick(ev))
+		return;
+
+	/* determine which track to record to */
+	i = ev->dest.port;
+	if (channel_split) {
+		i *= TRACKS_PER_PORT;
+		if (snd_seq_ev_is_channel_type(ev))
+			i += 1 + (ev->data.note.channel & 0xf);
+	}
+	if (i >= num_tracks)
+		return;
+	track = &tracks[i];
+
+	switch (ev->type) {
+	case SND_SEQ_EVENT_NOTEON:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_NOTE_ON | (ev->data.note.channel & 0xf));
+		add_byte(track, ev->data.note.note & 0x7f);
+		add_byte(track, ev->data.note.velocity & 0x7f);
+		break;
+	case SND_SEQ_EVENT_NOTEOFF:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_NOTE_OFF | (ev->data.note.channel & 0xf));
+		add_byte(track, ev->data.note.note & 0x7f);
+		add_byte(track, ev->data.note.velocity & 0x7f);
+		break;
+	case SND_SEQ_EVENT_KEYPRESS:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_NOTE_PRESSURE | (ev->data.note.channel & 0xf));
+		add_byte(track, ev->data.note.note & 0x7f);
+		add_byte(track, ev->data.note.velocity & 0x7f);
+		break;
+	case SND_SEQ_EVENT_CONTROLLER:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_CONTROL | (ev->data.control.channel & 0xf));
+		add_byte(track, ev->data.control.param & 0x7f);
+		add_byte(track, ev->data.control.value & 0x7f);
+		break;
+	case SND_SEQ_EVENT_PGMCHANGE:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_PGM_CHANGE | (ev->data.control.channel & 0xf));
+		add_byte(track, ev->data.control.value & 0x7f);
+		break;
+	case SND_SEQ_EVENT_CHANPRESS:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_CHANNEL_PRESSURE | (ev->data.control.channel & 0xf));
+		add_byte(track, ev->data.control.value & 0x7f);
+		break;
+	case SND_SEQ_EVENT_PITCHBEND:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_BENDER | (ev->data.control.channel & 0xf));
+		add_byte(track, (ev->data.control.value + 8192) & 0x7f);
+		add_byte(track, ((ev->data.control.value + 8192) >> 7) & 0x7f);
+		break;
+	case SND_SEQ_EVENT_CONTROL14:
+		/* create two commands for MSB and LSB */
+		delta_time(track, ev);
+		command(track, MIDI_CMD_CONTROL | (ev->data.control.channel & 0xf));
+		add_byte(track, ev->data.control.param & 0x7f);
+		add_byte(track, (ev->data.control.value >> 7) & 0x7f);
+		if ((ev->data.control.param & 0x7f) < 0x20) {
+			delta_time(track, ev);
+			/* running status */
+			add_byte(track, (ev->data.control.param & 0x7f) + 0x20);
+			add_byte(track, ev->data.control.value & 0x7f);
+		}
+		break;
+	case SND_SEQ_EVENT_NONREGPARAM:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_CONTROL | (ev->data.control.channel & 0xf));
+		add_byte(track, MIDI_CTL_NONREG_PARM_NUM_LSB);
+		add_byte(track, ev->data.control.param & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_NONREG_PARM_NUM_MSB);
+		add_byte(track, (ev->data.control.param >> 7) & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_MSB_DATA_ENTRY);
+		add_byte(track, (ev->data.control.value >> 7) & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_LSB_DATA_ENTRY);
+		add_byte(track, ev->data.control.value & 0x7f);
+		break;
+	case SND_SEQ_EVENT_REGPARAM:
+		delta_time(track, ev);
+		command(track, MIDI_CMD_CONTROL | (ev->data.control.channel & 0xf));
+		add_byte(track, MIDI_CTL_REGIST_PARM_NUM_LSB);
+		add_byte(track, ev->data.control.param & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_REGIST_PARM_NUM_MSB);
+		add_byte(track, (ev->data.control.param >> 7) & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_MSB_DATA_ENTRY);
+		add_byte(track, (ev->data.control.value >> 7) & 0x7f);
+		delta_time(track, ev);
+		add_byte(track, MIDI_CTL_LSB_DATA_ENTRY);
+		add_byte(track, ev->data.control.value & 0x7f);
+		break;
+#if 0	/* ignore */
+	case SND_SEQ_EVENT_SONGPOS:
+	case SND_SEQ_EVENT_SONGSEL:
+	case SND_SEQ_EVENT_QFRAME:
+	case SND_SEQ_EVENT_START:
+	case SND_SEQ_EVENT_CONTINUE:
+	case SND_SEQ_EVENT_STOP:
+	case SND_SEQ_EVENT_TUNE_REQUEST:
+	case SND_SEQ_EVENT_RESET:
+	case SND_SEQ_EVENT_SENSING:
+		break;
+#endif
+	case SND_SEQ_EVENT_SYSEX:
+		if (ev->data.ext.len == 0)
+			break;
+		delta_time(track, ev);
+		if (*(unsigned char*)ev->data.ext.ptr == 0xf0)
+			command(track, 0xf0), i = 1;
+		else
+			command(track, 0xf7), i = 0;
+		var_value(track, ev->data.ext.len - i);
+		for (; i < ev->data.ext.len; ++i)
+			add_byte(track, ((unsigned char*)ev->data.ext.ptr)[i]);
+		break;
+	default:
+		return;
+	}
+	track->used = 1;
+}
+
+static void finish_tracks(void)
+{
+	snd_seq_queue_status_t *queue_status;
+	int tick, i, err;
+
+	snd_seq_queue_status_alloca(&queue_status);
+
+	err = snd_seq_get_queue_status(seq, queue, queue_status);
+	check_snd("get queue status", err);
+	tick = snd_seq_queue_status_get_tick_time(queue_status);
+
+	/* make length of first track the recording length */
+	var_value(&tracks[0], tick - tracks[0].last_tick);
+	add_byte(&tracks[0], 0xff);
+	add_byte(&tracks[0], 0x2f);
+	var_value(&tracks[0], 0);
+
+	/* finish other tracks */
+	for (i = 1; i < num_tracks; ++i) {
+		var_value(&tracks[i], 0);
+		add_byte(&tracks[i], 0xff);
+		add_byte(&tracks[i], 0x2f);
+		var_value(&tracks[i], 0);
+	}
+}
+
+static void write_file(void)
+{
+	int used_tracks, time_division, i;
+	struct buffer *buf;
+
+	used_tracks = 0;
+	for (i = 0; i < num_tracks; ++i)
+		used_tracks += !!tracks[i].used;
+
+	/* header id and length */
+	fwrite("MThd\0\0\0\6", 1, 8, file);
+	/* type 0 or 1 */
+	fputc(0, file);
+	fputc(used_tracks > 1, file);
+	/* number of tracks */
+	fputc((used_tracks >> 8) & 0xff, file);
+	fputc(used_tracks & 0xff, file);
+	/* time division */
+	time_division = ticks;
+	if (smpte_timing)
+		time_division |= (0x100 - frames) << 8;
+	fputc(time_division >> 8, file);
+	fputc(time_division & 0xff, file);
+
+	for (i = 0; i < num_tracks; ++i) {
+		if (!tracks[i].used)
+			continue;
+		/* track id */
+		fwrite("MTrk", 1, 4, file);
+		/* data length */
+		fputc((tracks[i].size >> 24) & 0xff, file);
+		fputc((tracks[i].size >> 16) & 0xff, file);
+		fputc((tracks[i].size >> 8) & 0xff, file);
+		fputc(tracks[i].size & 0xff, file);
+		/* track contents */
+		for (buf = &tracks[i].first_buf; buf; buf = buf->next)
+			fwrite(buf->buf, 1, buf == tracks[i].cur_buf
+			       ? tracks[i].cur_buf_size : BUFFER_SIZE, file);
+	}
+}
+
+static void list_ports(void)
+{
+	snd_seq_client_info_t *cinfo;
+	snd_seq_port_info_t *pinfo;
+
+	snd_seq_client_info_alloca(&cinfo);
+	snd_seq_port_info_alloca(&pinfo);
+
+	puts(" Port    Client name                      Port name");
+
+	snd_seq_client_info_set_client(cinfo, -1);
+	while (snd_seq_query_next_client(seq, cinfo) >= 0) {
+		int client = snd_seq_client_info_get_client(cinfo);
+
+		if (client == SND_SEQ_CLIENT_SYSTEM)
+			continue; /* don't show system timer and announce ports */
+		snd_seq_port_info_set_client(pinfo, client);
+		snd_seq_port_info_set_port(pinfo, -1);
+		while (snd_seq_query_next_port(seq, pinfo) >= 0) {
+			/* we need both READ and SUBS_READ */
+			if ((snd_seq_port_info_get_capability(pinfo)
+			     & (SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_SUBS_READ))
+			    != (SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_SUBS_READ))
+				continue;
+			printf("%3d:%-3d  %-32.32s %s\n",
+			       snd_seq_port_info_get_client(pinfo),
+			       snd_seq_port_info_get_port(pinfo),
+			       snd_seq_client_info_get_name(cinfo),
+			       snd_seq_port_info_get_name(pinfo));
+		}
+	}
+}
+
+static void help(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s [options] outputfile\n"
+		"\nAvailable options:\n"
+		"  -h,--help                  this help\n"
+		"  -V,--version               show version\n"
+		"  -l,--list                  list input ports\n"
+		"  -p,--port=client:port,...  source port(s)\n"
+		"  -b,--bpm=beats             tempo in beats per minute\n"
+		"  -f,--fps=frames            resolution in frames per second (SMPTE)\n"
+		"  -t,--ticks=ticks           resolution in ticks per beat or frame\n"
+		"  -s,--split-channels        create a track for each channel\n",
+		argv0);
+}
+
+static void version(void)
+{
+	fputs("arecordmidi version " SND_UTIL_VERSION_STR "\n", stderr);
+}
+
+static void sighandler(int sig)
+{
+	stop = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	static char short_options[] = "hVlp:b:f:t:s";
+	static struct option long_options[] = {
+		{"help", 0, NULL, 'h'},
+		{"version", 0, NULL, 'V'},
+		{"list", 0, NULL, 'l'},
+		{"port", 1, NULL, 'p'},
+		{"bpm", 1, NULL, 'b'},
+		{"fps", 1, NULL, 'f'},
+		{"ticks", 1, NULL, 't'},
+		{"split-channels", 0, NULL, 's'},
+		{ }
+	};
+
+	char *filename = NULL;
+	int do_list = 0;
+	struct pollfd *pfds;
+	int npfds;
+	int c, err;
+
+	init_seq();
+
+	while ((c = getopt_long(argc, argv, short_options,
+				long_options, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			help(argv[0]);
+			return 0;
+		case 'V':
+			version();
+			return 0;
+		case 'l':
+			do_list = 1;
+			break;
+		case 'p':
+			parse_ports(optarg);
+			break;
+		case 'b':
+			beats = atoi(optarg);
+			if (beats < 4 || beats > 6000)
+				fatal("Invalid tempo");
+			smpte_timing = 0;
+			break;
+		case 'f':
+			frames = atoi(optarg);
+			if (frames != 24 && frames != 25 &&
+			    frames != 29 && frames != 30)
+				fatal("Invalid number of frames/s");
+			smpte_timing = 1;
+			break;
+		case 't':
+			ticks = atoi(optarg);
+			if (ticks < 1 || ticks > 0x7fff)
+				fatal("Invalid number of ticks");
+			break;
+		case 's':
+			channel_split = 1;
+			break;
+		default:
+			help(argv[0]);
+			return 1;
+		}
+	}
+
+	if (do_list) {
+		list_ports();
+		return 0;
+	}
+
+	if (port_count < 1) {
+		fputs("Pleast specify a source port with --port.\n", stderr);
+		return 1;
+	}
+
+	if (!ticks)
+		ticks = smpte_timing ? 40 : 384;
+	if (smpte_timing && ticks > 0xff)
+		ticks = 0xff;
+
+	if (optind >= argc) {
+		fputs("Please specify a file to record to.\n", stderr);
+		return 1;
+	}
+	filename = argv[optind];
+
+	init_tracks();
+	create_queue();
+	create_ports();
+	connect_ports();
+	if (port_count > 1)
+		record_port_numbers();
+
+	/* record tempo */
+	if (!smpte_timing) {
+		int usecs_per_quarter = 60000000 / beats;
+		var_value(&tracks[0], 0); /* delta time */
+		add_byte(&tracks[0], 0xff);
+		add_byte(&tracks[0], 0x51);
+		var_value(&tracks[0], 3);
+		add_byte(&tracks[0], usecs_per_quarter >> 16);
+		add_byte(&tracks[0], usecs_per_quarter >> 8);
+		add_byte(&tracks[0], usecs_per_quarter);
+	}
+	/* always write at least one track */
+	tracks[0].used = 1;
+
+	file = fopen(filename, "wb");
+	if (!file)
+		fatal("Cannot open %s - %s", filename, strerror(errno));
+
+	err = snd_seq_start_queue(seq, queue, NULL);
+	check_snd("start queue", err);
+	snd_seq_drain_output(seq);
+
+	err = snd_seq_nonblock(seq, 1);
+	check_snd("set nonblock mode", err);
+
+	signal(SIGINT, sighandler);
+	signal(SIGTERM, sighandler);
+
+	npfds = snd_seq_poll_descriptors_count(seq, POLLIN);
+	pfds = alloca(sizeof(*pfds) * npfds);
+	for (;;) {
+		snd_seq_poll_descriptors(seq, pfds, npfds, POLLIN);
+		if (poll(pfds, npfds, 69) < 0)
+			break;
+		do {
+			snd_seq_event_t *event;
+			err = snd_seq_event_input(seq, &event);
+			if (err < 0)
+				break;
+			if (event)
+				record_event(event);
+		} while (err > 0);
+		if (stop)
+			break;
+	}
+
+	finish_tracks();
+	write_file();
+
+	fclose(file);
+	snd_seq_close(seq);
+	return 0;
+}




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
