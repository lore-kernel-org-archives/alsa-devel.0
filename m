From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] ASoC: fsl_dma: Pass the proper device for dma
	mapping	routines
Date: Sat, 4 Apr 2009 22:33:19 +0400
Message-ID: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CA261037F8
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Apr 2009 20:33:20 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Timur Tabi <timur@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

The driver should pass a device that specifies internal DMA ops, but
substream->pcm is just a logical device, and thus doesn't have arch-
specific dma callbacks, therefore following bug appears:

  Freescale Synchronous Serial Interface (SSI) ASoC Driver
  ------------[ cut here ]------------
  kernel BUG at arch/powerpc/include/asm/dma-mapping.h:237!
  Oops: Exception in kernel mode, sig: 5 [#1]
  ...
  NIP [c02259c4] snd_malloc_dev_pages+0x58/0xac
  LR [c0225c74] snd_dma_alloc_pages+0xf8/0x108
  Call Trace:
  [df02bde0] [df02be2c] 0xdf02be2c (unreliable)
  [df02bdf0] [c0225c74] snd_dma_alloc_pages+0xf8/0x108
  [df02be10] [c023a100] fsl_dma_new+0x68/0x124
  [df02be20] [c02342ac] soc_new_pcm+0x1bc/0x234
  [df02bea0] [c02343dc] snd_soc_new_pcms+0xb8/0x148
  [df02bed0] [c023824c] cs4270_probe+0x34/0x124
  [df02bef0] [c0232fe8] snd_soc_instantiate_card+0x1a4/0x2f4
  [df02bf20] [c0233164] snd_soc_instantiate_cards+0x2c/0x68
  [df02bf30] [c0234704] snd_soc_register_platform+0x60/0x80
  [df02bf50] [c03d5664] fsl_soc_platform_init+0x18/0x28
  ...

This patch fixes the issue by using card's device instead.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 sound/soc/fsl/fsl_dma.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index b3eb857..835e43c 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -300,7 +300,7 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = fsl_dma_dmamask;
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
 		fsl_dma_hardware.buffer_bytes_max,
 		&pcm->streams[0].substream->dma_buffer);
 	if (ret) {
@@ -310,7 +310,7 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 		return -ENOMEM;
 	}
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
 		fsl_dma_hardware.buffer_bytes_max,
 		&pcm->streams[1].substream->dma_buffer);
 	if (ret) {
@@ -418,7 +418,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 		return -EBUSY;
 	}
 
-	dma_private = dma_alloc_coherent(substream->pcm->dev,
+	dma_private = dma_alloc_coherent(substream->pcm->card->dev,
 		sizeof(struct fsl_dma_private), &ld_buf_phys, GFP_KERNEL);
 	if (!dma_private) {
 		dev_err(substream->pcm->card->dev,
@@ -445,7 +445,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 		dev_err(substream->pcm->card->dev,
 			"can't register ISR for IRQ %u (ret=%i)\n",
 			dma_private->irq, ret);
-		dma_free_coherent(substream->pcm->dev,
+		dma_free_coherent(substream->pcm->card->dev,
 			sizeof(struct fsl_dma_private),
 			dma_private, dma_private->ld_buf_phys);
 		return ret;
@@ -761,13 +761,13 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 			free_irq(dma_private->irq, dma_private);
 
 		if (dma_private->ld_buf_phys) {
-			dma_unmap_single(substream->pcm->dev,
+			dma_unmap_single(substream->pcm->card->dev,
 				dma_private->ld_buf_phys,
 				sizeof(dma_private->link), DMA_TO_DEVICE);
 		}
 
 		/* Deallocate the fsl_dma_private structure */
-		dma_free_coherent(substream->pcm->dev,
+		dma_free_coherent(substream->pcm->card->dev,
 			sizeof(struct fsl_dma_private),
 			dma_private, dma_private->ld_buf_phys);
 		substream->runtime->private_data = NULL;
-- 
1.5.6.5
