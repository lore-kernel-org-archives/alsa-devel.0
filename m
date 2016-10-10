From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: Intel: haswell depends on sst-firmware
Date: Mon, 10 Oct 2016 14:33:20 +0200
Message-ID: <20161010123345.1363113-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: John Keeping <john@metanate.com>, Genki Marshall <genki@genki.is>, Tom Rini <trini@konsulko.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Intel Haswell audio support fails to link if
CONFIG_SND_SOC_INTEL_SST_FIRMWARE is disabled:

sst-haswell-dsp.c: undefined reference to `sst_mem_block_register'
sst-haswell-dsp.c: undefined reference to `sst_mem_block_unregister_all'
sst-haswell-dsp.c: undefined reference to `sst_module_alloc_blocks'
sst-haswell-dsp.c: undefined reference to `sst_module_free'
sst-haswell-dsp.c: undefined reference to `sst_module_new'
sst-haswell-pcm.c: undefined reference to `sst_module_get_from_id'
sst-haswell-pcm.c: undefined reference to `sst_module_runtime_restore'
sst-haswell-pcm.c: undefined reference to `sst_module_runtime_save'
ERROR: "sst_block_alloc_scratch" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_block_free_scratch" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_dma_copyfrom" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_dma_copyto" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_dma_get_channel" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_dma_put_channel" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_free" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_get_offset" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_dsp_new" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_fw_free_all" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_fw_new" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_fw_reload" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_fw_unload" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_module_runtime_alloc_blocks" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_module_runtime_get_from_id" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!
ERROR: "sst_module_runtime_new" [sound/soc/intel/haswell/snd-soc-sst-haswell-pcm.ko] undefined!

This moves the 'select' statement from two of the three haswell based users
into the line that is used by all of them, so make it harder to get wrong
and to fix the existing randconfig regressions.

Fixes: 2d995e5dc283 ("ASoC: Intel: boards: Add bdw-rt5677 machine driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 26eb5a0a5575..fd5d1e091038 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -47,6 +47,7 @@ config SND_SOC_INTEL_SST_MATCH
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate
@@ -56,7 +57,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -138,7 +138,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
 		   I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
2.9.0
