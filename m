From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 3/14] sound/usb: fix-up sleeping paths
Date: Fri, 8 Jul 2005 17:04:39 -0700
Message-ID: <20050709000439.GF2596@us.ibm.com>
References: <20050709000324.GD2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14433179
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:04:42 +0200 (MEST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j6904f10309308
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:04:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j6904fcC145018
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:04:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j6904fSb023056
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:04:41 -0600
Content-Disposition: inline
In-Reply-To: <20050709000324.GD2596@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Jaroslav, I realize that you are not the explicit maintainer for any of
these drivers, but I figured you would at least be able to {N,}ACK the
changes. I didn't find any entry in MAINTAINERS for usb-specific sound
drivers. If you would prefer split patches instead of the large
patchset, I can do that.

Description: Fix-up sleeping in sound/usb. Replace big_mdelay() with
msleep() to guarantee the task delays as expected. This also involved
replacing/removing custom sleep functions.

Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 usbaudio.c            |    4 ++--
 usx2y/usX2Yhwdep.c    |    3 +--
 usx2y/usx2yhwdeppcm.c |    6 ++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff -urpN 2.6.13-rc2-kj/sound/usb/usbaudio.c 2.6.13-rc2-kj-dev/sound/usb/usbaudio.c
--- 2.6.13-rc2-kj/sound/usb/usbaudio.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/usb/usbaudio.c	2005-07-08 12:33:55.000000000 -0700
@@ -790,7 +790,7 @@ static int start_urbs(snd_usb_substream_
  */
 static int wait_clear_urbs(snd_usb_substream_t *subs)
 {
-	int timeout = HZ;
+	unsigned long end_time = jiffies + msecs_to_jiffies(1000);
 	unsigned int i;
 	int alive;
 
@@ -810,7 +810,7 @@ static int wait_clear_urbs(snd_usb_subst
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (--timeout > 0);
+	} while (time_before(jiffies, end_time));
 	if (alive)
 		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
 	return 0;
diff -urpN 2.6.13-rc2-kj/sound/usb/usx2y/usX2Yhwdep.c 2.6.13-rc2-kj-dev/sound/usb/usx2y/usX2Yhwdep.c
--- 2.6.13-rc2-kj/sound/usb/usx2y/usX2Yhwdep.c	2005-07-06 07:57:08.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/usb/usx2y/usX2Yhwdep.c	2005-07-06 22:56:43.000000000 -0700
@@ -232,8 +232,7 @@ static int snd_usX2Y_hwdep_dsp_load(snd_
 	if (err)
 		return err;
 	if (dsp->index == 1) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/4);			// give the device some time 
+		msleep(250);				// give the device some time
 		err = usX2Y_AsyncSeq04_init(priv);
 		if (err) {
 			snd_printk("usX2Y_AsyncSeq04_init error \n");
diff -urpN 2.6.13-rc2-kj/sound/usb/usx2y/usx2yhwdeppcm.c 2.6.13-rc2-kj-dev/sound/usb/usx2y/usx2yhwdeppcm.c
--- 2.6.13-rc2-kj/sound/usb/usx2y/usx2yhwdeppcm.c	2005-03-01 23:38:11.000000000 -0800
+++ 2.6.13-rc2-kj-dev/sound/usb/usx2y/usx2yhwdeppcm.c	2005-07-06 22:58:50.000000000 -0700
@@ -50,6 +50,7 @@
    Currently rawusb dma pcm buffer transport (this file) is only available to snd-usb-usx2y. 
 */
 
+#include <linux/delay.h>
 #include "usbusx2yaudio.c"
 
 #if defined(USX2Y_NRPACKS_VARIABLE) || (!defined(USX2Y_NRPACKS_VARIABLE) &&  USX2Y_NRPACKS == 1)
@@ -520,11 +521,8 @@ static int snd_usX2Y_usbpcm_prepare(snd_
 		usX2Y->hwdep_pcm_shm->playback_iso_start = -1;
 		if (atomic_read(&subs->state) < state_PREPARED) {
 			while (usX2Y_iso_frames_per_buffer(runtime, usX2Y) > usX2Y->hwdep_pcm_shm->captured_iso_frames) {
-				signed long timeout;
 				snd_printd("Wait: iso_frames_per_buffer=%i,captured_iso_frames=%i\n", usX2Y_iso_frames_per_buffer(runtime, usX2Y), usX2Y->hwdep_pcm_shm->captured_iso_frames);
-				set_current_state(TASK_INTERRUPTIBLE);
-				timeout = schedule_timeout(HZ/100 + 1);
-				if (signal_pending(current)) {
+				if (msleep_interruptible(10)) {
 					err = -ERESTARTSYS;
 					goto up_prepare_mutex;
 				}


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
