From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: fix Kconfig dependencies" to the asoc tree
Date: Thu, 02 Nov 2017 11:21:33 +0000
Message-ID: <E1eADYz-000397-OI@debutante>
References: <20171102110737.2813128-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102110737.2813128-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: fix Kconfig dependencies

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f7a88db6fffdd193d792de5dae7890528b995cc0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 2 Nov 2017 12:07:04 +0100
Subject: [PATCH] ASoC: Intel: fix Kconfig dependencies

I ran into multiple problems during randconfig builds of the
recently changed Kconfig logic for Intel ASoC drivers:

- Building without DMADEVICES doesn't work in general
- With that dependency added, we can relax the 'depends
  on X86' again and allow compile-testing, except for
  SND_SST_ATOM_HIFI2_PLATFORM, which depends on X86
  for asm/platform_sst_audio.h
- Skylake requires SND_SOC_INTEL_SST_ACPI, so we
  have to depend on ACPI in turn
- Haswell needs SND_DMA_SGBUF for snd_sgbuf_aligned_pages()

With the new set of dependencies, I no longer get any build
failures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a59dda39007e..e18118209b75 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,13 +31,14 @@ config SND_SOC_ACPI_INTEL_MATCH
 
 config SND_SOC_INTEL_SST_TOPLEVEL
 	tristate "Intel ASoC SST drivers"
-	depends on X86
+	depends on X86 || COMPILE_TEST
+	depends on DMADEVICES
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
@@ -49,12 +50,12 @@ config SND_SOC_INTEL_BAYTRAIL
 
 config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
 	select SND_SOC_COMPRESS
 
 config SND_SOC_INTEL_SKYLAKE
 	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
-- 
2.15.0
