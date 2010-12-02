From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Apostrophe patrol in soc-core.c
Date: Thu,  2 Dec 2010 17:02:41 +0000
Message-ID: <1291309361-10184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43FA1103AD9
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 18:02:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Silly little grammar nit but it bugs the hell out of me.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eb950f7..20dcc97 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -525,7 +525,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	/* Check that the codec and cpu DAI's are compatible */
+	/* Check that the codec and cpu DAIs are compatible */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		runtime->hw.rate_min =
 			max(codec_dai_drv->playback.rate_min,
@@ -874,7 +874,7 @@ codec_err:
 }
 
 /*
- * Free's resources allocated by hw_params, can be called multiple times
+ * Frees resources allocated by hw_params, can be called multiple times
  */
 static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
@@ -898,7 +898,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (platform->driver->ops->hw_free)
 		platform->driver->ops->hw_free(substream);
 
-	/* now free hw params for the DAI's  */
+	/* now free hw params for the DAIs  */
 	if (codec_dai->driver->ops->hw_free)
 		codec_dai->driver->ops->hw_free(substream, codec_dai);
 
@@ -1005,7 +1005,7 @@ static int soc_suspend(struct device *dev)
 	/* we're going to block userspace touching us until resume completes */
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D3hot);
 
-	/* mute any active DAC's */
+	/* mute any active DACs */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
 		struct snd_soc_dai_driver *drv = dai->driver;
-- 
1.7.1
