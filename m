From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1177/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:23:40 +0800
Message-ID: <20160802122340.28626-1-baolex.ni@intel.com>
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
 sound/isa/cmi8330.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index dfedfd8..84d0fb9 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -84,38 +84,38 @@ static long fmport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 static long mpuport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 static int mpuirq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for CMI8330/CMI8329 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string  for CMI8330/CMI8329 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable CMI8330/CMI8329 soundcard.");
 #ifdef CONFIG_PNP
-module_param_array(isapnp, bool, NULL, 0444);
+module_param_array(isapnp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "PnP detection for specified soundcard.");
 #endif
 
-module_param_array(sbport, long, NULL, 0444);
+module_param_array(sbport, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sbport, "Port # for CMI8330/CMI8329 SB driver.");
-module_param_array(sbirq, int, NULL, 0444);
+module_param_array(sbirq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sbirq, "IRQ # for CMI8330/CMI8329 SB driver.");
-module_param_array(sbdma8, int, NULL, 0444);
+module_param_array(sbdma8, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sbdma8, "DMA8 for CMI8330/CMI8329 SB driver.");
-module_param_array(sbdma16, int, NULL, 0444);
+module_param_array(sbdma16, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(sbdma16, "DMA16 for CMI8330/CMI8329 SB driver.");
 
-module_param_array(wssport, long, NULL, 0444);
+module_param_array(wssport, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wssport, "Port # for CMI8330/CMI8329 WSS driver.");
-module_param_array(wssirq, int, NULL, 0444);
+module_param_array(wssirq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wssirq, "IRQ # for CMI8330/CMI8329 WSS driver.");
-module_param_array(wssdma, int, NULL, 0444);
+module_param_array(wssdma, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wssdma, "DMA for CMI8330/CMI8329 WSS driver.");
 
-module_param_array(fmport, long, NULL, 0444);
+module_param_array(fmport, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fmport, "FM port # for CMI8330/CMI8329 driver.");
-module_param_array(mpuport, long, NULL, 0444);
+module_param_array(mpuport, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpuport, "MPU-401 port # for CMI8330/CMI8329 driver.");
-module_param_array(mpuirq, int, NULL, 0444);
+module_param_array(mpuirq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpuirq, "IRQ # for CMI8330/CMI8329 MPU-401 port.");
 #ifdef CONFIG_PNP
 static int isa_registered;
-- 
2.9.2
