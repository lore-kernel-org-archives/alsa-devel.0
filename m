From: Dirk Jagdmann <doj@cubic.org>
Subject: envy24control: midi support for mixer
Date: Thu, 11 Nov 2004 21:50:08 +0100
Message-ID: <4193D080.9060508@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030809030009020708040601"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.
--------------030809030009020708040601
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello devlopers,

I have made the mixer sliders in envy24control react to MIDI 
controllers. This way the hardware mixer can be controlled from a 
sequencer program or some external MIDI controller hardware.

envy24control became a standard ALSA sequencer client which you can 
connect to arbitrary other MIDI sources/sinks.

The patch is attached to this email. Please tell me, if this can be 
included with the standard alsa-tools sources.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------030809030009020708040601
Content-Type: text/plain;
 name="envy24control-midi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-midi.patch"

diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/Makefile.am envy24control/Makefile.am
--- envy24control.orig/Makefile.am	Thu Nov 11 21:42:51 2004
+++ envy24control/Makefile.am	Thu Nov 11 13:34:09 2004
@@ -1,9 +1,9 @@
 AM_CFLAGS = @ENVY24CONTROL_CFLAGS@
 bin_PROGRAMS = envy24control
 man_MANS = envy24control.1
-envy24control_SOURCES = envy24control.c envy24control.h levelmeters.c \
+envy24control_SOURCES = envy24control.c envy24control.h levelmeters.c midi.c \
                         mixer.c patchbay.c hardware.c driverevents.c volume.c \
 			profiles.c profiles.h
 envy24control_LDFLAGS = @ENVY24CONTROL_LIBS@
 EXTRA_DIST = envy24control.1 depcomp configure.in-gtk2 \
 	     strstr_icase_blank.c new_process.c README.profiles
diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/envy24control.1 envy24control/envy24control.1
--- envy24control.orig/envy24control.1	Thu Nov 11 21:42:51 2004
+++ envy24control/envy24control.1	Thu Nov 11 21:28:55 2004
@@ -1,72 +1,75 @@
-.TH "envy24control" 1 "16 May 2004"
-.SH NAME
+.TH "envy24control" "1" "16 May 2004" "" ""
+.SH "NAME"
 envy24control \- GUI control tool for Envy24 (ice1712) based
 soundcards, under ALSA.
 
-.SH SYNOPSIS
-\fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
+.SH "SYNOPSIS"
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel]
 
-.SH DESCRIPTION
+.SH "DESCRIPTION"
 \fBenvy24control\fP allows control of the digital mixer, channel gains
 and other hardware settings for sound cards based on the ice1712
 chipset (Midiman Delta series, Terratec EWS and EWX series). It also
 displays a level meter for each input and output channel.
 
-.SH INVOKING
-
-\fBenvy24control\fP [\fI\-c\fP card-number] [\fI\-D\fP control-name] [\fI\-o\fP 0-num DACs max 8] [\fI\-i\fP 0-num ADCs max 8] [\fI\-p\fP 0-8] [\fI\-s\fP 0-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>]
-.TP
-If no control-name is given, then the first sound card is used.
+.SH "INVOKING"
+\fBenvy24control\fP [\fI\-c\fP card\-number] [\fI\-D\fP control\-name] [\fI\-o\fP 0\-num DACs max 8] [\fI\-i\fP 0\-num ADCs max 8] [\fI\-p\fP 0\-8] [\fI\-s\fP 0\-2] [\fI\-f\fP <profiles file name>] [\fI\-v\fP] [<profile number>|<profile name>] [\fI\-m\fP midi\-channel]
+.TP 
+If no control\-name is given, then the first sound card is used.
 
 .SS Options
-.TP
-\fI\-c\fP card-number
-Use the card specified by card-number rather than the first card.
+.TP 
+\fI\-c\fP card\-number
+Use the card specified by card\-number rather than the first card.
 This is equivalent with \fI\-Dhw:n\fP option where \fIn\fP is the card number.
