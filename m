From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] amidi utility
Date: Tue, 28 Oct 2003 11:17:24 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310281111090.10208-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


amidi - read from and write to RawMIDI ports
(see manpage for details)


Index: alsa/alsa-utils/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/Makefile.am,v
retrieving revision 1.26
diff -u -r1.26 Makefile.am
--- alsa/alsa-utils/Makefile.am	23 Oct 2003 16:54:32 -0000	1.26
+++ alsa/alsa-utils/Makefile.am	28 Oct 2003 10:03:59 -0000
@@ -4,7 +4,7 @@
 else
 ALSAMIXER_DIR=
 endif
-SUBDIRS=include alsactl $(ALSAMIXER_DIR) amixer aplay iecset seq utils
+SUBDIRS=include alsactl $(ALSAMIXER_DIR) amidi amixer aplay iecset seq utils
 EXTRA_DIST=ChangeLog INSTALL TODO README configure cvscompile depcomp

 rpm: dist
Index: alsa/alsa-utils/README
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/README,v
retrieving revision 1.5
diff -u -r1.5 README
--- alsa/alsa-utils/README	25 Nov 2000 18:25:56 -0000	1.5
+++ alsa/alsa-utils/README	28 Oct 2003 10:03:59 -0000
@@ -10,6 +10,7 @@
 aplay/arecord	- an utility for the playback / capture of .wav,.voc,.au files
 amixer		- a command line mixer
 alsamixer	- a ncurses mixer
+amidi		- a utility to send/receive sysex dumps or other MIDI data

 You may give a look for more information about the ALSA project to URL
 http://www.alsa-project.org.
Index: alsa/alsa-utils/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/configure.in,v
retrieving revision 1.67
diff -u -r1.67 configure.in
--- alsa/alsa-utils/configure.in	23 Oct 2003 16:54:32 -0000	1.67
+++ alsa/alsa-utils/configure.in	28 Oct 2003 10:03:59 -0000
@@ -64,6 +64,6 @@

 SAVE_UTIL_VERSION

