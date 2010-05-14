From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/4] intelhdmi - user friendly codec name
Date: Fri, 14 May 2010 16:36:13 +0800
Message-ID: <20100514084052.212959173@intel.com>
References: <20100514083611.624260274@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C7F441038EC
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 10:41:20 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-codenames.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Use the full chipset codename as codec name.
They are more user friendly than the spec abbrs.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2010-05-11 13:03:50.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2010-05-11 13:04:39.000000000 +0800
@@ -185,14 +185,14 @@ static int patch_intel_hdmi(struct hda_c
 }
 
 static struct hda_codec_preset snd_hda_preset_intelhdmi[] = {
-	{ .id = 0x808629fb, .name = "G45 DEVCL",  .patch = patch_intel_hdmi },
-	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
-	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
-	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
-	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
-	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi },
-	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
-	{} /* terminator */
+{ .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80862801, .name = "Bearlake HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80862802, .name = "Cantiga HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80862803, .name = "Eaglelake HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80862804, .name = "IbexPeak HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80860054, .name = "IbexPeak HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x10951392, .name = "SiI1392 HDMI",	.patch = patch_intel_hdmi },
+{} /* terminator */
 };
 
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
