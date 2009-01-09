From: Ian Molton <ian@mnementh.co.uk>
Subject: PATCH: Cleanup duplicate code
Date: Fri, 09 Jan 2009 00:37:22 +0000
Message-ID: <49669C42.408@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id CC30F1037EB
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 01:37:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi folks,

I noticed this function has been copied, 'cookie cutter' style in a lot 
of codec drivers.

Here is a patch that cleans it up.

Also available in my git repo:

git://git.mnementh.co.uk/linux-2.6-im.git asoc





 From 8cf35a0f438c70eb7dc3334745ce4658b69f9e8a Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Fri, 9 Jan 2009 00:23:21 +0000
Subject: [PATCH] ASoC: cleanup duplicated code.

Many codec drivers were implementing cookie-cutter copies of the function
that adds kcontrols to the codec.

This patch moves this code to a common function snd_soc_add_controls() in
soc-core.c and updates all drivers using copies of this function to use the
new common version.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  include/sound/soc.h            |    2 +
  sound/soc/codecs/ad1980.c      |   17 +------------
  sound/soc/codecs/ak4535.c      |   18 +------------
  sound/soc/codecs/ssm2602.c     |   18 +------------
  sound/soc/codecs/tlv320aic23.c |   21 +---------------
  sound/soc/codecs/tlv320aic3x.c |   19 +-------------
  sound/soc/codecs/twl4030.c     |   19 +-------------
  sound/soc/codecs/uda134x.c     |   50 
++++++++++++---------------------------
  sound/soc/codecs/uda1380.c     |   18 +------------
  sound/soc/codecs/wm8350.c      |   18 +------------
  sound/soc/codecs/wm8510.c      |   19 +-------------
  sound/soc/codecs/wm8580.c      |   17 +------------
  sound/soc/codecs/wm8728.c      |   18 +------------
  sound/soc/codecs/wm8731.c      |   19 +-------------
  sound/soc/codecs/wm8750.c      |   18 +------------
  sound/soc/codecs/wm8753.c      |   18 +------------
  sound/soc/codecs/wm8900.c      |   19 +-------------
  sound/soc/codecs/wm8903.c      |   18 +------------
  sound/soc/codecs/wm8971.c      |   18 +------------
  sound/soc/codecs/wm8990.c      |   18 +------------
  sound/soc/codecs/wm9712.c      |   18 +------------
  sound/soc/codecs/wm9713.c      |   18 +------------
  sound/soc/soc-core.c           |   23 ++++++++++++++++++
  23 files changed, 81 insertions(+), 360 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9b930d3..7223101 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -203,6 +203,8 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec 
*codec);
   */
  struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new 
*_template,
  	void *data, char *long_name);
+int snd_soc_add_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls);
  int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
  	struct snd_ctl_elem_info *uinfo);
  int snd_soc_info_enum_ext(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 73fdbb4..c3c5d0e 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -93,20 +93,6 @@ SOC_ENUM("Capture Source", ad1980_cap_src),
  SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
  };