-AC_OUTPUT(Makefile alsactl/Makefile alsamixer/Makefile amixer/Makefile aplay/Makefile \
-          include/Makefile iecset/Makefile utils/Makefile utils/alsa-utils.spec \
-	  seq/Makefile seq/aconnect/Makefile seq/aseqnet/Makefile)
+AC_OUTPUT(Makefile alsactl/Makefile alsamixer/Makefile amidi/Makefile amixer/Makefile \
+	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
+	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile seq/aseqnet/Makefile)
diff -urN alsaold/alsa-utils/amidi/Makefile.am alsa/alsa-utils/amidi/Makefile.am
--- alsaold/alsa-utils/amidi/Makefile.am	Thu Jan  1 01:00:00 1970
+++ alsa/alsa-utils/amidi/Makefile.am	Sun Oct 19 14:53:24 2003
@@ -0,0 +1,5 @@
+INCLUDES = -I$(top_srcdir)/include
+EXTRA_DIST = amidi.1
+
+bin_PROGRAMS = amidi
+man_MANS = amidi.1
diff -urN alsaold/alsa-utils/amidi/amidi.1 alsa/alsa-utils/amidi/amidi.1
--- alsaold/alsa-utils/amidi/amidi.1	Thu Jan  1 01:00:00 1970
+++ alsa/alsa-utils/amidi/amidi.1	Mon Oct 27 21:26:46 2003
@@ -0,0 +1,151 @@
+.TH AMIDI 1 "27 Oct 2003"
+
+.SH NAME
+amidi \- read from and write to ALSA RawMIDI ports
+
+.SH SYNOPSIS
+.B amidi
+.I options
+
+.SH DESCRIPTION
+.B amidi
+is a command-line utility which allows to receive and send
+SysEx (system exclusive) data from/to external MIDI devices.
+It can also send any other MIDI commands.
+
+.B amidi
+handles only files containing raw MIDI commands, without timing
+information.
+Standard MIDI (.mid) files are not supported.
+
+.SH INVOKING
+.B amidi
+.I options
+
+Use the
+.I -h,
+.I -V,
+.I -l,
+or
+.I -L
+options to display information;
+or use at least one of the
+.I -s,
+.I -r,
+.I -S,
+or
+.I -d
+options to specify what data to send or receive.
+
+.SS Options
+
+.TP
+.I -h, --help
+Help: prints a list of options.
+
+.TP
+.I -V, --version
+Prints the current version.
+
+.TP
+.I -l, --list-devices
+Prints a list of all hardware MIDI ports.
+
+.TP
+.I -L, --list-rawmidis
+Prints all RawMIDI definitions.
+(used when debugging configuration files)
+
+.TP
+.I -p, --port=name
+Sets the name of the ALSA RawMIDI port to use.
+If this is not specified,
+.B amidi
+uses the default port defined in the configuration file
+(the default for this is port 0 on card 0, which may not exist).
+
+.TP
+.I -s, --send=filename
+Sends the contents of the specified file to the MIDI port.
+The file must contain raw MIDI commands (e.g. a .syx file);
+you can
+.I not
+use a Standard MIDI (.mid) file for this.
+
+.TP
+.I -r, --receive=filename
+Writes data received from the MIDI port into the specified file.
+The file will contain raw MIDI commands (such as in a .syx file);
+this will
+.I not
+create a Standard MIDI (.mid) file.
+
+.B amidi
+will filter out any Active Sensing bytes (FEh).
+
+.TP
+.I -S, --send-hex="..."
+Sends the bytes specified as hexadecimal numbers to the MIDI port.
+
+.TP
+.I -d, --dump
+Prints data received from the MIDI port as hexadecimal bytes.
+Active Sensing bytes (FEh) will not be shown.
+
+This option is useful for debugging.
+
+.TP
+.I -t, --timeout=seconds
+Stops receiving data when no data has been received for the specified
+amount of time.
+
+If this option has not been given, you must press Ctrl+C (or kill
+.B amidi\fR)
+to stop receiving data.
+
+.SH EXAMPLES
+
+.SS
+.B amidi -p hw:0 -s my_settings.syx
+.ID
+will send the MIDI commands in
+.I my_settings.syx
+to port
+.I hw:0.
+
+.SS
+.B amidi -S 'F0 43 10 4C 00 00 7E 00 F7'
+.ID
+sends an XG Reset to the default port.
+
+.SS
+.B amidi -p hw:1,2 -S F0411042110C000000000074F7 -r dump.syx -t 1
+.ID
+sends a \(lqParameter Dump Request\(rq to a GS device, saves the received
+parameter data to the file
+.I dump.syx,
+and stops after the device has finished sending data
+(when no data has been received for one second).
+
+.SS
+.B amidi -p virtual -d
+.ID
+creates a virtual RawMIDI port and prints all data sent to this port.
+
+.SH FILES
+.I /usr/share/alsa/alsa.conf
+default rawmidi definitions
+.br
+.I /etc/asound.conf
+system-wide rawmidi definitions
+.br
+.I ~/.asoundrc
+user specific rawmidi definitions
+
+.SH BUGS
+The
+.I --list-devices
+option pretends that output and input ports are the same.
+
+.SH AUTHOR
+Clemens Ladisch <clemens@ladisch.de>
diff -urN -X alsa-d/Xu alsaold/alsa-utils/amidi/amidi.c alsa/alsa-utils/amidi/amidi.c
--- alsaold/alsa-utils/amidi/amidi.c	Thu Jan  1 01:00:00 1970
+++ alsa/alsa-utils/amidi/amidi.c	Mon Oct 27 21:19:38 2003
@@ -0,0 +1,556 @@
+/*
+ *  amidi.c - read from/write to RawMIDI ports
+ *
+ *  Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <ctype.h>
+#include <getopt.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/poll.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <alsa/asoundlib.h>
+#include "aconfig.h"
+#include "version.h"
+
+static int do_device_list, do_rawmidi_list;
+static char *port_name = "default";
+static char *send_file_name;
+static char *receive_file_name;
+static char *send_hex;
+static char *send_data;
+static int send_data_length;
+static int receive_file;
+static int dump;
+static int timeout;
+static int stop;
+static snd_rawmidi_t *input, **inputp;
+static snd_rawmidi_t *output, **outputp;
+
+static void error(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	vfprintf(stderr, format, ap);
+	va_end(ap);
+	putc('\n', stderr);
+}
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage: amidi options\n"
+		"\n"
+		"-h, --help             this help\n"
+		"-V, --version          print current version\n"
+		"-l, --list-devices     list all hardware ports\n"
+		"-L, --list-rawmidis    list all RawMIDI definitions\n"
+		"-p, --port=name        select port by name\n"
+		"-s, --send=file        send the contents of a (.syx) file\n"
+		"-r, --receive=file     write received data into a file\n"
+		"-S, --send-hex=\"...\"   send hexadecimal bytes\n"
+		"-d, --dump             print received data as hexadecimal bytes\n"
+		"-t, --timeout=seconds  exits when no data has been received\n"
+		"                       for the specified duration\n");
+}
+
+static void version(void)
+{
+	fputs("amidi version " SND_UTIL_VERSION_STR "\n", stderr);
+}
+
+static void list_device(snd_ctl_t *ctl, int card, int device)
+{
+	snd_rawmidi_info_t *info;
+	const char *name;
+	const char *sub_name;
+	int subs;
+	int err;
+
+	snd_rawmidi_info_alloca(&info);
+	snd_rawmidi_info_set_device(info, device);
+	snd_rawmidi_info_set_subdevice(info, 0);
+	snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_OUTPUT);
+	if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 &&
+	    err != -ENOENT) {
+		error("cannot get rawmidi information %d:%d: %s",
+		      card, device, snd_strerror(err));
+		return;
+	}
+	if (err == -ENOENT) {
+		snd_rawmidi_info_set_stream(info, SND_RAWMIDI_STREAM_INPUT);
+		if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0 &&
+		    err != -ENOENT) {
+			error("cannot get rawmidi information %d:%d: %s",
+			      card, device, snd_strerror(err));
+			return;
+		}
+	}
+	if (err == -ENOENT)
+		return;
+	name = snd_rawmidi_info_get_name(info);
+	sub_name = snd_rawmidi_info_get_subdevice_name(info);
+	subs = snd_rawmidi_info_get_subdevices_count(info);
+	if (sub_name[0] == '\0') {
+		if (subs == 1)
+			printf("hw:%d,%d    %s\n", card, device, name);
+		else
+			printf("hw:%d,%d    %s (%d subdevices)\n",
+			       card, device, name, subs);
+	} else {
+		int sub = 0;
+		for (;;) {
+			printf("hw:%d,%d,%d  %s\n",
+			       card, device, sub, sub_name);
+			if (++sub >= subs)
+				break;
+			snd_rawmidi_info_set_subdevice(info, sub);
+			if ((err = snd_ctl_rawmidi_info(ctl, info)) < 0) {
+				error("cannot get rawmidi information %d:%d:%d: %s",
+				      card, device, sub, snd_strerror(err));
+				break;
+			}
+			sub_name = snd_rawmidi_info_get_subdevice_name(info);
+		}
+	}
+}
+
+static void list_card_devices(int card)
+{
+	snd_ctl_t *ctl;
+	char name[32];
+	int device;
+	int err;
+
+	sprintf(name, "hw:%d", card);
+	if ((err = snd_ctl_open(&ctl, name, 0)) < 0) {
+		error("cannot open control for card %d: %s", card, snd_strerror(err));
+		return;
+	}
+	device = -1;
+	for (;;) {
+		if ((err = snd_ctl_rawmidi_next_device(ctl, &device)) < 0) {
+			error("cannot determine device number: %s", snd_strerror(err));
+			break;
+		}
+		if (device < 0)
+			break;
+		list_device(ctl, card, device);
+	}
+	snd_ctl_close(ctl);
+}
+
+static void device_list(void)
+{
+	int card, err;
+
+	card = -1;
+	if ((err = snd_card_next(&card)) < 0) {
+		error("cannot determine card number: %s", snd_strerror(err));
+		return;
+	}
+	if (card < 0) {
+		error("no sound card found");
+		return;
+	}
+	puts("Device    Name");
+	do {
+		list_card_devices(card);
+		if ((err = snd_card_next(&card)) < 0) {
+			error("cannot determine card number: %s", snd_strerror(err));
+			break;
+		}
+	} while (card >= 0);
+}
+
+static void rawmidi_list(void)
+{
+	snd_output_t *output;
+	snd_config_t *config;
+	int err;
+
+	if ((err = snd_config_update()) < 0) {
+		error("snd_config_update failed: %s", snd_strerror(err));
+		return;
+	}
+	if ((err = snd_output_stdio_attach(&output, stdout, 0)) < 0) {
+		error("snd_output_stdio_attach failed: %s", snd_strerror(err));
+		return;
+	}
+	if (snd_config_search(snd_config, "rawmidi", &config) >= 0) {
+		puts("RawMIDI list:");
+		snd_config_save(config, output);
+	}
+	snd_output_close(output);
+}
+
+static void load_file(void)
+{
+	int fd;
+	off_t length;
+
+	fd = open(send_file_name, O_RDONLY);
+	if (fd == -1) {
+		error("cannot open %s - %s", send_file_name, strerror(errno));
+		return;
+	}
+	length = lseek(fd, 0, SEEK_END);
+	if (length == (off_t)-1) {
+		error("cannot determine length of %s: %s", send_file_name, strerror(errno));
+		goto _error;
+	}
+	send_data = malloc(length);
+	if (!send_data) {
+		error("cannot allocate %d bytes: %s", (int)length, strerror(errno));
+		goto _error;
+	}
+	lseek(fd, 0, SEEK_SET);
+	if (read(fd, send_data, length) != length) {
+		error("cannot read from %s: %s", send_file_name, strerror(errno));
+		goto _error;
+	}
+	send_data_length = length;
+	goto _exit;
+_error:
+	free(send_data);
+_exit:
+	close(fd);
+}
+
+static int hex_value(char c)
+{
+	if ('0' <= c && c <= '9')
+		return c - '0';
+	if ('A' <= c && c <= 'F')
+		return c - 'A' + 10;
+	if ('a' <= c && c <= 'f')
+		return c - 'a' + 10;
+	error("invalid character %c", c);
+	return -1;
+}
+
+static void parse_data(void)
+{
+	const char *p;
+	int i, value;
+
+	send_data = malloc(strlen(send_hex)); /* guesstimate */
+	i = 0;
+	value = -1; /* value is >= 0 when the first hex digit of a byte has been read */
+	for (p = send_hex; *p; ++p) {
+		int digit;
+		if (isspace((unsigned char)*p)) {
+			if (value >= 0) {
+				send_data[i++] = value;
+				value = -1;
+			}
+			continue;
+		}
+		digit = hex_value(*p);
+		if (digit < 0) {
+			send_data = NULL;
+			return;
+		}
+		if (value < 0) {
+			value = digit;
+		} else {
+			send_data[i++] = (value << 4) | digit;
+			value = -1;
+		}
+	}
+	if (value >= 0)
+		send_data[i++] = value;
+	send_data_length = i;
+}
+
+/*
+ * prints MIDI commands, formatting them nicely
+ */
+static void print_byte(unsigned char byte)
+{
+	static enum {
+		STATE_UNKNOWN,
+		STATE_1PARAM,
+		STATE_1PARAM_CONTINUE,
+		STATE_2PARAM_1,
+		STATE_2PARAM_2,
+		STATE_2PARAM_1_CONTINUE,
+		STATE_SYSEX
+	} state = STATE_UNKNOWN;
+	int newline = 0;
+
+	if (byte >= 0xf8)
+		newline = 1;
+	else if (byte >= 0xf0) {
+		newline = 1;
+		switch (byte) {
+		case 0xf0:
+			state = STATE_SYSEX;
+			break;
+		case 0xf1:
+		case 0xf3:
+			state = STATE_1PARAM;
+			break;
+		case 0xf2:
+			state = STATE_2PARAM_1;
+			break;
+		case 0xf4:
+		case 0xf5:
+		case 0xf6:
+			state = STATE_UNKNOWN;
+			break;
+		case 0xf7:
+			newline = state != STATE_SYSEX;
+			state = STATE_UNKNOWN;
+			break;
+		}
+	} else if (byte >= 0x80) {
+		newline = 1;
+		if (byte >= 0xc0 && byte <= 0xdf)
+			state = STATE_1PARAM;
+		else
+			state = STATE_2PARAM_1;
+	} else /* b < 0x80 */ {
+		int running_status = 0;
+		newline = state == STATE_UNKNOWN;
+		switch (state) {
+		case STATE_1PARAM:
+			state = STATE_1PARAM_CONTINUE;
+			break;
+		case STATE_1PARAM_CONTINUE:
+			running_status = 1;
+			break;
+		case STATE_2PARAM_1:
+			state = STATE_2PARAM_2;
+			break;
+		case STATE_2PARAM_2:
+			state = STATE_2PARAM_1_CONTINUE;
+			break;
+		case STATE_2PARAM_1_CONTINUE:
+			running_status = 1;
+			state = STATE_2PARAM_2;
+			break;
+		}
+		if (running_status)
+			fputs("\n  ", stdout);
+	}
+	printf("%c%02X", newline ? '\n' : ' ', byte);
+}
+
+static void sig_handler(int dummy)
+{
+	stop = 1;
+}
+
+int main(int argc, char *argv[])
+{
+	static char short_options[] = "hVlLp:s:r:S:dt:";
+	static struct option long_options[] = {
+		{"help", 0, NULL, 'h'},
+		{"version", 0, NULL, 'V'},
+		{"list-devices", 0, NULL, 'l'},
+		{"list-rawmidis", 0, NULL, 'L'},
+		{"port", 1, NULL, 'p'},
+		{"send", 1, NULL, 's'},
+		{"receive", 1, NULL, 'r'},
+		{"send-hex", 1, NULL, 'S'},
+		{"dump", 0, NULL, 'd'},
+		{"timeout", 1, NULL, 't'},
+		{ }
+	};
+	int c, err, ok = 0;
+
+	while ((c = getopt_long(argc, argv, short_options,
+		     		long_options, NULL)) != -1) {
+		switch (c) {
+		case 'h':
+			usage();
+			return 0;
+		case 'V':
+			version();
+			return 0;
+		case 'l':
+			do_device_list = 1;
+			break;
+		case 'L':
+			do_rawmidi_list = 1;
+			break;
+		case 'p':
+			port_name = optarg;
+			break;
+		case 's':
+			send_file_name = optarg;
+			break;
+		case 'r':
+			receive_file_name = optarg;
+			break;
+		case 'S':
+			send_hex = optarg;
+			break;
+		case 'd':
+			dump = 1;
+			break;
+		case 't':
+			timeout = atoi(optarg);
+			break;
+		default:
+			error("Try `amidi --help' for more information.");
+			return 1;
+		}
+	}
+
+	if (do_rawmidi_list)
+		rawmidi_list();
+	if (do_device_list)
+		device_list();
+	if (do_rawmidi_list || do_device_list)
+		return 0;
+
+	if (!send_file_name && !receive_file_name && !send_hex && !dump) {
+		error("Please specify at least one of --send, --receive, --send-hex, or --dump.");
+		return 1;
+	}
+	if (send_file_name && send_hex) {
+		error("--send and --send-hex cannot be specified at the same time.");
+		return 1;
+	}
+
+	if (send_file_name)
+		load_file();
+	else if (send_hex)
+		parse_data();
+	if ((send_file_name || send_hex) && !send_data)
+		return 1;
+
+	if (receive_file_name) {
+		receive_file = creat(receive_file_name, 0);
+		if (receive_file == -1) {
+			error("cannot create %s: %s", receive_file_name, strerror(errno));
+			return -1;
+		}
+	} else {
+		receive_file = -1;
+	}
+
+	if (receive_file_name || dump)
+		inputp = &input;
+	else
+		inputp = NULL;
+	if (send_data)
+		outputp = &output;
+	else
+		outputp = NULL;
+
+	if ((err = snd_rawmidi_open(inputp, outputp, port_name, 0)) < 0) {
+		error("cannot open port \"%s\": %s", port_name, snd_strerror(err));
+		goto _exit2;
+	}
+
+	if (inputp)
+		snd_rawmidi_read(input, NULL, 0); /* trigger reading */
+
+	if (send_data &&
+	    ((err = snd_rawmidi_write(output, send_data, send_data_length))) < 0) {
+		error("cannot send data: %s", snd_strerror(err));
+		goto _exit;
+	}
+
+	if (inputp) {
+		int read = 0;
+		int npfds, time = 0;
+		struct pollfd *pfds;
+
+		timeout *= 1000;
+		snd_rawmidi_nonblock(input, 1);
+		npfds = snd_rawmidi_poll_descriptors_count(input);
+		pfds = alloca(npfds * sizeof(struct pollfd));
+		snd_rawmidi_poll_descriptors(input, pfds, npfds);
+		signal(SIGINT, sig_handler);
+		for (;;) {
+			unsigned char buf[256];
+			int i, length;
+			unsigned short revents;
+
+			err = poll(pfds, npfds, 200);
+			if (stop || (err < 0 && errno == EINTR))
+				break;
+			if (err < 0) {
+				error("poll failed: %s", strerror(errno));
+				break;
+			}
+			if (err == 0) {
+				time += 200;
+				if (timeout && time >= timeout)
+					break;
+				continue;
+			}
+			if ((err = snd_rawmidi_poll_descriptors_revents(input, pfds, npfds, &revents)) < 0) {
+				error("cannot get poll events: %s", snd_strerror(errno));
+				break;
+			}
+			if (revents & (POLLERR | POLLHUP))
+				break;
+			if (!(revents & POLLIN))
+				continue;
+			err = snd_rawmidi_read(input, buf, sizeof(buf));
+			if (err == -EAGAIN)
+				continue;
+			if (err < 0) {
+				error("cannot read from port \"%s\": %s", port_name, snd_strerror(err));
+				break;
+			}
+			length = 0;
+			for (i = 0; i < err; ++i)
+				if (buf[i] != 0xfe) /* drop any active sensing bytes */
+					buf[length++] = buf[i];
+			if (length == 0)
+				continue;
+			read += length;
+			time = 0;
+			if (receive_file != -1)
+				write(receive_file, buf, length);
+			if (dump) {
+				for (i = 0; i < length; ++i)
+					print_byte(buf[i]);
+				fflush(stdout);
+			}
+		}
+		printf("\n%d bytes read\n", read);
+	}
+
+	ok = 1;
+_exit:
+	if (inputp)
+		snd_rawmidi_close(input);
+	if (outputp)
+		snd_rawmidi_close(output);
+_exit2:
+	if (receive_file != -1)
+		close(receive_file);
+	return !ok;
+}




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
