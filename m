From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Add defaults for SND_SST_ options and machine drivers
Date: Thu, 16 Nov 2017 16:16:43 -0600
Message-ID: <20171116221643.30128-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add 'default m' when sensible, move common dependencies in if/endif block
and clarify which options default to n - distro configurations
should not enable legacy Baytrail stuff and NOCODEC (test only)

Basic tests run with defconfig, oldconfig, olddefconfig, there should be
no functionality change.

Fixes: f6a118a800e3 ("ASoC: Intel: clarify Kconfig dependencies")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        |  5 ++++
 sound/soc/intel/boards/Kconfig | 60 ++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7b49d04e3c60..b40719396e9d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -31,6 +31,7 @@ config SND_SOC_ACPI_INTEL_MATCH
 
 config SND_SOC_INTEL_SST_TOPLEVEL
 	tristate "Intel ASoC SST drivers"
+	default m
 	depends on X86 || COMPILE_TEST
 	select SND_SOC_INTEL_MACH
 	select SND_SOC_INTEL_COMMON
@@ -42,6 +43,7 @@ config SND_SOC_INTEL_SST_TOPLEVEL
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
+	default m
 	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
@@ -49,6 +51,7 @@ config SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
+	default n
 	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
@@ -56,11 +59,13 @@ config SND_SOC_INTEL_BAYTRAIL
 
 config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
+	default m
 	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
 	select SND_SOC_COMPRESS
 
 config SND_SOC_INTEL_SKYLAKE
 	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
+	default m
 	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 6f754708a48c..6069328c5c28 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -17,10 +17,12 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device.
           If unsure select "N".
 
+if SND_SOC_INTEL_HASWELL
+
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+	default m
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
 	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
@@ -30,8 +32,8 @@ config SND_SOC_INTEL_HASWELL_MACH
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
+	default m
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
 	  This adds support for Intel Broadwell platform based boards with
@@ -39,41 +41,50 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
+	default m
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
 	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
 	  Ultrabook platforms.
 	  Say Y if you have such a device.
 	  If unsure select "N".
+endif
+
+if SND_SOC_INTEL_BAYTRAIL
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
+	default n
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SST_IPC_ACPI = n
-	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
-	  with the MAX98090 audio codec.
+	  with the MAX98090 audio codec. This driver is deprecated, use
+	  SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH instead for better
+	  functionality.
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
+	default n
 	depends on X86_INTEL_LPSS && I2C
 	depends on SND_SST_IPC_ACPI = n
-	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the RT5640 audio codec. This driver is deprecated, use
 	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
 
+endif
+
+if SND_SST_ATOM_HIFI2_PLATFORM
+
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	default m
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -83,9 +94,9 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
+	default m
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -95,9 +106,9 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
+	default m
 	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        depends on SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -107,9 +118,9 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
+	default m
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -118,10 +129,10 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
+	default m
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -130,9 +141,9 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
+	default m
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
@@ -141,9 +152,9 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
+	default m
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
@@ -152,19 +163,23 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
+	default n
 	depends on X86_INTEL_LPSS && I2C && ACPI
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
 	  Up boards and provides access to I2S signals on the Low-Speed
-	  connector
+	  connector. It is not intended to be enabled by distros by default.
 	  If unsure select "N".
 
+endif
+
+if SND_SOC_INTEL_SKYLAKE
+
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
+	default m
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -176,8 +191,8 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
+	default m
 	depends on X86_INTEL_LPSS && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
@@ -190,8 +205,8 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
+	default m
 	depends on X86_INTEL_LPSS && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -204,8 +219,8 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
+	default m
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -219,8 +234,8 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
+	default m
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -233,9 +248,9 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
+	default m
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_INTEL_SST
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
@@ -248,9 +263,9 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
+	default m
         depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
-        depends on SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
@@ -261,5 +276,6 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
           create an alsa sound card for RT5663 + RT5514 + MAX98927.
           Say Y if you have such a device.
           If unsure select "N".
+endif
 
 endif
-- 
2.14.1
