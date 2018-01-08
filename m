From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: document what Kconfig options do" to the asoc tree
Date: Mon, 08 Jan 2018 16:22:14 +0000
Message-ID: <E1eYaBi-00026u-LK@debutante>
References: <20180103165022.4984-5-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103165022.4984-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.combroonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: document what Kconfig options do

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

>From def2c4284fd6b3402265ee050d769897e3331521 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 4 Jan 2018 16:35:55 -0600
Subject: [PATCH] ASoC: Intel: document what Kconfig options do

Document in comments what the options are supposed to mean, before
clean-up in next patch.

No functionality change here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 16374576cb6e..01b75df6b118 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -16,16 +16,27 @@ if SND_SOC_INTEL_SST_TOPLEVEL
 
 config SND_SST_IPC
 	tristate
+	# This option controls the IPC core for HiFi2 platforms
 
 config SND_SST_IPC_PCI
 	tristate
 	select SND_SST_IPC
+	# This option controls the PCI-based IPC for HiFi2 platforms
+	#  (Medfield, Merrifield).
 
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
 	select SND_SOC_INTEL_SST
 	select IOSF_MBI
+	# This option controls the ACPI-based IPC for HiFi2 platforms
+	# (Baytrail, Cherrytrail)
+
+config SND_SOC_INTEL_SST_ACPI
+	tristate
+	# This option controls ACPI-based probing on
+	# Haswell/Broadwell/Baytrail legacy and will be set
+	# when these platforms are enabled
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -34,9 +45,9 @@ config SND_SOC_INTEL_SST
 config SND_SOC_INTEL_SST_FIRMWARE
 	tristate
 	select DW_DMAC_CORE
-
-config SND_SOC_INTEL_SST_ACPI
-	tristate
+	# This option controls firmware download on
+	# Haswell/Broadwell/Baytrail legacy and will be set
+	# when these platforms are enabled
 
 config SND_SOC_INTEL_HASWELL
 	tristate "Intel ASoC SST driver for Haswell/Broadwell"
-- 
2.15.1
