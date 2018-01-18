From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: remove select on non-existing SND_SOC_INTEL_COMMON" to the asoc tree
Date: Thu, 18 Jan 2018 11:23:05 +0000
Message-ID: <E1ec8Hh-0003mn-5i@debutante>
References: <20180117184324.3475-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117184324.3475-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.orgCorentin Labbe <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: remove select on non-existing SND_SOC_INTEL_COMMON

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e29a22a86a20ea7651ff8c731ab034c31bd9764e Mon Sep 17 00:00:00 2001
From: Corentin LABBE <clabbe.montjoie@gmail.com>
Date: Wed, 17 Jan 2018 19:43:24 +0100
Subject: [PATCH] ASoC: Intel: remove select on non-existing
 SND_SOC_INTEL_COMMON

SND_SST_ATOM_HIFI2_PLATFORM_PCI select SND_SOC_INTEL_COMMON which do not
exists anymore.
So remove this select.

Fixes: c6059879be29 ("ASoC: Intel: Fix Kconfig with top-level selector")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b0bd1938b71e..f2c9e8c5970a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -77,7 +77,6 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
 	depends on X86 && PCI
 	select SND_SST_IPC_PCI
 	select SND_SOC_COMPRESS
-	select SND_SOC_INTEL_COMMON
 	help
 	  If you have a Intel Medfield or Merrifield/Edison platform, then
 	  enable this option by saying Y or m. Distros will typically not
-- 
2.15.1
