From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 8/8] ASoC: AD183x: add support for more
	multiple parts
Date: Tue, 14 Jun 2011 17:34:28 -0400
Message-ID: <1308087268-11464-8-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D16F243F2
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:09 +0200 (CEST)
In-Reply-To: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Scott Jiang <scott.jiang@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

This extends the AD1836 codec driver to also support the parts:
	- AD1835A
	- AD1837A
	- AD1838A
	- AD1839A

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad183x.c |  217 ++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/ad183x.h |    7 ++-
 2 files changed, 199 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/ad183x.c b/sound/soc/codecs/ad183x.c
index 21567ce..5a13599 100644
--- a/sound/soc/codecs/ad183x.c
+++ b/sound/soc/codecs/ad183x.c
@@ -1,5 +1,6 @@
 /*
- * Audio Codec driver supporting AD1836
+ * Audio Codec driver supporting:
+ *  AD1835A, AD1836, AD1837A, AD1838A, AD1839A
  *
  * Copyright 2009-2011 Analog Devices Inc.
  *
@@ -21,9 +22,19 @@
 #include "ad183x.h"
 
 /* codec private data */
+struct ad183x_chl_ctrls {
+	const struct snd_kcontrol_new *snd_ctrls;
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	const struct snd_soc_dapm_route *audio_paths;
+	int ctrl_num;
+	int widget_num;
+	int path_num;
+	int play_max, capt_max;
+};
+
 struct ad183x_priv {
 	enum snd_soc_control_type control_type;
-	void *control_data;
+	const struct ad183x_chl_ctrls *chl_ctrl;
 };
 
 /*
@@ -34,7 +45,76 @@ static const char *ad183x_deemp[] = {"None", "44.1kHz", "32kHz", "48kHz"};
 static const struct soc_enum ad183x_deemp_enum =
 	SOC_ENUM_SINGLE(AD183X_DAC_CTRL1, 8, 4, ad183x_deemp);
 
-static const struct snd_kcontrol_new ad183x_snd_controls[] = {
+/* AD1835A/AD1837A: 4 stereo DAC, 1 stereo ADC; */
+static const struct snd_kcontrol_new ad1835a_ad1837a_snd_controls[] = {
+	/* DAC volume control */
+	SOC_DOUBLE_R("DAC1 Volume", AD183X_DAC_L1_VOL,
+			AD183X_DAC_R1_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC2 Volume", AD183X_DAC_L2_VOL,
+			AD183X_DAC_R2_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC3 Volume", AD183X_DAC_L3_VOL,
+			AD183X_DAC_R3_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC4 Volume", AD183X_DAC_L4_VOL,
+			AD183X_DAC_R4_VOL, 0, 0x3FF, 0),
+
+	/* ADC switch control */
+	SOC_DOUBLE("ADC1 Switch", AD183X_ADC_CTRL2, AD183X_ADCL1_MUTE,
+			AD183X_ADCR1_MUTE, 1, 1),
+
+	/* DAC switch control */
+	SOC_DOUBLE("DAC1 Switch", AD183X_DAC_CTRL2, AD183X_DACL1_MUTE,
+			AD183X_DACR1_MUTE, 1, 1),
+	SOC_DOUBLE("DAC2 Switch", AD183X_DAC_CTRL2, AD183X_DACL2_MUTE,
+			AD183X_DACR2_MUTE, 1, 1),
+	SOC_DOUBLE("DAC3 Switch", AD183X_DAC_CTRL2, AD183X_DACL3_MUTE,
+			AD183X_DACR3_MUTE, 1, 1),
+	SOC_DOUBLE("DAC4 Switch", AD183X_DAC_CTRL2, AD183X_DACL4_MUTE,
+			AD183X_DACR4_MUTE, 1, 1),
+
+	/* ADC high-pass filter */
+	SOC_SINGLE("ADC High Pass Filter Switch", AD183X_ADC_CTRL1,
+			AD183X_ADC_HIGHPASS_FILTER, 1, 0),
+
+	/* DAC de-emphasis */
+	SOC_ENUM("Playback Deemphasis", ad183x_deemp_enum),
+};
+
+static const struct snd_soc_dapm_widget ad1835a_ad1837a_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", AD183X_DAC_CTRL1,
+			AD183X_DAC_POWERDOWN, 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD183X_ADC_CTRL1,
+			AD183X_ADC_POWERDOWN, 1, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC4OUT"),
+	SND_SOC_DAPM_INPUT("ADC1IN"),
+};
+
+static const struct snd_soc_dapm_route ad1835a_ad1837a_audio_paths[] = {
+	{ "DAC", NULL, "ADC_PWR" },
+	{ "ADC", NULL, "ADC_PWR" },
+	{ "DAC1OUT", "DAC1 Switch", "DAC" },
+	{ "DAC2OUT", "DAC2 Switch", "DAC" },
+	{ "DAC3OUT", "DAC3 Switch", "DAC" },
+	{ "DAC3OUT", "DAC4 Switch", "DAC" },
+	{ "ADC", "ADC1 Switch", "ADC1IN" },
+};
+
+static const struct ad183x_chl_ctrls ad1835a_ad1837a_chl_ctrls = {
+	.snd_ctrls    = ad1835a_ad1837a_snd_controls,
+	.dapm_widgets = ad1835a_ad1837a_dapm_widgets,
+	.audio_paths  = ad1835a_ad1837a_audio_paths,
+	.ctrl_num     = ARRAY_SIZE(ad1835a_ad1837a_snd_controls),
+	.widget_num   = ARRAY_SIZE(ad1835a_ad1837a_dapm_widgets),
+	.path_num     = ARRAY_SIZE(ad1835a_ad1837a_audio_paths),
+	.play_max     = 8,
+	.capt_max     = 2,
+};
+
+/* AD1836: 3 stereo DAC, 2 stereo ADC; */
+static const struct snd_kcontrol_new ad1836_snd_controls[] = {
 	/* DAC volume control */
 	SOC_DOUBLE_R("DAC1 Volume", AD183X_DAC_L1_VOL,
 			AD183X_DAC_R1_VOL, 0, 0x3FF, 0),
@@ -45,17 +125,17 @@ static const struct snd_kcontrol_new ad183x_snd_controls[] = {
 
 	/* ADC switch control */
 	SOC_DOUBLE("ADC1 Switch", AD183X_ADC_CTRL2, AD183X_ADCL1_MUTE,
-		AD183X_ADCR1_MUTE, 1, 1),
+			AD183X_ADCR1_MUTE, 1, 1),
 	SOC_DOUBLE("ADC2 Switch", AD183X_ADC_CTRL2, AD183X_ADCL2_MUTE,
-		AD183X_ADCR2_MUTE, 1, 1),
+			AD183X_ADCR2_MUTE, 1, 1),
 
 	/* DAC switch control */
 	SOC_DOUBLE("DAC1 Switch", AD183X_DAC_CTRL2, AD183X_DACL1_MUTE,
-		AD183X_DACR1_MUTE, 1, 1),
+			AD183X_DACR1_MUTE, 1, 1),
 	SOC_DOUBLE("DAC2 Switch", AD183X_DAC_CTRL2, AD183X_DACL2_MUTE,
-		AD183X_DACR2_MUTE, 1, 1),
+			AD183X_DACR2_MUTE, 1, 1),
 	SOC_DOUBLE("DAC3 Switch", AD183X_DAC_CTRL2, AD183X_DACL3_MUTE,
-		AD183X_DACR3_MUTE, 1, 1),
+			AD183X_DACR3_MUTE, 1, 1),
 
 	/* ADC high-pass filter */
 	SOC_SINGLE("ADC High Pass Filter Switch", AD183X_ADC_CTRL1,
@@ -65,12 +145,12 @@ static const struct snd_kcontrol_new ad183x_snd_controls[] = {
 	SOC_ENUM("Playback Deemphasis", ad183x_deemp_enum),
 };
 
-static const struct snd_soc_dapm_widget ad183x_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget ad1836_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", "Playback", AD183X_DAC_CTRL1,
-				AD183X_DAC_POWERDOWN, 1),
+			AD183X_DAC_POWERDOWN, 1),
 	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD183X_ADC_CTRL1,
