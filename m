From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: fix MSI handling
Date: Tue,  6 Aug 2019 12:06:03 -0500
Message-ID: <20190806170603.10815-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E372F800F3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 19:14:22 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The addition of a kernel module parameter to optionally disable MSI
had the side effect of permanently disabling it.

The return value of pci_alloc_irq_vectors() is the number of allocated
vectors or a negative number on error, so testing with the ! operator
is not quite right. It was one optimization too far.

Restore previous behavior to use MSI by default, unless the user
selects not to do so or the allocation of irq_vectors fails.

Fixes: 672ff5e3596ee ('ASoC: SOF: Intel: hda: add a parameter to disable MSI')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 724a494702fa..c7de5065b961 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -543,7 +543,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 	 * if it fails, use legacy interrupt mode
 	 * TODO: support msi multiple vectors
 	 */
-	if (hda_use_msi && !pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI)) {
+	if (hda_use_msi && pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) > 0) {
 		dev_info(sdev->dev, "use msi interrupt mode\n");
 		hdev->irq = pci_irq_vector(pci, 0);
 		/* ipc irq number is the same of hda irq */
-- 
2.20.1
