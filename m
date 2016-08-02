From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1195/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:29 +0800
Message-ID: <20160802122529.29850-1-baolex.ni@intel.com>
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
 sound/isa/sc6000.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 51cfa76..4e2287e 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -58,25 +58,25 @@ static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 0 */
 static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0, 1, 3 */
 static bool joystick[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = false };
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for sc-6000 based soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for sc-6000 based soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable sc-6000 based soundcard.");
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for sc-6000 driver.");
-module_param_array(mss_port, long, NULL, 0444);
+module_param_array(mss_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mss_port, "MSS Port # for sc-6000 driver.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for sc-6000 driver.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for sc-6000 driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
+module_param_array(mpu_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for sc-6000 driver.");
-module_param_array(dma, int, NULL, 0444);
+module_param_array(dma, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma, "DMA # for sc-6000 driver.");
-module_param_array(joystick, bool, NULL, 0444);
+module_param_array(joystick, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(joystick, "Enable gameport.");
 
 /*
-- 
2.9.2
