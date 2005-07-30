From: Dirk Jagdmann <doj@cubic.org>
Subject: [patch] envy24control: enhanced mapping of midi controller
Date: Sat, 30 Jul 2005 16:18:49 +0200
Message-ID: <42EB8C49.6060905@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090406010105090703040907"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from roasted.cubic.org (roasted.cubic.org [193.108.181.130])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E66EE19A
	for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2005 16:18:50 +0200 (MEST)
Received: from c144092.adsl.hansenet.de ([213.39.144.92] helo=mrmucke.doj)
	by roasted.cubic.org with esmtp (Exim 3.36 #1)
	id 1DysAr-00074r-00
	for alsa-devel@alsa-project.org; Sat, 30 Jul 2005 16:18:50 +0200
Received: from [192.168.0.3] (helo=[192.168.0.3])
	by mrmucke.doj with esmtp (Exim 3.36 #1)
	id 1DysAw-0007uj-00
	for alsa-devel@alsa-project.org; Sat, 30 Jul 2005 16:18:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090406010105090703040907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch adds a command line option to select a better mapping from 
midi controller values to dB sliders. The default stays as a linear 
mapping, which has the disadvantage, that a sensible area to adjust your 
volume (which ist mostly in the range of 0..-12dB) is in the upper 
1/10th of your midi controller. This patch adds a map, which consists of 
two linear functions, so that the upper half of your midi controller 
controls values from 0..-12dB, the lower half then controls -13..-96dB.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------090406010105090703040907
Content-Type: text/plain;
 name="envy24control-enhancedmidi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-enhancedmidi.patch"

Index: envy24control.1
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.1,v
retrieving revision 1.9
diff -u -r1.9 envy24control.1
--- envy24control.1	17 Nov 2004 11:41:57 -0000	1.9
+++ envy24control.1	30 Jul 2005 13:39:59 -0000
@@ -1,10 +1,10 @@
-.TH "envy24control" "1" "16 May 2004" "" ""
+.TH "envy24control" "1" "30 July 2005" "" ""
 .SH "NAME"
 envy24control \- GUI control tool for Envy24 (ice1712) based
 soundcards, under ALSA.
 
 .SH "SYNOPSIS"
-\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel]
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP]
 
 .SH "DESCRIPTION"
 \fBenvy24control\fP allows control of the digital mixer, channel gains
@@ -13,7 +13,7 @@
 displays a level meter for each input and output channel.
 
 .SH "INVOKING"
-\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel]
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel] [\fI\-M\fP]
 .TP 
 If no control\-name is given, then the first sound card is used.
 
@@ -62,6 +62,9 @@
 Use MIDI controller values to control the Faders in the mixer view.
 The application will react to controllers on channel midi\-channel and
 send controllers on this channel when the user moves the GUI sliders.
+.TP 
+\fI\-M\fP
+Use an enhanced mapping from midi controller values to db sliders.
 .SH "SEE ALSO"
 \fB
 alsamixer(1),
Index: envy24control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.c,v
retrieving revision 1.35
diff -u -r1.35 envy24control.c
--- envy24control.c	24 May 2005 16:52:18 -0000	1.35
+++ envy24control.c	30 Jul 2005 13:40:00 -0000
@@ -1951,7 +1951,7 @@
 	snd_ctl_elem_value_t *val;
 	int npfds;
 	struct pollfd *pfds;
-	int midi_fd = -1, midi_channel = -1;
+	int midi_fd = -1, midi_channel = -1, midi_enhanced = 0;
 	int page;
 	int input_channels_set = 0;
 	int output_channels_set = 0;
@@ -1961,6 +1961,7 @@
 		{"profiles_file", 1, 0, 'f'},
 		{"inputs", 1, 0, 'i'},
 		{"midichannel", 1, 0, 'm'},
+		{"midienhanced", 0, 0, 'M'},
 		{"outputs", 1, 0, 'o'},
 		{"pcm_outputs", 1, 0, 'p'},
 		{"spdif", 1, 0, 's'},
@@ -1984,7 +1985,7 @@
 	view_spdif_playback = 0;
 	profiles_file_name = DEFAULT_PROFILERC;
 	default_profile = NULL;
