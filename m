From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1181/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:24:03 +0800
Message-ID: <20160802122403.28898-1-baolex.ni@intel.com>
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
 sound/isa/es18xx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 5094b62..0ee4703 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1989,27 +1989,27 @@ static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,9,10 */
 static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
 static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for ES18xx soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for ES18xx soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable ES18xx soundcard.");
 #ifdef CONFIG_PNP
-module_param_array(isapnp, bool, NULL, 0444);
+module_param_array(isapnp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "PnP detection for specified soundcard.");
 #endif
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for ES18xx driver.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for ES18xx driver.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_array(fm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port # for ES18xx driver.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for ES18xx driver.");
-module_param_array(dma1, int, NULL, 0444);
+module_param_array(dma1, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "DMA 1 # for ES18xx driver.");
-module_param_array(dma2, int, NULL, 0444);
+module_param_array(dma2, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "DMA 2 # for ES18xx driver.");
 
 #ifdef CONFIG_PNP
-- 
2.9.2
