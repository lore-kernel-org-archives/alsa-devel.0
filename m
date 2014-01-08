From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: adav80x: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 18:51:29 +0000
Message-ID: <1389207089-23741-5-git-send-email-broonie@kernel.org>
References: <1389207089-23741-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D99992651A1
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 19:51:39 +0100 (CET)
In-Reply-To: <1389207089-23741-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/adav80x.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index f7bf45552749..f78b27a7c461 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -453,22 +453,22 @@ static int adav80x_set_dac_clock(struct snd_soc_codec *codec,
 }
 
 static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
-		struct snd_soc_dai *dai, snd_pcm_format_t format)
+		struct snd_soc_dai *dai, struct snd_pcm_hw_params *params)
 {
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
-	switch (format) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		val = ADAV80X_CAPTURE_WORD_LEN16;
 		break;
-	case SNDRV_PCM_FORMAT_S18_3LE:
+	case 18:
 		val = ADAV80X_CAPTRUE_WORD_LEN18;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val = ADAV80X_CAPTURE_WORD_LEN20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		val = ADAV80X_CAPTURE_WORD_LEN24;
 		break;
 	default:
@@ -482,7 +482,7 @@ static int adav80x_set_capture_pcm_format(struct snd_soc_codec *codec,
 }
 
 static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
-		struct snd_soc_dai *dai, snd_pcm_format_t format)
+		struct snd_soc_dai *dai, struct snd_pcm_hw_params *params)
 {
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
@@ -490,17 +490,17 @@ static int adav80x_set_playback_pcm_format(struct snd_soc_codec *codec,
 	if (adav80x->dai_fmt[dai->id] != SND_SOC_DAIFMT_RIGHT_J)
 		return 0;
 
-	switch (format) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		val = ADAV80X_PLAYBACK_MODE_RIGHT_J_16;
 		break;
-	case SNDRV_PCM_FORMAT_S18_3LE:
+	case 18:
 		val = ADAV80X_PLAYBACK_MODE_RIGHT_J_18;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val = ADAV80X_PLAYBACK_MODE_RIGHT_J_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		val = ADAV80X_PLAYBACK_MODE_RIGHT_J_24;
 		break;
 	default:
@@ -524,12 +524,10 @@ static int adav80x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adav80x_set_playback_pcm_format(codec, dai,
-			params_format(params));
+		adav80x_set_playback_pcm_format(codec, dai, params);
 		adav80x_set_dac_clock(codec, rate);
 	} else {
-		adav80x_set_capture_pcm_format(codec, dai,
-			params_format(params));
+		adav80x_set_capture_pcm_format(codec, dai, params);
 		adav80x_set_adc_clock(codec, rate);
 	}
 	adav80x->rate = rate;
-- 
1.8.5.2