-	while ((c = getopt_long(argc, argv, "D:c:f:i:m:o:p:s:v", long_options, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "D:c:f:i:m:Mo:p:s:v", long_options, NULL)) != -1) {
 		switch (c) {
 		case 'D':
 			name = optarg;
@@ -2023,6 +2024,7 @@
 			}
 			--midi_channel;
 			break;
+		case 'M': midi_enhanced = 1; break;
 		case 'o':
 			output_channels = atoi(optarg);
 			if (output_channels < 0 || output_channels > MAX_OUTPUT_CHANNELS) {
@@ -2122,7 +2124,7 @@
 	hardware_init();
 	analog_volume_init();
 	if (midi_channel >= 0)
-		midi_fd = midi_init(argv[0], midi_channel);
+		midi_fd = midi_init(argv[0], midi_channel, midi_enhanced);
 
 	fprintf(stderr, "using\t --- input_channels: %i\n\t --- output_channels: %i\n\t --- pcm_output_channels: %i\n\t --- spdif in/out channels: %i\n", \
 		input_channels, output_channels, pcm_output_channels, spdif_channels);
Index: midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/midi.c,v
retrieving revision 1.3
diff -u -r1.3 midi.c
--- midi.c	26 Jul 2005 11:37:11 -0000	1.3
+++ midi.c	30 Jul 2005 13:40:00 -0000
@@ -24,6 +24,75 @@
 #include <gtk/gtk.h>
 #include <stdint.h>
 
+static const int midi2slider_lin[128] = {
+  96, 96, 95, 94, 93, 93, 92, 91,
+  90, 90, 89, 88, 87, 87, 86, 85,
+  84, 84, 83, 82, 81, 81, 80, 79,
+  78, 78, 77, 76, 75, 75, 74, 73,
+  72, 72, 71, 70, 69, 69, 68, 67,
+  66, 66, 65, 64, 63, 62, 62, 61,
+  60, 59, 59, 58, 57, 56, 56, 55,
+  54, 53, 53, 52, 51, 50, 50, 49,
+  48, 47, 47, 46, 45, 44, 44, 43,
+  42, 41, 41, 40, 39, 38, 38, 37,
+  36, 35, 35, 34, 33, 32, 31, 31,
+  30, 29, 28, 28, 27, 26, 25, 25,
+  24, 23, 22, 22, 21, 20, 19, 19,
+  18, 17, 16, 16, 15, 14, 13, 13,
+  12, 11, 10, 10, 9, 8, 7, 7,
+  6, 5, 4, 4, 3, 2, 1, 0,
+};
+static const int slider2midi_lin[97] = {
+  0, 1, 2, 3, 5, 6, 7, 9,
+  10, 11, 13, 14, 15, 17, 18, 19,
+  21, 22, 23, 25, 26, 27, 29, 30,
+  31, 33, 34, 35, 37, 38, 39, 41,
+  42, 43, 44, 46, 47, 48, 50, 51,
+  52, 54, 55, 56, 58, 59, 60, 62,
+  63, 64, 66, 67, 68, 70, 71, 72,
+  74, 75, 76, 78, 79, 80, 82, 83,
+  84, 85, 87, 88, 89, 91, 92, 93,
+  95, 96, 97, 99, 100, 101, 103, 104,
+  105, 107, 108, 109, 111, 112, 113, 115,
+  116, 117, 119, 120, 121, 123, 124, 125,
+  127,
+};
+
+static const int midi2slider_enh[128] = {
+  96, 95, 94, 93, 91, 90, 89, 87,
+  86, 85, 83, 82, 81, 79, 78, 77,
+  75, 74, 73, 72, 70, 69, 68, 66,
+  65, 64, 62, 61, 60, 58, 57, 56,
+  54, 53, 52, 51, 49, 48, 47, 45,
+  44, 43, 41, 40, 39, 37, 36, 35,
+  33, 32, 31, 30, 28, 27, 26, 24,
+  23, 22, 20, 19, 18, 16, 15, 14,
+  12, 12, 12, 12, 12, 11, 11, 11,
+  11, 11, 10, 10, 10, 10, 10, 9,
+  9, 9, 9, 9, 8, 8, 8, 8,
+  8, 7, 7, 7, 7, 7, 6, 6,
+  6, 6, 6, 5, 5, 5, 5, 5,
+  4, 4, 4, 4, 4, 3, 3, 3,
+  3, 3, 2, 2, 2, 2, 2, 1,
+  1, 1, 1, 1, 0, 0, 0, 0,
+};
+static const int slider2midi_enh[97] = {
+  0, 1, 2, 3, 4, 4, 5, 6,
+  7, 7, 8, 9, 10, 10, 11, 12,
+  13, 13, 14, 15, 16, 16, 17, 18,
+  19, 20, 20, 21, 22, 23, 23, 24,
+  25, 26, 26, 27, 28, 29, 29, 30,
+  31, 32, 32, 33, 34, 35, 36, 36,
+  37, 38, 39, 39, 40, 41, 42, 42,
+  43, 44, 45, 45, 46, 47, 48, 48,
+  49, 50, 51, 52, 52, 53, 54, 55,
+  55, 56, 57, 58, 58, 59, 60, 61,
+  61, 62, 63, 68, 68, 73, 78, 83,
+  88, 93, 98, 103, 108, 113, 118, 123,
+  127,
+};
+
+static const int *midi2slider, *slider2midi;
 static snd_seq_t *seq=0;
 static int client, clientId, port, ch;
 static char *portname=0, *appname=0;
@@ -72,16 +141,16 @@
 
 int midi_controller(int c, int v)
 {
+  int v2;
   if(c<0 || c>127) return 0;
 
-  v*=127; v/=96;
   if(v<0) v=0;
-  if(v>127) v=127;
+  else if(v>96) v=96;
+  v2=slider2midi[v];
 #if 0
-  fprintf(stderr, "midi_controller(%i,%i)\n",c,v);
+  fprintf(stderr, "midi_controller(%i,%i)->%i\n",c,v,v2);
 #endif
-  if(currentvalue[c]==v-1 || currentvalue[c]==v-2) return 0; /* because of 96to127 conversion values can differ up to two integers */
-  do_controller(c,v);
+  do_controller(c,v2);
   return 0;
 }
 
@@ -94,7 +163,7 @@
   return 0;
 }
 
-int midi_init(char *appname, int channel)
+int midi_init(char *appname, int channel, int midi_enhanced)
 {
   snd_seq_client_info_t *clientinfo;
   int npfd;
@@ -107,6 +176,16 @@
     currentvalue[npfd]=-1;
 
   ch=channel;
+  if(midi_enhanced)
+    {
+      midi2slider=midi2slider_enh;
+      slider2midi=slider2midi_enh;
+    }
+  else
+    {
+      midi2slider=midi2slider_lin;
+      slider2midi=slider2midi_lin;
+    }
 
   if(snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, SND_SEQ_NONBLOCK) < 0)
     {
@@ -185,8 +264,7 @@
 		{
 		  int stream=ev->data.control.param;
 		  long data=((stream/2+1)<<16)|(stream&1);
-		  int v=ev->data.control.value; v*=96; v/=127;
-		  gtk_adjustment_set_value(adj, 96-v);
+		  gtk_adjustment_set_value(adj, midi2slider[ev->data.control.value]);
 		  mixer_adjust(adj, (gpointer)data);
 		}
 	      else if(ev->data.control.param < maxstreams*2)
@@ -225,3 +303,58 @@
     }
   while (snd_seq_event_input_pending(seq, 0) > 0);
 }
