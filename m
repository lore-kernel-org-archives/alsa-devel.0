From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 1/2] ASoC: atmel_ssc_dai: move set dma data to
	startup callback
Date: Tue,  2 Jul 2013 15:55:17 +0800
Message-ID: <1372751718-1437-2-git-send-email-voice.shen@atmel.com>
References: <1372751718-1437-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6DB261A14
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 09:58:04 +0200 (CEST)
In-Reply-To: <1372751718-1437-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

move set dma data to startup callback function, if the set dma
data exist in hw_params callback, so the dma data only usable when
call hw_params, if want use it before hw_params callback, it will
cause NULL pointer access oops

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f3fdfa0..6cf9cf1 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -196,15 +196,27 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
-	int dir_mask;
+	struct atmel_pcm_dma_params *dma_params;
+	int dir, dir_mask;
 
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
 		ssc_readl(ssc_p->ssc->regs, SR));
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dir = 0;
 		dir_mask = SSC_DIR_MASK_PLAYBACK;
-	else
+	} else {
+		dir = 1;
 		dir_mask = SSC_DIR_MASK_CAPTURE;
+	}
+
+	dma_params = &ssc_dma_params[dai->id][dir];
+	dma_params->ssc = ssc_p->ssc;
+	dma_params->substream = substream;
+
+	ssc_p->dma_params[dir] = dma_params;
+
+	snd_soc_dai_set_dma_data(dai, substream, dma_params);
 
 	spin_lock_irq(&ssc_p->lock);
 	if (ssc_p->dir_mask & dir_mask) {
@@ -325,7 +337,6 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	int id = dai->id;
 	struct atmel_ssc_info *ssc_p = &ssc_info[id];
 	struct atmel_pcm_dma_params *dma_params;
@@ -344,19 +355,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
-	dma_params = &ssc_dma_params[id][dir];
-	dma_params->ssc = ssc_p->ssc;
-	dma_params->substream = substream;
-
-	ssc_p->dma_params[dir] = dma_params;
-
-	/*
-	 * The snd_soc_pcm_stream->dma_data field is only used to communicate
-	 * the appropriate DMA parameters to the pcm driver hw_params()
-	 * function.  It should not be used for other purposes
-	 * as it is common to all substreams.
-	 */
-	snd_soc_dai_set_dma_data(rtd->cpu_dai, substream, dma_params);
+	dma_params = ssc_p->dma_params[dir];
 
 	channels = params_channels(params);
 
-- 
1.7.9.5
