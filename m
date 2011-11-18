From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: dmix issue when used with hot-plugged devices
Date: Fri, 18 Nov 2011 15:39:27 +0100
Message-ID: <4EC66E1F.2070800@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aob106.obsmtp.com (eu1sys200aob106.obsmtp.com
	[207.126.144.120])
	by alsa0.perex.cz (Postfix) with SMTP id 1B984243B0
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 15:39:34 +0100 (CET)
Received: by mail-fx0-f42.google.com with SMTP id n2so9885062faa.1
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 06:39:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm using  USB audio devices with dmix.
I notice that the system can lock when the device gets unplugged.

ex:

     $ aplay -D "dmix device on top of usb device" -f S16_LE /dev/zero
     now   unplug the USB device, and aplay is now waiting forever.


Two root causes of the problem in alsa-lib, with some proposed patch 
(I'm not able to upgrade to upstream, but I didn't see any change which 
can fix my issue)


A) the sound timer used by dmix doesn't get the notification when the 
card was removed. so the poll done to wait is locking
here is a patch to solve this:

________________________________________________________________________
commit 2ac49899d6a45ef594a99ad409a378119f0fa157
Author: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date:   Fri Nov 18 15:03:29 2011 +0100

     timer: use SND_TIMER_EVENT_MSTOP as interesting filter for timers, 
otherwise we
     miss the event when the hotplug device is removed and we set a 
timer of it

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 88609e5..c38da70 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1137,6 +1137,7 @@ int 
snd_pcm_direct_initialize_poll_fd(snd_pcm_direct_t *dmix)

         dmix->timer_events = (1<<SND_TIMER_EVENT_MSUSPEND) |
                              (1<<SND_TIMER_EVENT_MRESUME) |
+                            (1<<SND_TIMER_EVENT_MSTOP) |
                              (1<<SND_TIMER_EVENT_STOP);

         /*


________________________________________________________________________


B) when snd_pcm_direct_poll_revents() check for 
snd_pcm_state(dmix->spcm), it doesn't care about negative values
so it just consider POLLERR should not be set, and on return, we can be 
sure to poll again

I see 2 issues here:
1)how can snd_pcm_state returns negatives values
(simply consider that for gcc,   "if (snd_pcm_state() < 0)" can't be false
So may be "snd_pcm_state" should check for negative values, and return 
an associated ALSA_state (like SND_PCM_STATE_DISCONNECTED)

2) POLLERR, at least, should be set for negative values:

here is the patch for the second:

________________________________________________________________________
commit 4463226b9e14e17e84492c5d59c0920876b614c0
Author: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date:   Fri Nov 18 15:00:36 2011 +0100

     snd_pcm_direct_poll_revents set POLLERR is the snd_pcm_state result 
is invalid

     this happened for example when the real pcm device (in case of 
dmix) has been
     removed. snd_pcm_state(dmix->spcm) returns -ENODEV

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 0a9047d..227602f 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -548,6 +548,7 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, 
struct pollfd *pfds, unsigned in
      snd_pcm_direct_t *dmix = pcm->private_data;
      unsigned short events;
      int empty = 0;
+    int state;

      assert(pfds && nfds == 1 && revents);
      events = pfds[0].revents;
@@ -563,28 +564,33 @@ int snd_pcm_direct_poll_revents(snd_pcm_t *pcm, 
struct pollfd *pfds, unsigned in
          }
          empty = avail < pcm->avail_min;
      }
-    switch (snd_pcm_state(dmix->spcm)) {
-    case SND_PCM_STATE_XRUN:
-    case SND_PCM_STATE_SUSPENDED:
-    case SND_PCM_STATE_SETUP:
+    state = snd_pcm_state(dmix->spcm);
+    if (((int) state) < 0) {
          events |= POLLERR;
-        break;
-    default:
-        if (empty) {
-            snd_pcm_direct_clear_timer_queue(dmix);
-            events &= ~(POLLOUT|POLLIN);
-            /* additional check */
-            switch (snd_pcm_state(pcm)) {
-            case SND_PCM_STATE_XRUN:
-            case SND_PCM_STATE_SUSPENDED:
-            case SND_PCM_STATE_SETUP:
-                events |= POLLERR;
-                break;
-            default:
-                break;
+    } else {
+        switch (state) {
+        case SND_PCM_STATE_XRUN:
+        case SND_PCM_STATE_SUSPENDED:
+        case SND_PCM_STATE_SETUP:
+            events |= POLLERR;
+            break;
+        default:
+            if (empty) {
+                snd_pcm_direct_clear_timer_queue(dmix);
+                events &= ~(POLLOUT | POLLIN);
+                /* additional check */
+                switch (snd_pcm_state(pcm)) {
+                case SND_PCM_STATE_XRUN:
+                case SND_PCM_STATE_SUSPENDED:
+                case SND_PCM_STATE_SETUP:
+                    events |= POLLERR;
+                    break;
+                default:
+                    break;
+                }
              }
+            break;
          }
-        break;
      }
      *revents = events;
      return 0;
