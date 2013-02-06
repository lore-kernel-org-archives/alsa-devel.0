From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: compress: Only mute playback streams
Date: Wed,  6 Feb 2013 17:55:44 +0000
Message-ID: <1360173344-27930-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91A6126007E
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 18:55:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise capture activity on a compressed DAI would mute any playback
on the same DAI.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index c81aeec..35726cb 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -116,13 +116,12 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		cpu_dai->playback_active--;
 		codec_dai->playback_active--;
+		snd_soc_dai_digital_mute(codec_dai, 1);
 	} else {
 		cpu_dai->capture_active--;
 		codec_dai->capture_active--;
 	}
 
-	snd_soc_dai_digital_mute(codec_dai, 1);
-
 	cpu_dai->active--;
 	codec_dai->active--;
 	codec->active--;
@@ -179,10 +178,16 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	if (cmd == SNDRV_PCM_TRIGGER_START)
-		snd_soc_dai_digital_mute(codec_dai, 0);
-	else if (cmd == SNDRV_PCM_TRIGGER_STOP)
-		snd_soc_dai_digital_mute(codec_dai, 1);
+	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			snd_soc_dai_digital_mute(codec_dai, 0);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			snd_soc_dai_digital_mute(codec_dai, 1);
+			break;
+		}
+	}
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
-- 
1.7.10.4
