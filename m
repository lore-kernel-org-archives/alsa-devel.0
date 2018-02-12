From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: dma: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:50 +0000
Message-ID: <E1elDF0-00039s-Py@debutante>
References: <87373bgaxq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F28C2267439
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:54 +0100 (CET)
In-Reply-To: <87373bgaxq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: dma: replace platform to component

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

>From 4cb1ea925e66a2a04bcaf880f62bce425ddb9f94 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:46:22 +0000
Subject: [PATCH] ASoC: fsl: dma: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 8c2981b70f64..fce2010d3c53 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -37,6 +37,8 @@
 #include "fsl_dma.h"
 #include "fsl_ssi.h"	/* For the offset of stx0 and srx0 */
 
+#define DRV_NAME "fsl_dma"
+
 /*
  * The formats that the DMA controller supports, which is anything
  * that is 8, 16, or 32 bits.
@@ -56,7 +58,7 @@
 			    SNDRV_PCM_FMTBIT_U32_LE     | \
 			    SNDRV_PCM_FMTBIT_U32_BE)
 struct dma_object {
-	struct snd_soc_platform_driver dai;
+	struct snd_soc_component_driver dai;
 	dma_addr_t ssi_stx_phys;
 	dma_addr_t ssi_srx_phys;
 	unsigned int ssi_fifo_depth;
@@ -203,7 +205,8 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 	struct fsl_dma_private *dma_private = dev_id;
 	struct snd_pcm_substream *substream = dma_private->substream;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	irqreturn_t ret = IRQ_NONE;
 	u32 sr, sr2 = 0;
@@ -385,9 +388,10 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	struct dma_object *dma =
-		container_of(rtd->platform->driver, struct dma_object, dai);
+		container_of(component->driver, struct dma_object, dai);
 	struct fsl_dma_private *dma_private;
 	struct ccsr_dma_channel __iomem *dma_channel;
 	dma_addr_t ld_buf_phys;
@@ -539,7 +543,8 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 
 	/* Number of bits per sample */
 	unsigned int sample_bits =
@@ -702,7 +707,8 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
 	dma_addr_t position;
 	snd_pcm_uframes_t frames;
@@ -799,9 +805,10 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_dma_private *dma_private = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	struct dma_object *dma =
-		container_of(rtd->platform->driver, struct dma_object, dai);
+		container_of(component->driver, struct dma_object, dai);
 
 	if (dma_private) {
 		if (dma_private->irq)
@@ -908,6 +915,7 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	dma->dai.name = DRV_NAME;
 	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
@@ -925,7 +933,7 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 
 	of_node_put(ssi_np);
 
-	ret = snd_soc_register_platform(&pdev->dev, &dma->dai);
+	ret = devm_snd_soc_register_component(&pdev->dev, &dma->dai, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register platform\n");
 		kfree(dma);
@@ -944,7 +952,6 @@ static int fsl_soc_dma_remove(struct platform_device *pdev)
 {
 	struct dma_object *dma = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_platform(&pdev->dev);
 	iounmap(dma->channel);
 	irq_dispose_mapping(dma->irq);
 	kfree(dma);
-- 
2.16.1
