From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: haswell depends on sst-firmware" to the asoc tree
Date: Tue, 11 Oct 2016 12:28:08 +0200
Message-ID: <E1btuI4-0008Bv-OG@finisterre>
References: <20161010123345.1363113-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161010123345.1363113-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>, alsa-devel@alsa-project.org, Genki Marshall <genki@genki.is>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, John Keeping <john@metanate.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Jeeja KP <jeeja.kp@intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: haswell depends on sst-firmware

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c3474e211576fc88ddd1f3e8ce3b06a2051438e7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Oct 2016 14:33:20 +0200
Subject: [PATCH] ASoC: Intel: haswell depends on sst-firmware

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a20c3dfbcb5d..54dec9161cef 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -46,6 +46,7 @@ config SND_SOC_INTEL_SST_MATCH
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate
@@ -55,7 +56,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -126,7 +126,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
 		   I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
2.9.3
