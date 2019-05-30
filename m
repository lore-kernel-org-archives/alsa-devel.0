From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/5] ASoC: SOF: add COMPILE_TEST for PCI options
Date: Thu, 30 May 2019 06:50:15 -0500
Message-ID: <20190530115015.5677-6-pierre-louis.bossart@linux.intel.com>
References: <20190530115015.5677-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 980D6F8970A
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2019 13:50:41 +0200 (CEST)
In-Reply-To: <20190530115015.5677-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add COMPILE_TEST and use IS_ENABLED(CONFIG_PCI) to sort out
cross-compilation issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
index e47f03dc62f0..b1f4db0a6895 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -488,7 +488,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	 * TODO: support interrupt mode selection with kernel parameter
 	 *       support msi multiple vectors
 	 */
+#if IS_ENABLED(CONFIG_PCI)
 	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI);
+#endif
 	if (ret < 0) {
 		dev_info(sdev->dev, "use legacy interrupt mode\n");
 		/*
@@ -500,7 +502,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		sdev->msi_enabled = 0;
 	} else {
 		dev_info(sdev->dev, "use msi interrupt mode\n");
+#if IS_ENABLED(CONFIG_PCI)
 		hdev->irq = pci_irq_vector(pci, 0);
+#endif
 		/* ipc irq number is the same of hda irq */
 		sdev->ipc_irq = hdev->irq;
 		sdev->msi_enabled = 1;
@@ -561,8 +565,10 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
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
@@ -577,7 +583,6 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	struct hdac_bus *bus = sof_to_bus(sdev);
-	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	const struct sof_intel_dsp_desc *chip = hda->desc;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
@@ -606,8 +611,12 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 
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
