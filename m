From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: rename SND_SST_MFLD_PLATFORM to
	SND_SST_ATOM_HIFI2_PLATFORM" to the asoc tree
Date: Tue, 17 Jan 2017 18:45:23 +0000
Message-ID: <E1cTYl1-00005x-EA@debutante>
References: <20170107123250.52930-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C46842666DB
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:33 +0100 (CET)
In-Reply-To: <20170107123250.52930-5-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: rename SND_SST_MFLD_PLATFORM to SND_SST_ATOM_HIFI2_PLATFORM

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 231a091ef8dece94b0ad2b85affb059c483af33c Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 16 Jan 2017 15:12:29 +0200
Subject: [PATCH] ASoC: Intel: rename SND_SST_MFLD_PLATFORM to
 SND_SST_ATOM_HIFI2_PLATFORM

Rename SND_SST_MFLD_PLATFORM to SND_SST_ATOM_HIFI2_PLATFORM to make it clear
that is not only about Medfield platform.

The new name is derived from Intel Atom and HiFi2. HiFi2 is the DSP version,
it's public information for Intel *Field/*Trail parts, see
https://www.alsa-project.org/main/index.php/Firmware. By combining HiFi2 with
Atom we get a unique non-ambiguous description of the core+DSP hardware for
Intel Medfield through Intel Cherrytrail.

Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig                      | 14 +++++++-------
 sound/soc/intel/Makefile                     |  2 +-
 sound/soc/intel/atom/Makefile                |  7 ++++---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  1 +
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 86766d7c18b0..9e3b25069de3 100644
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
 
@@ -148,7 +148,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -161,7 +161,7 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5651
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -174,7 +174,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
         depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
-        select SND_SST_MFLD_PLATFORM
+        select SND_SST_ATOM_HIFI2_PLATFORM
         select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
         help
@@ -187,7 +187,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
-	select SND_SST_MFLD_PLATFORM
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
@@ -200,7 +200,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
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
index 0fd7848fbe4a..21cac1c8dd4c 100644
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
