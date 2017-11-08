From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: improve DMADEVICES dependency" to the asoc tree
Date: Wed, 08 Nov 2017 18:26:34 +0000
Message-ID: <E1eCV3a-0006k0-Ga@debutante>
References: <20171108130354.86106-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171108130354.86106-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: improve DMADEVICES dependency

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

>From 326c4aa27a801918136df15d507f74968c7093fb Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Nov 2017 14:03:19 +0100
Subject: [PATCH] ASoC: Intel: improve DMADEVICES dependency

As pointed out by Pierre-Louis Bossart, the dependency I added
was broader than necessary, only Baytrail and Haswell/Broadwell
actually need it, the others don't.

At the same time, we have individual entries for the codecs
that all have the 'select' statement but now don't need it
any more.

Fixes: f7a88db6fffd ("ASoC: Intel: fix Kconfig dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig        | 3 ++-
 sound/soc/intel/boards/Kconfig | 5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index e18118209b75..bb8be10b8437 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -32,19 +32,20 @@ config SND_SOC_ACPI_INTEL_MATCH
 config SND_SOC_INTEL_SST_TOPLEVEL
 	tristate "Intel ASoC SST drivers"
 	depends on X86 || COMPILE_TEST
-	depends on DMADEVICES
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
 	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
+	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
 	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 449bc8baaa60..5063f15b4ca4 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -19,7 +19,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DMADEVICES
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -32,7 +31,6 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
 	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
-	depends on DMADEVICES
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
@@ -43,7 +41,6 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
 	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DMADEVICES
 	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
@@ -56,7 +53,6 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
-	depends on DMADEVICES
 	depends on SND_SST_IPC_ACPI = n
 	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
@@ -68,7 +64,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
-	depends on DMADEVICES
 	depends on SND_SST_IPC_ACPI = n
 	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
-- 
2.15.0
