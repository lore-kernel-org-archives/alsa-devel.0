From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/4] ASoC: Intel: select DW_DMAC_CORE since
	it's mandatory
Date: Mon,  2 Jan 2017 17:20:14 +0200
Message-ID: <20170102152017.13938-2-andriy.shevchenko@linux.intel.com>
References: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 027E526728A
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 16:20:26 +0100 (CET)
In-Reply-To: <20170102152017.13938-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Select DW_DMAC_CORE like the rest of glue drivers do, e.g.
drivers/dma/dw/Kconfig.

While here group selectors under SND_SOC_INTEL_HASWELL and
SND_SOC_INTEL_BAYTRAIL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fd5d1e091038..3da3b28b70e1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -33,11 +33,9 @@ config SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	depends on (X86 || COMPILE_TEST)
 
-# firmware stuff depends DW_DMAC_CORE; since there is no depends-on from
-# the reverse selection, each machine driver needs to select
-# SND_SOC_INTEL_SST_FIRMWARE carefully depending on DW_DMAC_CORE
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
+	select DW_DMAC_CORE
 
 config SND_SOC_INTEL_SST_ACPI
 	tristate
@@ -47,16 +45,17 @@ config SND_SOC_INTEL_SST_MATCH
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -99,9 +98,7 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE && (SND_SST_IPC_ACPI = n)
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
+	depends on SND_SST_IPC_ACPI = n
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
@@ -112,9 +109,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE && (SND_SST_IPC_ACPI = n)
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
+	depends on SND_SST_IPC_ACPI = n
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
@@ -123,9 +118,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
-	depends on X86_INTEL_LPSS && GPIOLIB && I2C && DW_DMAC
-	depends on DW_DMAC_CORE=y
-	select SND_SOC_INTEL_SST
+	depends on X86_INTEL_LPSS && GPIOLIB && I2C
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
@@ -134,10 +127,7 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 
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
2.11.0
