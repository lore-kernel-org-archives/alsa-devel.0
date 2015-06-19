From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/6] ASoC: Intel: kconfig - Move DW_DMAC_CORE
	dependency to machines
Date: Fri, 19 Jun 2015 23:55:27 +0530
Message-ID: <1434738331-12518-3-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1685326062A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:24:00 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Some HSW and BYT machines depend on the DW_DMAC_CORE so they should
have have depends on this symbol rather than common IPC lib as SKL
onwards IPC lib is used but we don't depend on DW_DMAC_CORE

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index f3060a4ca040..6f9a54af9c64 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -29,7 +29,6 @@ config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
 	depends on (X86 || COMPILE_TEST)
-	depends on DW_DMAC_CORE
 	help
           This adds support for Intel(R) Smart Sound Technology (SST).
           Say Y if you have such a device
@@ -48,6 +47,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C && \
 		   I2C_DESIGNWARE_PLATFORM
+	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -59,6 +59,7 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
@@ -68,6 +69,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
@@ -78,6 +80,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \
 		   I2C_DESIGNWARE_PLATFORM
+	depends on DW_DMAC_CORE
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
1.9.1
