From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH] ASoC: Samsung: fix DMA interface for s3c2442
	boards
Date: Wed, 28 Mar 2012 00:37:49 +0200
Message-ID: <1332887869-3527-2-git-send-email-GNUtoo@no-log.org>
References: <1332887869-3527-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp201.alice.it (smtp201.alice.it [82.57.200.97])
	by alsa0.perex.cz (Postfix) with ESMTP id BA62D2444A
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 00:38:00 +0200 (CEST)
In-Reply-To: <1332887869-3527-1-git-send-email-GNUtoo@no-log.org>
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
Cc: alsa-devel@alsa-project.org, Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
List-Id: alsa-devel@alsa-project.org

Without this fix playing a wav file that said "incomming call"
  resulted in the following beeing played: "in-in-in-co-co-co-mi-mi-mi...".

This commit was tested on the GTA02 Machine.

The problem was introduced by commit 344b4c48887a443f7478fc7047d1397b20821ed3
  (ASoC: Samsung: Update DMA interface)

Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/samsung/dma.c |   69 ++++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index ddc6cde..157d991 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -62,8 +62,6 @@ struct runtime_data {
 	struct s3c_dma_params *params;
 };
 
-static void audio_buffdone(void *data);
-
 /* dma_enqueue
  *
  * place a dma buffer onto the queue for the dma system
@@ -74,7 +72,7 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 	struct runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
 	unsigned int limit;
-	struct samsung_dma_prep_info dma_info;
+	int ret;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -83,58 +81,48 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
 	pr_debug("%s: loaded %d, limit %d\n",
 				__func__, prtd->dma_loaded, limit);
 
-	dma_info.cap = (samsung_dma_has_circular() ? DMA_CYCLIC : DMA_SLAVE);
-	dma_info.direction =
-		(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
-		? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
-	dma_info.fp = audio_buffdone;
-	dma_info.fp_param = substream;
-	dma_info.period = prtd->dma_period;
-	dma_info.len = prtd->dma_period*limit;
-
 	while (prtd->dma_loaded < limit) {
+		unsigned long len = prtd->dma_period;
 		pr_debug("dma_loaded: %d\n", prtd->dma_loaded);
 
-		if ((pos + dma_info.period) > prtd->dma_end) {
-			dma_info.period  = prtd->dma_end - pos;
-			pr_debug("%s: corrected dma len %ld\n",
-					__func__, dma_info.period);
-		}
-
-		dma_info.buf = pos;
-		prtd->params->ops->prepare(prtd->params->ch, &dma_info);
+		ret = s3c2410_dma_enqueue(prtd->params->channel,
+			substream, pos, len);
 
-		prtd->dma_loaded++;
-		pos += prtd->dma_period;
-		if (pos >= prtd->dma_end)
-			pos = prtd->dma_start;
+		if (ret == 0) {
+			prtd->dma_loaded++;
+			pos += prtd->dma_period;
+			if (pos >= prtd->dma_end)
+				pos = prtd->dma_start;
+		} else
+			break;
 	}
 
 	prtd->dma_pos = pos;
 }
 
-static void audio_buffdone(void *data)
+static void audio_buffdone(struct s3c2410_dma_chan *channel,
+				void *dev_id, int size,
+				enum s3c2410_dma_buffresult result)
 {
-	struct snd_pcm_substream *substream = data;
-	struct runtime_data *prtd = substream->runtime->private_data;
+	struct snd_pcm_substream *substream = dev_id;
+	struct runtime_data *prtd;
 
 	pr_debug("Entered %s\n", __func__);
 
-	if (prtd->state & ST_RUNNING) {
-		prtd->dma_pos += prtd->dma_period;
-		if (prtd->dma_pos >= prtd->dma_end)
-			prtd->dma_pos = prtd->dma_start;
+	if (result == S3C2410_RES_ABORT || result == S3C2410_RES_ERR)
+		return;
 
-		if (substream)
-			snd_pcm_period_elapsed(substream);
+	prtd = substream->runtime->private_data;
 
-		spin_lock(&prtd->lock);
-		if (!samsung_dma_has_circular()) {
-			prtd->dma_loaded--;
-			dma_enqueue(substream);
-		}
-		spin_unlock(&prtd->lock);
+	if (substream)
+		snd_pcm_period_elapsed(substream);
+
+	spin_lock(&prtd->lock);
+	if (!samsung_dma_has_circular()) {
+		prtd->dma_loaded--;
+		dma_enqueue(substream);
 	}
+	spin_unlock(&prtd->lock);
 }
 
 static int dma_hw_params(struct snd_pcm_substream *substream,
@@ -178,6 +166,9 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 				prtd->params->channel, &dma_info);
 	}
 
+	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
+				    audio_buffdone);
+
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	runtime->dma_bytes = totbytes;
-- 
1.7.4.1
