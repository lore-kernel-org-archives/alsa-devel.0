From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: fix MSI handling" to
	the asoc tree
Date: Wed,  7 Aug 2019 14:30:49 +0100 (BST)
Message-ID: <20190807133049.79D22274304E@ypsilon.sirena.org.uk>
References: <20190806170603.10815-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AE2BF805E2
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 15:30:51 +0200 (CEST)
In-Reply-To: <20190806170603.10815-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: fix MSI handling

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

>From bb67dd1878de5766c24fe7a4002d1a12c14da518 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 6 Aug 2019 12:06:03 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: fix MSI handling

The addition of a kernel module parameter to optionally disable MSI
had the side effect of permanently disabling it.

The return value of pci_alloc_irq_vectors() is the number of allocated
vectors or a negative number on error, so testing with the ! operator
is not quite right. It was one optimization too far.

Restore previous behavior to use MSI by default, unless the user
selects not to do so or the allocation of irq_vectors fails.

Fixes: 672ff5e3596ee ('ASoC: SOF: Intel: hda: add a parameter to disable MSI')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190806170603.10815-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 79cce20666b6..53813de7844e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -537,7 +537,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
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
