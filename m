From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/5] ASoC: adau1701: Use params_width() rather
	than memory format
Date: Wed,  8 Jan 2014 18:51:28 +0000
Message-ID: <1389207089-23741-4-git-send-email-broonie@kernel.org>
References: <1389207089-23741-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAB1265176
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
 sound/soc/codecs/adau1701.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index ebff1128be59..52e3d83e26e6 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -299,20 +299,20 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
 }
 
 static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
-		snd_pcm_format_t format)
+					   struct snd_pcm_hw_params *params)
 {
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 	unsigned int mask = ADAU1701_SEROCTL_WORD_LEN_MASK;
 	unsigned int val;
 
-	switch (format) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		val = ADAU1701_SEROCTL_WORD_LEN_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val = ADAU1701_SEROCTL_WORD_LEN_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		val = ADAU1701_SEROCTL_WORD_LEN_24;
 		break;
 	default:
@@ -320,14 +320,14 @@ static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
 	}
 
 	if (adau1701->dai_fmt == SND_SOC_DAIFMT_RIGHT_J) {
-		switch (format) {
-		case SNDRV_PCM_FORMAT_S16_LE:
+		switch (params_width(params)) {
+		case 16:
 			val |= ADAU1701_SEROCTL_MSB_DEALY16;
 			break;
-		case SNDRV_PCM_FORMAT_S20_3LE:
+		case 20:
 			val |= ADAU1701_SEROCTL_MSB_DEALY12;
 			break;
-		case SNDRV_PCM_FORMAT_S24_LE:
+		case 24:
 			val |= ADAU1701_SEROCTL_MSB_DEALY8;
 			break;
 		}
@@ -340,7 +340,7 @@ static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
 }
 
 static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
-			snd_pcm_format_t format)
+					    struct snd_pcm_hw_params *params)
 {
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
@@ -348,14 +348,14 @@ static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
 	if (adau1701->dai_fmt != SND_SOC_DAIFMT_RIGHT_J)
 		return 0;
 
-	switch (format) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	switch (params_width(params)) {
+	case 16:
 		val = ADAU1701_SERICTL_RIGHTJ_16;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
+	case 20:
 		val = ADAU1701_SERICTL_RIGHTJ_20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case 24:
 		val = ADAU1701_SERICTL_RIGHTJ_24;
 		break;
 	default:
@@ -374,7 +374,6 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 	unsigned int clkdiv = adau1701->sysclk / params_rate(params);
-	snd_pcm_format_t format;
 	unsigned int val;
 	int ret;
 
@@ -406,11 +405,10 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(adau1701->regmap, ADAU1701_DSPCTRL,
 		ADAU1701_DSPCTRL_SR_MASK, val);
 
-	format = params_format(params);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		return adau1701_set_playback_pcm_format(codec, format);
+		return adau1701_set_playback_pcm_format(codec, params);
 	else
-		return adau1701_set_capture_pcm_format(codec, format);
+		return adau1701_set_capture_pcm_format(codec, params);
 }
 
 static int adau1701_set_dai_fmt(struct snd_soc_dai *codec_dai,
-- 
1.8.5.2
