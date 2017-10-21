From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: reorder boards Kconfig by
	chronological order" to the asoc tree
Date: Sat, 21 Oct 2017 11:28:10 +0100 (BST)
Message-ID: <20171021102810.25255440057@finisterre.ee.mobilebroadband>
References: <20170908205702.1985-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF7926775D
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:28:40 +0200 (CEST)
In-Reply-To: <20170908205702.1985-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: reorder boards Kconfig by chronological order

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

>From d4d86b86e1ffa6be16b287ee34b0090ef79a0fbb Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:49:44 -0500
Subject: [PATCH] ASoC: Intel: reorder boards Kconfig by chronological order

This file is a mess, order by generation with more recent last

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
