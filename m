From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8996: Add 44.1kHz support
Date: Wed, 14 Mar 2012 20:36:33 +0000
Message-ID: <1331757394-27488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BBB3103B5E
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 21:36:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8996 specification has been updated to specify 44.1kHz as a supported
sample rate. Update the driver to accept this configuration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 40a124c..1fd6354 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1914,7 +1914,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
-	int bits, i, bclk_rate;
+	int bits, i, bclk_rate, best;
 	int aifdata = 0;
 	int lrclk = 0;
 	int dsp = 0;
@@ -1963,14 +1963,11 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 		return bits;
 	aifdata |= (bits << WM8996_AIF1TX_WL_SHIFT) | bits;
 
+	best = 0;
 	for (i = 0; i < ARRAY_SIZE(dsp_divs); i++) {
-		if (dsp_divs[i] == params_rate(params))
-			break;
-	}
-	if (i == ARRAY_SIZE(dsp_divs)) {
-		dev_err(codec->dev, "Unsupported sample rate %dHz\n",
-			params_rate(params));
-		return -EINVAL;
+		if (abs(dsp_divs[i] - params_rate(params)) <
+		    abs(dsp_divs[best] - params_rate(params)))
+			best = i;
 	}
 	dsp |= i << dsp_shift;
 
@@ -2030,13 +2027,16 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 	}
 
 	switch (wm8996->sysclk) {
+	case 5644800:
 	case 6144000:
 		snd_soc_update_bits(codec, WM8996_AIF_RATE,
 				    WM8996_SYSCLK_RATE, 0);
 		break;
+	case 22579200:
 	case 24576000:
 		ratediv = WM8996_SYSCLK_DIV;
 		wm8996->sysclk /= 2;
+	case 11289600:
 	case 12288000:
 		snd_soc_update_bits(codec, WM8996_AIF_RATE,
 				    WM8996_SYSCLK_RATE, WM8996_SYSCLK_RATE);
@@ -3060,7 +3060,8 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8996 = {
 };
 
 #define WM8996_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
-		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
+		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+		      SNDRV_PCM_RATE_48000)
 #define WM8996_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
 			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE |\
 			SNDRV_PCM_FMTBIT_S32_LE)
-- 
1.7.9.1
