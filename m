From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/18] ASoC: omap-mcpdm: Assign the dai DMA
	data at earlier time
Date: Wed, 16 Apr 2014 12:23:15 +0300
Message-ID: <1397640211-15447-3-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9DD261B0A
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:23:41 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Assign the dai dma data at dai driver probe time, not in startup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 2f5b1536477e..489cb1f972a6 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -265,9 +265,6 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 	}
 	mutex_unlock(&mcpdm->mutex);
 
-	snd_soc_dai_set_dma_data(dai, substream,
-				 &mcpdm->dma_data[substream->stream]);
-
 	return 0;
 }
 
@@ -406,6 +403,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold = 2;
 	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =
 							MCPDM_UP_THRES_MAX - 3;
+
+	dai->playback_dma_data = &mcpdm->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
+	dai->capture_dma_data = &mcpdm->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+
 	return ret;
 }
 
-- 
1.9.2
