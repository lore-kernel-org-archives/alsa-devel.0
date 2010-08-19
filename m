From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 3/3] asoc/multi-component: add support for
	separate codec DAIs to the fsl_dma driver
Date: Thu, 19 Aug 2010 16:43:42 -0500
Message-ID: <1282254222-19990-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id 5B91B243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 23:43:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Some codecs have separate DAIs for playback and capture, so the DMA driver
should allocate a DMA buffer only for the streams that are valid when the
driver is opened.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index cb78698..4cf98c0 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -306,21 +306,29 @@ static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = fsl_dma_dmamask;
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
-		fsl_dma_hardware.buffer_bytes_max,
-		&pcm->streams[0].substream->dma_buffer);
-	if (ret) {
-		dev_err(card->dev, "can't allocate playback dma buffer\n");
-		return ret;
+	/* Some codecs have separate DAIs for playback and capture, so we
+	 * should allocate a DMA buffer only for the streams that are valid.
+	 */
+
+	if (dai->driver->playback.channels_min) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+			fsl_dma_hardware.buffer_bytes_max,
+			&pcm->streams[0].substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev, "can't alloc playback dma buffer\n");
+			return ret;
+		}
 	}
 
-	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
-		fsl_dma_hardware.buffer_bytes_max,
-		&pcm->streams[1].substream->dma_buffer);
-	if (ret) {
-		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
-		dev_err(card->dev, "can't allocate capture dma buffer\n");
-		return ret;
+	if (dai->driver->capture.channels_min) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+			fsl_dma_hardware.buffer_bytes_max,
+			&pcm->streams[1].substream->dma_buffer);
+		if (ret) {
+			snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
+			dev_err(card->dev, "can't alloc capture dma buffer\n");
+			return ret;
+		}
 	}
 
 	return 0;
-- 
1.7.0.1
