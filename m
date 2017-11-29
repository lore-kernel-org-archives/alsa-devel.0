From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH v2 6/7] ASoC: Intel: boards: align Kconfig configurations for HiFi2
Date: Tue, 28 Nov 2017 19:45:50 -0600
Message-ID: <20171129014551.30552-7-pierre-louis.bossart@linux.intel.com>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Make sure all the configs are aligned
Also add the missing dependencies on SOC_ACPI stuff used to fix
DAI names based on HID and fix a couple of indentation issues

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index a1e169c86526..850b5ef9265e 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -87,29 +87,32 @@ endif
 if SND_SST_ATOM_HIFI2_PLATFORM
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C && ACPI
+	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
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
+	select CONFIG_SND_SOC_ACPI
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
+	select CONFIG_SND_SOC_ACPI
+	select SND_SOC_RT5670
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
           platforms with RT5672 audio codec.
@@ -119,6 +122,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_RT5645
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -140,6 +144,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
+	select CONFIG_SND_SOC_ACPI
 	select SND_SOC_DA7213
 	help
 	  This adds support for ASoC machine driver for Intel(R) Baytrail & CherryTrail
-- 
2.14.1
