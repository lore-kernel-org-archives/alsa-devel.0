From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/18] ASoC: omap-dmic: Assign the dai DMA data
	at earlier time
Date: Wed, 16 Apr 2014 12:23:19 +0300
Message-ID: <1397640211-15447-7-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id BA883261A9A
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:23:51 +0200 (CEST)
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
 sound/soc/omap/omap-dmic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 1bd531d718f9..350b4d524c86 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -113,7 +113,6 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_unlock(&dmic->mutex);
 
-	snd_soc_dai_set_dma_data(dai, substream, &dmic->dma_data);
 	return ret;
 }
 
@@ -417,6 +416,10 @@ static int omap_dmic_probe(struct snd_soc_dai *dai)
 
 	/* Configure DMIC threshold value */
 	dmic->threshold = OMAP_DMIC_THRES_MAX - 3;
+
+	dai->playback_dma_data = NULL;
+	dai->capture_dma_data = &dmic->dma_data;
+
 	return 0;
 }
 
-- 
1.9.2
