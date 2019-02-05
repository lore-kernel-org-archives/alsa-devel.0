From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/20] ASoC: amd: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:10 +0100
Message-ID: <20190205194221.25924-10-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4804C26790F
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:28 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/acp-pcm-dma.c         | 26 +++++++++++---------------
 sound/soc/amd/raven/acp3x-pcm-dma.c |  9 ++++-----
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index f4011bebc7ec..2391c7f1dd2d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1142,7 +1142,6 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
-	int ret;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
@@ -1150,24 +1149,21 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
-		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							    SNDRV_DMA_TYPE_DEV,
-							    parent,
-							    ST_MIN_BUFFER,
-							    ST_MAX_BUFFER);
+		snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+						      SNDRV_DMA_TYPE_DEV,
+						      parent,
+						      ST_MIN_BUFFER,
+						      ST_MAX_BUFFER);
 		break;
 	default:
-		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							    SNDRV_DMA_TYPE_DEV,
-							    parent,
-							    MIN_BUFFER,
-							    MAX_BUFFER);
+		snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+						      SNDRV_DMA_TYPE_DEV,
+						      parent,
+						      MIN_BUFFER,
+						      MAX_BUFFER);
 		break;
 	}
-	if (ret < 0)
-		dev_err(component->dev,
-			"buffer preallocation failure error:%d\n", ret);
-	return ret;
+	return 0;
 }
 
 static int acp_dma_close(struct snd_pcm_substream *substream)
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 3e7d4099364c..1a2e15ff1456 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -367,11 +367,10 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-						     SNDRV_DMA_TYPE_DEV,
-						     rtd->pcm->card->dev,
-						     MIN_BUFFER,
-						     MAX_BUFFER);
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+					      rtd->pcm->card->dev,
+					      MIN_BUFFER, MAX_BUFFER);
+	return 0;
 }
 
 static int acp3x_dma_hw_free(struct snd_pcm_substream *substream)
-- 
2.16.4
