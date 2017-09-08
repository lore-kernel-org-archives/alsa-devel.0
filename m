From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 6/8] ASoC: Intel: move machine drivers to
	dedicated KConfig
Date: Fri,  8 Sep 2017 15:57:00 -0500
Message-ID: <20170908205702.1985-7-pierre-louis.bossart@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B37C266E4C
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 22:57:19 +0200 (CEST)
In-Reply-To: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

split Kconfig to prepare for reuse of machine drivers for
SOF support
no functional change or edits

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        | 271 +----------------------------------------
 sound/soc/intel/boards/Kconfig | 269 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+), 269 deletions(-)
 create mode 100644 sound/soc/intel/boards/Kconfig

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ec74d1d..b8ebf05 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -1,15 +1,3 @@
-config SND_MFLD_MACHINE
-	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
-	depends on INTEL_SCU_IPC
-	select SND_SOC_SN95031
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_PCI
-	help
-          This adds support for ASoC machine driver for Intel(R) MID Medfield platform
-          used as alsa device in audio substem in Intel(R) MID devices
-          Say Y if you have such a device.
-          If unsure select "N".
-
 config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate
 	select SND_SOC_COMPRESS
@@ -57,223 +45,6 @@ config SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
-config SND_SOC_INTEL_HASWELL_MACH
-	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
-	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
-	select SND_SOC_RT5640
-	help
-	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
-	  Ultrabook platforms.
-	  Say Y if you have such a device.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
-	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
-	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_DA7219
-	select SND_SOC_MAX98357A
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	select SND_HDA_DSP_LOADER
-	help
-	   This adds support for ASoC machine driver for Broxton-P platforms
-	   with DA7219 + MAX98357A I2S audio codec.
-	   Say Y if you have such a device.
-	   If unsure select "N".
-
-config SND_SOC_INTEL_BXT_RT298_MACH
-	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
-	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_RT298
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	select SND_HDA_DSP_LOADER
-	help
-	   This adds support for ASoC machine driver for Broxton platforms
-	   with RT286 I2S audio codec.
-	   Say Y if you have such a device.
-	   If unsure select "N".
-
-config SND_SOC_INTEL_BYT_RT5640_MACH
-	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
-	depends on X86_INTEL_LPSS && I2C
-	depends on DMADEVICES
-	depends on SND_SST_IPC_ACPI = n
-	select SND_SOC_INTEL_BAYTRAIL
-	select SND_SOC_RT5640
-	help
-	  This adds audio driver for Intel Baytrail platform based boards
-	  with the RT5640 audio codec. This driver is deprecated, use
-	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
-
-config SND_SOC_INTEL_BYT_MAX98090_MACH
-	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
-	depends on X86_INTEL_LPSS && I2C
-	depends on DMADEVICES
-	depends on SND_SST_IPC_ACPI = n
-	select SND_SOC_INTEL_BAYTRAIL
-	select SND_SOC_MAX98090
-	help
-	  This adds audio driver for Intel Baytrail platform based boards
-	  with the MAX98090 audio codec.
-
-config SND_SOC_INTEL_BDW_RT5677_MACH
-	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
-	depends on X86_INTEL_LPSS && GPIOLIB && I2C
-	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
-	select SND_SOC_RT5677
-	help
-	  This adds support for Intel Broadwell platform based boards with
-	  the RT5677 audio codec.
-
-config SND_SOC_INTEL_BROADWELL_MACH
-	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
-	select SND_SOC_RT286
-	help
-	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
-	  Ultrabook platforms.
-	  Say Y if you have such a device.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_BYTCR_RT5640_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C && ACPI
-	select SND_SOC_RT5640
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
-          platforms with RT5640 audio codec.
-          Say Y if you have such a device.
-          If unsure select "N".
-
-config SND_SOC_INTEL_BYTCR_RT5651_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on X86 && I2C && ACPI
-	select SND_SOC_RT5651
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
-          platforms with RT5651 audio codec.
-          Say Y if you have such a device.
-          If unsure select "N".
-
-config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
-        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on X86_INTEL_LPSS && I2C && ACPI
-        select SND_SOC_RT5670
-        select SND_SST_ATOM_HIFI2_PLATFORM
-        select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-        help
-          This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-          platforms with RT5672 audio codec.
-          Say Y if you have such a device.
-          If unsure select "N".
-
-config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SOC_RT5645
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-	  platforms with RT5645/5650 audio codec.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SOC_MAX98090
-	select SND_SOC_TS3A227E
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SOC_DA7213
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
-	  platforms with DA7212/7213 audio codec.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
-	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SOC_ES8316
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-	  This adds support for ASoC machine driver for Intel(R) Baytrail &
-	  Cherrytrail platforms with ES8316 audio codec.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
-	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
-	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SST_ATOM_HIFI2_PLATFORM
-	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
-	help
-	  This adds support for ASoC machine driver for the MinnowBoard Max or
-	  Up boards and provides access to I2S signals on the Low-Speed
-	  connector
-	  If unsure select "N".
-
-config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
-	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_RT5663
-	select SND_SOC_MAX98927
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	help
-	  This adds support for ASoC Onboard Codec I2S machine driver. This will
-	  create an alsa sound card for RT5663 + MAX98927.
-	  Say Y if you have such a device.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
-        tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on X86_INTEL_LPSS && I2C && SPI
-        select SND_SOC_INTEL_SST
-        select SND_SOC_INTEL_SKYLAKE
-        select SND_SOC_RT5663
-        select SND_SOC_RT5514
-        select SND_SOC_RT5514_SPI
-        select SND_SOC_MAX98927
-        select SND_SOC_HDAC_HDMI
-        help
-          This adds support for ASoC Onboard Codec I2S machine driver. This will
-          create an alsa sound card for RT5663 + RT5514 + MAX98927.
-          Say Y if you have such a device.
-          If unsure select "N".
-
 config SND_SOC_INTEL_SKYLAKE
 	tristate
 	select SND_HDA_EXT_CORE
