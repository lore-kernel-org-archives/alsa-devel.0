From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1190/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:00 +0800
Message-ID: <20160802122500.29510-1-baolex.ni@intel.com>
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
 sound/isa/opti9xx/opti92x-ad1848.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 0a52660..520853d 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -78,30 +78,30 @@ static int dma1 = SNDRV_DEFAULT_DMA1;		/* 0,1,3 */
 static int dma2 = SNDRV_DEFAULT_DMA1;		/* 0,1,3 */
 #endif	/* CS4231 || OPTi93X */
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for opti9xx based soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for opti9xx based soundcard.");
 //module_param(enable, bool, 0444);
 //MODULE_PARM_DESC(enable, "Enable opti9xx soundcard.");
 #ifdef CONFIG_PNP
-module_param(isapnp, bool, 0444);
+module_param(isapnp, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "Enable ISA PnP detection for specified soundcard.");
 #endif
-module_param(port, long, 0444);
+module_param(port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "WSS port # for opti9xx driver.");
-module_param(mpu_port, long, 0444);
+module_param(mpu_port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for opti9xx driver.");
-module_param(fm_port, long, 0444);
+module_param(fm_port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port # for opti9xx driver.");
-module_param(irq, int, 0444);
+module_param(irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "WSS irq # for opti9xx driver.");
-module_param(mpu_irq, int, 0444);
+module_param(mpu_irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 irq # for opti9xx driver.");
-module_param(dma1, int, 0444);
+module_param(dma1, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "1st dma # for opti9xx driver.");
 #if defined(CS4231) || defined(OPTi93X)
-module_param(dma2, int, 0444);
+module_param(dma2, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "2nd dma # for opti9xx driver.");
 #endif	/* CS4231 || OPTi93X */
 
-- 
2.9.2
