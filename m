From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Add Comet Lake PCI IDs" to the asoc tree
Date: Mon, 13 May 2019 13:30:29 +0100 (BST)
Message-ID: <20190513123029.821AB1129233@debutante.sirena.org.uk>
References: <20190510223929.165569-2-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510223929.165569-2-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: alsa-devel@alsa-project.org, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Rajat Jain <rajatja@chromium.org>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Add Comet Lake PCI IDs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 927ce5c76e485e9d6e98b6ca29199a593d013793 Mon Sep 17 00:00:00 2001
From: Evan Green <evgreen@chromium.org>
Date: Fri, 10 May 2019 15:39:28 -0700
Subject: [PATCH] ASoC: SOF: Add Comet Lake PCI IDs

Add support for Intel Comet Lake platforms by adding a new Kconfig
for CometLake and the appropriate PCI IDs.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/Kconfig | 32 ++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 32ee0fabab92..25c472e6bc22 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -24,6 +24,8 @@ config SND_SOC_SOF_INTEL_PCI
 	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
 	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
 	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_LP if SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_H if SND_SOC_SOF_COMETLAKE_H_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -179,6 +181,36 @@ config SND_SOC_SOF_ICELAKE
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_COMETLAKE_LP
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	bool "SOF support for CometLake-LP"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-LP processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_SOF_COMETLAKE_H
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_H_SUPPORT
+	bool "SOF support for CometLake-H"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-H processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index b778dffb2d25..d736806c2e0d 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -129,6 +129,26 @@ static const struct sof_dev_desc cfl_desc = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP) || \
+	IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+
+static const struct sof_dev_desc cml_desc = {
+	.machines		= snd_soc_acpi_intel_cnl_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &cnl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-cnl.ri",
+	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
+	.ops = &sof_cnl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 static const struct sof_dev_desc icl_desc = {
 	.machines               = snd_soc_acpi_intel_icl_machines,
@@ -353,6 +373,14 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{ PCI_DEVICE(0x8086, 0x34C8),
 		.driver_data = (unsigned long)&icl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&cml_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+	{ PCI_DEVICE(0x8086, 0x06c8),
+		.driver_data = (unsigned long)&cml_desc},
 #endif
 	{ 0, }
 };
-- 
2.20.1
