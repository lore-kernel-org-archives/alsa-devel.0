From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 8/8] ASoC: Intel: clarify Kconfig
	dependencies
Date: Fri,  8 Sep 2017 15:57:02 -0500
Message-ID: <20170908205702.1985-9-pierre-louis.bossart@linux.intel.com>
References: <20170908205702.1985-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A899C267593
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 22:57:20 +0200 (CEST)
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

Introduce more logical dependencies, with the SOC selected first and the
relevant machine drivers are exposed.
The same mechanism will be used for SOF support.

Also select SND_SOC_ACPI_INTEL_MATCH for all machine drivers

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        | 25 +++++++++-----
 sound/soc/intel/boards/Kconfig | 77 ++++++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b8ebf05..1dcc9e45 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -1,7 +1,3 @@
-config SND_SST_ATOM_HIFI2_PLATFORM
-	tristate
-	select SND_SOC_COMPRESS
-
 config SND_SST_IPC
 	tristate
 
@@ -20,9 +16,7 @@ config SND_SOC_INTEL_COMMON
 
 config SND_SOC_INTEL_SST
 	tristate
-	select SND_SOC_INTEL_COMMON
 	select SND_SOC_INTEL_SST_ACPI if ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
@@ -35,18 +29,31 @@ config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
 
+config SND_SOC_INTEL_SST_TOPLEVEL
+	tristate "Intel ASoC SST drivers"
+	select SND_SOC_INTEL_MACH
+	select SND_SOC_INTEL_COMMON
+
 config SND_SOC_INTEL_HASWELL
-	tristate
+	tristate "Intel ASoC SST driver for Haswell/Broadwell"
+	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
-	tristate
+	tristate "Intel ASoC SST driver for Baytrail (legacy)"
+	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
+config SND_SST_ATOM_HIFI2_PLATFORM
+	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
+	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	select SND_SOC_COMPRESS
+
 config SND_SOC_INTEL_SKYLAKE
-	tristate
+	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
+	depends on SND_SOC_INTEL_SST_TOPLEVEL
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index cfc6679..de1280f 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -1,8 +1,13 @@
+config SND_SOC_INTEL_MACH
+	tristate "Intel Audio machine drivers"
+	select SND_SOC_ACPI_INTEL_MATCH if ACPI
+
 config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
+	depends on SND_SOC_INTEL_MACH
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_PCI
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
@@ -12,9 +17,10 @@ config SND_MFLD_MACHINE
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
+	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
 	  This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
@@ -24,9 +30,10 @@ config SND_SOC_INTEL_HASWELL_MACH
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
 	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
+	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
 	  This adds support for Intel Broadwell platform based boards with
@@ -34,9 +41,10 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on DMADEVICES
-	select SND_SOC_INTEL_HASWELL
+	depends on SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
 	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
@@ -46,10 +54,11 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on DMADEVICES
 	depends on SND_SST_IPC_ACPI = n
-	select SND_SOC_INTEL_BAYTRAIL
+	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
@@ -57,10 +66,11 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	depends on DMADEVICES
 	depends on SND_SST_IPC_ACPI = n
-	select SND_SOC_INTEL_BAYTRAIL
+	depends on SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
@@ -69,11 +79,11 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
@@ -82,11 +92,11 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
@@ -95,11 +105,11 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on X86_INTEL_LPSS && I2C && ACPI
+        depends on SND_SOC_INTEL_MACH
+	depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        select SND_SST_ATOM_HIFI2_PLATFORM
+        depends on SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -108,11 +118,11 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with RT5645/5650 audio codec.
@@ -120,12 +130,12 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 
 config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with MAX98090 & TI codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
@@ -133,11 +143,11 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7213
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
 	  platforms with DA7212/7213 audio codec.
@@ -145,11 +155,11 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 
 config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with ES8316 codec"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_ES8316
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail &
 	  Cherrytrail platforms with ES8316 audio codec.
@@ -157,10 +167,10 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
-	select SND_SST_ATOM_HIFI2_PLATFORM
+	depends on SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_ACPI_INTEL_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for the MinnowBoard Max or
 	  Up boards and provides access to I2S signals on the Low-Speed
@@ -169,8 +179,9 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -182,8 +193,9 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
@@ -196,8 +208,9 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -210,8 +223,9 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -225,8 +239,9 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -239,9 +254,10 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
+	depends on SND_SOC_INTEL_MACH
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SKYLAKE
+	depends on SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
@@ -254,9 +270,10 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
+        depends on SND_SOC_INTEL_MACH
         depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
-        select SND_SOC_INTEL_SKYLAKE
+        depends on SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
-- 
2.9.3
