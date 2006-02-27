From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Mon, 27 Feb 2006 09:09:20 +0100
Message-ID: <4402B3B0.8000508@cendio.se>
References: <43F09D76.9060004@cendio.se>	<43F61E6D.5020206@cendio.se>	<s5hirr8k7ra.wl%tiwai@suse.de>	<43FB420D.8010605@cendio.se>	<s5hfymck6k3.wl%tiwai@suse.de>	<43FC3374.2030701@cendio.se>	<s5hirr7765t.wl%tiwai@suse.de>	<43FDB25D.402@cendio.se> <s5hwtfmb0ts.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060204040900030601010306"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70D2017C
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 09:09:23 +0100 (MET)
In-Reply-To: <s5hwtfmb0ts.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060204040900030601010306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just one more. :)

Seems I fumbled the control event code a bit. Only one event at a time 
got through. Here is a fix so that all four elements can change in one go.

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com

--------------060204040900030601010306
Content-Type: text/x-patch;
 name="polyp-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="polyp-update.patch"

? polyp-update.patch
Index: polyp/ctl_polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/ctl_polyp.c,v
retrieving revision 1.2
diff -u -r1.2 ctl_polyp.c
--- polyp/ctl_polyp.c	23 Feb 2006 14:31:13 -0000	1.2
+++ polyp/ctl_polyp.c	26 Feb 2006 21:48:32 -0000
@@ -48,6 +48,11 @@
 #define SINK_VOL_NAME "Master Playback Volume"
 #define SINK_MUTE_NAME "Master Playback Switch"
 
+#define UPDATE_SINK_VOL     0x01
+#define UPDATE_SINK_MUTE    0x02
+#define UPDATE_SOURCE_VOL   0x04
+#define UPDATE_SOURCE_MUTE  0x08
+
 static void sink_info_cb(pa_context *c, const pa_sink_info *i, int is_last, void *userdata)
 {
     snd_ctl_polyp_t *ctl = (snd_ctl_polyp_t*)userdata;
@@ -58,6 +63,11 @@
 
     assert(ctl && i);
 
+    if (!!ctl->sink_muted != !!i->mute) {
+        ctl->sink_muted = i->mute;
+        ctl->updated |= UPDATE_SINK_MUTE;
+    }
+
     if (ctl->sink_volume.channels == i->volume.channels) {
         for (chan = 0;chan < ctl->sink_volume.channels;chan++)
             if (i->volume.values[chan] != ctl->sink_volume.values[chan])
@@ -66,15 +76,10 @@
         if (chan == ctl->sink_volume.channels)
             return;
 
-        ctl->updated = 1;
+        ctl->updated |= UPDATE_SINK_VOL;
     }
 
     memcpy(&ctl->sink_volume, &i->volume, sizeof(pa_cvolume));
-
-    if (!!ctl->sink_muted != !!i->mute) {
-        ctl->sink_muted = i->mute;
-        ctl->updated = 1;
-    }
 }
 
 static void source_info_cb(pa_context *c, const pa_source_info *i, int is_last, void *userdata)
@@ -87,6 +92,11 @@
 
     assert(ctl && i);
 
+    if (!!ctl->source_muted != !!i->mute) {
+        ctl->source_muted = i->mute;
+        ctl->updated |= UPDATE_SOURCE_MUTE;
+    }
+
     if (ctl->source_volume.channels == i->volume.channels) {
         for (chan = 0;chan < ctl->source_volume.channels;chan++)
             if (i->volume.values[chan] != ctl->source_volume.values[chan])
@@ -95,15 +105,10 @@
         if (chan == ctl->source_volume.channels)
             return;
 
-        ctl->updated = 1;
+        ctl->updated |= UPDATE_SOURCE_VOL;
     }
 
     memcpy(&ctl->source_volume, &i->volume, sizeof(pa_cvolume));
-
-    if (!!ctl->source_muted != !!i->mute) {
-        ctl->source_muted = i->mute;
-        ctl->updated = 1;
-    }
 }
 
 static void event_cb(pa_context *c, pa_subscription_event_type_t t,
@@ -392,15 +397,33 @@
     unsigned int *event_mask)
 {
     snd_ctl_polyp_t *ctl = ext->private_data;
+    int offset;
 
     assert(ctl);
 
     if (!ctl->updated || !ctl->subscribed)
         return -EAGAIN;
 
-    polyp_elem_list(ext, 0, id);
+    if (ctl->source)
+        offset = 2;
+    else
+        offset = 0;
+
+    if (ctl->updated & UPDATE_SOURCE_VOL) {
+        polyp_elem_list(ext, 0, id);
+        ctl->updated &= ~UPDATE_SOURCE_VOL;
+    } else if (ctl->updated & UPDATE_SOURCE_MUTE) {
+        polyp_elem_list(ext, 1, id);
+        ctl->updated &= ~UPDATE_SOURCE_MUTE;
+    } else if (ctl->updated & UPDATE_SINK_VOL) {
+        polyp_elem_list(ext, offset + 0, id);
+        ctl->updated &= ~UPDATE_SINK_VOL;
+    } else if (ctl->updated & UPDATE_SINK_MUTE) {
+        polyp_elem_list(ext, offset + 1, id);
+        ctl->updated &= ~UPDATE_SINK_MUTE;
+    }
+
     *event_mask = SND_CTL_EVENT_MASK_VALUE;
-    ctl->updated = 0;
 
     return 1;
 }
@@ -416,11 +439,20 @@
 
 static int polyp_ctl_poll_descriptors(snd_ctl_ext_t *ext, struct pollfd *pfd, unsigned int space)
 {
+    int num;
+
 	snd_ctl_polyp_t *ctl = ext->private_data;
 
     assert(ctl && ctl->p);
 
-    return polyp_poll_descriptors(ctl->p, pfd, space);
+    num = polyp_poll_descriptors(ctl->p, pfd, space);
+    if (num < 0)
+        return num;
+
+    if (ctl->updated)
+        pa_mainloop_wakeup(ctl->p->mainloop);
+
+    return num;
 }
 
 static int polyp_ctl_poll_revents(snd_ctl_ext_t *ext, struct pollfd *pfd, unsigned int nfds, unsigned short *revents)

--------------060204040900030601010306--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
