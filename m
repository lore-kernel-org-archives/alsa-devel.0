From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/12] ASoC: SSM2602: Add SSM2604 support
Date: Thu,  5 May 2011 16:59:17 +0200
Message-ID: <1304607560-15083-9-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id D70BC103A15
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:47 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

The SSM2604 is basically a lightweight variant of the SSM2602 with a compatible
register layout. Thus we can easily support both devices by the same driver,
by providing a slightly set of controls, widgets and routes.

Compared to the SSM2602 the SSM2604 has no microphone input and no headphone
output.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |  169 ++++++++++++++++++++++++++++++--------------
 1 files changed, 116 insertions(+), 53 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index c6dc0da..b36bfd1 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -45,12 +45,19 @@
 
 #define SSM2602_VERSION "0.1"
 
+enum ssm2602_type {
+	SSM2602,
+	SSM2604,
+};
+
 /* codec private data */
 struct ssm2602_priv {
 	unsigned int sysclk;
 	enum snd_soc_control_type control_type;
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
+
+	enum ssm2602_type type;
 };
 
 /*
@@ -80,90 +87,97 @@ static const struct soc_enum ssm2602_enum[] = {
 	SOC_ENUM_SINGLE(SSM2602_APDIGI, 1, 4, ssm2602_deemph),
 };
 
-static const struct snd_kcontrol_new ssm2602_snd_controls[] = {
+static const struct snd_kcontrol_new ssm260x_snd_controls[] = {
+SOC_DOUBLE_R("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 31, 0),
+SOC_DOUBLE_R("Capture Switch", SSM2602_LINVOL, SSM2602_RINVOL, 7, 1, 1),
 
+SOC_SINGLE("ADC High Pass Filter Switch", SSM2602_APDIGI, 0, 1, 1),
+SOC_SINGLE("Store DC Offset Switch", SSM2602_APDIGI, 4, 1, 0),
+
+SOC_ENUM("Playback De-emphasis", ssm2602_enum[1]),
+};
+
+static const struct snd_kcontrol_new ssm2602_snd_controls[] = {
 SOC_DOUBLE_R("Master Playback Volume", SSM2602_LOUT1V, SSM2602_ROUT1V,
 	0, 127, 0),
 SOC_DOUBLE_R("Master Playback ZC Switch", SSM2602_LOUT1V, SSM2602_ROUT1V,
 	7, 1, 0),
 
-SOC_DOUBLE_R("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 31, 0),
-SOC_DOUBLE_R("Capture Switch", SSM2602_LINVOL, SSM2602_RINVOL, 7, 1, 1),
+SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
 
 SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
 SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 8, 1, 0),
 SOC_SINGLE("Mic Switch", SSM2602_APANA, 1, 1, 1),
-
-SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
-
-SOC_SINGLE("ADC High Pass Filter Switch", SSM2602_APDIGI, 0, 1, 1),
-SOC_SINGLE("Store DC Offset Switch", SSM2602_APDIGI, 4, 1, 0),
-
-SOC_ENUM("Playback De-emphasis", ssm2602_enum[1]),
 };
 
 /* Output Mixer */
