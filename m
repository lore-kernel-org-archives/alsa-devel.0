From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: [PATCH] new options for arecordmidi
Date: Sun, 4 Apr 2004 15:15:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404041515.41777.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9pAcAm79jxsszmi"
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


--Boundary-00=_9pAcAm79jxsszmi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This patch adds three new options to arecordmidi.

       -d,--dump
              Shows the received events as text on standard output.

       -m,--metronome=client:port
              Plays a metronome signal on the specified sequencer port.

              Metronome  sounds  are  played on channel 10, MIDI notes 33 & 34
              (GM metronome standard notes), with velocity 100 and duration 1.

       -i,--timesig=numerator:denominator
              Sets the time signature for the MIDI file and metronome.

              The  time signature is specified as usual with two numbers, rep-
              resenting the numerator and denominator of the time signature as
              it  would  be  notated.  Both  numbers  should be separated by a
              colon. The time signature is 4:4 by default.

Regards,
Pedro

--Boundary-00=_9pAcAm79jxsszmi
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="arecordmidi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="arecordmidi.patch"

Index: arecordmidi.1
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/arecordmidi.1,v
retrieving revision 1.1
diff -u -r1.1 arecordmidi.1
--- arecordmidi.1	23 Feb 2004 10:58:35 -0000	1.1
+++ arecordmidi.1	4 Apr 2004 12:49:01 -0000
@@ -58,5 +58,25 @@
 Specifies that the data for each MIDI channel should be written to a
 separate track in the MIDI file.
 
+.TP
+.I -d,--dump
+Shows the events received as text on standard output.
+
+.TP
+.I -m,--metronome=client:port
+Plays a metronome signal on the specified sequencer port.
+
+Metronome sounds are played on channel 10, MIDI notes 33 & 34 (GM 
+metronome standard notes), with velocity 100 and duration 1.
+
+.TP
+.I -i,--timesig=numerator:denominator
+Sets the time signature for the MIDI file and metronome.
+
+The time signature is specified as usual with two numbers, representing
+the numerator and denominator of the time signature as it would be 
+notated. Both numbers should be separated by a colon. The time signature 
+is 4:4 by default.
+
 .SH AUTHOR
 Clemens Ladisch <clemens@ladisch.de>
Index: arecordmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/seq/aplaymidi/arecordmidi.c,v
retrieving revision 1.1
diff -u -r1.1 arecordmidi.c
--- arecordmidi.c	23 Feb 2004 10:58:35 -0000	1.1
+++ arecordmidi.c	4 Apr 2004 12:49:02 -0000
@@ -53,6 +53,14 @@
 /* timing/sysex + 16 channels */
 #define TRACKS_PER_PORT 17
 
+/* metronome settings */
+/* TODO: create options for this */
+#define METRONOME_CHANNEL 9
+#define METRONOME_STRONG_NOTE 34
+#define METRONOME_WEAK_NOTE 33
+#define METRONOME_VELOCITY 100
+#define METRONOME_PROGRAM 0
+
 
 static snd_seq_t *seq;
 static int client;
@@ -68,7 +76,16 @@
 static int num_tracks;
 static struct smf_track *tracks;
 static volatile sig_atomic_t stop = 0;
-
+static int dump = 0;
+static snd_seq_addr_t *metronome_port = NULL;
+static int metronome_weak_note = METRONOME_WEAK_NOTE;
+static int metronome_strong_note = METRONOME_STRONG_NOTE;
+static int metronome_velocity = METRONOME_VELOCITY;
+static int metronome_program = METRONOME_PROGRAM;
+static int metronome_channel = METRONOME_CHANNEL;
+static int ts_num = 4; /* time signature: numerator */
+static int ts_div = 4; /* time signature: denominator */
+static int ts_dd = 2; /* time signature: denominator as a power of two */
 
 /* prints an error message to stderr, and dies */
 static void fatal(const char *msg, ...)
@@ -142,6 +159,159 @@
 	free(buf);
 }
 
