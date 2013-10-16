From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 2/2] ASoC: generic-dmaengine-pcm: Support
	on-chip internal memory for DMA buffer
Date: Wed, 16 Oct 2013 16:18:04 +0800
Message-ID: <764ec7a383968296dbd3988aee2f3e30b951c7d1.1381911378.git.b42378@freescale.com>
References: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 252AB261A13
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 10:18:39 +0200 (CEST)
In-Reply-To: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add type check when allocating memory space for DMA buffer.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 include/sound/dmaengine_pcm.h         | 4 ++++
 sound/soc/soc-generic-dmaengine-pcm.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index f11c35c..587f091 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -96,6 +96,10 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * playback.
  */
 #define SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX BIT(3)
+/*
+ * The memory space used by DMA is allocated from SoC on-chip internal memory
+ */
+#define SND_DMAENGINE_PCM_FLAG_DMA_IRAM BIT(4)
 
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index e29ec3c..dd72964 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -142,7 +142,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
 	const struct snd_dmaengine_pcm_config *config = pcm->config;
 	struct snd_pcm_substream *substream;
-	unsigned int i;
+	unsigned int i, type = SNDRV_DMA_TYPE_DEV;
 	int ret;
 
 	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
@@ -162,8 +162,10 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			goto err_free;
 		}
 
-		ret = snd_pcm_lib_preallocate_pages(substream,
-				SNDRV_DMA_TYPE_DEV,
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_DMA_IRAM)
+			type = SNDRV_DMA_TYPE_DEV_IRAM;
+
+		ret = snd_pcm_lib_preallocate_pages(substream, type,
 				dmaengine_dma_dev(pcm, substream),
 				config->prealloc_buffer_size,
 				config->pcm_hardware->buffer_bytes_max);
-- 
1.8.4
