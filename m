From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1213/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:27:18 +0800
Message-ID: <20160802122718.31073-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lars@metafoo.de, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/pci/azt3328.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 5e2ef0b..327b750 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -239,19 +239,19 @@ MODULE_SUPPORTED_DEVICE("{{Aztech,AZF3328}}");
 */
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for AZF3328 soundcard.");
 
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for AZF3328 soundcard.");
 
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable AZF3328 soundcard.");
 
 static int seqtimer_scaling = 128;
-module_param(seqtimer_scaling, int, 0444);
+module_param(seqtimer_scaling, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seqtimer_scaling, "Set 1024000Hz sequencer timer scale factor (lockup danger!). Default 128.");
 
 enum snd_azf3328_codec_type {
-- 
2.9.2
