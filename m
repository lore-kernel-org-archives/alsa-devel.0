From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1182/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:24:09 +0800
Message-ID: <20160802122409.28966-1-baolex.ni@intel.com>
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
 sound/isa/galaxy/galaxy.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 3227884..e590f20 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -37,11 +37,11 @@ static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
@@ -53,21 +53,21 @@ static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
-module_param_array(wss_port, long, NULL, 0444);
+module_param_array(wss_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wss_port, "WSS port # for " CRD_NAME " driver.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_array(fm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port # for " CRD_NAME " driver.");
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
-module_param_array(mpu_irq, int, NULL, 0444);
+module_param_array(mpu_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
-module_param_array(dma1, int, NULL, 0444);
+module_param_array(dma1, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "Playback DMA # for " CRD_NAME " driver.");
-module_param_array(dma2, int, NULL, 0444);
+module_param_array(dma2, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "Capture DMA # for " CRD_NAME " driver.");
 
 /*
-- 
2.9.2
