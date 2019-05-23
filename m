From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: sound/soc/intel/boards: limit some drivers to X86 since
 headers are only in arch/x86/
Date: Wed, 22 May 2019 20:58:49 -0700
Message-ID: <46dc0767-bb21-2b98-90f2-34dd4bcad7c0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Several drivers in sound/soc/intel/boards/ #include header files
that only exist in arch/x86/include/asm.  This causes build errors,
so make these drivers depend on X86.

Fixes these build errors (on ia64):

../sound/soc/intel/boards/bxt_da7219_max98357a.c:19:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcr_rt5640.c:31:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcr_rt5651.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/cht_bsw_rt5645.c:29:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcht_es8316.c:33:10: fatal error: asm/cpu_device_id.h: No such file or directory
 #include <asm/cpu_device_id.h>
../sound/soc/intel/boards/bytcht_da7213.c:26:10: fatal error: asm/platform_sst_audio.h: No such file or directory
 #include <asm/platform_sst_audio.h>

And more drivers determined by:
> grep "include.*asm.cpu_device_id.h" *.c
bxt_da7219_max98357a.c:#include <asm/cpu_device_id.h>
bytcht_es8316.c:#include <asm/cpu_device_id.h>
bytcr_rt5640.c:#include <asm/cpu_device_id.h>
bytcr_rt5651.c:#include <asm/cpu_device_id.h>
cht_bsw_rt5645.c:#include <asm/cpu_device_id.h>
sof_rt5682.c:#include <asm/cpu_device_id.h>
  and
> grep "include.*asm.platform_sst_audio.h" *.c
bytcht_da7213.c:#include <asm/platform_sst_audio.h>
bytcht_es8316.c:#include <asm/platform_sst_audio.h>

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/intel/boards/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- lnx-52-rc1.orig/sound/soc/intel/boards/Kconfig
+++ lnx-52-rc1/sound/soc/intel/boards/Kconfig
@@ -87,6 +87,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	tristate "Baytrail and Baytrail-CR with RT5640 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5640
 	help
@@ -99,6 +100,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
 	tristate "Baytrail and Baytrail-CR with RT5651 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5651
 	help
@@ -123,6 +125,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_RT5645
 	help
@@ -159,6 +162,7 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	tristate "Baytrail & Cherrytrail with DA7212/7213 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_DA7213
 	help
@@ -171,6 +175,7 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	tristate "Baytrail & Cherrytrail with ES8316 codec"
 	depends on I2C && ACPI
 	depends on X86_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_ACPI
 	select SND_SOC_ES8316
 	help
@@ -249,6 +254,7 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357
 	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on I2C && ACPI
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
+	depends on X86
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
