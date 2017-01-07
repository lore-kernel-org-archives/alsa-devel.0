From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/4] ASoC: Intel: rename
	SND_SST_MFLD_PLATFORM to SND_SST_ATOM_HIFI2_PLATFORM
Date: Sat,  7 Jan 2017 14:32:50 +0200
Message-ID: <20170107123250.52930-5-andriy.shevchenko@linux.intel.com>
References: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4246126721A
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2017 13:32:55 +0100 (CET)
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

Rename SND_SST_MFLD_PLATFORM to SND_SST_ATOM_HIFI2_PLATFORM to make it clear
that is not only about Medfield platform.

The new name is derived from Intel Atom and HiFi2. HiFi2 is the DSP version,
it's public information for Intel *Field/*Trail parts, see
https://www.alsa-project.org/main/index.php/Firmware. By combining HiFi2 with
Atom we get a unique non-ambiguous description of the core+DSP hardware for
Intel Medfield through Intel Cherrytrail.

Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/Kconfig                      | 14 +++++++-------
 sound/soc/intel/Makefile                     |  2 +-
 sound/soc/intel/atom/Makefile                |  7 ++++---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  1 +
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7da8b9ceb728..efd523b38ad6 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -2,7 +2,7 @@ config SND_MFLD_MACHINE
 	tristate "SOC Machine Audio driver for Intel Medfield MID platform"
 	depends on INTEL_SCU_IPC
 	select SND_SOC_SN95031
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_PCI
 	help
           This adds support for ASoC machine driver for Intel(R) MID Medfield platform
@@ -10,7 +10,7 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device.
           If unsure select "N".
 
-config SND_SST_MFLD_PLATFORM
+config SND_SST_ATOM_HIFI2_PLATFORM
 	tristate
 	select SND_SOC_COMPRESS
 
@@ -137,7 +137,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -150,7 +150,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -163,7 +163,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
         depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        select SND_SST_MFLD_PLATFORM
+        select SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
         help
@@ -176,7 +176,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -189,7 +189,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 2b45435e6245..cdd495f7ee2c 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 # Platform Support
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
-obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
+obj-$(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM) += atom/
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
 
 # Machine support
diff --git a/sound/soc/intel/atom/Makefile b/sound/soc/intel/atom/Makefile
index ce8074fa6d66..aa6548c6feab 100644
--- a/sound/soc/intel/atom/Makefile
+++ b/sound/soc/intel/atom/Makefile
@@ -1,7 +1,8 @@
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o \
-	        sst-mfld-platform-compress.o sst-atom-controls.o
+snd-soc-sst-atom-hifi2-platform-objs :=	sst-mfld-platform-pcm.o \
+					sst-mfld-platform-compress.o \
+					sst-atom-controls.o
 
-obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
+obj-$(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM) += snd-soc-sst-atom-hifi2-platform.o
 
 # DSP driver
 obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index f5a8050351b5..deb325da2369 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -839,4 +839,5 @@ MODULE_DESCRIPTION("ASoC Intel(R) MID Platform driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
 MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sst-atom-hifi2-platform");
 MODULE_ALIAS("platform:sst-mfld-platform");
-- 
2.11.0
