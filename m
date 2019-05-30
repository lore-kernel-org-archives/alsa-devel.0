From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: add COMPILE_TEST for PCI options"
	to the asoc tree
Date: Thu, 30 May 2019 17:33:10 +0100 (BST)
Message-ID: <20190530163310.63792440049@finisterre.sirena.org.uk>
References: <20190530115015.5677-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 750BEF89708
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 18:33:17 +0200 (CEST)
In-Reply-To: <20190530115015.5677-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: add COMPILE_TEST for PCI options

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

>From e13ef82a9ab83dd21d8dd43ef9f5e8bf5b101106 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 30 May 2019 06:50:15 -0500
Subject: [PATCH] ASoC: SOF: add COMPILE_TEST for PCI options

Add COMPILE_TEST and use IS_ENABLED(CONFIG_PCI) to sort out
cross-compilation issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/Kconfig       |  2 +-
 sound/soc/sof/intel/hda.c   | 13 +++++++++++--
 sound/soc/sof/sof-pci-dev.c |  4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index a9a1d502daae..ca3ad3362478 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -10,7 +10,7 @@ if SND_SOC_SOF_TOPLEVEL
 
 config SND_SOC_SOF_PCI
 	tristate "SOF PCI enumeration support"
-	depends on PCI
+	depends on PCI || COMPILE_TEST
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7e3980a2f7ba..5378d47a55fd 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -506,7 +506,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	 * TODO: support interrupt mode selection with kernel parameter
 	 *       support msi multiple vectors
 	 */
+#if IS_ENABLED(CONFIG_PCI)
 	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI);
+#endif
 	if (ret < 0) {
 		dev_info(sdev->dev, "use legacy interrupt mode\n");
 		/*
@@ -518,7 +520,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		sdev->msi_enabled = 0;
 	} else {
 		dev_info(sdev->dev, "use msi interrupt mode\n");
+#if IS_ENABLED(CONFIG_PCI)
 		hdev->irq = pci_irq_vector(pci, 0);
+#endif
 		/* ipc irq number is the same of hda irq */
 		sdev->ipc_irq = hdev->irq;
 		sdev->msi_enabled = 1;
@@ -622,8 +626,10 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 free_hda_irq:
 	free_irq(hdev->irq, bus);
 free_irq_vector:
+#if IS_ENABLED(CONFIG_PCI)
 	if (sdev->msi_enabled)
 		pci_free_irq_vectors(pci);
+#endif
 free_streams:
 	hda_dsp_stream_free(sdev);
 /* dsp_unmap: not currently used */
@@ -638,7 +644,6 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	struct hdac_bus *bus = sof_to_bus(sdev);
-	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	const struct sof_intel_dsp_desc *chip = hda->desc;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
@@ -667,8 +672,12 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 
 	free_irq(sdev->ipc_irq, sdev);
 	free_irq(hda->irq, bus);
-	if (sdev->msi_enabled)
+#if IS_ENABLED(CONFIG_PCI)
+	if (sdev->msi_enabled) {
+		struct pci_dev *pci = to_pci_dev(sdev->dev);
 		pci_free_irq_vectors(pci);
+	}
+#endif
 
 	hda_dsp_stream_free(sdev);
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index e2b19782f01a..ab58d4f9119f 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -251,9 +251,11 @@ static int sof_pci_probe(struct pci_dev *pci,
 	if (!sof_pdata)
 		return -ENOMEM;
 
+#if IS_ENABLED(CONFIG_PCI)
 	ret = pcim_enable_device(pci);
 	if (ret < 0)
 		return ret;
+#endif
 
 	ret = pci_request_regions(pci, "Audio DSP");
 	if (ret < 0)
@@ -386,6 +388,7 @@ static const struct pci_device_id sof_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
 
+#if IS_ENABLED(CONFIG_PCI)
 /* pci_driver definition */
 static struct pci_driver snd_sof_pci_driver = {
 	.name = "sof-audio-pci",
@@ -397,5 +400,6 @@ static struct pci_driver snd_sof_pci_driver = {
 	},
 };
 module_pci_driver(snd_sof_pci_driver);
+#endif
 
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.20.1
