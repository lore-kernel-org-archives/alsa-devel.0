From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [RFC PATCH 5/5] ASoC: dmaengine: remove
	compat_request_channel
Date: Mon,  9 Dec 2013 13:24:16 -0700
Message-ID: <1386620656-18391-6-git-send-email-swarren@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7220E2650E1
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:24:37 +0100 (CET)
In-Reply-To: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

struct snd_dmaengine_pcm_config's compat_request_channel field is no
longer set anywhere. Remove it, and the code that implements it.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Don't apply this until the last compat_request_channel usage is actually
removed from the ux500 driver.

 include/sound/dmaengine_pcm.h         | 3 ---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index eb73a3a39ec2..72463afef52b 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -130,9 +130,6 @@ struct snd_dmaengine_pcm_config {
 	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct dma_slave_config *slave_config);
-	struct dma_chan *(*compat_request_channel)(
-			struct snd_soc_pcm_runtime *rtd,
-			struct snd_pcm_substream *substream);
 	dma_filter_fn compat_filter_fn;
 	struct device *dma_dev;
 	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5b70c556fba3..6ce85371d2f7 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -180,9 +180,6 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
 		return pcm->chan[0];
 
-	if (pcm->config->compat_request_channel)
-		return pcm->config->compat_request_channel(rtd, substream);
-
 	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
 						 dma_data->filter_data);
 }
-- 
1.8.1.5