-				AD183X_ADC_POWERDOWN, 1, NULL, 0),
+			AD183X_ADC_POWERDOWN, 1, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
@@ -78,7 +158,7 @@ static const struct snd_soc_dapm_widget ad183x_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
 
-static const struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route ad1836_audio_paths[] = {
 	{ "DAC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC_PWR" },
 	{ "DAC1OUT", "DAC1 Switch", "DAC" },
@@ -88,6 +168,79 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "ADC", "ADC2 Switch", "ADC2IN" },
 };
 
+static const struct ad183x_chl_ctrls ad1836_chl_ctrls = {
+	.snd_ctrls    = ad1836_snd_controls,
+	.dapm_widgets = ad1836_dapm_widgets,
+	.audio_paths  = ad1836_audio_paths,
+	.ctrl_num     = ARRAY_SIZE(ad1836_snd_controls),
+	.widget_num   = ARRAY_SIZE(ad1836_dapm_widgets),
+	.path_num     = ARRAY_SIZE(ad1836_audio_paths),
+	.play_max     = 6,
+	.capt_max     = 4,
+};
+
+/* AD1838A/AD1939A: 3 stereo DAC, 1 stereo ADC; */
+static const struct snd_kcontrol_new ad1838a_ad1839a_snd_controls[] = {
+	/* DAC volume control */
+	SOC_DOUBLE_R("DAC1 Volume", AD183X_DAC_L1_VOL,
+			AD183X_DAC_R1_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC2 Volume", AD183X_DAC_L2_VOL,
+			AD183X_DAC_R2_VOL, 0, 0x3FF, 0),
+	SOC_DOUBLE_R("DAC3 Volume", AD183X_DAC_L3_VOL,
+			AD183X_DAC_R3_VOL, 0, 0x3FF, 0),
+
+	/* ADC switch control */
+	SOC_DOUBLE("ADC1 Switch", AD183X_ADC_CTRL2, AD183X_ADCL1_MUTE,
+			AD183X_ADCR1_MUTE, 1, 1),
+
+	/* DAC switch control */
+	SOC_DOUBLE("DAC1 Switch", AD183X_DAC_CTRL2, AD183X_DACL1_MUTE,
+			AD183X_DACR1_MUTE, 1, 1),
+	SOC_DOUBLE("DAC2 Switch", AD183X_DAC_CTRL2, AD183X_DACL2_MUTE,
+			AD183X_DACR2_MUTE, 1, 1),
+	SOC_DOUBLE("DAC3 Switch", AD183X_DAC_CTRL2, AD183X_DACL3_MUTE,
+			AD183X_DACR3_MUTE, 1, 1),
+
+	/* ADC high-pass filter */
+	SOC_SINGLE("ADC High Pass Filter Switch", AD183X_ADC_CTRL1,
+			AD183X_ADC_HIGHPASS_FILTER, 1, 0),
+
+	/* DAC de-emphasis */
+	SOC_ENUM("Playback Deemphasis", ad183x_deemp_enum),
+};
+
+static const struct snd_soc_dapm_widget ad1838a_ad1839a_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", AD183X_DAC_CTRL1,
+			AD183X_DAC_POWERDOWN, 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD183X_ADC_CTRL1,
+			AD183X_ADC_POWERDOWN, 1, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
+	SND_SOC_DAPM_OUTPUT("DAC3OUT"),
+	SND_SOC_DAPM_INPUT("ADC1IN"),
+};
+
+static const struct snd_soc_dapm_route ad1838a_ad1839a_audio_paths[] = {
+	{ "DAC", NULL, "ADC_PWR" },
+	{ "ADC", NULL, "ADC_PWR" },
+	{ "DAC1OUT", "DAC1 Switch", "DAC" },
+	{ "DAC2OUT", "DAC2 Switch", "DAC" },
+	{ "DAC3OUT", "DAC3 Switch", "DAC" },
+	{ "ADC", "ADC1 Switch", "ADC1IN" },
+};
+
+static const struct ad183x_chl_ctrls ad1838a_ad1839a_chl_ctrls = {
+	.snd_ctrls    = ad1838a_ad1839a_snd_controls,
+	.dapm_widgets = ad1838a_ad1839a_dapm_widgets,
+	.audio_paths  = ad1838a_ad1839a_audio_paths,
+	.ctrl_num     = ARRAY_SIZE(ad1838a_ad1839a_snd_controls),
+	.widget_num   = ARRAY_SIZE(ad1838a_ad1839a_dapm_widgets),
+	.path_num     = ARRAY_SIZE(ad1838a_ad1839a_audio_paths),
+	.play_max     = 6,
+	.capt_max     = 2,
+};
+
 /*
  * DAI ops entries
  */
