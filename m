From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/20] ASoC: dmaengine: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:20 +0100
Message-ID: <20190205194221.25924-20-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 893E8267950
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:29 +0100 (CET)
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
 sound/soc/soc-generic-dmaengine-pcm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 30e791a53352..46252b13d3b3 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -270,7 +270,6 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	size_t prealloc_buffer_size;
 	size_t max_buffer_size;
 	unsigned int i;
-	int ret;
 
 	if (config && config->prealloc_buffer_size) {
 		prealloc_buffer_size = config->prealloc_buffer_size;
@@ -303,13 +302,11 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			return -EINVAL;
 		}
 
-		ret = snd_pcm_lib_preallocate_pages(substream,
+		snd_pcm_lib_preallocate_pages(substream,
 				SNDRV_DMA_TYPE_DEV_IRAM,
 				dmaengine_dma_dev(pcm, substream),
 				prealloc_buffer_size,
 				max_buffer_size);
-		if (ret)
-			return ret;
 
 		if (!dmaengine_pcm_can_report_residue(dev, pcm->chan[i]))
 			pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
-- 
2.16.4
