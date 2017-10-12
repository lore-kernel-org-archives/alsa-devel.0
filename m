From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/8] ASoC: Intel: reorder boards Kconfig by
	chronological order
Date: Thu, 12 Oct 2017 18:49:44 -0500
Message-ID: <20171012234945.30318-8-pierre-louis.bossart@linux.intel.com>
References: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 80ABD266EEB
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:50:03 +0200 (CEST)
In-Reply-To: <20171012234945.30318-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This file is a mess, order by generation with more recent last

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 166 ++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index b00721b85df8..5bb0eb00df58 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -22,58 +22,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
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
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
 	depends on X86_INTEL_LPSS && GPIOLIB && I2C
@@ -96,6 +44,29 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
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
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C && ACPI
@@ -196,37 +167,6 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	  connector
 	  If unsure select "N".
 
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
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
 	depends on X86 && ACPI && I2C
@@ -267,3 +207,63 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	  create an alsa sound card for NAU88L25 + MAX98357A.
 	  Say Y if you have such a device.
 	  If unsure select "N".
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
-- 
2.11.0
