From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 11/11] hda - remove static intelhdmi
	configurations
Date: Thu, 15 Oct 2009 15:03:59 +0800
Message-ID: <20091015070919.177396454@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id F349A103827
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:15 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-remove-static.patch
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

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |   36 ++----------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:20:35.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:20:55.000000000 +0800
@@ -841,24 +841,7 @@ static struct hda_codec_ops intel_hdmi_p
 	.unsol_event		= intel_hdmi_unsol_event,
 };
 
-static struct intel_hdmi_spec static_specs[] = {
-	{
-		.num_cvts = 1,
-		.num_pins = 1,
-		.cvt	  = { 0x2 },
-		.pin	  = { 0x3 },
-		.pin_cvt  = { 0x2 },
-	},
-	{
-		.num_cvts = 2,
-		.num_pins = 3,
-		.cvt	  = { 0x2, 0x3 },
-		.pin	  = { 0x4, 0x5, 0x6 },
-		.pin_cvt  = { 0x2, 0x2, 0x2 },
-	},
-};
-
-static int do_patch_intel_hdmi(struct hda_codec *codec, int spec_id)
+static int patch_intel_hdmi(struct hda_codec *codec)
 {
 	struct intel_hdmi_spec *spec;
 	int i;
@@ -873,9 +856,6 @@ static int do_patch_intel_hdmi(struct hd
 		kfree(spec);
 		return -EINVAL;
 	}
-	if (memcmp(spec, static_specs + spec_id, sizeof(*spec)))
-		snd_printk(KERN_WARNING
-			   "HDMI: auto parse disagree with known config\n");
 	codec->patch_ops = intel_hdmi_patch_ops;
 
 	for (i = 0; i < spec->num_pins; i++)
@@ -886,23 +866,13 @@ static int do_patch_intel_hdmi(struct hd
 	return 0;
 }
 
-static int patch_intel_hdmi(struct hda_codec *codec)
-{
-	return do_patch_intel_hdmi(codec, 0);
-}
-
-static int patch_intel_hdmi_ibexpeak(struct hda_codec *codec)
-{
-	return do_patch_intel_hdmi(codec, 1);
-}
-
 static struct hda_codec_preset snd_hda_preset_intelhdmi[] = {
 	{ .id = 0x808629fb, .name = "G45 DEVCL",  .patch = patch_intel_hdmi },
 	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
 	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
 	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
-	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
-	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
+	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
+	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi },
 	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
 };
