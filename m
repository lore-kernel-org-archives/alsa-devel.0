From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: intel: fix build when ACPI is not enabled
Date: Thu, 9 Jun 2016 17:01:38 -0700
Message-ID: <575A0362.2080604@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

kconfig tools generate the following warning when CONFIG_ACPI is not
enabled:

warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH && SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH && SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && ACPI)

causing these build errors:

In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
../include/acpi/acpi_bus.h:65:20: error: conflicting types for 'acpi_evaluate_dsm'
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
../include/linux/acpi.h:676:34: note: previous definition of 'acpi_evaluate_dsm' was here
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,

I am told that ACPI is a requirement for these drivers, so make that
explicit. Also end help text sentences with a period.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Jie Yang <yang.jie@linux.intel.com>
Cc:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:	alsa-devel@alsa-project.org
---
 sound/soc/intel/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Should SND_SOC_INTEL_SST and possibly other similar drivers get this
same change?

--- linux-next-20160607.orig/sound/soc/intel/Kconfig
+++ linux-next-20160607/sound/soc/intel/Kconfig
@@ -128,28 +128,28 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_INTEL_SST_MATCH
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5640 audio codec.
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
-	select SND_SOC_INTEL_SST_MATCH if ACPI
+	select SND_SOC_INTEL_SST_MATCH
 	help
           This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
           platforms with RT5651 audio codec.
-          Say Y if you have such a device
+          Say Y if you have such a device.
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
