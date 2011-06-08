From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: fix initialization of DMA
	buffers
Date: Wed, 8 Jun 2011 15:02:56 -0500
Message-ID: <1307563376-13055-2-git-send-email-timur@freescale.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B6310397F
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 22:03:30 +0200 (CEST)
In-Reply-To: <1307563376-13055-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The DMA (PCM) driver used by some Freescale PowerPC supports separate DAIs
for playback and capture, so DMA buffers should be allocated only for the
initialized streams.  Instead of checking for the number of active channels,
which apparently is not reliable, check to see if the actual stream object
exists.

Also provide a better name for the DMA interrupt.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 3872598..732208c 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -312,7 +312,7 @@ static int fsl_dma_new(struct snd_soc_pcm_runtime *rtd)
 	 * should allocate a DMA buffer only for the streams that are valid.
 	 */
 
-	if (dai->driver->playback.channels_min) {
+	if (pcm->streams[0].substream) {
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
 			fsl_dma_hardware.buffer_bytes_max,
 			&pcm->streams[0].substream->dma_buffer);
@@ -322,13 +322,13 @@ static int fsl_dma_new(struct snd_soc_pcm_runtime *rtd)
 		}
 	}
 
-	if (dai->driver->capture.channels_min) {
+	if (pcm->streams[1].substream) {
 		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
 			fsl_dma_hardware.buffer_bytes_max,
 			&pcm->streams[1].substream->dma_buffer);
 		if (ret) {
-			snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
 			dev_err(card->dev, "can't alloc capture dma buffer\n");
+			snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
 			return ret;
 		}
 	}
@@ -451,7 +451,8 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 	dma_private->ld_buf_phys = ld_buf_phys;
 	dma_private->dma_buf_phys = substream->dma_buffer.addr;
 
-	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "DMA", dma_private);
+	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "fsldma-audio",
+			  dma_private);
 	if (ret) {
 		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
 			dma_private->irq, ret);
-- 
1.7.3.4
