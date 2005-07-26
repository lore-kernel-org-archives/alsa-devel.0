From: Dirk Jagdmann <doj@cubic.org>
Subject: envy24control midi updates
Date: Tue, 26 Jul 2005 02:44:35 +0200
Message-ID: <42E58773.2020609@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070401030804060509020605"
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070401030804060509020605
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers,

I have enhanced the midi control of envy24control.

1) I have fixed midi feedback, where issuing a controller event resulted 
in the controller value beeing sent to the midi port again.

2) I have added midi controllers for the "mute" buttons, which can now 
be controller via midi.

3) and while rewriting the midi code to support the mute buttons several 
off-by-one errors have been fixed.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------070401030804060509020605
Content-Type: text/plain;
 name="envy24control-buttons.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-buttons.patch"

Index: midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/midi.c,v
retrieving revision 1.2
diff -u -r1.2 midi.c
--- midi.c	27 Dec 2004 14:54:42 -0000	1.2
+++ midi.c	26 Jul 2005 00:37:00 -0000
@@ -1,7 +1,7 @@
 /*****************************************************************************
    envy24control.c - Env24 chipset (ICE1712) control utility
    midi controller code
-   (c) 2004 by Dirk Jagdmann <doj@cubic.org>
+   (c) 2004, 2005 by Dirk Jagdmann <doj@cubic.org>
 
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
@@ -27,13 +27,12 @@
 static snd_seq_t *seq=0;
 static int client, clientId, port, ch;
 static char *portname=0, *appname=0;
-static int nofeedback=-1;
 static int maxstreams=0;
-static uint8_t currentvalues[128];
+static int currentvalue[128];
 
 void midi_maxstreams(int m)
 {
-  maxstreams=(m-1)*2;
+  maxstreams=m*2;
 }
 
 int midi_close()
@@ -56,6 +55,10 @@
 {
   snd_seq_event_t ev;
   if(!seq) return;
+  if(currentvalue[c]==v) return;
+#if 0
+  fprintf(stderr, "do_controller(%i,%i)\n",c,v);
+#endif
   snd_seq_ev_clear(&ev);
   snd_seq_ev_set_source(&ev, port);
   snd_seq_ev_set_subs(&ev);
@@ -63,21 +66,34 @@
   snd_seq_ev_set_controller(&ev,ch,c,v);
   snd_seq_event_output(seq, &ev);
   snd_seq_drain_output(seq);
+
+  currentvalue[c]=v;
 }
 
 int midi_controller(int c, int v)
 {
-  if(c==nofeedback) return 0;
   if(c<0 || c>127) return 0;
 
   v*=127; v/=96;
   if(v<0) v=0;
   if(v>127) v=127;
-  currentvalues[c]=v;
+#if 0
+  fprintf(stderr, "midi_controller(%i,%i)\n",c,v);
+#endif
+  if(currentvalue[c]==v-1 || currentvalue[c]==v-2) return 0; /* because of 96to127 conversion values can differ up to two integers */
   do_controller(c,v);
   return 0;
 }
 
+int midi_button(int b, int v)
+{
+  if(b<0) return 0;
+  b+=maxstreams;
+  if(b>127) return 0;
+  do_controller(b, v?127:0);
+  return 0;
+}
+
 int midi_init(char *appname, int channel)
 {
   snd_seq_client_info_t *clientinfo;
@@ -87,6 +103,9 @@
   if(seq)
     return 0;
 
+  for(npfd=0; npfd!=128; ++npfd)
+    currentvalue[npfd]=-1;
+
   ch=channel;
 
   if(snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, SND_SEQ_NONBLOCK) < 0)
@@ -139,6 +158,7 @@
 }
 
 void mixer_adjust(GtkAdjustment *adj, gpointer data);
+void mixer_set_mute(int stream, int left, int right);
 
 void midi_process(gpointer data, gint source, GdkInputCondition condition)
 {
@@ -158,15 +178,27 @@
 	  fprintf(stderr, "Channel %02d: Controller %03d: Value:%d\n",
 		  ev->data.control.channel, ev->data.control.param, ev->data.control.value);
 #endif
-	  if(ev->data.control.channel == ch && ev->data.control.param < maxstreams)
+	  if(ev->data.control.channel == ch)
 	    {
-	      int stream=ev->data.control.param+1;
-	      long data=((stream/2)<<16)|(stream&1);
-	      int v=ev->data.control.value; v*=96; v/=127;
-	      gtk_adjustment_set_value(adj, 96-v);
-	      nofeedback=ev->data.control.param;
-	      mixer_adjust(adj, (gpointer)data);
-	      nofeedback=-1;
+	      currentvalue[ev->data.control.param]=ev->data.control.value;
+	      if(ev->data.control.param < maxstreams)
+		{
+		  int stream=ev->data.control.param;
+		  long data=((stream/2+1)<<16)|(stream&1);
+		  int v=ev->data.control.value; v*=96; v/=127;
+		  gtk_adjustment_set_value(adj, 96-v);
+		  mixer_adjust(adj, (gpointer)data);
+		}
+	      else if(ev->data.control.param < maxstreams*2)
+		{
+		  int b=ev->data.control.param-maxstreams;
+		  int left=-1, right=-1;
+		  if(b&1)
+		    right=ev->data.control.value;
+		  else
+		    left=ev->data.control.value;
+		  mixer_set_mute(b/2+1, left, right);
+		}
 	    }
 	  break;
 
@@ -178,8 +210,14 @@
 	  if(ev->data.connect.dest.client!=clientId)
 	    {
 	      int i;
-	      for(i=0; i<sizeof(currentvalues); ++i)
-		do_controller(i, currentvalues[i]);
+	      for(i=0; i!=128; ++i)
+		if(currentvalue[i] >= 0)
+		  {
+		    /* set currentvalue[i] to a fake value, so the check in do_controller does not trigger */
+		    int v=currentvalue[i];
+		    currentvalue[i]=-1;
+		    do_controller(i, v);
+		  }
 	    }
 	  break;
 	}
