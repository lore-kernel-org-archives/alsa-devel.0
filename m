From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: mpc5200: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:27 +0000
Message-ID: <E1elDEd-000374-2f@debutante>
References: <87y3l3ew9f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0535426745B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:31 +0100 (CET)
In-Reply-To: <87y3l3ew9f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: mpc5200: replace platform to component

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

>From 60bceb8029e26c49549a276d5d67198cdfb57b5d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:47:19 +0000
Subject: [PATCH] ASoC: fsl: mpc5200: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_dma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index e63029f1aabc..c1a4544eb16b 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -22,6 +22,8 @@
 
 #include "mpc5200_dma.h"
 
+#define DRV_NAME "mpc5200_dma"
+
 /*
  * Interrupt handlers
  */
@@ -300,12 +302,13 @@ static const struct snd_pcm_ops psc_dma_ops = {
 static int psc_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	size_t size = psc_dma_hardware.buffer_bytes_max;
 	int rc;
 
-	dev_dbg(rtd->platform->dev, "psc_dma_new(card=%p, dai=%p, pcm=%p)\n",
+	dev_dbg(component->dev, "psc_dma_new(card=%p, dai=%p, pcm=%p)\n",
 		card, dai, pcm);
 
 	rc = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
@@ -341,10 +344,11 @@ static int psc_dma_new(struct snd_soc_pcm_runtime *rtd)
 static void psc_dma_free(struct snd_pcm *pcm)
 {
 	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct snd_pcm_substream *substream;
 	int stream;
 
-	dev_dbg(rtd->platform->dev, "psc_dma_free(pcm=%p)\n", pcm);
+	dev_dbg(component->dev, "psc_dma_free(pcm=%p)\n", pcm);
 
 	for (stream = 0; stream < 2; stream++) {
 		substream = pcm->streams[stream].substream;
@@ -356,7 +360,8 @@ static void psc_dma_free(struct snd_pcm *pcm)
 	}
 }
 
-static const struct snd_soc_platform_driver mpc5200_audio_dma_platform = {
+static const struct snd_soc_component_driver mpc5200_audio_dma_component = {
+	.name		= DRV_NAME,
 	.ops		= &psc_dma_ops,
 	.pcm_new	= &psc_dma_new,
 	.pcm_free	= &psc_dma_free,
@@ -468,7 +473,8 @@ int mpc5200_audio_dma_create(struct platform_device *op)
 	dev_set_drvdata(&op->dev, psc_dma);
 
 	/* Tell the ASoC OF helpers about it */
-	return snd_soc_register_platform(&op->dev, &mpc5200_audio_dma_platform);
+	return devm_snd_soc_register_component(&op->dev,
+					&mpc5200_audio_dma_component, NULL, 0);
 out_irq:
 	free_irq(psc_dma->irq, psc_dma);
 	free_irq(psc_dma->capture.irq, &psc_dma->capture);
@@ -487,8 +493,6 @@ int mpc5200_audio_dma_destroy(struct platform_device *op)
 
 	dev_dbg(&op->dev, "mpc5200_audio_dma_destroy()\n");
 
-	snd_soc_unregister_platform(&op->dev);
-
 	bcom_gen_bd_rx_release(psc_dma->capture.bcom_task);
 	bcom_gen_bd_tx_release(psc_dma->playback.bcom_task);
 
-- 
2.16.1
