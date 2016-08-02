From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1223/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:28:20 +0800
Message-ID: <20160802122820.31753-1-baolex.ni@intel.com>
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
 sound/pci/emu10k1/emu10k1.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index db7a2e5..6440655 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -54,27 +54,27 @@ static bool enable_ir[SNDRV_CARDS];
 static uint subsystem[SNDRV_CARDS]; /* Force card subsystem model */
 static uint delay_pcm_irq[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
 
-module_param_array(index, int, NULL, 0444);
+module_param_array(index, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(index, "Index value for the EMU10K1 soundcard.");
-module_param_array(id, charp, NULL, 0444);
+module_param_array(id, charp, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(id, "ID string for the EMU10K1 soundcard.");
-module_param_array(enable, bool, NULL, 0444);
+module_param_array(enable, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable, "Enable the EMU10K1 soundcard.");
-module_param_array(extin, int, NULL, 0444);
+module_param_array(extin, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(extin, "Available external inputs for FX8010. Zero=default.");
-module_param_array(extout, int, NULL, 0444);
+module_param_array(extout, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(extout, "Available external outputs for FX8010. Zero=default.");
-module_param_array(seq_ports, int, NULL, 0444);
+module_param_array(seq_ports, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(seq_ports, "Allocated sequencer ports for internal synthesizer.");
-module_param_array(max_synth_voices, int, NULL, 0444);
+module_param_array(max_synth_voices, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(max_synth_voices, "Maximum number of voices for WaveTable.");
-module_param_array(max_buffer_size, int, NULL, 0444);
+module_param_array(max_buffer_size, int, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(max_buffer_size, "Maximum sample buffer size in MB.");
-module_param_array(enable_ir, bool, NULL, 0444);
+module_param_array(enable_ir, bool, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(enable_ir, "Enable IR.");
-module_param_array(subsystem, uint, NULL, 0444);
+module_param_array(subsystem, uint, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(subsystem, "Force card subsystem model.");
-module_param_array(delay_pcm_irq, uint, NULL, 0444);
+module_param_array(delay_pcm_irq, uint, NULL, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(delay_pcm_irq, "Delay PCM interrupt by specified number of samples (default 0).");
 /*
  * Class 0401: 1102:0008 (rev 00) Subsystem: 1102:1001 -> Audigy2 Value  Model:SB0400
-- 
2.9.2
