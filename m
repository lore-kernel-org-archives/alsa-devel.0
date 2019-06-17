From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: disallow building without CONFIG_PCI again" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:17 +0100 (BST)
Message-ID: <20190617152417.9FBC0440046@finisterre.sirena.org.uk>
References: <20190617124632.1176809-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617124632.1176809-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: disallow building without CONFIG_PCI again

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

>From 9de7eaddfa7f47fbb1cd9cdb9aab405599ef414e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 14:45:49 +0200
Subject: [PATCH] ASoC: SOF: disallow building without CONFIG_PCI again

Compile-testing without PCI just causes warnings:

sound/soc/sof/sof-pci-dev.c:330:13: error: 'sof_pci_remove' defined but not used [-Werror=unused-function]
 static void sof_pci_remove(struct pci_dev *pci)
             ^~~~~~~~~~~~~~
sound/soc/sof/sof-pci-dev.c:230:12: error: 'sof_pci_probe' defined but not used [-Werror=unused-function]
 static int sof_pci_probe(struct pci_dev *pci,
            ^~~~~~~~~~~~~

I tried to fix this in a way that would still allow compile
tests, but it got too ugly, so this just reverts the patch
that allowed it in the first place.

Most architectures do allow enabling PCI, so the value of the
COMPILE_TEST alternative was not very high to start with.

Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/Kconfig       |  2 +-
 sound/soc/sof/intel/hda.c   | 13 ++-----------
 sound/soc/sof/sof-pci-dev.c |  4 ----
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 1d4b4dced4b6..bc6d7b311af4 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -10,7 +10,7 @@ if SND_SOC_SOF_TOPLEVEL
 
 config SND_SOC_SOF_PCI
 	tristate "SOF PCI enumeration support"
-	depends on PCI || COMPILE_TEST
+	depends on PCI
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index af546e42e1d9..8754dfe75000 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -525,9 +525,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	 * TODO: support interrupt mode selection with kernel parameter
 	 *       support msi multiple vectors
 	 */
-#if IS_ENABLED(CONFIG_PCI)
 	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI);
-#endif
 	if (ret < 0) {
 		dev_info(sdev->dev, "use legacy interrupt mode\n");
 		/*
@@ -539,9 +537,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		sdev->msi_enabled = 0;
 	} else {
 		dev_info(sdev->dev, "use msi interrupt mode\n");
-#if IS_ENABLED(CONFIG_PCI)
 		hdev->irq = pci_irq_vector(pci, 0);
-#endif
 		/* ipc irq number is the same of hda irq */
 		sdev->ipc_irq = hdev->irq;
 		sdev->msi_enabled = 1;
@@ -598,10 +594,8 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 free_hda_irq:
 	free_irq(hdev->irq, bus);
 free_irq_vector:
-#if IS_ENABLED(CONFIG_PCI)
 	if (sdev->msi_enabled)
 		pci_free_irq_vectors(pci);
-#endif
 free_streams:
 	hda_dsp_stream_free(sdev);
 /* dsp_unmap: not currently used */
@@ -616,6 +610,7 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	const struct sof_intel_dsp_desc *chip = hda->desc;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
@@ -644,12 +639,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 
 	free_irq(sdev->ipc_irq, sdev);
 	free_irq(hda->irq, bus);
-#if IS_ENABLED(CONFIG_PCI)
-	if (sdev->msi_enabled) {
-		struct pci_dev *pci = to_pci_dev(sdev->dev);
+	if (sdev->msi_enabled)
 		pci_free_irq_vectors(pci);
-	}
-#endif
 
 	hda_dsp_stream_free(sdev);
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index ab58d4f9119f..e2b19782f01a 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -251,11 +251,9 @@ static int sof_pci_probe(struct pci_dev *pci,
 	if (!sof_pdata)
 		return -ENOMEM;
 
-#if IS_ENABLED(CONFIG_PCI)
 	ret = pcim_enable_device(pci);
 	if (ret < 0)
 		return ret;
-#endif
 
 	ret = pci_request_regions(pci, "Audio DSP");
 	if (ret < 0)
@@ -388,7 +386,6 @@ static const struct pci_device_id sof_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
 
-#if IS_ENABLED(CONFIG_PCI)
 /* pci_driver definition */
 static struct pci_driver snd_sof_pci_driver = {
 	.name = "sof-audio-pci",
@@ -400,6 +397,5 @@ static struct pci_driver snd_sof_pci_driver = {
 	},
 };
 module_pci_driver(snd_sof_pci_driver);
-#endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1
