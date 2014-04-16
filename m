From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/20] ASoC: omap-mcbsp: Assign the dai DMA
	data at earlier time
Date: Wed, 16 Apr 2014 15:46:15 +0300
Message-ID: <1397652390-852-6-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F0E2652AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:48 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Assign the dai dma data at dai driver probe time, not in startup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6c19bba23570..4525190d5599 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -149,9 +149,6 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 	}
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream,
-				 &mcbsp->dma_data[substream->stream]);
-
 	return err;
 }
 
@@ -559,6 +556,10 @@ static int omap_mcbsp_probe(struct snd_soc_dai *dai)
 
 	pm_runtime_enable(mcbsp->dev);
 
+	snd_soc_dai_init_dma_data(dai,
+				  &mcbsp->dma_data[SNDRV_PCM_STREAM_PLAYBACK],
+				  &mcbsp->dma_data[SNDRV_PCM_STREAM_CAPTURE]);
+
 	return 0;
 }
 
-- 
1.9.2