-/* add non dapm controls */
-static int ad1980_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(ad1980_snd_ac97_controls); i++) {
-		err = snd_ctl_add(codec->card, snd_soc_cnew(
-				&ad1980_snd_ac97_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  static unsigned int ac97_read(struct snd_soc_codec *codec,
  	unsigned int reg)
  {
@@ -269,7 +255,8 @@ static int ad1980_soc_probe(struct platform_device 
*pdev)
  	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
  	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);

-	ad1980_add_controls(codec);
+	snd_soc_add_controls(codec, ad1980_snd_ac97_controls,
+				ARRAY_SIZE(ad1980_snd_ac97_controls));
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
  		printk(KERN_ERR "ad1980: failed to register card\n");
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 81300d8..f17c363 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -155,21 +155,6 @@ static const struct snd_kcontrol_new 
ak4535_snd_controls[] = {
  	SOC_SINGLE("Mic Sidetone Volume", AK4535_VOL, 4, 7, 0),
  };

-/* add non dapm controls */
-static int ak4535_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(ak4535_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&ak4535_snd_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Mono 1 Mixer */
  static const struct snd_kcontrol_new ak4535_mono1_mixer_controls[] = {
  	SOC_DAPM_SINGLE("Mic Sidetone Switch", AK4535_SIG1, 4, 1, 0),
@@ -510,7 +495,8 @@ static int ak4535_init(struct snd_soc_device *socdev)
  	/* power on device */
  	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

-	ak4535_add_controls(codec);
+	snd_soc_add_controls(codec, ak4535_snd_controls,
+				ARRAY_SIZE(ak4535_snd_controls));
  	ak4535_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cac3736..ec7fe3b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -151,21 +151,6 @@ SOC_ENUM("Capture Source", ssm2602_enum[0]),
  SOC_ENUM("Playback De-emphasis", ssm2602_enum[1]),
  };

-/* add non dapm controls */
-static int ssm2602_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(ssm2602_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&ssm2602_snd_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Output Mixer */
  static const struct snd_kcontrol_new ssm2602_output_mixer_controls[] = {
  SOC_DAPM_SINGLE("Line Bypass Switch", SSM2602_APANA, 3, 1, 0),
@@ -622,7 +607,8 @@ static int ssm2602_init(struct snd_soc_device *socdev)
  			APANA_ENABLE_MIC_BOOST);
  	ssm2602_write(codec, SSM2602_PWR, 0);

-	ssm2602_add_controls(codec);
+	snd_soc_add_controls(codec, ssm2602_snd_controls,
+				ARRAY_SIZE(ssm2602_snd_controls));
  	ssm2602_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index cfdea00..a0e47c1 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -183,24 +183,6 @@ static const struct snd_kcontrol_new 
tlv320aic23_snd_controls[] = {
  	SOC_ENUM("Playback De-emphasis", tlv320aic23_deemph),
  };

-/* add non dapm controls */
-static int tlv320aic23_add_controls(struct snd_soc_codec *codec)
-{
-
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(tlv320aic23_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&tlv320aic23_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-
-}
-
  /* PGA Mixer controls for Line and Mic switch */
  static const struct snd_kcontrol_new 
tlv320aic23_output_mixer_controls[] = {
  	SOC_DAPM_SINGLE("Line Bypass Switch", TLV320AIC23_ANLG, 3, 1, 0),
@@ -718,7 +700,8 @@ static int tlv320aic23_init(struct snd_soc_device 
*socdev)

  	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);

-	tlv320aic23_add_controls(codec);
+	snd_soc_add_controls(codec, tlv320aic23_snd_controls,
+				ARRAY_SIZE(tlv320aic23_snd_controls));
  	tlv320aic23_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index b47a749..36ab019 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -311,22 +311,6 @@ static const struct snd_kcontrol_new 
aic3x_snd_controls[] = {
  	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
  };

-/* add non dapm controls */
-static int aic3x_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(aic3x_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&aic3x_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Left DAC Mux */
  static const struct snd_kcontrol_new aic3x_left_dac_mux_controls =
  SOC_DAPM_ENUM("Route", aic3x_enum[LDAC_ENUM]);
@@ -1224,7 +1208,8 @@ static int aic3x_init(struct snd_soc_device *socdev)
  	aic3x_write(codec, AIC3X_GPIO1_REG, (setup->gpio_func[0] & 0xf) << 4);
  	aic3x_write(codec, AIC3X_GPIO2_REG, (setup->gpio_func[1] & 0xf) << 4);

-	aic3x_add_controls(codec);
+	snd_soc_add_controls(codec, aic3x_snd_controls,
+				ARRAY_SIZE(aic3x_snd_controls));
  	aic3x_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index fd0f338..253063f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -670,22 +670,6 @@ static const struct snd_kcontrol_new 
twl4030_snd_controls[] = {
  		0, 3, 5, 0, input_gain_tlv),
  };

-/* add non dapm controls */
-static int twl4030_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(twl4030_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&twl4030_snd_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
  	/* Left channel inputs */
  	SND_SOC_DAPM_INPUT("MAINMIC"),
@@ -1233,7 +1217,8 @@ static int twl4030_init(struct snd_soc_device *socdev)
  	/* power on device */
  	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

-	twl4030_add_controls(codec);
+	snd_soc_add_controls(codec, twl4030_snd_controls,
+				ARRAY_SIZE(twl4030_snd_controls));
  	twl4030_add_widgets(codec);

  	ret = snd_soc_init_card(socdev);
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index a2c5064..277825d 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -431,39 +431,6 @@ SOC_ENUM("PCM Playback De-emphasis", 
uda134x_mixer_enum[1]),
  SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
  };

-static int uda134x_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i, n;
-	const struct snd_kcontrol_new *ctrls;
-	struct uda134x_platform_data *pd = codec->control_data;
-
-	switch (pd->model) {
-	case UDA134X_UDA1340:
-	case UDA134X_UDA1344:
-		n = ARRAY_SIZE(uda1340_snd_controls);
-		ctrls = uda1340_snd_controls;
-		break;
-	case UDA134X_UDA1341:
-		n = ARRAY_SIZE(uda1341_snd_controls);
-		ctrls = uda1341_snd_controls;
-		break;
-	default:
-		printk(KERN_ERR "%s unkown codec type: %d",
-		       __func__, pd->model);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < n; i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&ctrls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  struct snd_soc_dai uda134x_dai = {
  	.name = "UDA134X",
  	/* playback capabilities */
@@ -572,7 +539,22 @@ static int uda134x_soc_probe(struct platform_device 
*pdev)
  		goto pcm_err;
  	}

-	ret = uda134x_add_controls(codec);
+	switch (pd->model) {
+	case UDA134X_UDA1340:
+	case UDA134X_UDA1344:
+		ret = snd_soc_add_controls(codec, uda1340_snd_controls,
+					ARRAY_SIZE(uda1340_snd_controls));
+	break;
+	case UDA134X_UDA1341:
+		ret = snd_soc_add_controls(codec, uda1341_snd_controls,
+					ARRAY_SIZE(uda1341_snd_controls));
+	break;
+	default:
+		printk(KERN_ERR "%s unkown codec type: %d",
+			__func__, pd->model);
+	return -EINVAL;
+	}
+
  	if (ret < 0) {
  		printk(KERN_ERR "UDA134X: failed to register controls\n");
  		goto pcm_err;
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index e6bf084..a957b43 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -271,21 +271,6 @@ static const struct snd_kcontrol_new 
uda1380_snd_controls[] = {
  	SOC_SINGLE("AGC Switch", UDA1380_AGC, 0, 1, 0),
  };

-/* add non dapm controls */
-static int uda1380_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(uda1380_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&uda1380_snd_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Input mux */
  static const struct snd_kcontrol_new uda1380_input_mux_control =
  	SOC_DAPM_ENUM("Route", uda1380_input_sel_enum);
@@ -675,7 +660,8 @@ static int uda1380_init(struct snd_soc_device 
*socdev, int dac_clk)
  	}

  	/* uda1380 init */
-	uda1380_add_controls(codec);
+	snd_soc_add_controls(codec, uda1380_snd_controls,
+				ARRAY_SIZE(uda1380_snd_controls));
  	uda1380_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index e3989d4..db00b6f 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -775,21 +775,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
  	{"Beep", NULL, "IN3R PGA"},
  };

-static int wm8350_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8350_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8350_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  static int wm8350_add_widgets(struct snd_soc_codec *codec)
  {
  	int ret;
@@ -1387,7 +1372,8 @@ static int wm8350_probe(struct platform_device *pdev)
  		return ret;
  	}

-	wm8350_add_controls(codec);
+	snd_soc_add_controls(codec, wm8350_snd_controls,
+				ARRAY_SIZE(wm8350_snd_controls));
  	wm8350_add_widgets(codec);

  	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 40f8238..abe7cce 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -171,22 +171,6 @@ SOC_SINGLE("Capture Boost(+20dB)", WM8510_ADCBOOST, 
  8, 1, 0),
  SOC_SINGLE("Mono Playback Switch", WM8510_MONOMIX, 6, 1, 1),
  };

-/* add non dapm controls */
-static int wm8510_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8510_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8510_snd_controls[i], codec,
-					NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Speaker Output Mixer */
  static const struct snd_kcontrol_new wm8510_speaker_mixer_controls[] = {
  SOC_DAPM_SINGLE("Line Bypass Switch", WM8510_SPKMIX, 1, 1, 0),
@@ -656,7 +640,8 @@ static int wm8510_init(struct snd_soc_device *socdev)
  	/* power on device */
  	codec->bias_level = SND_SOC_BIAS_OFF;
  	wm8510_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm8510_add_controls(codec);
+	snd_soc_add_controls(codec, wm8510_snd_controls,
+				ARRAY_SIZE(wm8510_snd_controls));
  	wm8510_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index d004e58..9b75a37 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -330,20 +330,6 @@ SOC_DOUBLE("ADC Mute Switch", WM8580_ADC_CONTROL1, 
0, 1, 1, 0),
  SOC_SINGLE("ADC High-Pass Filter Switch", WM8580_ADC_CONTROL1, 4, 1, 0),
  };

-/* Add non-DAPM controls */
-static int wm8580_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8580_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8580_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
  static const struct snd_soc_dapm_widget wm8580_dapm_widgets[] = {
  SND_SOC_DAPM_DAC("DAC1", "Playback", WM8580_PWRDN1, 2, 1),
  SND_SOC_DAPM_DAC("DAC2", "Playback", WM8580_PWRDN1, 3, 1),
@@ -866,7 +852,8 @@ static int wm8580_init(struct snd_soc_device *socdev)
  		goto pcm_err;
  	}

-	wm8580_add_controls(codec);
+	snd_soc_add_controls(codec, wm8580_snd_controls,
+				ARRAY_SIZE(wm8580_snd_controls));
  	wm8580_add_widgets(codec);

  	ret = snd_soc_init_card(socdev);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 80b1198..defa310 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -92,21 +92,6 @@ SOC_DOUBLE_R_TLV("Digital Playback Volume", 
WM8728_DACLVOL, WM8728_DACRVOL,
  SOC_SINGLE("Deemphasis", WM8728_DACCTL, 1, 1, 0),
  };

-static int wm8728_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8728_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8728_snd_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /*
   * DAPM controls.
   */
@@ -330,7 +315,8 @@ static int wm8728_init(struct snd_soc_device *socdev)
  	/* power on device */
  	wm8728_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

-	wm8728_add_controls(codec);
+	snd_soc_add_controls(codec, wm8728_snd_controls,
+				ARRAY_SIZE(wm8728_snd_controls));
  	wm8728_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c444b9f..96d6e1a 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -129,22 +129,6 @@ SOC_SINGLE("Store DC Offset Switch", WM8731_APDIGI, 
4, 1, 0),
  SOC_ENUM("Playback De-emphasis", wm8731_enum[1]),
  };

-/* add non dapm controls */
-static int wm8731_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8731_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8731_snd_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  /* Output Mixer */
  static const struct snd_kcontrol_new wm8731_output_mixer_controls[] = {
  SOC_DAPM_SINGLE("Line Bypass Switch", WM8731_APANA, 3, 1, 0),
@@ -543,7 +527,8 @@ static int wm8731_init(struct snd_soc_device *socdev)
  	reg = wm8731_read_reg_cache(codec, WM8731_RINVOL);
  	wm8731_write(codec, WM8731_RINVOL, reg & ~0x0100);

-	wm8731_add_controls(codec);
+	snd_soc_add_controls(codec, wm8731_snd_controls,
+				ARRAY_SIZE(wm8731_snd_controls));
  	wm8731_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 5997fa6..1578569 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -231,21 +231,6 @@ SOC_SINGLE("Mono Playback Volume", WM8750_MOUTV, 0, 
127, 0),

  };

-/* add non dapm controls */
-static int wm8750_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8750_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8750_snd_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /*
   * DAPM Controls
   */
@@ -816,7 +801,8 @@ static int wm8750_init(struct snd_soc_device *socdev)
  	reg = wm8750_read_reg_cache(codec, WM8750_RINVOL);
  	wm8750_write(codec, WM8750_RINVOL, reg | 0x0100);

-	wm8750_add_controls(codec);
+	snd_soc_add_controls(codec, wm8750_snd_controls,
+				ARRAY_SIZE(wm8750_snd_controls));
  	wm8750_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 6c21b50..7283178 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -339,21 +339,6 @@ SOC_ENUM("ADC Data Select", wm8753_enum[27]),
  SOC_ENUM("ROUT2 Phase", wm8753_enum[28]),
  };

-/* add non dapm controls */
-static int wm8753_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8753_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8753_snd_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /*
   * _DAPM_ Controls
   */
@@ -1603,7 +1588,8 @@ static int wm8753_init(struct snd_soc_device *socdev)
  	reg = wm8753_read_reg_cache(codec, WM8753_RINVOL);
  	wm8753_write(codec, WM8753_RINVOL, reg | 0x0100);

-	wm8753_add_controls(codec);
+	snd_soc_add_controls(codec, wm8753_snd_controls,
+				ARRAY_SIZE(wm8753_snd_controls));
  	wm8753_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 6767de1..1e08d4f 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -517,22 +517,6 @@ SOC_SINGLE("LINEOUT2 LP -12dB", WM8900_REG_LOUTMIXCTL1,

  };

-/* add non dapm controls */
-static int wm8900_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8900_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8900_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  static const struct snd_kcontrol_new wm8900_dapm_loutput2_control =
  SOC_DAPM_SINGLE("LINEOUT2L Switch", WM8900_REG_POWER3, 6, 1, 0);

@@ -1439,7 +1423,8 @@ static int wm8900_probe(struct platform_device *pdev)
  		goto pcm_err;
  	}

-	wm8900_add_controls(codec);
+	snd_soc_add_controls(codec, wm8900_snd_controls,
+				ARRAY_SIZE(wm8900_snd_controls));
  	wm8900_add_widgets(codec);

  	ret = snd_soc_init_card(socdev);
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index bde7454..6ff34b9 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -744,21 +744,6 @@ SOC_DOUBLE_R_TLV("Speaker Volume",
  		 0, 63, 0, out_tlv),
  };

-static int wm8903_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8903_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm8903_snd_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
  static const struct snd_kcontrol_new linput_mode_mux =
  	SOC_DAPM_ENUM("Left Input Mode Mux", linput_mode_enum);

@@ -1737,7 +1722,8 @@ static int wm8903_probe(struct platform_device *pdev)
  		goto err;
  	}

-	wm8903_add_controls(socdev->codec);
+	snd_soc_add_controls(socdev->codec, wm8903_snd_controls,
+				ARRAY_SIZE(wm8903_snd_controls));
  	wm8903_add_widgets(socdev->codec);

  	ret = snd_soc_init_card(socdev);
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 88ead7f..c8bd9b0 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -195,21 +195,6 @@ static const struct snd_kcontrol_new 
wm8971_snd_controls[] = {
  	SOC_DOUBLE_R("Mic Boost", WM8971_LADCIN, WM8971_RADCIN, 4, 3, 0),
  };

-/* add non-DAPM controls */
-static int wm8971_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8971_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8971_snd_controls[i],
-					     codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /*
   * DAPM Controls
   */
@@ -745,7 +730,8 @@ static int wm8971_init(struct snd_soc_device *socdev)
  	reg = wm8971_read_reg_cache(codec, WM8971_RINVOL);
  	wm8971_write(codec, WM8971_RINVOL, reg | 0x0100);

-	wm8971_add_controls(codec);
+	snd_soc_add_controls(codec, wm8971_snd_controls,
+				ARRAY_SIZE(wm8971_snd_controls));
  	wm8971_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 5b5afc1..6b27786 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -417,21 +417,6 @@ SOC_SINGLE("RIN34 Mute Switch", 
WM8990_RIGHT_LINE_INPUT_3_4_VOLUME,

  };

-/* add non dapm controls */
-static int wm8990_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8990_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8990_snd_controls[i], codec,
-					NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /*
   * _DAPM_ Controls
   */
@@ -1460,7 +1445,8 @@ static int wm8990_init(struct snd_soc_device *socdev)
  	wm8990_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
  	wm8990_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));

