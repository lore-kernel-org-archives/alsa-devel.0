From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kconfig: drop boiler plate text from config items" to the asoc tree
Date: Mon, 08 Jan 2018 16:21:17 +0000
Message-ID: <E1eYaAn-0001xt-AO@debutante>
References: <20180104223601.5831-11-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104223601.5831-11-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.orgPierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kconfig: drop boiler plate text from config items

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

>From 8fca15839ce5c473c57356abe36e166367e6c6ef Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 4 Jan 2018 16:36:01 -0600
Subject: [PATCH] ASoC: Intel: kconfig: drop boiler plate text from config
 items

Drop "Intel ASoC SST driver for " platforms and "SOC Machine Audio driver
for Intel" for machines..

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig        | 10 +++++-----
 sound/soc/intel/boards/Kconfig | 42 +++++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ca0d6eb95d11..b0bd1938b71e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -47,7 +47,7 @@ config SND_SOC_INTEL_SST_FIRMWARE
 	# when these platforms are enabled
 
 config SND_SOC_INTEL_HASWELL
-	tristate "Intel ASoC SST driver for Haswell/Broadwell"
+	tristate "Haswell/Broadwell Platforms"
 	depends on SND_DMA_SGBUF
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
@@ -60,7 +60,7 @@ config SND_SOC_INTEL_HASWELL
 	  typically used for Chromebooks. This is a recommended option.
 
 config SND_SOC_INTEL_BAYTRAIL
-	tristate "Intel ASoC SST driver for Baytrail (legacy)"
+	tristate "Baytrail (legacy) Platforms"
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_ACPI
@@ -73,7 +73,7 @@ config SND_SOC_INTEL_BAYTRAIL
 	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
 
 config SND_SST_ATOM_HIFI2_PLATFORM_PCI
-	tristate "Intel ASoC SST driver for PCI HiFi2 platforms (Medfield, Merrifield)"
+	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
 	depends on X86 && PCI
 	select SND_SST_IPC_PCI
 	select SND_SOC_COMPRESS
@@ -87,7 +87,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
 	  is not in the standard firmware tree
 
 config SND_SST_ATOM_HIFI2_PLATFORM
-	tristate "Intel ASoC SST driver for ACPI HiFi2 platforms (Baytrail, Cherrytrail)"
+	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
 	depends on X86 && ACPI
 	select SND_SST_IPC_ACPI
 	select SND_SOC_COMPRESS
@@ -99,7 +99,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM
 	  recommended option
 
 config SND_SOC_INTEL_SKYLAKE
-	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
+	tristate "SKL/BXT/KBL/GLK/CNL... Platforms"
 	depends on PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index e1b6addcd13d..12761d8fd8a5 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -15,7 +15,7 @@ if SND_SOC_INTEL_MACH
 if SND_SST_ATOM_HIFI2_PLATFORM_PCI
 
 config SND_MFLD_MACHINE
-	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
+	tristate "Medfield (Intel MID)"
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
 	help
@@ -29,7 +29,7 @@ endif ## SND_SST_ATOM_HIFI2_PLATFORM_PCI
 if SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_HASWELL_MACH
-	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+	tristate "Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_RT5640
 	help
@@ -39,7 +39,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
-	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
+	tristate "Broadwell with RT5677 codec"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM && GPIOLIB
 	select SND_SOC_RT5677
 	help
@@ -49,7 +49,7 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BROADWELL_MACH
-	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
+	tristate "Broadwell Wildcatpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_RT286
 	help
@@ -62,7 +62,7 @@ endif ## SND_SOC_INTEL_HASWELL
 if SND_SOC_INTEL_BAYTRAIL
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
-	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
+	tristate "Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_MAX98090
 	help
@@ -72,7 +72,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 	  functionality.
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
-	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
+	tristate "Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_RT5640
 	help
@@ -85,7 +85,7 @@ endif ## SND_SOC_INTEL_BAYTRAIL
 if SND_SST_ATOM_HIFI2_PLATFORM
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	tristate "Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_RT5640
@@ -96,7 +96,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
-	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
+	tristate "Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_RT5651
@@ -107,7 +107,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
+	tristate "Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_RT5670
@@ -118,7 +118,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
+	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_RT5645
@@ -129,7 +129,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
+	tristate "Cherrytrail & Braswell with MAX98090 & TI codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
@@ -140,7 +140,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
+	tristate "Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ACPI
 	select SND_SOC_DA7213
@@ -151,7 +151,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
+	tristate "Baytrail & Cherrytrail with ES8316 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
 	help
@@ -161,7 +161,7 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
+	tristate "Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
@@ -177,7 +177,7 @@ endif ## SND_SST_ATOM_HIFI2_PLATFORM
 if SND_SOC_INTEL_SKYLAKE
 
 config SND_SOC_INTEL_SKL_RT286_MACH
-	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
+	tristate "SKL with RT286 I2S mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
@@ -189,7 +189,7 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 	   If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
-	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
+	tristate "SKL with NAU88L25 and SSM4567 in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
@@ -202,7 +202,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
-	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
+	tristate "SKL with NAU88L25 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
@@ -215,7 +215,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
-	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
+	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
@@ -229,7 +229,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	   If unsure select "N".
 
 config SND_SOC_INTEL_BXT_RT298_MACH
-	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
+	tristate "Broxton with RT298 I2S mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
@@ -242,7 +242,7 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	   If unsure select "N".
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
-	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
+	tristate "KBL with RT5663 and MAX98927 in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
@@ -255,7 +255,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
-        tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
+        tristate "KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
         depends on MFD_INTEL_LPSS && I2C && ACPI
         depends on SPI
         select SND_SOC_RT5663
-- 
2.15.1
