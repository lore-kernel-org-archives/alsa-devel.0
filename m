From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Don't try to bind i915 unless
	CONFIG_SND_HDA_I915 is set
Date: Wed,  9 Dec 2015 07:40:24 +0100
Message-ID: <1449643224-10215-2-git-send-email-tiwai@suse.de>
References: <1449643224-10215-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7586226065A
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 07:40:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 479DFAAB2
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 06:40:29 +0000 (UTC)
In-Reply-To: <1449643224-10215-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd-hda-intel driver tries to bind with i915 audio component always
when AZX_DCAPS_I915_POWERWELL is set in the driver caps.  This was
mostly OK in the past, as the flag was applied only to a limited set
of devices, namely, Haswell and Broadwell.  On these machines, i915
graphics is almost mandatory as long as HDMI/DP is concerned.

Recently the application of i915 binding was widened to more Intel
chips.  On these chips, the chance of a kernel without i915 graphics
is much higher, and such user would hit an error like:

 snd_hda_intel 0000:00:1b.0: failed to add i915 component master (-19)

Although the error itself is harmless, it's certainly superfluous even
to try binding with i915, if we already know that there isn't any.

This patch fixes it by simply defining AZX_DCAPS_I915_POWERWELL as 0
in the case without i915.  Then all codes referring to this flag will
be optimized out by the compiler.

Fixes: 6603249dcdbb ('ALSA: hda - Enable audio component for old Intel PCH devices')
Reported-by: kernel test robot <ying.huang@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 7b635d68cfe1..c1d28a657f19 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -46,7 +46,11 @@
 #define AZX_DCAPS_REVERSE_ASSIGN (1 << 24)	/* Assign devices in reverse order */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
+#ifdef CONFIG_SND_HDA_I915
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
+#else
+#define AZX_DCAPS_I915_POWERWELL 0		/* NOP */
+#endif
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
-- 
2.6.3
