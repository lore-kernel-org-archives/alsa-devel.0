From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Kconfig: fix build when ACPI
	is not enabled
Date: Tue, 21 Jun 2016 09:33:03 +0530
Message-ID: <1466481784-3651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C862656F5
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 05:56:24 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Randy reported following error when ACPI is not enabled:

warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH
&& SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH &&
SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI
+which has unmet direct dependencies (SOUND && !M68K && !UML && SND &&
SND_SOC && ACPI)

causing these build errors:

In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
../include/acpi/acpi_bus.h:65:20: error: conflicting types for
'acpi_evaluate_dsm'
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
../include/linux/acpi.h:676:34: note: previous definition of
'acpi_evaluate_dsm' was here
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,

CONFIG_SND_SST_IPC_ACPI was already dependent upon ACPI, but that was not
solving it. So move the depends up to machine drivers and remove from
CONFIG_SND_SST_IPC_ACPI.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 3875425a9693..63e4c14ebe9f 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -25,7 +25,6 @@ config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
-	depends on ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -128,7 +127,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -141,7 +140,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -154,7 +153,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on X86_INTEL_LPSS && I2C
+        depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
         select SND_SST_MFLD_PLATFORM
         select SND_SST_IPC_ACPI
@@ -167,7 +166,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
-- 
1.9.1
