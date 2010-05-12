From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 4/5] intelhdmi - add id for the CougarPoint
	chipset
Date: Wed, 12 May 2010 09:30:19 +0800
Message-ID: <20100512015714.104225577@intel.com>
References: <20100512013015.752623810@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id BD052103891
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:58:45 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-snb-id.patch
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

Add id for Intel CougarPoint HDMI audio codec.

CougarPoint provides 3 Audio Converters.
Increase MAX_HDMI_CVTS/MAX_HDMI_PINS accordingly.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2010-05-11 13:04:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2010-05-11 13:22:30.000000000 +0800
@@ -40,7 +40,7 @@
  *
  * The HDA correspondence of pipes/ports are converter/pin nodes.
  */
-#define MAX_HDMI_CVTS	2
+#define MAX_HDMI_CVTS	3
 #define MAX_HDMI_PINS	3
 
 #include "patch_hdmi.c"
@@ -48,6 +48,7 @@
 static char *intel_hdmi_pcm_names[MAX_HDMI_CVTS] = {
 	"INTEL HDMI 0",
 	"INTEL HDMI 1",
+	"INTEL HDMI 2",
 };
 
 /*
@@ -191,6 +192,7 @@ static struct hda_codec_preset snd_hda_p
 { .id = 0x80862803, .name = "Eaglelake HDMI",	.patch = patch_intel_hdmi },
 { .id = 0x80862804, .name = "IbexPeak HDMI",	.patch = patch_intel_hdmi },
 { .id = 0x80860054, .name = "IbexPeak HDMI",	.patch = patch_intel_hdmi },
+{ .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_intel_hdmi },
 { .id = 0x10951392, .name = "SiI1392 HDMI",	.patch = patch_intel_hdmi },
 {} /* terminator */
 };
@@ -200,6 +202,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862801"
 MODULE_ALIAS("snd-hda-codec-id:80862802");
 MODULE_ALIAS("snd-hda-codec-id:80862803");
 MODULE_ALIAS("snd-hda-codec-id:80862804");
+MODULE_ALIAS("snd-hda-codec-id:80862805");
 MODULE_ALIAS("snd-hda-codec-id:80860054");
 MODULE_ALIAS("snd-hda-codec-id:10951392");
