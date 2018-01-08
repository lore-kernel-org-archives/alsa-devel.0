From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs" to the asoc tree
Date: Mon, 08 Jan 2018 16:21:33 +0000
Message-ID: <E1eYaB3-00020X-4v@debutante>
References: <20180104223601.5831-9-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104223601.5831-9-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

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

>From 969eaef7710400e39be13190bace40910555d426 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 4 Jan 2018 16:35:59 -0600
Subject: [PATCH] ASoC: Intel: boards: align/fix SKL/BXT/KBL Kconfigs

No reason why SND_SOC_INTEL_SST should be set here.
Also make sure same dependencies are used everywhere (only last one has SPI
in addition). Replace X86_INTEL_LPSS by MFD_INTEL_LPSS since the former
makes no sense for Skylake+ devices

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 08c482cc02f7..063611ad641c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -178,7 +178,7 @@ if SND_SOC_INTEL_SKYLAKE
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on X86 && ACPI && I2C
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -190,7 +190,7 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
@@ -203,7 +203,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -216,7 +216,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
-	depends on X86 && ACPI && I2C
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -230,7 +230,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
-	depends on X86 && ACPI && I2C
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -243,8 +243,7 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
+	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
@@ -257,8 +256,8 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on X86_INTEL_LPSS && I2C && SPI
-        select SND_SOC_INTEL_SST
+        depends on MFD_INTEL_LPSS && I2C && ACPI
+        depends on SPI
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
-- 
2.15.1
