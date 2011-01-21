From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: cs4271.c: improve error handling
Date: Fri, 21 Jan 2011 22:22:07 +0300
Message-ID: <1295637727.1561.9.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward1.mail.yandex.net (forward1.mail.yandex.net [77.88.46.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C608103B4A
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 20:22:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

CS4271 CODEC driver adapted to recently introduced error handling in
snd_soc_update_bits().
Added snd_soc_cache_sync() error handling.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---

 sound/soc/codecs/cs4271.c |   59 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 25fed1b..5357ec5 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -209,6 +209,7 @@ static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val = 0;
+	int ret;
 
 	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -226,22 +227,27 @@ static int cs4271_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_LEFT_J:
 		val |= CS4271_MODE1_DAC_DIF_LJ;
-		snd_soc_update_bits(codec, CS4271_ADCCTL,
+		ret = snd_soc_update_bits(codec, CS4271_ADCCTL,
 			CS4271_ADCCTL_ADC_DIF_MASK, CS4271_ADCCTL_ADC_DIF_LJ);
+		if (ret < 0)
+			return ret;
 		break;
 	case SND_SOC_DAIFMT_I2S:
 		val |= CS4271_MODE1_DAC_DIF_I2S;
-		snd_soc_update_bits(codec, CS4271_ADCCTL,
+		ret = snd_soc_update_bits(codec, CS4271_ADCCTL,
 			CS4271_ADCCTL_ADC_DIF_MASK, CS4271_ADCCTL_ADC_DIF_I2S);
+		if (ret < 0)
+			return ret;
 		break;
 	default:
 		dev_err(codec->dev, "Invalid DAI format\n");
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, CS4271_MODE1,
+	ret = snd_soc_update_bits(codec, CS4271_MODE1,
 		CS4271_MODE1_DAC_DIF_MASK | CS4271_MODE1_MASTER, val);
-
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 
@@ -250,7 +256,7 @@ static int cs4271_deemph[] = {0, 44100, 48000, 32000};
 static int cs4271_set_deemph(struct snd_soc_codec *codec)
 {
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
-	int i;
+	int i, ret;
 	int val = CS4271_DACCTL_DEM_DIS;
 
 	if (cs4271->deemph) {
@@ -263,8 +269,11 @@ static int cs4271_set_deemph(struct snd_soc_codec *codec)
 		val <<= 4;
 	}
 
-	return snd_soc_update_bits(codec, CS4271_DACCTL,
+	ret = snd_soc_update_bits(codec, CS4271_DACCTL,
 		CS4271_DACCTL_DEM_MASK, val);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static int cs4271_get_deemph(struct snd_kcontrol *kcontrol,
@@ -294,7 +303,8 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
-	unsigned int i, ratio, val;
+	int i, ret;
+	unsigned int ratio, val;
 
 	cs4271->rate = params_rate(params);
 	ratio = cs4271->mclk / cs4271->rate;
@@ -315,8 +325,10 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 	else
 		val |= cs4271_clk_tab[i].mclk_slave;
 
-	snd_soc_update_bits(codec, CS4271_MODE1,
+	ret = snd_soc_update_bits(codec, CS4271_MODE1,
 		CS4271_MODE1_MODE_MASK | CS4271_MODE1_DIV_MASK, val);
+	if (ret < 0)
+		return ret;
 
 	return cs4271_set_deemph(codec);
 }
@@ -324,6 +336,7 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	int ret;
 	int val_a = 0;
 	int val_b = 0;
 
@@ -332,8 +345,12 @@ static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
 		val_b = CS4271_VOLB_MUTE;
 	}
 
-	snd_soc_update_bits(codec, CS4271_VOLA, CS4271_VOLA_MUTE, val_a);
-	snd_soc_update_bits(codec, CS4271_VOLB, CS4271_VOLB_MUTE, val_b);
+	ret = snd_soc_update_bits(codec, CS4271_VOLA, CS4271_VOLA_MUTE, val_a);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_update_bits(codec, CS4271_VOLB, CS4271_VOLB_MUTE, val_b);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -392,17 +409,25 @@ struct snd_soc_dai_driver cs4271_dai = {
 #ifdef CONFIG_PM
 static int cs4271_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 {
+	int ret;
 	/* Set power-down bit */
-	snd_soc_update_bits(codec, CS4271_MODE2, 0, CS4271_MODE2_PDN);
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0, CS4271_MODE2_PDN);
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 
 static int cs4271_soc_resume(struct snd_soc_codec *codec)
 {
+	int ret;
 	/* Restore codec state */
-	snd_soc_cache_sync(codec);
+	ret = snd_soc_cache_sync(codec);
+	if (ret < 0)
+		return ret;
 	/* then disable the power-down bit */
-	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 #else
@@ -467,9 +492,13 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	snd_soc_update_bits(codec, CS4271_MODE2, 0, 
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, 0,
 		CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
-	snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	if (ret < 0)
+		return ret;
+	ret = snd_soc_update_bits(codec, CS4271_MODE2, CS4271_MODE2_PDN, 0);
+	if (ret < 0)
+		return ret;
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
