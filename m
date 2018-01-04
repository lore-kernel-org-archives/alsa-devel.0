From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 05/10] ASoC: Intel: Fix nested/unnecessary Kconfig dependencies
Date: Thu,  4 Jan 2018 16:35:56 -0600
Message-ID: <20180104223601.5831-6-pierre-louis.bossart@linux.intel.com>
References: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104223601.5831-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a number of issues:
1. IOSF_MBI is only needed for byt-cr detection, which is only supported
on Baytrail/Cherrytrail, move to HiFi2 config

2. SND_SOC_INTEL_SST should not select SND_SOC_INTEL_SST_ACPI, the latter
config is only valid for Haswell/Baytrail legacy but not needed by Skylake

3. SND_SST_IPC_ACPI, used only by the atom/sst driver, should not select
SND_SOC_INTEL_SST, none of the code under common/sst*.c is used

This nesting of configs really makes no sense, it's easier to maintain
if for each platform one can control what is strictly required.

Compiled-tested with each of Haswell, Baytrail legacy, HiFi2, SKL cases
selected independently. 0-day and explicit randconfig tests did not report
additional issues and no functionality loss was observed in Intel tests on
HIFI2 and SKYLAKE platforms

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 01b75df6b118..ca0d6eb95d11 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -27,8 +27,6 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
-	select SND_SOC_INTEL_SST
-	select IOSF_MBI
 	# This option controls the ACPI-based IPC for HiFi2 platforms
 	# (Baytrail, Cherrytrail)
 
@@ -40,7 +38,6 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
-	select SND_SOC_INTEL_SST_ACPI if ACPI
 
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
@@ -54,6 +51,7 @@ config SND_SOC_INTEL_HASWELL
 	depends on SND_DMA_SGBUF
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
@@ -65,6 +63,7 @@ config SND_SOC_INTEL_BAYTRAIL
 	tristate "Intel ASoC SST driver for Baytrail (legacy)"
 	depends on DMADEVICES && ACPI
 	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
@@ -93,6 +92,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_COMPRESS
 	select SND_SOC_ACPI_INTEL_MATCH
+	select IOSF_MBI
 	help
 	  If you have a Intel Baytrail or Cherrytrail platform with an I2S
 	  codec, then enable this option by saying Y or m. This is a
-- 
2.14.1
