From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 1/7] ASoC: Intel: Fix Kconfig
Date: Fri, 17 Nov 2017 18:01:56 -0600
Message-ID: <20171118000202.22302-2-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Follow network example suggested by Linus, move Intel definitions
in if/endif block and clarify which options distro configurations
should enable - everything except legacy Baytrail stuff and
NOCODEC (test only)

There should be no functionality change - except that sound capabilities
are restored when using older configs without any user selection.

Fixes: f6a118a800e3 ("ASoC: Intel: clarify Kconfig dependencies")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        | 57 +++++++++++++++----------
 sound/soc/intel/boards/Kconfig | 97 ++++++++++++++++++++++++------------------
 2 files changed, 90 insertions(+), 64 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7b49d04e3c60..98ef2273665f 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -1,3 +1,18 @@
+config SND_SOC_INTEL_SST_TOPLEVEL
+	bool "Intel ASoC SST drivers"
+	default y
+	depends on X86 || COMPILE_TEST
+	help
+          Intel ASoC SST Platform Drivers. If you have a Intel machine that
+          has audio controller with a DSP and I2S or DMIC port, then
+          enable this option by saying Y
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Intel SST drivers.
+
+if SND_SOC_INTEL_SST_TOPLEVEL
+
 config SND_SST_IPC
 	tristate
 
@@ -11,9 +26,6 @@ config SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST
 	select IOSF_MBI
 
-config SND_SOC_INTEL_COMMON
-	tristate
-
 config SND_SOC_INTEL_SST
 	tristate
 	select SND_SOC_INTEL_SST_ACPI if ACPI
@@ -25,47 +37,48 @@ config SND_SOC_INTEL_SST_FIRMWARE
 config SND_SOC_INTEL_SST_ACPI
 	tristate
 
-config SND_SOC_ACPI_INTEL_MATCH
-	tristate
-	select SND_SOC_ACPI if ACPI
-
-config SND_SOC_INTEL_SST_TOPLEVEL
-	tristate "Intel ASoC SST drivers"
-	depends on X86 || COMPILE_TEST
-	select SND_SOC_INTEL_MACH
-	select SND_SOC_INTEL_COMMON
-	help
-          Intel ASoC Audio Drivers. If you have a Intel machine that
-          has audio controller with a DSP and I2S or DMIC port, then
-          enable this option by saying Y or M
-          If unsure select "N".
-
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
+	depends on SND_DMA_SGBUF
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
+	select SND_SOC_INTEL_COMMON
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	depends on DMADEVICES
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
+	select SND_SOC_INTEL_COMMON
 
 config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
+	depends on X86
 	select SND_SOC_COMPRESS
+	select SND_SOC_INTEL_COMMON
 
 config SND_SOC_INTEL_SKYLAKE
 	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
+	depends on PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_COMMON
+
+endif ## SND_SOC_INTEL_SST_TOPLEVEL
 
 # ASoC codec drivers
 source "sound/soc/intel/boards/Kconfig"
+
+# configs common to SST and SOF to compile sound/soc/intel/common
+# directory and use matching tables
+
+config SND_SOC_INTEL_COMMON
+	tristate
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+
+config SND_SOC_ACPI_INTEL_MATCH
+	tristate
+	select SND_SOC_ACPI if ACPI
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 6f754708a48c..4ae44b0cea0a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -1,7 +1,14 @@
-config SND_SOC_INTEL_MACH
-	tristate "Intel Audio machine drivers"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+config  SND_SOC_INTEL_MACH
+	bool "Intel ASoC machine drivers"
+	default y
+	help
+          Intel ASoC Audio Machine Drivers. If you have a Intel machine that
+          has audio controller with a DSP and I2S or DMIC port, then
+          enable this option by saying Y
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Intel SST machine drivers.
 
 if SND_SOC_INTEL_MACH
 
@@ -17,103 +24,108 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device.
           If unsure select "N".
 
+if SND_SOC_INTEL_HASWELL
+
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
 	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
-	  Ultrabook platforms.
-	  Say Y if you have such a device.
+	  Ultrabook platforms. This is a recommended option.
+	  Say Y or m if you have such a device.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
 	  This adds support for Intel Broadwell platform based boards with
-	  the RT5677 audio codec.
+	  the RT5677 audio codec. This is a recommended option.
+	  Say Y or m if you have such a device.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
 	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
 	  Ultrabook platforms.
-	  Say Y if you have such a device.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
+endif
+
+if SND_SOC_INTEL_BAYTRAIL
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
+	default n
 	depends on X86_INTEL_LPSS && I2C
-	depends on SND_SST_IPC_ACPI = n
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
-	depends on SND_SST_IPC_ACPI = n
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
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
-          Say Y if you have such a device.
+          Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
-          Say Y if you have such a device.
+          Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        depends on SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
-          Say Y if you have such a device.
+          Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
@@ -121,63 +133,68 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
 	  platforms with DA7212/7213 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
-	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
 	  Cherrytrail platforms with ES8316 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
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
+	  connector. This is not a recommended option outside of these cases.
+	  It is not intended to be enabled by distros by default.
+	  Say Y or m if you have such a device.
+
 	  If unsure select "N".
 
+endif
+
+if SND_SOC_INTEL_SKYLAKE
+
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
 	help
 	   This adds support for ASoC machine driver for Skylake platforms
 	   with RT286 I2S audio codec.
-	   Say Y if you have such a device.
+	   Say Y or m if you have such a device.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
@@ -185,13 +202,12 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for NAU88L25 + SSM4567.
-	  Say Y if you have such a device.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -199,13 +215,12 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for NAU88L25 + MAX98357A.
-	  Say Y if you have such a device.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -214,13 +229,12 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	help
 	   This adds support for ASoC machine driver for Broxton-P platforms
 	   with DA7219 + MAX98357A I2S audio codec.
-	   Say Y if you have such a device.
+	   Say Y or m if you have such a device. This is a recommended option.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
 	depends on X86 && ACPI && I2C
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -228,14 +242,13 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	help
 	   This adds support for ASoC machine driver for Broxton platforms
 	   with RT286 I2S audio codec.
-	   Say Y if you have such a device.
+	   Say Y or m if you have such a device. This is a recommended option.
 	   If unsure select "N".
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_INTEL_SST
-	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
@@ -243,14 +256,13 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	help
 	  This adds support for ASoC Onboard Codec I2S machine driver. This will
 	  create an alsa sound card for RT5663 + MAX98927.
-	  Say Y if you have such a device.
+	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
         depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
-        depends on SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
@@ -259,7 +271,8 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         help
           This adds support for ASoC Onboard Codec I2S machine driver. This will
           create an alsa sound card for RT5663 + RT5514 + MAX98927.
-          Say Y if you have such a device.
+          Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
+endif
 
 endif
-- 
2.14.1
