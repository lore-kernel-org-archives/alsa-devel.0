From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: don't bother to invalidate cache for the extra
 voice
Date: Fri, 27 Aug 2004 01:26:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093584379.20987.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Since the extra voice is only used to generate the period interrupts and
is always silent, I don't see why we need to invalidate its cache. 
Apparently the author of the driver felt the same way.  Latency tracing
shows that this can shave 20 usecs off the 120 usecs required for
startup and xrun recovery.

Lee

--- alsa-kernel/pci/emu10k1/emupcm.c~	2004-07-14 12:14:54.000000000 -0400
+++ alsa-kernel/pci/emu10k1/emupcm.c	2004-08-27 01:20:05.000000000 -0400
@@ -574,7 +574,6 @@
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);	/* do we need this? */
 		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0]);
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