-.TP
-\fI\-D\fP control-name
-Use the card specified by control-name rather than the first card,
+.TP 
+\fI\-D\fP control\-name
+Use the card specified by control\-name rather than the first card,
 normally this will be of the form hw:\fIn\fP where \fIn\fP is the sound
-card number (zero-based). This is only needed if you have more than one
-Envy24-based card or if your Envy24 card is not configured as the first
+card number (zero\-based). This is only needed if you have more than one
+Envy24\-based card or if your Envy24 card is not configured as the first
 card in your ALSA driver setup.
-.TP
+.TP 
 \fI\-o\fP outputs
 Limit number of analog line outputs to display.  Default is the number of
 DACs in the driver specification. Maximum is 8.
 The number of analog output lines can only be reduced from the available
 number of output lines.
-.TP
+.TP 
 \fI\-i\fP inputs
 Limit number of analog line inputs to display.  Default is the number of
 ADCs in the driver specification. Maximum is 8.
 The number of analog input lines can only be reduced from the available
 number of input lines.
-.TP
+.TP 
 \fI\-p\fP pcm outputs
 Limit number of PCM outputs to display.  Default is 8.
-.TP
+.TP 
 \fI\-s\fP spdif inputs/outputs
 Limit number of SPDIF inputs/outputs to display.  Default is 2.
-.TP
+.TP 
 \fI\-f\fP name and path of the profiles file name.
 From/to this file will envy24control read/write the alsactl settings.
 If is not given DEFAULT_PROFILERC or for restore if DEFAULT_PROFILERC
 doesn't exists SYS_PROFILERC will be used.
-.TP
+.TP 
 \fI\-v\fP view spdif playback channels in the mixer.
 It is not possible to manage something (muting, volume levels).
 It is only to view the levelmeters.
 Default is no view of spdif playback channels in the mixer.
-
-.SH SEE ALSO
+.TP 
+\fI\-m\fP midi\-channel
+Use MIDI controller values to control the Faders in the mixer view.
+The application will react to controllers on channel midi\-channel and
+send controllers on this channel when the user moves the GUI sliders.
+.SH "SEE ALSO"
 \fB
 alsamixer(1),
 amixer(1),
 gamix(1)
 \fP
 
-.SH AUTHOR
+.SH "AUTHOR"
 \fBenvy24control\fP is  by Jaroslav Kysela <perex@suse.cz>
 This document is by James Tappin <james@xena.uklinux.net>.
 Last updated by Dirk Kalis <dirk.kalis@t\-online.de>.
diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/envy24control.c envy24control/envy24control.c
--- envy24control.orig/envy24control.c	Thu Nov 11 21:42:51 2004
+++ envy24control/envy24control.c	Thu Nov 11 15:02:58 2004
@@ -19,10 +19,11 @@
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 ******************************************************************************/
 
 #include "envy24control.h"
+#include "midi.h"
 #define _GNU_SOURCE
 #include <getopt.h>
 
 int input_channels, output_channels, pcm_output_channels, spdif_channels, view_spdif_playback, card_number;
 char *profiles_file_name, *default_profile;
@@ -1924,19 +1925,20 @@
 	}
 }
 
 static void usage(void)
 {
-	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name] [-o num-outputs] [-i num-inputs] [-p num-pcm-outputs] [-s num-spdif-in/outs] [-v] [-f profiles-file] [profile name|profile id]\n");
+	fprintf(stderr, "usage: envy24control [-c card#] [-D control-name] [-o num-outputs] [-i num-inputs] [-p num-pcm-outputs] [-s num-spdif-in/outs] [-v] [-f profiles-file] [profile name|profile id] [-m channel-num]\n");
 	fprintf(stderr, "\t-c, --card\tAlsa card number to control\n");
 	fprintf(stderr, "\t-D, --device\tcontrol-name\n");
 	fprintf(stderr, "\t-o, --outputs\tLimit number of analog line outputs to display\n");
 	fprintf(stderr, "\t-i, --input\tLimit number of analog line inputs to display\n");
 	fprintf(stderr, "\t-p, --pcm_output\tLimit number of PCM outputs to display\n");
 	fprintf(stderr, "\t-s, --spdif\tLimit number of spdif inputs/outputs to display\n");
 	fprintf(stderr, "\t-v, --view_spdif_playback\tshows the spdif playback channels in the mixer\n");
 	fprintf(stderr, "\t-f, --profiles_file\tuse file as profiles file\n");
