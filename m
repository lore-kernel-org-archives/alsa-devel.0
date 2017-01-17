From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove redundant select
	SND_SOC_INTEL_SST" to the asoc tree
Date: Tue, 17 Jan 2017 18:45:26 +0000
Message-ID: <E1cTYl4-00007N-GI@debutante>
References: <20170102152017.13938-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F72B2665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:37 +0100 (CET)
In-Reply-To: <20170102152017.13938-3-andriy.shevchenko@linux.intel.com>
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

   ASoC: Intel: remove redundant select SND_SOC_INTEL_SST

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

>From dd8275771f7a65dd552137e1839d39e15b313ed2 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 16 Jan 2017 15:12:27 +0200
Subject: [PATCH] ASoC: Intel: remove redundant select SND_SOC_INTEL_SST

SND_SOC_INTEL_SKYLAKE selects SND_SOC_INTEL_SST already. Thus no need to
duplicate. Remove duplications.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fd5d1e091038..86766d7c18b0 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -68,7 +68,6 @@ config SND_SOC_INTEL_HASWELL_MACH
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "ASoC Audio driver for Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
@@ -84,7 +83,6 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT298
 	select SND_SOC_DMIC
@@ -220,7 +218,6 @@ config SND_SOC_INTEL_SKYLAKE
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "ASoC Audio driver for SKL with RT286 I2S mode"
 	depends on X86 && ACPI && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_RT286
 	select SND_SOC_DMIC
@@ -234,7 +231,6 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_SSM4567
@@ -249,7 +245,6 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
 	depends on X86_INTEL_LPSS && I2C
-	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_NAU8825
 	select SND_SOC_MAX98357A
-- 
2.11.0
