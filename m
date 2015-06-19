From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/6] ASoC: intel - kconfig: remove
	SND_SOC_INTEL_SST prompt
Date: Fri, 19 Jun 2015 23:55:28 +0530
Message-ID: <1434738331-12518-4-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A34C26062B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:24:02 +0200 (CEST)
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

The SND_SOC_INTEL_SST is for common IPC lib and this should ideally be
not selectable symbol but selected by respective machine driver So
remove the prompt and get respective machines select it

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 6f9a54af9c64..32262be80871 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -26,13 +26,9 @@ config SND_SST_IPC_ACPI
 	depends on ACPI
 
 config SND_SOC_INTEL_SST
-	tristate "ASoC support for Intel(R) Smart Sound Technology"
+	tristate
 	select SND_SOC_INTEL_SST_ACPI if ACPI
 	depends on (X86 || COMPILE_TEST)
-	help
-          This adds support for Intel(R) Smart Sound Technology (SST).
-          Say Y if you have such a device
-          If unsure select "N".
 
 config SND_SOC_INTEL_SST_ACPI
 	tristate
@@ -45,9 +41,9 @@ config SND_SOC_INTEL_BAYTRAIL
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C && \
-		   I2C_DESIGNWARE_PLATFORM
+	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -58,8 +54,9 @@ config SND_SOC_INTEL_HASWELL_MACH
 
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C
 	depends on DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
@@ -68,8 +65,9 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C
 	depends on DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
@@ -78,9 +76,10 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC && \
+	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
 		   I2C_DESIGNWARE_PLATFORM
 	depends on DW_DMAC_CORE
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
1.9.1
