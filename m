From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 4/4] hda - add id for Intel IbexPeak integrated
	HDMI codec
Date: Wed, 11 Feb 2009 15:22:31 +0800
Message-ID: <20090211073402.901334392@intel.com>
References: <20090211072227.760779741@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id EF6DD103885
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 08:56:18 +0100 (CET)
Content-Disposition: inline; filename=intel-hdmi-ibexpeak.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    2 ++
 1 file changed, 2 insertions(+)

--- mm.orig/sound/pci/hda/patch_intelhdmi.c
+++ mm/sound/pci/hda/patch_intelhdmi.c
@@ -684,6 +684,7 @@ static struct hda_codec_preset snd_hda_p
 	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
 	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
 	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
+	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
 	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
 };
@@ -692,6 +693,7 @@ MODULE_ALIAS("snd-hda-codec-id:808629fb"
 MODULE_ALIAS("snd-hda-codec-id:80862801");
 MODULE_ALIAS("snd-hda-codec-id:80862802");
 MODULE_ALIAS("snd-hda-codec-id:80862803");
+MODULE_ALIAS("snd-hda-codec-id:80862804");
 MODULE_ALIAS("snd-hda-codec-id:10951392");
 
 MODULE_LICENSE("GPL");

-- 
