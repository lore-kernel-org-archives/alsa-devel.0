From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: wm8903: Move register default
	changes to I2C probe
Date: Sat,  9 Jun 2012 11:09:55 +0800
Message-ID: <1339211396-31711-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C55D2103D92
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 05:10:16 +0200 (CEST)
In-Reply-To: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Also convert to use update_bits() while we're at it. No great need to do
this, it's just a bit neater to do as much as possible in the I2C probe.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   63 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 21c4dd2..9410d54 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2096,7 +2096,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int ret;
-	u16 val;
 
 	wm8903->codec = codec;
 	codec->control_data = wm8903->regmap;
@@ -2110,37 +2109,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	/* power on device */
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	/* Latch volume update bits */
-	val = snd_soc_read(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT);
-	val |= WM8903_ADCVU;
-	snd_soc_write(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT, val);
-	snd_soc_write(codec, WM8903_ADC_DIGITAL_VOLUME_RIGHT, val);
-
-	val = snd_soc_read(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT);
-	val |= WM8903_DACVU;
-	snd_soc_write(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT, val);
-	snd_soc_write(codec, WM8903_DAC_DIGITAL_VOLUME_RIGHT, val);
-
-	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT1_LEFT);
-	val |= WM8903_HPOUTVU;
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT1_LEFT, val);
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT1_RIGHT, val);
-
-	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT2_LEFT);
-	val |= WM8903_LINEOUTVU;
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT2_LEFT, val);
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT2_RIGHT, val);
-
-	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT3_LEFT);
-	val |= WM8903_SPKVU;
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT3_LEFT, val);
-	snd_soc_write(codec, WM8903_ANALOGUE_OUT3_RIGHT, val);
-
-	/* Enable DAC soft mute by default */
-	snd_soc_update_bits(codec, WM8903_DAC_DIGITAL_1,
-			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE,
-			    WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE);
-
 	return ret;
 }
 
@@ -2397,6 +2365,37 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 				   WM8903_IM_WSEQ_BUSY_EINT, 0);
 	}
 
+	/* Latch volume update bits */
+	regmap_update_bits(wm8903->regmap, WM8903_ADC_DIGITAL_VOLUME_LEFT,
+			   WM8903_ADCVU, WM8903_ADCVU);
+	regmap_update_bits(wm8903->regmap, WM8903_ADC_DIGITAL_VOLUME_RIGHT,
+			   WM8903_ADCVU, WM8903_ADCVU);
+
+	regmap_update_bits(wm8903->regmap, WM8903_DAC_DIGITAL_VOLUME_LEFT,
+			   WM8903_DACVU, WM8903_DACVU);
+	regmap_update_bits(wm8903->regmap, WM8903_DAC_DIGITAL_VOLUME_RIGHT,
+			   WM8903_DACVU, WM8903_DACVU);
+
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT1_LEFT,
+			   WM8903_HPOUTVU, WM8903_HPOUTVU);
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT1_RIGHT,
+			   WM8903_HPOUTVU, WM8903_HPOUTVU);
+
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT2_LEFT,
+			   WM8903_LINEOUTVU, WM8903_LINEOUTVU);
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT2_RIGHT,
+			   WM8903_LINEOUTVU, WM8903_LINEOUTVU);
+
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT3_LEFT,
+			   WM8903_SPKVU, WM8903_SPKVU);
+	regmap_update_bits(wm8903->regmap, WM8903_ANALOGUE_OUT3_RIGHT,
+			   WM8903_SPKVU, WM8903_SPKVU);
+
+	/* Enable DAC soft mute by default */
+	regmap_update_bits(wm8903->regmap, WM8903_DAC_DIGITAL_1,
+			   WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE,
+			   WM8903_DAC_MUTEMODE | WM8903_DAC_MUTE);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
 	if (ret != 0)
-- 
1.7.10
