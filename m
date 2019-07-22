From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 16/21] ASoC: SOF: Intel: hda: add a parameter
	to disable MSI
Date: Mon, 22 Jul 2019 09:13:57 -0500
Message-ID: <20190722141402.7194-17-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E69AF8049A
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:23 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Enabling MSI on HDA can fail, in which case the legacy PCI IRQ mode
will be used. To make testing this mode easier add an "enable_msi"
module parameter, which is only enabled if debugging is enabled too.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 28 +++++++++++++++++-----------
 sound/soc/sof/sof-priv.h  |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7f665392618f..79cce20666b6 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -46,6 +46,12 @@ struct hda_dsp_msg_code {
 	const char *msg;
 };
 
+static bool hda_use_msi = IS_ENABLED(CONFIG_PCI);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG)
+module_param_named(use_msi, hda_use_msi, bool, 0444);
+MODULE_PARM_DESC(use_msi, "SOF HDA use PCI MSI mode");
+#endif
+
 static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
 	{HDA_DSP_ROM_FW_MANIFEST_LOADED, "status: manifest loaded"},
 	{HDA_DSP_ROM_FW_FW_LOADED, "status: fw loaded"},
@@ -529,11 +535,18 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	 * register our IRQ
 	 * let's try to enable msi firstly
 	 * if it fails, use legacy interrupt mode
-	 * TODO: support interrupt mode selection with kernel parameter
-	 *       support msi multiple vectors
+	 * TODO: support msi multiple vectors
 	 */
-	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI);
-	if (ret < 0) {
+	if (hda_use_msi && !pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI)) {
+		dev_info(sdev->dev, "use msi interrupt mode\n");
+		hdev->irq = pci_irq_vector(pci, 0);
+		/* ipc irq number is the same of hda irq */
+		sdev->ipc_irq = hdev->irq;
+		/* initialised to "false" by kzalloc() */
+		sdev->msi_enabled = true;
+	}
+
+	if (!sdev->msi_enabled) {
 		dev_info(sdev->dev, "use legacy interrupt mode\n");
 		/*
 		 * in IO-APIC mode, hda->irq and ipc_irq are using the same
@@ -541,13 +554,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		 */
 		hdev->irq = pci->irq;
 		sdev->ipc_irq = pci->irq;
-		sdev->msi_enabled = 0;
-	} else {
-		dev_info(sdev->dev, "use msi interrupt mode\n");
-		hdev->irq = pci_irq_vector(pci, 0);
-		/* ipc irq number is the same of hda irq */
-		sdev->ipc_irq = hdev->irq;
-		sdev->msi_enabled = 1;
 	}
 
 	dev_dbg(sdev->dev, "using HDA IRQ %d\n", hdev->irq);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index b8c9274ccf42..983eadef4b30 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -435,7 +435,7 @@ struct snd_sof_dev {
 	u32 dtrace_error;
 	u32 dtrace_draining;
 
-	u32 msi_enabled;
+	bool msi_enabled;
 
 	void *private;			/* core does not touch this */
 };
-- 
2.20.1