+
+/* ************************************************* */
+/* C++ code to help calculating midi<->slider tables */
+#if 0
+#include <iostream>
+#include <map>
+#include <vector>
+using namespace std;
+int main()
+{
+  int i;
+  int midi2slider[128];
+  ///// your midi to slider conversion should be calculated here
+  for(i=0; i<64; ++i)
+    midi2slider[i]=(i*84)/64;
+  for(i=0; i<64; ++i)
+    midi2slider[i+64]=(i*13)/64+84;
+  ///// end of your calculation
+
+  // print map
+  map<int,int> m;
+  int z=-1;
+  cout << "static const int midi2slider_enh[128] = {" << endl;
+  for(i=0; i<128; ++i)
+    {
+      int v=96-midi2slider[i];
+      cout << v << ", ";
+      if(((++z)%8)==7)
+	cout << endl;
+      m[v]=z;
+    }
+  cout << "};" << endl;
+
+  // now generate the reverse map
+  vector<int> rm;
+  cout << "static const int slider2midi_enh[97] = {" << endl;
+  int last=0;
+  for(i=0; i<97; ++i)
+    {
+      int v=m[i];
+      if(v==0) v=last;
+      last=v;
+      rm.push_back(v);
+    }
+  z=-1;
+  for(i=96; i>=0; --i)
+    {
+      cout << rm[i] << ", ";
+      if(((++z)%8)==7)
+	cout << endl;
+    }
+  cout << "};" << endl;
+  return 0;
+}
+#endif
Index: midi.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/midi.h,v
retrieving revision 1.2
diff -u -r1.2 midi.h
--- midi.h	26 Jul 2005 11:37:11 -0000	1.2
+++ midi.h	30 Jul 2005 13:40:00 -0000
@@ -3,7 +3,7 @@
 
 #include <gdk/gdk.h>
 
-int midi_init(char *appname, int channel);
+int midi_init(char *appname, int channel, int midi_enhanced);
 int midi_close();
 void midi_maxstreams(int);
 int midi_controller(int c, int v);

--------------090406010105090703040907--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