-	wm8990_add_controls(codec);
+	snd_soc_add_controls(codec, wm8990_snd_controls,
+				ARRAY_SIZE(wm8990_snd_controls));
  	wm8990_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index af83d62..1b0ace0 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -154,21 +154,6 @@ SOC_SINGLE("Mic 2 Volume", AC97_MIC, 0, 31, 1),
  SOC_SINGLE("Mic 20dB Boost Switch", AC97_MIC, 7, 1, 0),
  };

-/* add non dapm controls */
-static int wm9712_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm9712_snd_ac97_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				  snd_soc_cnew(&wm9712_snd_ac97_controls[i],
-					       codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /* We have to create a fake left and right HP mixers because
   * the codec only has a single control that is shared by both channels.
   * This makes it impossible to determine the audio path.
@@ -698,7 +683,8 @@ static int wm9712_soc_probe(struct platform_device 
*pdev)
  	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);

  	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	wm9712_add_controls(codec);
+	snd_soc_add_controls(codec, wm9712_snd_ac97_controls,
+				ARRAY_SIZE(wm9712_snd_ac97_controls));
  	wm9712_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0) {
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index f3ca8aa..a456226 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -190,21 +190,6 @@ SOC_SINGLE("3D Lower Cut-off Switch", 
AC97_REC_GAIN_MIC, 4, 1, 0),
  SOC_SINGLE("3D Depth", AC97_REC_GAIN_MIC, 0, 15, 1),
  };

-/* add non dapm controls */
-static int wm9713_add_controls(struct snd_soc_codec *codec)
-{
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm9713_snd_ac97_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm9713_snd_ac97_controls[i],
-					codec, NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
  /* We have to create a fake left and right HP mixers because
   * the codec only has a single control that is shared by both channels.
   * This makes it impossible to determine the audio path using the current
@@ -1245,7 +1230,8 @@ static int wm9713_soc_probe(struct platform_device 
*pdev)
  	reg = ac97_read(codec, AC97_CD) & 0x7fff;
  	ac97_write(codec, AC97_CD, reg);

-	wm9713_add_controls(codec);
+	snd_soc_add_controls(codec, wm9713_snd_ac97_controls,
+				ARRAY_SIZE(wm9713_snd_ac97_controls));
  	wm9713_add_widgets(codec);
  	ret = snd_soc_init_card(socdev);
  	if (ret < 0)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6cbe7e8..3167162 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1495,6 +1495,29 @@ struct snd_kcontrol *snd_soc_cnew(const struct 
snd_kcontrol_new *_template,
  EXPORT_SYMBOL_GPL(snd_soc_cnew);

  /**
+ * snd_soc_add_controls - add an array of controls to a codec.
+ * Convienience function to add a list of controls. Many codecs were
+ * duplicating this code.
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_controls(struct snd_soc_codec *codec,
+	const struct snd_kcontrol_new *controls, int num_controls)
+{
+	int err, i;
+
+	for (i = 0; i < num_controls; i++) {
+		err = snd_ctl_add(codec->card,
+			snd_soc_cnew(&controls[i], codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_controls);
+
+/**
   * snd_soc_info_enum_double - enumerated double mixer info callback
   * @kcontrol: mixer control
   * @uinfo: control element information
-- 
1.5.6.5