+/* Metronome port setting */
+static void init_metronome(const char *arg)
+{
+	int err;
+	
+	metronome_port = malloc(sizeof(snd_seq_addr_t));
+	check_mem(metronome_port);
+	err = snd_seq_parse_address(seq, metronome_port, arg);
+	if (err < 0)
+		fatal("Invalid port %s - %s", arg, snd_strerror(err));
+}
+
+/* parses time signature specification */
+static void time_signature(const char *arg)
+{
+	long x = 0;
+	char *sep;
+
+        x = strtol(arg, &sep, 10);
+	if ((x < 1) | (x > 32) | (*sep != ':'))
+		fatal("Invalid time signature (%s)", arg);
+	ts_num = x;
+	x = strtol(++sep, NULL, 10);
+	if ((x < 1) | (x > 32))
+		fatal("Invalid time signature (%s)", arg);
+	ts_div = x;
+	for(ts_dd = 0; x > 1; x /= 2) ts_dd++;
+}
+
+/*
+ * Dump incoming events
+ */
+static void print_syx(int len, unsigned char *data)
+{
+	int i;
+	
+	for (i=0; i<len; i++) {
+		printf("%02x ", data[i]);
+	}
+	printf("\n");
+}
+
+static void print_time(snd_seq_event_t *ev)
+{
+	printf("%11d ", ev->time.tick);
+}
+
+static void print_midi_event(snd_seq_event_t *ev)
+{
+	switch (ev->type) {
+	case SND_SEQ_EVENT_SENSING:
+		print_time(ev);
+		printf("Active Sensing\n");
+		break;
+	case SND_SEQ_EVENT_NOTEOFF:
+		print_time(ev);
+		printf("Note off               %2d %3d %3d\n",
+		ev->data.note.channel, ev->data.note.note, ev->data.note.velocity);
+		break;
+	case SND_SEQ_EVENT_NOTEON:
+		print_time(ev);
+		printf("Note on                %2d %3d %3d\n",
+		ev->data.note.channel, ev->data.note.note, ev->data.note.velocity);
+		break;
+	case SND_SEQ_EVENT_KEYPRESS:
+		print_time(ev);
+		printf("Polyphonic aftertouch  %2d %3d %3d\n",
+		ev->data.note.channel, ev->data.note.note, ev->data.note.velocity);
+		break;
+	case SND_SEQ_EVENT_PITCHBEND:
+		print_time(ev);
+		printf("Pich bender            %2d  %6d\n",
+		ev->data.control.channel, ev->data.control.value);
+		break;
+	case SND_SEQ_EVENT_CHANPRESS:
+		print_time(ev);
+		printf("Channel aftertouch     %2d %3d\n",
+		ev->data.control.channel, ev->data.control.value);
+		break;
+	case SND_SEQ_EVENT_CONTROLLER:
+		print_time(ev);
+		printf("Control change         %2d %3d %3d\n",
+		ev->data.control.channel, ev->data.control.param, ev->data.control.value);
+		break;
+	case SND_SEQ_EVENT_PGMCHANGE:
+		print_time(ev);
+		printf("Program change         %2d %3d\n",
+		ev->data.control.channel, ev->data.control.value);
+		break;
+	case SND_SEQ_EVENT_SYSEX:
+		print_time(ev);
+		printf("System  exclusive      ");
+		print_syx(ev->data.ext.len, ev->data.ext.ptr);
+		break;
+	case SND_SEQ_EVENT_ECHO:
+		break;
+	default:
+		print_time(ev);
+		printf("Event type %d\n",  ev->type);
+	}
+}
+
+/*
+ * Metronome implementation
+ */
+static void metronome_note(unsigned char note, int tick)
+{
+	snd_seq_event_t ev;
+	snd_seq_ev_clear(&ev);
+	snd_seq_ev_set_note(&ev, metronome_channel, note, metronome_velocity, 1);
+	snd_seq_ev_schedule_tick(&ev, queue, 1, tick);
+	snd_seq_ev_set_source(&ev, port_count);
+	snd_seq_ev_set_subs(&ev);
+	snd_seq_event_output(seq, &ev);
+}
+
+static void metronome_echo(int tick)
+{
+	snd_seq_event_t ev;
+	snd_seq_ev_clear(&ev);
+	ev.type = SND_SEQ_EVENT_ECHO;
+	snd_seq_ev_schedule_tick(&ev, queue, 1, tick);
+	snd_seq_ev_set_source(&ev, port_count);
+	snd_seq_ev_set_dest(&ev, client, 0);
+	snd_seq_event_output(seq, &ev);
+}
+
+static void metronome_pattern(void)
+{
+	int j, t, duration;
+
+	t = 0;
+	duration = ticks * 4 / ts_div;
+	for (j = 0; j < ts_num; j++) {
+		metronome_note(j ? metronome_weak_note : metronome_strong_note, t);
+		t += duration;
+	}
+	metronome_echo(t);
+        snd_seq_drain_output(seq);
+}
+
+static void metronome_set_program(void)
+{
+	snd_seq_event_t ev;
+
+	snd_seq_ev_clear(&ev);
+	snd_seq_ev_set_pgmchange(&ev, metronome_channel, metronome_program);
+	snd_seq_ev_set_source(&ev, port_count);
+	snd_seq_ev_set_subs(&ev);
+	snd_seq_event_output(seq, &ev);
+}
+
+
 static void init_tracks(void)
 {
 	int i;
@@ -237,6 +407,18 @@
 		err = snd_seq_create_port(seq, pinfo);
 		check_snd("create port", err);
 	}
