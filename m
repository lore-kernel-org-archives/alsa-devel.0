From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1196/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:37 +0800
Message-ID: <20160802122537.29918-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, serge@hallyn.com, davem@davemloft.net, kadlec@blackhole.kfki.hu, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, vilhelm.gray@gmail.com, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/isa/sscape.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index fdcfa29..2f684e5 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -57,31 +57,31 @@ static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static bool joystick[SNDRV_CARDS];
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index number for SoundScape soundcard");
 
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "Description for SoundScape card");
 
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for SoundScape driver.");
 
-module_param_array(wss_port, long, NULL, 0444);
+module_param_array(wss_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wss_port, "WSS Port # for SoundScape driver.");
 
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for SoundScape driver.");
 
-module_param_array(mpu_irq, int, NULL, 0444);
+module_param_array(mpu_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU401 IRQ # for SoundScape driver.");
 
-module_param_array(dma, int, NULL, 0444);
+module_param_array(dma, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma, "DMA # for SoundScape driver.");
 
-module_param_array(dma2, int, NULL, 0444);
+module_param_array(dma2, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "DMA2 # for SoundScape driver.");
 
-module_param_array(joystick, bool, NULL, 0444);
+module_param_array(joystick, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick, "Enable gameport.");
 
 #ifdef CONFIG_PNP
-- 
2.9.2
