From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/14] ASoC: dmaengine-pcm: Remove
	snd_dmaengine_pcm_{set, get}_data
Date: Fri, 22 Mar 2013 14:12:14 +0100
Message-ID: <1363957934-20059-15-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 615E2266542
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:19 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

These functions were initially added to be able to support some oddball dma
drivers, but all users have been updated to deal with the situation without the
help of snd_dmaengine_pcm_{set,get}_data, so these two functions can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h |  3 ---
 sound/soc/soc-dmaengine-pcm.c | 29 -----------------------------
 2 files changed, 32 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..f8a7031 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -32,9 +32,6 @@ snd_pcm_substream_to_dma_direction(const struct snd_pcm_substream *substream)
 		return DMA_DEV_TO_MEM;
 }
 
-void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data);
-void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream);
-
 int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
 	const struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config);
 int snd_dmaengine_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 111b7d92..e8b1215 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -33,8 +33,6 @@ struct dmaengine_pcm_runtime_data {
 	dma_cookie_t cookie;
 
 	unsigned int pos;
-
-	void *data;
 };
 
 static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
@@ -43,33 +41,6 @@ static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
 	return substream->runtime->private_data;
 }
 
-/**
- * snd_dmaengine_pcm_set_data - Set dmaengine substream private data
- * @substream: PCM substream
- * @data: Data to set
- */
-void snd_dmaengine_pcm_set_data(struct snd_pcm_substream *substream, void *data)
-{
-	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
-
-	prtd->data = data;
-}
-EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_data);
-
-/**
- * snd_dmaengine_pcm_get_data - Get dmaeinge substream private data
- * @substream: PCM substream
- *
- * Returns the data previously set with snd_dmaengine_pcm_set_data
- */
-void *snd_dmaengine_pcm_get_data(struct snd_pcm_substream *substream)
-{
-	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
-
-	return prtd->data;
-}
-EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_data);
-
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
-- 
1.8.0
