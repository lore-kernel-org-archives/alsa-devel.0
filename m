From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ASoC: adau1701: more direct regmap usage
Date: Thu, 27 Jun 2013 22:00:04 +0200
Message-ID: <1372363205-31244-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F765265663
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 21:59:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lars@metafoo.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Replace calls to snd_soc_update_bits() with regmap_update_bits().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/adau1701.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index ac8b2c4..ce56065 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -334,7 +334,7 @@ static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
 		mask |= ADAU1701_SEROCTL_MSB_DEALY_MASK;
 	}
 
-	snd_soc_update_bits(codec, ADAU1701_SEROCTL, mask, val);
+	regmap_update_bits(adau1701->regmap, ADAU1701_SEROCTL, mask, val);
 
 	return 0;
 }
@@ -362,7 +362,7 @@ static int adau1701_set_playback_pcm_format(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ADAU1701_SERICTL,
+	regmap_update_bits(adau1701->regmap, ADAU1701_SERICTL,
 		ADAU1701_SERICTL_MODE_MASK, val);
 
 	return 0;
@@ -403,7 +403,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ADAU1701_DSPCTRL,
+	regmap_update_bits(adau1701->regmap, ADAU1701_DSPCTRL,
 		ADAU1701_DSPCTRL_SR_MASK, val);
 
 	format = params_format(params);
@@ -489,6 +489,7 @@ static int adau1701_set_bias_level(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
 	unsigned int mask = ADAU1701_AUXNPOW_VBPD | ADAU1701_AUXNPOW_VRPD;
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -497,11 +498,13 @@ static int adau1701_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* Enable VREF and VREF buffer */
-		snd_soc_update_bits(codec, ADAU1701_AUXNPOW, mask, 0x00);
+		regmap_update_bits(adau1701->regmap,
+				   ADAU1701_AUXNPOW, mask, 0x00);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* Disable VREF and VREF buffer */
-		snd_soc_update_bits(codec, ADAU1701_AUXNPOW, mask, mask);
+		regmap_update_bits(adau1701->regmap,
+				   ADAU1701_AUXNPOW, mask, mask);
 		break;
 	}
 
@@ -513,6 +516,7 @@ static int adau1701_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	unsigned int mask = ADAU1701_DSPCTRL_DAM;
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
 
 	if (mute)
@@ -520,7 +524,7 @@ static int adau1701_digital_mute(struct snd_soc_dai *dai, int mute)
 	else
 		val = mask;
 
-	snd_soc_update_bits(codec, ADAU1701_DSPCTRL, mask, val);
+	regmap_update_bits(adau1701->regmap, ADAU1701_DSPCTRL, mask, val);
 
 	return 0;
 }
@@ -542,7 +546,8 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ADAU1701_OSCIPOW, ADAU1701_OSCIPOW_OPD, val);
+	regmap_update_bits(adau1701->regmap, ADAU1701_OSCIPOW,
+			   ADAU1701_OSCIPOW_OPD, val);
 	adau1701->sysclk = freq;
 
 	return 0;
-- 
1.8.1.4
