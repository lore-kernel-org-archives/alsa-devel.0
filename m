From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 2/2] ASoC: imx: use more robust checking of
	available streams
Date: Thu, 25 Aug 2011 15:54:56 +0200
Message-ID: <1314280496-21826-2-git-send-email-w.sang@pengutronix.de>
References: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 234F7243E8
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 15:55:01 +0200 (CEST)
In-Reply-To: <1314280496-21826-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Replace the channels_min check with a check for the relevant substream
being present. Suggested here [1] when mxs implemented the
audio-support.

[1] http://www.spinics.net/lists/arm-kernel/msg133010.html

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/imx-pcm-fiq.c |   11 +++++------
 sound/soc/imx/imx-ssi.c     |    4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 309c59e..ac790e8 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -243,23 +243,22 @@ static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_pcm_substream *substream;
 	int ret;
 
 	ret = imx_pcm_new(rtd);
 	if (ret)
 		return ret;
 
-	if (dai->driver->playback.channels_min) {
-		struct snd_pcm_substream *substream =
-			pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (substream) {
 		struct snd_dma_buffer *buf = &substream->dma_buffer;
 
 		imx_ssi_fiq_tx_buffer = (unsigned long)buf->area;
 	}
 
-	if (dai->driver->capture.channels_min) {
-		struct snd_pcm_substream *substream =
-			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (substream) {
 		struct snd_dma_buffer *buf = &substream->dma_buffer;
 
 		imx_ssi_fiq_rx_buffer = (unsigned long)buf->area;
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 3b8d5cd..4297cb6 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -399,14 +399,14 @@ int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		card->dev->dma_mask = &imx_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	if (dai->driver->playback.channels_min) {
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->driver->capture.channels_min) {
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
-- 
1.7.5.4
