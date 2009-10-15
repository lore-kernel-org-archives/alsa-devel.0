From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 01/11] hda - select IbexPeak handler for
	Calpella
Date: Thu, 15 Oct 2009 15:03:49 +0800
Message-ID: <20091015070917.923497406@intel.com>
References: <20091015070348.390451250@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AF82103827
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Oct 2009 09:10:13 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-calpella.patch
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

An earlier patch merely adds id for 0x80862804.
It has 2/3 cvt/pin nodes and shall be tied to the IbexPeak handler.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-10-15 09:34:00.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-10-15 10:16:52.000000000 +0800
@@ -684,7 +684,7 @@ static struct hda_codec_preset snd_hda_p
 	{ .id = 0x80862801, .name = "G45 DEVBLC", .patch = patch_intel_hdmi },
 	{ .id = 0x80862802, .name = "G45 DEVCTG", .patch = patch_intel_hdmi },
 	{ .id = 0x80862803, .name = "G45 DEVELK", .patch = patch_intel_hdmi },
-	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi },
+	{ .id = 0x80862804, .name = "G45 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
 	{ .id = 0x80860054, .name = "Q57 DEVIBX", .patch = patch_intel_hdmi_ibexpeak },
 	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
 	{} /* terminator */
