From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1174/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:23:18 +0800
Message-ID: <20160802122318.28422-1-baolex.ni@intel.com>
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
 sound/isa/als100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index bc9ea30..103ea7a 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -63,11 +63,11 @@ static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
 static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
 static int dma16[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for Avance Logic based soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for Avance Logic based soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable Avance Logic based soundcard.");
 
 MODULE_ALIAS("snd-dt019x");
-- 
2.9.2
