From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/4] ASoC: Intel: remove redundant select
	SND_SOC_INTEL_SST
Date: Sat,  7 Jan 2017 14:32:48 +0200
Message-ID: <20170107123250.52930-3-andriy.shevchenko@linux.intel.com>
References: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A46A2669E9
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2017 13:32:57 +0100 (CET)
In-Reply-To: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
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

SND_SOC_INTEL_SKYLAKE selects SND_SOC_INTEL_SST already. Thus no need to
duplicate. Remove duplications.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 3da3b28b70e1..7b60689a22d4 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -67,7 +67,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
@@ -83,7 +82,6 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
@@ -210,7 +208,6 @@ config SND_SOC_INTEL_SKYLAKE
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
@@ -224,7 +221,6 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
@@ -239,7 +235,6 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
-- 
2.11.0