Index: midi.h
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/midi.h,v
retrieving revision 1.1
diff -u -r1.1 midi.h
--- midi.h	17 Nov 2004 11:41:57 -0000	1.1
+++ midi.h	26 Jul 2005 00:37:00 -0000
@@ -8,5 +8,6 @@
 void midi_maxstreams(int);
 int midi_controller(int c, int v);
 void midi_process(gpointer data, gint source, GdkInputCondition condition);
+int midi_button(int b, int v);
 
 #endif
Index: mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/mixer.c,v
retrieving revision 1.10
diff -u -r1.10 mixer.c
--- mixer.c	17 Nov 2004 11:41:57 -0000	1.10
+++ mixer.c	26 Jul 2005 00:37:00 -0000
@@ -63,8 +63,8 @@
 			toggle_set(mixer_stereo_toggle[stream-1], FALSE);
 		gtk_adjustment_set_value(GTK_ADJUSTMENT(mixer_adj[stream-1][0]), 96 - v[0]);
 		gtk_adjustment_set_value(GTK_ADJUSTMENT(mixer_adj[stream-1][1]), 96 - v[1]);
-		midi_controller(stream*2-1, v[0]);
-		midi_controller(stream*2,   v[1]);
+		midi_controller((stream-1)*2,   v[0]);
+		midi_controller((stream-1)*2+1, v[1]);
 	}
 	if (sw_flag) {
 		snd_ctl_elem_value_t *sw;
@@ -81,6 +81,8 @@
 			toggle_set(mixer_stereo_toggle[stream-1], FALSE);
 		toggle_set(mixer_mute_toggle[stream-1][0], !v[0] ? TRUE : FALSE);
 		toggle_set(mixer_mute_toggle[stream-1][1], !v[1] ? TRUE : FALSE);
+		midi_button((stream-1)*2, v[0]);
+		midi_button((stream-1)*2+1, v[1]);
 	}
 }
 
@@ -98,10 +100,12 @@
 	if (left >= 0 && left != snd_ctl_elem_value_get_boolean(sw, 0)) {
 		snd_ctl_elem_value_set_boolean(sw, 0, left);
 		changed = 1;
+		midi_button((stream-1)*2, left);
 	}
 	if (right >= 0 && right != snd_ctl_elem_value_get_boolean(sw, 1)) {
 		snd_ctl_elem_value_set_boolean(sw, 1, right);
 		changed = 1;
+		midi_button((stream-1)*2+1, right);
 	}
 	if (changed) {
 		err = snd_ctl_elem_write(ctl, sw);
@@ -127,12 +131,21 @@
 	set_switch1(stream, vol[0], vol[1]);
 }
 
+void mixer_set_mute(int stream, int left, int right)
+{
+  if(left>=0)
+    toggle_set(mixer_mute_toggle[stream-1][0], left ? TRUE : FALSE);
+  if(right>=0)
+    toggle_set(mixer_mute_toggle[stream-1][1], right ? TRUE : FALSE);
+  set_switch1(stream, left, right);
+}
+
 static void set_volume1(int stream, int left, int right)
 {
 	snd_ctl_elem_value_t *vol;
 	int change = 0;
 	int err;
@@ -142,12 +155,12 @@
 	if (left >= 0) {
 		change |= (snd_ctl_elem_value_get_integer(vol, 0) != left);
 		snd_ctl_elem_value_set_integer(vol, 0, left);
-		midi_controller(stream*2-1, left);
+		midi_controller((stream-1)*2, left);
 	}
 	if (right >= 0) {
 		change |= (snd_ctl_elem_value_get_integer(vol, 1) != right);
 		snd_ctl_elem_value_set_integer(vol, 1, right);
-		midi_controller(stream*2, right);
+		midi_controller((stream-1)*2+1, right);
 	}
 	if (change) {
 		if ((err = snd_ctl_elem_write(ctl, vol)) < 0 && err != -EBUSY)

--------------070401030804060509020605--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