+	fprintf(stderr, "\t-m, --midichannel\tmidi channel number for controller control\n");
 }
 
 int main(int argc, char **argv)
 {
         GtkWidget *notebook;
@@ -1944,21 +1946,23 @@
 	int i, c, err;
 	snd_ctl_card_info_t *hw_info;
 	snd_ctl_elem_value_t *val;
 	int npfds;
 	struct pollfd *pfds;
+	int midi_fd=-1, midi_channel=0;
 	int page;
 	int input_channels_set = 0;
 	int output_channels_set = 0;
 	static struct option long_options[] = {
 		{"device", 1, 0, 'D'},
 		{"card", 1, 0, 'c'},
+		{"profiles_file", 1, 0, 'f'},
 		{"inputs", 1, 0, 'i'},
+		{"midichannel", 1, 0, 'm'},
 		{"outputs", 1, 0, 'o'},
 		{"pcm_outputs", 1, 0, 'p'},
 		{"spdif", 1, 0, 's'},
-		{"profiles_file", 1, 0, 'f'},
 		{"view_spdif_playback", 0, 0, 'v'},
 		{ NULL }
 	};
 
 
@@ -1975,38 +1979,49 @@
 	pcm_output_channels = MAX_PCM_OUTPUT_CHANNELS;
 	spdif_channels = MAX_SPDIF_CHANNELS;
 	view_spdif_playback = 0;
 	profiles_file_name = DEFAULT_PROFILERC;
 	default_profile = NULL;
-	while ((c = getopt_long(argc, argv, "D:c:i:o:p:s:f:v", long_options, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "D:c:f:i:m:o:p:s:v", long_options, NULL)) != -1) {
 		switch (c) {
+		case 'D':
+			name = optarg;
+			card_number = atoi(strchr(name, ':') + sizeof(char));
+			if (card_number < 0 || card_number >= MAX_CARD_NUMBERS) {
+				fprintf(stderr, "envy24control: invalid card number %d\n", card_number);
+				exit(1);
+			}
+			break;
 		case 'c':
 			i = atoi(optarg);
 			if (i < 0 || i >= MAX_CARD_NUMBERS) {
 				fprintf(stderr, "envy24control: invalid card number %d\n", i);
 				exit(1);
 			}
 			card_number = i;
 			sprintf(tmpname, "hw:%d", i);
 			name = tmpname;
 			break;
-		case 'D':
-			name = optarg;
-			card_number = atoi(strchr(name, ':') + sizeof(char));
-			if (card_number < 0 || card_number >= MAX_CARD_NUMBERS) {
-				fprintf(stderr, "envy24control: invalid card number %d\n", card_number);
-				exit(1);
-			}
+		case 'f':
+			profiles_file_name = optarg;
 			break;
 		case 'i':
 			input_channels = atoi(optarg);
 			if (input_channels < 0 || input_channels > MAX_INPUT_CHANNELS) {
 				fprintf(stderr, "envy24control: must have 0-%i inputs\n", MAX_INPUT_CHANNELS);
 				exit(1);
 			}
 			input_channels_set = 1;
 			break;
+		case 'm':
+			midi_channel=atoi(optarg);
+			if(midi_channel<1 || midi_channel>16) {
+				fprintf(stderr, "envy24control: invalid midi channel number %i\n", midi_channel);
+				exit(1);
+			}
+			--midi_channel;
+			break;
 		case 'o':
 			output_channels = atoi(optarg);
 			if (output_channels < 0 || output_channels > MAX_OUTPUT_CHANNELS) {
 				fprintf(stderr, "envy24control: must have 0-%i outputs\n", MAX_OUTPUT_CHANNELS);
 				exit(1);
@@ -2025,13 +2040,10 @@
 			if (spdif_channels < 0 || spdif_channels > MAX_SPDIF_CHANNELS) {
 				fprintf(stderr, "envy24control: must have 0-%i spdifs\n", MAX_SPDIF_CHANNELS);
 				exit(1);
 			}
 			break;
-		case 'f':
-			profiles_file_name = optarg;
-			break;
 		case 'v':
 			view_spdif_playback = 1;
 			break;
 		default:
 			usage();
@@ -2081,10 +2093,11 @@
 	level_meters_init();
 	mixer_init();
 	patchbay_init();
 	hardware_init();
 	analog_volume_init();
+	midi_fd=midi_init(argv[0], midi_channel);
 
 	fprintf(stderr, "using\t --- input_channels: %i\n\t --- output_channels: %i\n\t --- pcm_output_channels: %i\n\t --- spdif in/out channels: %i\n", \
 		input_channels, output_channels, pcm_output_channels, spdif_channels);
 
         /* Make the title */
@@ -2121,10 +2134,13 @@
 				      GDK_INPUT_READ,
 				      control_input_callback,
 				      ctl);
 		snd_ctl_subscribe_events(ctl, 1);
 	}
+	if(midi_fd >= 0) {
+		gdk_input_add(midi_fd, GDK_INPUT_READ, midi_process, NULL);
+	}
 	gtk_timeout_add(40, level_meters_timeout_callback, NULL);
 	gtk_timeout_add(100, master_clock_status_timeout_callback, NULL);
 	gtk_timeout_add(100, internal_clock_status_timeout_callback, NULL);
 	gtk_timeout_add(100, rate_locking_status_timeout_callback, NULL);
 	gtk_timeout_add(100, rate_reset_status_timeout_callback, NULL);
@@ -2139,8 +2155,9 @@
 	analog_volume_postinit();
 
 	gtk_main();
 
 	snd_ctl_close(ctl);
+	midi_close();
 
 	return EXIT_SUCCESS;
 }
diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/midi.c envy24control/midi.c
--- envy24control.orig/midi.c	Thu Jan  1 01:00:00 1970
+++ envy24control/midi.c	Thu Nov 11 21:18:52 2004
@@ -0,0 +1,188 @@
+/*****************************************************************************
+   envy24control.c - Env24 chipset (ICE1712) control utility
+   midi controller code
+   (c) 2004 by Dirk Jagdmann <doj@cubic.org>
+
+   This program is free software; you can redistribute it and/or
+   modify it under the terms of the GNU General Public License
+   as published by the Free Software Foundation; either version 2
+   of the License, or (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+******************************************************************************/
+
+#include <string.h>
+#include <alsa/asoundlib.h>
+#include "midi.h"
+#include <gtk/gtk.h>
+#include <stdint.h>
+
+static snd_seq_t *seq=0;
+static int client, clientId, port, ch;
+static char *portname=0, *appname=0;
+static int nofeedback=-1;
+static int maxstreams=0;
+static uint8_t currentvalues[128];
+
+void midi_maxstreams(int m)
+{
+  maxstreams=(m-1)*2;
+}
+
+int midi_close()
+{
+  int i=0;
+  if(seq)
+    i=snd_seq_close(seq);
+
+  seq=0;
+  client=port=0;
+  if(portname)
+    free(portname), portname=0;
+  if(appname)
+    free(appname), appname=0;
+
+  return i;
+}
+
+static void do_controller(int c, int v)
+{
+  snd_seq_event_t ev;
+  snd_seq_ev_clear(&ev);
+  snd_seq_ev_set_source(&ev, port);
+  snd_seq_ev_set_subs(&ev);
+  snd_seq_ev_set_direct(&ev);
+  snd_seq_ev_set_controller(&ev,ch,c,v);
+  snd_seq_event_output(seq, &ev);
+  snd_seq_drain_output(seq);
+}
+
+int midi_controller(int c, int v)
+{
+  if(c==nofeedback) return 0;
+  if(c<0 || c>127) return 0;
+
+  v*=127; v/=96;
+  if(v<0) v=0;
+  if(v>127) v=127;
+  currentvalues[c]=v;
+  do_controller(c,v);
+  return 0;
+}
+
+int midi_init(char *appname, int channel)
+{
+  snd_seq_client_info_t *clientinfo;
+  int npfd;
+  struct pollfd *pfd;
+
+  if(seq)
+    return 0;
+
+  ch=channel;
+
+  if(snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, SND_SEQ_NONBLOCK) < 0)
+    {
+      g_warning("could not init ALSA sequencer\n");
+      seq=0;
+      return -1;
+    }
+
+  snd_seq_set_client_name(seq, appname);
+  snd_seq_client_info_alloca(&clientinfo);
+  snd_seq_get_client_info (seq, clientinfo);
+  client=snd_seq_client_info_get_client(clientinfo);
+  clientId = snd_seq_client_id(seq);
+
+  portname=g_strdup_printf("%s Mixer Control", appname);
+  port=snd_seq_create_simple_port(seq, portname,
+				  SND_SEQ_PORT_CAP_WRITE|SND_SEQ_PORT_CAP_SUBS_WRITE|SND_SEQ_PORT_CAP_READ|SND_SEQ_PORT_CAP_SUBS_READ,
+				  SND_SEQ_PORT_TYPE_APPLICATION);
+  if(port < 0)
+    {
+      g_warning("could not create ALSA sequencer port\n");
+      midi_close();
+      return -1;
+    }
+
+  npfd=snd_seq_poll_descriptors_count(seq, POLLIN);
+  if(npfd<=0)
+    {
+      g_warning("could not get number of ALSA sequencer poll descriptors\n");
+      midi_close();
+      return -1;
+    }
+
+  pfd=(struct pollfd*)alloca(npfd * sizeof(struct pollfd));
+  if(pfd==0)
+    {
+      g_warning("could not alloc memory for ALSA sequencer poll descriptors\n");
+      midi_close();
+      return -1;
+    }
+  if(snd_seq_poll_descriptors(seq, pfd, npfd, POLLIN) != npfd)
+    {
+      g_warning("number of returned poll desc is not equal of request poll desc\n");
+      midi_close();
+      return -1;
+    }
+
+  return pfd[0].fd;
+}
+
+void mixer_adjust(GtkAdjustment *adj, gpointer data);
+
+void midi_process(gpointer data, gint source, GdkInputCondition condition)
+{
+  snd_seq_event_t *ev;
+  static GtkAdjustment *adj=0;
+  if(!adj)
+    adj=(GtkAdjustment*) gtk_adjustment_new(0, 0, 96, 1, 1, 10);
+
+  do
+    {
+      snd_seq_event_input(seq, &ev);
+      if(!ev) continue;
+      switch(ev->type)
+	{
+	case SND_SEQ_EVENT_CONTROLLER:
+#if 0
+	  fprintf(stderr, "Channel %02d: Controller %03d: Value:%d\n",
+		  ev->data.control.channel, ev->data.control.param, ev->data.control.value);
+#endif
+	  if(ev->data.control.channel == ch && ev->data.control.param < maxstreams)
+	    {
+	      int stream=ev->data.control.param+1;
+	      long data=((stream/2)<<16)|(stream&1);
+	      int v=ev->data.control.value; v*=96; v/=127;
+	      gtk_adjustment_set_value(adj, 96-v);
+	      nofeedback=ev->data.control.param;
+	      mixer_adjust(adj, (gpointer)data);
+	      nofeedback=-1;
+	    }
+	  break;
+
+	case SND_SEQ_EVENT_PORT_SUBSCRIBED:
+#if 0
+	  fprintf(stderr, "event subscribed send.client:%i dest.client:%i clientId:%i\n",
+		  (int)ev->data.connect.sender.client, (int)ev->data.connect.dest.client, clientId);
+#endif
+	  if(ev->data.connect.dest.client!=clientId)
+	    {
+	      int i;
+	      for(i=0; i<sizeof(currentvalues); ++i)
+		do_controller(i, currentvalues[i]);
+	    }
+	  break;
+	}
+      snd_seq_free_event(ev);
+    }
+  while (snd_seq_event_input_pending(seq, 0) > 0);
+}
diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/midi.h envy24control/midi.h
--- envy24control.orig/midi.h	Thu Jan  1 01:00:00 1970
+++ envy24control/midi.h	Thu Nov 11 14:29:38 2004
@@ -0,0 +1,12 @@
+#ifndef MIDI__H
+#define MIDI__H
+
+#include <gdk/gdk.h>
+
+int midi_init(char *appname, int channel);
+int midi_close();
+void midi_maxstreams(int);
+int midi_controller(int c, int v);
+void midi_process(gpointer data, gint source, GdkInputCondition condition);
+
+#endif
diff -u -U 5 -r --new-file -x *~ -X /tmp/diffexclude envy24control.orig/mixer.c envy24control/mixer.c
--- envy24control.orig/mixer.c	Thu Nov 11 21:42:51 2004
+++ envy24control/mixer.c	Thu Nov 11 21:17:41 2004
@@ -16,10 +16,11 @@
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 ******************************************************************************/
 
 #include "envy24control.h"
