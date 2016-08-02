From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1192/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:12 +0800
Message-ID: <20160802122512.29646-1-baolex.ni@intel.com>
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
 sound/isa/sb/jazz16.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 6b4884d..8affc8e 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -44,23 +44,23 @@ static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static int dma16[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Media Vision Jazz16 based soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Media Vision Jazz16 based soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Media Vision Jazz16 based soundcard.");
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for jazz16 driver.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for jazz16 driver.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for jazz16 driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
+module_param_array(mpu_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for jazz16 driver.");
-module_param_array(dma8, int, NULL, 0444);
+module_param_array(dma8, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma8, "DMA8 # for jazz16 driver.");
-module_param_array(dma16, int, NULL, 0444);
+module_param_array(dma16, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma16, "DMA16 # for jazz16 driver.");
 
 #define SB_JAZZ16_WAKEUP	0xaf
-- 
2.9.2
