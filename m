From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: select DW_DMAC_CORE since it's
	mandatory" to the asoc tree
Date: Tue, 17 Jan 2017 18:45:20 +0000
Message-ID: <E1cTYky-0008WB-Bj@debutante>
References: <20170116131229.102820-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF0202665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:32 +0100 (CET)
In-Reply-To: <20170116131229.102820-2-andriy.shevchenko@linux.intel.com>
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

   ASoC: Intel: select DW_DMAC_CORE since it's mandatory

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

>From ebf79091bf85d9b2270ab29191de9cd3aaf888c5 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 16 Jan 2017 15:12:26 +0200
Subject: [PATCH] ASoC: Intel: select DW_DMAC_CORE since it's mandatory

Select DW_DMAC_CORE like the rest of glue drivers do, e.g.
drivers/dma/dw/Kconfig.

While here group selectors under SND_SOC_INTEL_HASWELL and
SND_SOC_INTEL_BAYTRAIL.

Make platforms, which are using a common SST firmware driver, to be
dependent on DMADEVICES.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 9e3b25069de3..93c41b7219f2 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -33,11 +33,9 @@ config SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	depends on (X86 || COMPILE_TEST)
 
-# firmware stuff depends DW_DMAC_CORE; since there is no depends-on from
-# the reverse selection, each machine driver needs to select
-# SND_SOC_INTEL_SST_FIRMWARE carefully depending on DW_DMAC_CORE
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
+	select DW_DMAC_CORE
 
 config SND_SOC_INTEL_SST_ACPI
 	tristate
@@ -47,16 +45,18 @@ config SND_SOC_INTEL_SST_MATCH
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SST_FIRMWARE
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
+	depends on DMADEVICES
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5640
 	help
@@ -97,9 +97,8 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE && (SND_SST_IPC_ACPI = n)
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
+	depends on DMADEVICES
+	depends on SND_SST_IPC_ACPI = n
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5640
 	help
@@ -110,9 +109,8 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on X86_INTEL_LPSS && I2C
-	depends on DW_DMAC_CORE && (SND_SST_IPC_ACPI = n)
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_FIRMWARE
+	depends on DMADEVICES
+	depends on SND_SST_IPC_ACPI = n
 	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_MAX98090
 	help
@@ -121,9 +119,8 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
-	depends on X86_INTEL_LPSS && GPIOLIB && I2C && DW_DMAC
-	depends on DW_DMAC_CORE=y
-	select SND_SOC_INTEL_SST
+	depends on X86_INTEL_LPSS && GPIOLIB && I2C
+	depends on DMADEVICES
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT5677
 	help
@@ -132,10 +129,8 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
 
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
-	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
-		   I2C_DESIGNWARE_PLATFORM
-	depends on DW_DMAC_CORE
-	select SND_SOC_INTEL_SST
+	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
+	depends on DMADEVICES
 	select SND_SOC_INTEL_HASWELL
 	select SND_SOC_RT286
 	help
-- 
2.11.0
