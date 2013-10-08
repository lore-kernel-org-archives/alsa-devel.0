From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/2] ASoC: dmaengine-pcm: Provide default
	config
Date: Tue,  8 Oct 2013 15:08:00 +0200
Message-ID: <1381237680-32654-2-git-send-email-lars@metafoo.de>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-117.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 52C69265353
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 15:06:15 +0200 (CEST)
In-Reply-To: <1381237680-32654-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds some default settings for the generic dmaengine PCM driver for
the case that no config has been supplied. The following defaults are used:
	* Use snd_dmaengine_pcm_prepare_slave_config for preparing the DMA slave
	  config.
	* 512kB for the prealloc buffer size. This value has been chosen based on
	  'feels about right' and is not backed up by any scientific facts. We
	  may need to come up with something smarter in the future but it should
	  work fine for now.

With this infrastructure in place we can finally write DAI drivers which are
independent of the DMA controller they are connected to. This is e.g. useful if
the DAI IP core is reused across different SoCs, but the SoCs uses different DMA
controllers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index c39e19e..99f9495 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -84,12 +84,19 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params,
+			struct dma_slave_config *slave_config);
 	struct dma_slave_config slave_config;
 	int ret;
 
-	if (pcm->config->prepare_slave_config) {
-		ret = pcm->config->prepare_slave_config(substream, params,
-				&slave_config);
+	if (!pcm->config)
+		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
+	else
+		prepare_slave_config = pcm->config->prepare_slave_config;
+
+	if (prepare_slave_config) {
+		ret = prepare_slave_config(substream, params, &slave_config);
 		if (ret)
 			return ret;
 
@@ -112,7 +119,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	struct snd_pcm_hardware hw;
 	int ret;
 
-	if (pcm->config->pcm_hardware)
+	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
 				pcm->config->pcm_hardware);
 
@@ -177,9 +184,20 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
 	const struct snd_dmaengine_pcm_config *config = pcm->config;
 	struct snd_pcm_substream *substream;
+	size_t prealloc_buffer_size;
+	size_t max_buffer_size;
 	unsigned int i;
 	int ret;
 
+	if (config && config->prealloc_buffer_size) {
+		prealloc_buffer_size = config->prealloc_buffer_size;
+		max_buffer_size = config->pcm_hardware->buffer_bytes_max;
+	} else {
+		prealloc_buffer_size = 512 * 1024;
+		max_buffer_size = SIZE_MAX;
+	}
+
+
 	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
 		substream = rtd->pcm->streams[i].substream;
 		if (!substream)
@@ -200,8 +218,8 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		ret = snd_pcm_lib_preallocate_pages(substream,
 				SNDRV_DMA_TYPE_DEV,
 				dmaengine_dma_dev(pcm, substream),
-				config->prealloc_buffer_size,
-				config->pcm_hardware->buffer_bytes_max);
+				prealloc_buffer_size,
+				max_buffer_size);
 		if (ret)
 			goto err_free;
 	}
-- 
1.8.0