+
+	/* create an optional metronome port*/
+	if (metronome_port) {
+		snd_seq_port_info_set_capability(pinfo,
+						 SND_SEQ_PORT_CAP_READ |
+						 SND_SEQ_PORT_CAP_SUBS_READ);
+		snd_seq_port_info_set_port(pinfo, port_count);
+
+		snd_seq_port_info_set_name(pinfo, "arecordmidi metronome");
+		err = snd_seq_create_port(seq, pinfo);
+		check_snd("create metronome port", err);
+	}
 }
 
 static void connect_ports(void)
@@ -249,6 +431,14 @@
 			fatal("Cannot connect from port %d:%d - %s",
 			      ports[i].client, ports[i].port, snd_strerror(err));
 	}
+
+	/* subscribe the metronome port */
+	if (metronome_port) {
+	        err = snd_seq_connect_to(seq, port_count, metronome_port->client, metronome_port->port);
+		if (err < 0)
+	    		fatal("Cannot connect to port %d:%d - %s",
+			      metronome_port->client, metronome_port->port, snd_strerror(err));
+	}
 }
 
 /* records a byte to be written to the .mid file */
@@ -444,6 +634,9 @@
 		for (; i < ev->data.ext.len; ++i)
 			add_byte(track, ((unsigned char*)ev->data.ext.ptr)[i]);
 		break;
+	case SND_SEQ_EVENT_ECHO:
+		metronome_pattern();
+		break;
 	default:
 		return;
 	}
@@ -561,7 +754,10 @@
 		"  -b,--bpm=beats             tempo in beats per minute\n"
 		"  -f,--fps=frames            resolution in frames per second (SMPTE)\n"
 		"  -t,--ticks=ticks           resolution in ticks per beat or frame\n"
-		"  -s,--split-channels        create a track for each channel\n",
+		"  -s,--split-channels        create a track for each channel\n"
+		"  -d,--dump                  dump events on standard output\n"
+		"  -m,--metronome=client:port play a metronome signal\n"
+		"  -i,--timesig=nn:dd         time signature\n",
 		argv0);
 }
 
@@ -577,7 +773,7 @@
 
 int main(int argc, char *argv[])
 {
-	static char short_options[] = "hVlp:b:f:t:s";
+	static char short_options[] = "hVlp:b:f:t:sdm:i:";
 	static struct option long_options[] = {
 		{"help", 0, NULL, 'h'},
 		{"version", 0, NULL, 'V'},
@@ -587,6 +783,9 @@
 		{"fps", 1, NULL, 'f'},
 		{"ticks", 1, NULL, 't'},
 		{"split-channels", 0, NULL, 's'},
+		{"dump", 0, NULL, 'd'},
+		{"metronome", 1, NULL, 'm'},
+		{"timesig", 1, NULL, 'i'},
 		{ }
 	};
 
@@ -634,6 +833,15 @@
 		case 's':
 			channel_split = 1;
 			break;
+		case 'd':
+			dump = 1;
+			break;
+		case 'm':
+			init_metronome(optarg);
+			break;
+		case 'i':
+			time_signature(optarg);
+			break;
 		default:
 			help(argv[0]);
 			return 1;
@@ -679,6 +887,16 @@
 		add_byte(&tracks[0], usecs_per_quarter >> 8);
 		add_byte(&tracks[0], usecs_per_quarter);
 	}
+	/* time signature */
+	var_value(&tracks[0], 0); /* delta time */
+	add_byte(&tracks[0], 0xff);
+	add_byte(&tracks[0], 0x58);
+	var_value(&tracks[0], 4);
+	add_byte(&tracks[0], ts_num);
+	add_byte(&tracks[0], ts_dd);
+	add_byte(&tracks[0], 24);
+	add_byte(&tracks[0], 8);
+	
 	/* always write at least one track */
 	tracks[0].used = 1;
 
@@ -692,6 +910,16 @@
 
 	err = snd_seq_nonblock(seq, 1);
 	check_snd("set nonblock mode", err);
+	
+	if (dump) {
+		printf("Waiting for data. Press Ctrl+C to end\n");
+		printf("_______Tick Event_________________ Ch _Data__\n");
+	}
+	
+	if (metronome_port) {
+		metronome_set_program();
+		metronome_pattern();
+	}
 
 	signal(SIGINT, sighandler);
 	signal(SIGTERM, sighandler);
@@ -709,6 +937,8 @@
 				break;
 			if (event)
 				record_event(event);
+			if (dump)
+				print_midi_event(event);
 		} while (err > 0);
 		if (stop)
 			break;

--Boundary-00=_9pAcAm79jxsszmi--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
