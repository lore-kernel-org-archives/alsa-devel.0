From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-pcm: No need to set constraint at
	open time
Date: Tue, 5 Feb 2013 13:43:39 +0100
Message-ID: <1360068219-32156-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id AD292260307
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 13:43:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The same constraint is going to be set in the snd_dmaengine_pcm_open()
function, so there is no need to set it here as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 47bdbd4..c722c2e 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -174,23 +174,15 @@ static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
 
 static int omap_pcm_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct omap_pcm_dma_data *dma_data;
-	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
 
-	/* Ensure that buffer size is a multiple of period size */
-	ret = snd_pcm_hw_constraint_integer(runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		return ret;
-
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	ret = snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
-				     &dma_data->dma_req);
-	return ret;
+
+	return snd_dmaengine_pcm_open(substream, omap_dma_filter_fn,
+				      &dma_data->dma_req);
 }
 
 static int omap_pcm_close(struct snd_pcm_substream *substream)
-- 
1.8.1.1