+#include "midi.h"
 
 #define	MULTI_PLAYBACK_SWITCH		"Multi Playback Switch"
 #define MULTI_PLAYBACK_VOLUME		"Multi Playback Volume"
 
 #define HW_MULTI_CAPTURE_SWITCH		"H/W Multi Capture Switch"
@@ -60,10 +61,12 @@
 		v[1] = snd_ctl_elem_value_get_integer(vol, 1);
 		if (v[0] != v[1])
 			toggle_set(mixer_stereo_toggle[stream-1], FALSE);
 		gtk_adjustment_set_value(GTK_ADJUSTMENT(mixer_adj[stream-1][0]), 96 - v[0]);
 		gtk_adjustment_set_value(GTK_ADJUSTMENT(mixer_adj[stream-1][1]), 96 - v[1]);
+		midi_controller(stream*2-1, v[0]);
+		midi_controller(stream*2,   v[1]);
 	}
 	if (sw_flag) {
 		snd_ctl_elem_value_t *sw;
 		int v[2];
 		snd_ctl_elem_value_alloca(&sw);
@@ -137,14 +140,16 @@
 	if ((err = snd_ctl_elem_read(ctl, vol)) < 0)
 		g_print("Unable to read multi volume: %s\n", snd_strerror(err));
 	if (left >= 0) {
 		change |= (snd_ctl_elem_value_get_integer(vol, 0) != left);
 		snd_ctl_elem_value_set_integer(vol, 0, left);
+		midi_controller(stream*2-1, left);
 	}
 	if (right >= 0) {
 		change |= (snd_ctl_elem_value_get_integer(vol, 1) != right);
 		snd_ctl_elem_value_set_integer(vol, 1, right);
+		midi_controller(stream*2, right);
 	}
 	if (change) {
 		if ((err = snd_ctl_elem_write(ctl, vol)) < 0 && err != -EBUSY)
 			g_print("Unable to write multi volume: %s\n", snd_strerror(err));
 	}
@@ -173,10 +178,12 @@
 void mixer_init(void)
 {
 	int i;
 	int nb_active_channels;
 	snd_ctl_elem_value_t *val;
+
+	midi_maxstreams(sizeof(stream_is_active)/sizeof(stream_is_active[0]));
 
 	snd_ctl_elem_value_alloca(&val);
 	snd_ctl_elem_value_set_interface(val, SND_CTL_ELEM_IFACE_MIXER);
 	memset (stream_is_active, 0, (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + MAX_SPDIF_CHANNELS) * sizeof(int));
 	snd_ctl_elem_value_set_name(val, MULTI_PLAYBACK_SWITCH);

--------------030809030009020708040601--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