@@ -208,24 +361,22 @@ static int ad183x_resume(struct snd_soc_codec *codec)
 static int ad183x_probe(struct snd_soc_codec *codec)
 {
 	struct ad183x_priv *ad183x = snd_soc_codec_get_drvdata(codec);
+	const struct ad183x_chl_ctrls *chl_ctrl;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret = 0;
+	int ret;
 
-	codec->control_data = ad183x->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 4, 12, ad183x->control_type);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to set cache I/O: %d\n",
-				ret);
+		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
-	snd_soc_add_controls(codec, ad183x_snd_controls,
-			     ARRAY_SIZE(ad183x_snd_controls));
-	snd_soc_dapm_new_controls(dapm, ad183x_dapm_widgets,
-				  ARRAY_SIZE(ad183x_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
+	chl_ctrl = ad183x->chl_ctrl;
+	snd_soc_add_controls(codec, chl_ctrl->snd_ctrls, chl_ctrl->ctrl_num);
+	snd_soc_dapm_new_controls(dapm, chl_ctrl->dapm_widgets, chl_ctrl->widget_num);
+	snd_soc_dapm_add_routes(dapm, chl_ctrl->audio_paths, chl_ctrl->path_num);
 
-	return ret;
+	return 0;
 }
 
 /* power down chip */
@@ -251,19 +402,37 @@ static int __devinit ad183x_spi_probe(struct spi_device *spi)
 {
 	struct ad183x_priv *ad183x;
 	int ret;
+	const char *chip_name = spi->dev.platform_data;
+
+	if (!chip_name)
+		return -ENODEV;
 
 	ad183x = kzalloc(sizeof(struct ad183x_priv), GFP_KERNEL);
 	if (ad183x == NULL)
 		return -ENOMEM;
 
+	if (!strcmp(chip_name, "ad1835a") || !strcmp(chip_name, "ad1837a"))
+		ad183x->chl_ctrl = &ad1835a_ad1837a_chl_ctrls;
+	else if (!strcmp(chip_name, "ad1838a") || !strcmp(chip_name, "ad1839a"))
+		ad183x->chl_ctrl = &ad1838a_ad1839a_chl_ctrls;
+	else if (!strcmp(chip_name, "ad1836"))
+		ad183x->chl_ctrl = &ad1836_chl_ctrls;
+	else {
+		dev_err(&spi->dev, "unsupported chip type: %s\n", chip_name);
+		return -EINVAL;
+	}
+
+	ad183x_dai.playback.channels_max = ad183x->chl_ctrl->play_max;
+	ad183x_dai.capture.channels_max = ad183x->chl_ctrl->capt_max;
+
 	spi_set_drvdata(spi, ad183x);
-	ad183x->control_data = spi;
 	ad183x->control_type = SND_SOC_SPI;
 
 	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_ad183x, &ad183x_dai, 1);
+		&soc_codec_dev_ad183x, &ad183x_dai, 1);
 	if (ret < 0)
 		kfree(ad183x);