-static const struct snd_kcontrol_new ssm2602_output_mixer_controls[] = {
+static const struct snd_kcontrol_new ssm260x_output_mixer_controls[] = {
 SOC_DAPM_SINGLE("Line Bypass Switch", SSM2602_APANA, 3, 1, 0),
-SOC_DAPM_SINGLE("Mic Sidetone Switch", SSM2602_APANA, 5, 1, 0),
 SOC_DAPM_SINGLE("HiFi Playback Switch", SSM2602_APANA, 4, 1, 0),
+SOC_DAPM_SINGLE("Mic Sidetone Switch", SSM2602_APANA, 5, 1, 0),
 };
 
 /* Input mux */
 static const struct snd_kcontrol_new ssm2602_input_mux_controls =
 SOC_DAPM_ENUM("Input Select", ssm2602_enum[0]);
 
-static const struct snd_soc_dapm_widget ssm2602_dapm_widgets[] = {
-SND_SOC_DAPM_MIXER("Output Mixer", SSM2602_PWR, 4, 1,
-	&ssm2602_output_mixer_controls[0],
-	ARRAY_SIZE(ssm2602_output_mixer_controls)),
+static const struct snd_soc_dapm_widget ssm260x_dapm_widgets[] = {
 SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM2602_PWR, 3, 1),
+SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
+SND_SOC_DAPM_PGA("Line Input", SSM2602_PWR, 0, 1, NULL, 0),
+
 SND_SOC_DAPM_OUTPUT("LOUT"),
-SND_SOC_DAPM_OUTPUT("LHPOUT"),
 SND_SOC_DAPM_OUTPUT("ROUT"),
-SND_SOC_DAPM_OUTPUT("RHPOUT"),
-SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
+SND_SOC_DAPM_INPUT("RLINEIN"),
+SND_SOC_DAPM_INPUT("LLINEIN"),
+};
+
+static const struct snd_soc_dapm_widget ssm2602_dapm_widgets[] = {
+SND_SOC_DAPM_MIXER("Output Mixer", SSM2602_PWR, 4, 1,
+	ssm260x_output_mixer_controls,
+	ARRAY_SIZE(ssm260x_output_mixer_controls)),
+
 SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &ssm2602_input_mux_controls),
-SND_SOC_DAPM_PGA("Line Input", SSM2602_PWR, 0, 1, NULL, 0),
 SND_SOC_DAPM_MICBIAS("Mic Bias", SSM2602_PWR, 1, 1),
+
+SND_SOC_DAPM_OUTPUT("LHPOUT"),
+SND_SOC_DAPM_OUTPUT("RHPOUT"),
 SND_SOC_DAPM_INPUT("MICIN"),
-SND_SOC_DAPM_INPUT("RLINEIN"),
-SND_SOC_DAPM_INPUT("LLINEIN"),
 };
 
-static const struct snd_soc_dapm_route audio_conn[] = {
-	/* output mixer */
+static const struct snd_soc_dapm_widget ssm2604_dapm_widgets[] = {
+SND_SOC_DAPM_MIXER("Output Mixer", SND_SOC_NOPM, 0, 0,
+	ssm260x_output_mixer_controls,
+	ARRAY_SIZE(ssm260x_output_mixer_controls) - 1), /* Last element is the mic */
+};
+
+static const struct snd_soc_dapm_route ssm260x_routes[] = {
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
+
+	{"ROUT", NULL, "Output Mixer"},
+	{"LOUT", NULL, "Output Mixer"},
+
+	{"Line Input", NULL, "LLINEIN"},
+	{"Line Input", NULL, "RLINEIN"},
+};
+
+static const struct snd_soc_dapm_route ssm2602_routes[] = {
 	{"Output Mixer", "Mic Sidetone Switch", "Mic Bias"},
 
-	/* outputs */
 	{"RHPOUT", NULL, "Output Mixer"},
-	{"ROUT", NULL, "Output Mixer"},
 	{"LHPOUT", NULL, "Output Mixer"},
-	{"LOUT", NULL, "Output Mixer"},
 
-	/* input mux */
 	{"Input Mux", "Line", "Line Input"},
 	{"Input Mux", "Mic", "Mic Bias"},
 	{"ADC", NULL, "Input Mux"},
 
-	/* inputs */
-	{"Line Input", NULL, "LLINEIN"},
-	{"Line Input", NULL, "RLINEIN"},
 	{"Mic Bias", NULL, "MICIN"},
 };
 
-static int ssm2602_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, ssm2602_dapm_widgets,
-				  ARRAY_SIZE(ssm2602_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_conn, ARRAY_SIZE(audio_conn));
-
-	return 0;
-}
+static const struct snd_soc_dapm_route ssm2604_routes[] = {
+	{"ADC", NULL, "Line Input"},
+};
 
 struct ssm2602_coeff {
 	u32 mclk;
@@ -492,8 +506,46 @@ static int ssm2602_resume(struct snd_soc_codec *codec)
 
 static int ssm2602_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret, reg;
+
+	reg = snd_soc_read(codec, SSM2602_LOUT1V);
+	snd_soc_write(codec, SSM2602_LOUT1V, reg | LOUT1V_LRHP_BOTH);
+	reg = snd_soc_read(codec, SSM2602_ROUT1V);
+	snd_soc_write(codec, SSM2602_ROUT1V, reg | ROUT1V_RLHP_BOTH);
+
+	ret = snd_soc_add_controls(codec, ssm2602_snd_controls,
+			ARRAY_SIZE(ssm2602_snd_controls));
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, ssm2602_dapm_widgets,
+			ARRAY_SIZE(ssm2602_dapm_widgets));
+	if (ret)
+		return ret;
+
+	return snd_soc_dapm_add_routes(dapm, ssm2602_routes,
+			ARRAY_SIZE(ssm2602_routes));
+}
+
+static int ssm2604_probe(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, ssm2604_dapm_widgets,
+			ARRAY_SIZE(ssm2604_dapm_widgets));
+	if (ret)
+		return ret;
+
+	return snd_soc_dapm_add_routes(dapm, ssm2604_routes,
+			ARRAY_SIZE(ssm2604_routes));
+}
+
+static int ssm260x_probe(struct snd_soc_codec *codec)
+{
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0, reg;
+	int ret, reg;
 
 	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
 
@@ -514,19 +566,20 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SSM2602_LINVOL, reg | LINVOL_LRIN_BOTH);
 	reg = snd_soc_read(codec, SSM2602_RINVOL);
 	snd_soc_write(codec, SSM2602_RINVOL, reg | RINVOL_RLIN_BOTH);
