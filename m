From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1185/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:24:26 +0800
Message-ID: <20160802122426.29170-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/isa/gus/gusmax.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 8216e8d..2337ce4 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -50,25 +50,25 @@ static int joystick_dac[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 29};
 static int channels[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 24};
 static int pcm_channels[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for GUS MAX soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for GUS MAX soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable GUS MAX soundcard.");
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for GUS MAX driver.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for GUS MAX driver.");
-module_param_array(dma1, int, NULL, 0444);
+module_param_array(dma1, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "DMA1 # for GUS MAX driver.");
-module_param_array(dma2, int, NULL, 0444);
+module_param_array(dma2, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "DMA2 # for GUS MAX driver.");
-module_param_array(joystick_dac, int, NULL, 0444);
+module_param_array(joystick_dac, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick_dac, "Joystick DAC level 0.59V-4.52V or 0.389V-2.98V for GUS MAX driver.");
-module_param_array(channels, int, NULL, 0444);
+module_param_array(channels, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(channels, "Used GF1 channels for GUS MAX driver.");
-module_param_array(pcm_channels, int, NULL, 0444);
+module_param_array(pcm_channels, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for GUS MAX driver.");
 
 struct snd_gusmax {
-- 
2.9.2
