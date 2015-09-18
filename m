From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] sst: select DW_DMAC_CORE since it's
	mandatory
Date: Fri, 18 Sep 2015 14:44:49 +0300
Message-ID: <1442576689-32221-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F66260412
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 13:45:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

While here group selectors under SND_SOC_INTEL_HASWELL and
SND_SOC_INTEL_BAYTRAIL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 05fde5e6e..bc5281e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -35,15 +35,17 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+	select DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate
+	select DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -55,8 +57,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
@@ -66,8 +66,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
@@ -76,10 +74,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
-		   I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
+	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
2.5.1
