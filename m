From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: align Kconfig configurations for HiFi2" to the asoc tree
Date: Mon, 08 Jan 2018 16:21:45 +0000
Message-ID: <E1eYaBF-000231-NB@debutante>
References: <20180103165022.4984-8-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-8-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: align Kconfig configurations for HiFi2

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

>From 99644597d71333866070f0223bffa62c03f36587 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 4 Jan 2018 16:35:58 -0600
Subject: [PATCH] ASoC: Intel: boards: align Kconfig configurations for HiFi2

Make sure all the configs are aligned
Also add the missing dependencies on SOC_ACPI stuff used to fix
DAI names based on HID and fix a couple of indentation issues

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 358f8f33adc4..08c482cc02f7 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -85,29 +85,32 @@ endif
 if SND_SST_ATOM_HIFI2_PLATFORM
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C && ACPI
+	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_RT5640
 	help
-          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
-          platforms with RT5640 audio codec.
-          Say Y or m if you have such a device. This is a recommended option.
-          If unsure select "N".
+	  This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+	  platforms with RT5640 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on X86 && I2C && ACPI
+	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_RT5651
 	help
-          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
-          platforms with RT5651 audio codec.
-          Say Y or m if you have such a device. This is a recommended option.
-          If unsure select "N".
+	  This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+	  platforms with RT5651 audio codec.
+	  Say Y or m if you have such a device. This is a recommended option.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
-        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
+	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
-        select SND_SOC_RT5670
+	select SND_SOC_ACPI
+	select SND_SOC_RT5670
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -117,6 +120,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_RT5645
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -138,6 +142,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ACPI
 	select SND_SOC_DA7213
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
-- 
2.15.1
