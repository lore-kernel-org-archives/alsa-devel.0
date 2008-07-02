From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Advertise 16000Hz rate for WM9713
	PCM interface
Date: Wed,  2 Jul 2008 11:51:19 +0100
Message-ID: <1214995880-2773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2FAB2462E
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 12:51:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 0db9637..a480618 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1001,9 +1001,18 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream)
 	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
-#define WM9713_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
-		SNDRV_PCM_RATE_48000)
+#define WM9713_RATES (SNDRV_PCM_RATE_8000  |	\
+		      SNDRV_PCM_RATE_11025 |	\
+		      SNDRV_PCM_RATE_22050 |	\
+		      SNDRV_PCM_RATE_44100 |	\
+		      SNDRV_PCM_RATE_48000)
+
+#define WM9713_PCM_RATES (SNDRV_PCM_RATE_8000  |	\
+			  SNDRV_PCM_RATE_11025 |	\
+			  SNDRV_PCM_RATE_16000 |	\
+			  SNDRV_PCM_RATE_22050 |	\
+			  SNDRV_PCM_RATE_44100 |	\
+			  SNDRV_PCM_RATE_48000)
 
 #define WM9713_PCM_FORMATS \
 	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
@@ -1051,13 +1060,13 @@ struct snd_soc_codec_dai wm9713_dai[] = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
 		.channels_max = 1,
-		.rates = WM9713_RATES,
+		.rates = WM9713_PCM_RATES,
 		.formats = WM9713_PCM_FORMATS,},
 	.capture = {
 		.stream_name = "Voice Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = WM9713_RATES,
+		.rates = WM9713_PCM_RATES,
 		.formats = WM9713_PCM_FORMATS,},
 	.ops = {
 		.hw_params = wm9713_pcm_hw_params,
-- 
1.5.6
