From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1189/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:24:54 +0800
Message-ID: <20160802122454.29442-1-baolex.ni@intel.com>
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
 sound/isa/opti9xx/miro.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 3a9067d..4b97916 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -65,30 +65,30 @@ static int ide;
 static bool isapnp = 1;				/* Enable ISA PnP detection */
 #endif
 
-module_param(index, int, 0444);
+module_param(index, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for miro soundcard.");
-module_param(id, charp, 0444);
+module_param(id, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for miro soundcard.");
-module_param(port, long, 0444);
+module_param(port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "WSS port # for miro driver.");
-module_param(mpu_port, long, 0444);
+module_param(mpu_port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for miro driver.");
-module_param(fm_port, long, 0444);
+module_param(fm_port, long, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM Port # for miro driver.");
-module_param(irq, int, 0444);
+module_param(irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "WSS irq # for miro driver.");
-module_param(mpu_irq, int, 0444);
+module_param(mpu_irq, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_irq, "MPU-401 irq # for miro driver.");
-module_param(dma1, int, 0444);
+module_param(dma1, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "1st dma # for miro driver.");
-module_param(dma2, int, 0444);
+module_param(dma2, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "2nd dma # for miro driver.");
-module_param(wss, int, 0444);
+module_param(wss, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(wss, "wss mode");
-module_param(ide, int, 0444);
+module_param(ide, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ide, "enable ide port");
 #ifdef CONFIG_PNP
-module_param(isapnp, bool, 0444);
+module_param(isapnp, bool, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "Enable ISA PnP detection for specified soundcard.");
 #endif
 
-- 
2.9.2
