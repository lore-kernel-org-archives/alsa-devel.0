From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kconfig: add some comments for if symbols" to the asoc tree
Date: Mon, 08 Jan 2018 16:21:27 +0000
Message-ID: <E1eYaAx-0001zU-Im@debutante>
References: <20180104223601.5831-10-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104223601.5831-10-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.orgPierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kconfig: add some comments for if symbols

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

>From 89671061116f83bd8b8b01d1c9620a26b221725f Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 4 Jan 2018 16:36:00 -0600
Subject: [PATCH] ASoC: Intel: kconfig: add some comments for if symbols

Help in finding matching "if" endings by commenting the "endif".

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 063611ad641c..e1b6addcd13d 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -24,7 +24,7 @@ config SND_MFLD_MACHINE
           Say Y if you have such a device.
           If unsure select "N".
 
-endif
+endif ## SND_SST_ATOM_HIFI2_PLATFORM_PCI
 
 if SND_SOC_INTEL_HASWELL
 
@@ -57,7 +57,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
-endif
+endif ## SND_SOC_INTEL_HASWELL
 
 if SND_SOC_INTEL_BAYTRAIL
 
@@ -80,7 +80,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	  with the RT5640 audio codec. This driver is deprecated, use
 	  SND_SOC_INTEL_BYTCR_RT5640_MACH instead for better functionality.
 
-endif
+endif ## SND_SOC_INTEL_BAYTRAIL
 
 if SND_SST_ATOM_HIFI2_PLATFORM
 
@@ -172,7 +172,7 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 	  If unsure select "N".
 
-endif
+endif ## SND_SST_ATOM_HIFI2_PLATFORM
 
 if SND_SOC_INTEL_SKYLAKE
 
@@ -268,6 +268,6 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
           create an alsa sound card for RT5663 + RT5514 + MAX98927.
           Say Y or m if you have such a device. This is a recommended option.
           If unsure select "N".
-endif
+endif ## SND_SOC_INTEL_SKYLAKE
 
 endif ## SND_SOC_INTEL_MACH
-- 
2.15.1
