From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1193/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:25:18 +0800
Message-ID: <20160802122518.29714-1-baolex.ni@intel.com>
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
 sound/isa/sb/sb16.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 4a7d7c8..4468c89 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -89,40 +89,40 @@ static int csp[SNDRV_CARDS];
 static int seq_ports[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 4};
 #endif
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for SoundBlaster 16 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for SoundBlaster 16 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable SoundBlaster 16 soundcard.");
 #ifdef CONFIG_PNP
-module_param_array(isapnp, bool, NULL, 0444);
+module_param_array(isapnp, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(isapnp, "PnP detection for specified soundcard.");
 #endif
-module_param_array(port, long, NULL, 0444);
+module_param_array(port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(port, "Port # for SB16 driver.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_array(mpu_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port # for SB16 driver.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_array(fm_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fm_port, "FM port # for SB16 PnP driver.");
 #ifdef SNDRV_SBAWE_EMU8000
-module_param_array(awe_port, long, NULL, 0444);
+module_param_array(awe_port, long, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(awe_port, "AWE port # for SB16 PnP driver.");
 #endif
-module_param_array(irq, int, NULL, 0444);
+module_param_array(irq, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(irq, "IRQ # for SB16 driver.");
-module_param_array(dma8, int, NULL, 0444);
+module_param_array(dma8, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma8, "8-bit DMA # for SB16 driver.");
-module_param_array(dma16, int, NULL, 0444);
+module_param_array(dma16, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(dma16, "16-bit DMA # for SB16 driver.");
-module_param_array(mic_agc, int, NULL, 0444);
+module_param_array(mic_agc, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mic_agc, "Mic Auto-Gain-Control switch.");
 #ifdef CONFIG_SND_SB16_CSP
-module_param_array(csp, int, NULL, 0444);
+module_param_array(csp, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(csp, "ASP/CSP chip support.");
 #endif
 #ifdef SNDRV_SBAWE_EMU8000
-module_param_array(seq_ports, int, NULL, 0444);
+module_param_array(seq_ports, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_ports, "Number of sequencer ports for WaveTable synth.");
 #endif
 
-- 
2.9.2