+
 	return ret;
 }
 
diff --git a/sound/soc/codecs/ad183x.h b/sound/soc/codecs/ad183x.h
index b8f7289..7591dc1 100644
--- a/sound/soc/codecs/ad183x.h
+++ b/sound/soc/codecs/ad183x.h
@@ -1,5 +1,6 @@
 /*
- * Audio Codec driver supporting AD1836
+ * Audio Codec driver supporting:
+ *  AD1835A, AD1836, AD1837A, AD1838A, AD1839A
  *
  * Copyright 2009-2011 Analog Devices Inc.
  *
@@ -24,6 +25,8 @@
 #define AD183X_DACR2_MUTE              3
 #define AD183X_DACL3_MUTE              4
 #define AD183X_DACR3_MUTE              5
+#define AD183X_DACL4_MUTE              6
+#define AD183X_DACR4_MUTE              7
 
 #define AD183X_DAC_L1_VOL              2
 #define AD183X_DAC_R1_VOL              3
@@ -31,6 +34,8 @@
 #define AD183X_DAC_R2_VOL              5
 #define AD183X_DAC_L3_VOL              6
 #define AD183X_DAC_R3_VOL              7
+#define AD183X_DAC_L4_VOL              8
+#define AD183X_DAC_R4_VOL              9
 
 #define AD183X_ADC_CTRL1               12
 #define AD183X_ADC_POWERDOWN           7
-- 
1.7.5.3
