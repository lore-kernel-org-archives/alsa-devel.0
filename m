From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 7/7] ASoC: Intel: boards: align/fix
	SKL/BXT/KBL Kconfigs
Date: Fri, 17 Nov 2017 18:02:02 -0600
Message-ID: <20171118000202.22302-8-pierre-louis.bossart@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D4E7267256
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:02:33 +0100 (CET)
In-Reply-To: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
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
Cc: arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

No reason why SND_SOC_INTEL_SST should be set here.
Also make sure same dependencies are used everywhere (only last one has SPI
in addition)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 7379b0220210..810fa769c4cb 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -181,7 +181,7 @@ if SND_SOC_INTEL_SKYLAKE
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
-	depends on X86 && ACPI && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -193,7 +193,7 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
 	select SND_SOC_DMIC
@@ -206,7 +206,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -219,7 +219,7 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
-	depends on X86 && ACPI && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -233,7 +233,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
-	depends on X86 && ACPI && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
@@ -246,8 +246,7 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "ASoC Audio driver for KBL with RT5663 and MAX98927 in I2S Mode"
-	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	select SND_SOC_DMIC
@@ -260,8 +259,7 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on X86_INTEL_LPSS && I2C && SPI
-        select SND_SOC_INTEL_SST
+        depends on X86_INTEL_LPSS && I2C && SPI && ACPI
         select SND_SOC_RT5663
         select SND_SOC_RT5514
         select SND_SOC_RT5514_SPI
-- 
2.14.1