@@ -281,43 +52,5 @@ config SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 
-config SND_SOC_INTEL_SKL_RT286_MACH
-	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_RT286
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	help
-	   This adds support for ASoC machine driver for Skylake platforms
-	   with RT286 I2S audio codec.
-	   Say Y if you have such a device.
-	   If unsure select "N".
-
-config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
-	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_NAU8825
-	select SND_SOC_SSM4567
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	help
-	  This adds support for ASoC Onboard Codec I2S machine driver. This will
-	  create an alsa sound card for NAU88L25 + SSM4567.
-	  Say Y if you have such a device.
-	  If unsure select "N".
-
-config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
-	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SKYLAKE
-	select SND_SOC_NAU8825
-	select SND_SOC_MAX98357A
-	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI
-	help
-	  This adds support for ASoC Onboard Codec I2S machine driver. This will
-	  create an alsa sound card for NAU88L25 + MAX98357A.
-	  Say Y if you have such a device.
-	  If unsure select "N".
+# ASoC codec drivers
+source "sound/soc/intel/boards/Kconfig"
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
new file mode 100644
index 0000000..b00721b
--- /dev/null
+++ b/sound/soc/intel/boards/Kconfig
@@ -0,0 +1,269 @@
+config SND_MFLD_MACHINE
+	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
+	depends on INTEL_SCU_IPC
+	select SND_SOC_SN95031
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_PCI
+	help
+          This adds support for ASoC machine driver for Intel(R) MID Medfield platform
+          used as alsa device in audio substem in Intel(R) MID devices
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_INTEL_HASWELL_MACH
+	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
+	depends on DMADEVICES
+	select SND_SOC_INTEL_HASWELL
+	select SND_SOC_RT5640
+	help
+	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
+	  Ultrabook platforms.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
+	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
+	depends on X86 && ACPI && I2C
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_DA7219
+	select SND_SOC_MAX98357A
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	select SND_HDA_DSP_LOADER
+	help
+	   This adds support for ASoC machine driver for Broxton-P platforms
+	   with DA7219 + MAX98357A I2S audio codec.
+	   Say Y if you have such a device.
+	   If unsure select "N".
+
+config SND_SOC_INTEL_BXT_RT298_MACH
+	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
+	depends on X86 && ACPI && I2C
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_RT298
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	select SND_HDA_DSP_LOADER
+	help
+	   This adds support for ASoC machine driver for Broxton platforms
+	   with RT286 I2S audio codec.
+	   Say Y if you have such a device.
+	   If unsure select "N".
+
+config SND_SOC_INTEL_BYT_RT5640_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
+	depends on X86_INTEL_LPSS && I2C
+	depends on DMADEVICES
+	depends on SND_SST_IPC_ACPI = n
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_RT5640
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the RT5640 audio codec. This driver is deprecated, use
+	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
+
+config SND_SOC_INTEL_BYT_MAX98090_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
+	depends on X86_INTEL_LPSS && I2C
+	depends on DMADEVICES
+	depends on SND_SST_IPC_ACPI = n
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_MAX98090
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the MAX98090 audio codec.
+
+config SND_SOC_INTEL_BDW_RT5677_MACH
+	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
+	depends on X86_INTEL_LPSS && GPIOLIB && I2C
+	depends on DMADEVICES
+	select SND_SOC_INTEL_HASWELL
+	select SND_SOC_RT5677
+	help
+	  This adds support for Intel Broadwell platform based boards with
+	  the RT5677 audio codec.
+
+config SND_SOC_INTEL_BROADWELL_MACH
+	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
+	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
+	depends on DMADEVICES
+	select SND_SOC_INTEL_HASWELL
+	select SND_SOC_RT286
+	help
+	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
+	  Ultrabook platforms.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_BYTCR_RT5640_MACH
+        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	depends on X86 && I2C && ACPI
+	select SND_SOC_RT5640
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+          platforms with RT5640 audio codec.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_INTEL_BYTCR_RT5651_MACH
+        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
+	depends on X86 && I2C && ACPI
+	select SND_SOC_RT5651
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+          platforms with RT5651 audio codec.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
+        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
+        depends on X86_INTEL_LPSS && I2C && ACPI
+        select SND_SOC_RT5670
+        select SND_SST_ATOM_HIFI2_PLATFORM
+        select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+        help
+          This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+          platforms with RT5672 audio codec.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
+	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_RT5645
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+	  platforms with RT5645/5650 audio codec.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
+	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_MAX98090
+	select SND_SOC_TS3A227E
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
+	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_DA7213
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
+	  platforms with DA7212/7213 audio codec.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
+	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ES8316
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) Baytrail &
+	  Cherrytrail platforms with ES8316 audio codec.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
+	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for the MinnowBoard Max or
+	  Up boards and provides access to I2S signals on the Low-Speed
+	  connector
+	  If unsure select "N".
+
+config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
+	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
+	depends on X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for RT5663 + MAX98927.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
+        tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
+        depends on X86_INTEL_LPSS && I2C && SPI
+        select SND_SOC_INTEL_SST
+        select SND_SOC_INTEL_SKYLAKE
+        select SND_SOC_RT5663
+        select SND_SOC_RT5514
+        select SND_SOC_RT5514_SPI
+        select SND_SOC_MAX98927
+        select SND_SOC_HDAC_HDMI
+        help
+          This adds support for ASoC Onboard Codec I2S machine driver. This will
+          create an alsa sound card for RT5663 + RT5514 + MAX98927.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_INTEL_SKL_RT286_MACH
+	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
+	depends on X86 && ACPI && I2C
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_RT286
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	help
+	   This adds support for ASoC machine driver for Skylake platforms
+	   with RT286 I2S audio codec.
+	   Say Y if you have such a device.
+	   If unsure select "N".
+
+config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
+	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
+	depends on X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_NAU8825
+	select SND_SOC_SSM4567
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for NAU88L25 + SSM4567.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
+	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
+	depends on X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_NAU8825
+	select SND_SOC_MAX98357A
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for NAU88L25 + MAX98357A.
+	  Say Y if you have such a device.
+	  If unsure select "N".
-- 
2.9.3
