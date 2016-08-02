From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1197/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:43 +0800
Message-ID: <20160802122543.29986-1-baolex.ni@intel.com>
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
 sound/isa/wavefront/wavefront.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index a0987a5..d48fad9 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -53,35 +53,35 @@ static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	    /* 0,1,3,5,6,7 */
 static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	    /* 0,1,3,5,6,7 */
 static bool use_cs4232_midi[SNDRV_CARDS];
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for WaveFront soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for WaveFront soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable WaveFront soundcard.");
 #ifdef CONFIG_PNP
-module_param_array(isapnp, bool, NULL, 0444);
+module_param_array(isapnp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for WaveFront soundcards.");
 #endif
-module_param_array(cs4232_pcm_port, long, NULL, 0444);
+module_param_array(cs4232_pcm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cs4232_pcm_port, "Port # for CS4232 PCM interface.");
-module_param_array(cs4232_pcm_irq, int, NULL, 0444);
+module_param_array(cs4232_pcm_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cs4232_pcm_irq, "IRQ # for CS4232 PCM interface.");
-module_param_array(dma1, int, NULL, 0444);
+module_param_array(dma1, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma1, "DMA1 # for CS4232 PCM interface.");
-module_param_array(dma2, int, NULL, 0444);
+module_param_array(dma2, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma2, "DMA2 # for CS4232 PCM interface.");
-module_param_array(cs4232_mpu_port, long, NULL, 0444);
+module_param_array(cs4232_mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cs4232_mpu_port, "port # for CS4232 MPU-401 interface.");
-module_param_array(cs4232_mpu_irq, int, NULL, 0444);
+module_param_array(cs4232_mpu_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cs4232_mpu_irq, "IRQ # for CS4232 MPU-401 interface.");
-module_param_array(ics2115_irq, int, NULL, 0444);
+module_param_array(ics2115_irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ics2115_irq, "IRQ # for ICS2115.");
-module_param_array(ics2115_port, long, NULL, 0444);
+module_param_array(ics2115_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ics2115_port, "Port # for ICS2115.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_array(fm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port #.");
-module_param_array(use_cs4232_midi, bool, NULL, 0444);
+module_param_array(use_cs4232_midi, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_cs4232_midi, "Use CS4232 MPU-401 interface (inaccessibly located inside your computer)");
 
 #ifdef CONFIG_PNP
-- 
2.9.2
