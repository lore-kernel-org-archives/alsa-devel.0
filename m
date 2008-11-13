From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] handle SiI1392 HDMI codec in patch_intelhdmi.c
Date: Thu, 13 Nov 2008 10:19:38 +0800
Message-ID: <1226542784.139555.6879@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 96D5524394
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 03:19:46 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Move the handling of SiI1392 HDMI codec from patch_atihdmi.c to
patch_intelhdmi.c, which makes our ASUS P5E-VM HDMI board work.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_atihdmi.c   |    1 -
 sound/pci/hda/patch_intelhdmi.c |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_atihdmi.c
+++ sound-2.6/sound/pci/hda/patch_atihdmi.c
@@ -193,7 +193,6 @@ struct hda_codec_preset snd_hda_preset_a
 	{ .id = 0x1002791a, .name = "ATI RS690/780 HDMI", .patch = patch_atihdmi },
 	{ .id = 0x1002aa01, .name = "ATI R6xx HDMI", .patch = patch_atihdmi },
 	{ .id = 0x10951390, .name = "SiI1390 HDMI", .patch = patch_atihdmi },
-	{ .id = 0x10951392, .name = "SiI1392 HDMI", .patch = patch_atihdmi },
 	{ .id = 0x17e80047, .name = "Chrontel HDMI",  .patch = patch_atihdmi },
 	{} /* terminator */
 };
--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -924,5 +924,6 @@ struct hda_codec_preset snd_hda_preset_i
 	{ .id = 0x80862801, .name = "INTEL G45 DEVBLC", .patch = patch_intel_hdmi },
 	{ .id = 0x80862802, .name = "INTEL G45 DEVCTG", .patch = patch_intel_hdmi },
 	{ .id = 0x80862803, .name = "INTEL G45 DEVELK", .patch = patch_intel_hdmi },
+	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
 };