-	reg = snd_soc_read(codec, SSM2602_LOUT1V);
-	snd_soc_write(codec, SSM2602_LOUT1V, reg | LOUT1V_LRHP_BOTH);
-	reg = snd_soc_read(codec, SSM2602_ROUT1V);
-	snd_soc_write(codec, SSM2602_ROUT1V, reg | ROUT1V_RLHP_BOTH);
 	/*select Line in as default input*/
 	snd_soc_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
 			APANA_ENABLE_MIC_BOOST);
 
-	snd_soc_add_controls(codec, ssm2602_snd_controls,
-				ARRAY_SIZE(ssm2602_snd_controls));
-	ssm2602_add_widgets(codec);
+	switch (ssm2602->type) {
+	case SSM2602:
+		ret = ssm2602_probe(codec);
+		break;
+	case SSM2604:
+		ret = ssm2604_probe(codec);
+		break;
+	}
 
-	return 0;
+	return ret;
 }
 
 /* remove everything here */
@@ -537,7 +590,7 @@ static int ssm2602_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
-	.probe =	ssm2602_probe,
+	.probe =	ssm260x_probe,
 	.remove =	ssm2602_remove,
 	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
@@ -545,6 +598,13 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.reg_cache_size = ARRAY_SIZE(ssm2602_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = ssm2602_reg,
+
+	.controls = ssm260x_snd_controls,
+	.num_controls = ARRAY_SIZE(ssm260x_snd_controls),
+	.dapm_widgets = ssm260x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ssm260x_dapm_widgets),
+	.dapm_routes = ssm260x_routes,
+	.num_dapm_routes = ARRAY_SIZE(ssm260x_routes),
 };
 
 #if defined(CONFIG_SPI_MASTER)
@@ -559,6 +619,7 @@ static int __devinit ssm2602_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ssm2602);
 	ssm2602->control_type = SND_SOC_SPI;
+	ssm2602->type = SSM2602;
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
@@ -603,6 +664,7 @@ static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, ssm2602);
 	ssm2602->control_type = SND_SOC_I2C;
+	ssm2602->type = id->driver_data;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
@@ -619,7 +681,8 @@ static int __devexit ssm2602_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ssm2602_i2c_id[] = {
-	{ "ssm2602", 0 },
+	{ "ssm2602", SSM2602 },
+	{ "ssm2604", SSM2604 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
@@ -669,6 +732,6 @@ static void __exit ssm2602_exit(void)
 }
 module_exit(ssm2602_exit);
 
-MODULE_DESCRIPTION("ASoC ssm2602 driver");
+MODULE_DESCRIPTION("ASoC SSM2602/SSM2604 driver");
 MODULE_AUTHOR("Cliff Cai");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5
