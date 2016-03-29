From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: intel: make Kconfig selects depend on ACPI
Date: Tue, 29 Mar 2016 09:45:05 -0700
Message-ID: <56FAB111.2070503@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Prevent SND_SST_IPC_ACPI from being selected when CONFIG_ACPI is
not enabled.  This fixes the kconfig warning:

warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH && SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH && SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && ACPI)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jie Yang <yang.jie@linux.intel.com>
Cc:	alsa-devel@alsa-project.org
---
 sound/soc/intel/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20160308.orig/sound/soc/intel/Kconfig
+++ linux-next-20160308/sound/soc/intel/Kconfig
@@ -100,7 +100,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	depends on X86 && I2C
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
-	select SND_SST_IPC_ACPI
+	select SND_SST_IPC_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -113,7 +113,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	depends on X86 && I2C
 	select SND_SOC_RT5651
 	select SND_SST_MFLD_PLATFORM
-	select SND_SST_IPC_ACPI
+	select SND_SST_IPC_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
@@ -126,7 +126,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         depends on X86_INTEL_LPSS && I2C
         select SND_SOC_RT5670
         select SND_SST_MFLD_PLATFORM
-        select SND_SST_IPC_ACPI
+        select SND_SST_IPC_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
         help
           This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -139,7 +139,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	depends on X86_INTEL_LPSS && I2C
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
-	select SND_SST_IPC_ACPI
+	select SND_SST_IPC_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
@@ -152,7 +152,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
 	select SND_SST_MFLD_PLATFORM
-	select SND_SST_IPC_ACPI
+	select SND_SST_IPC_ACPI if ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
       This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
