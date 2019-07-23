From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: add a parameter to
	disable MSI" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:12 +0100 (BST)
Message-ID: <20190723112912.1B0242742BAC@ypsilon.sirena.org.uk>
References: <20190722141402.7194-17-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A499F80447
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:12 +0200 (CEST)
In-Reply-To: <20190722141402.7194-17-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: add a parameter to disable MSI

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 672ff5e3596ee27b64edcc73251f4ae1c8ab12ac Mon Sep 17 00:00:00 2001
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:57 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: add a parameter to disable MSI

Enabling MSI on HDA can fail, in which case the legacy PCI IRQ mode
will be used. To make testing this mode easier add an "enable_msi"
module parameter, which is only enabled if debugging is enabled too.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-17-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
