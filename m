From: Randolph Chung <rchung42@gmail.com>
Subject: [PATCH v2] Add support for tlv320aic3007 to
	tlv320aic3x codec.
Date: Fri, 20 Aug 2010 12:47:53 +0800
Message-ID: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 383A01038BB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 06:49:31 +0200 (CEST)
Received: by pxi14 with SMTP id 14so1280421pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 21:49:29 -0700 (PDT)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds support for the tlv320aic3007 codec to the tlv320aic3x
driver.

The tlv320aic3007 is similar to the aic31, but has an additional class-D
speaker amp. The speaker amp control register overlaps with the mono
output register of other codecs in this family, so we add logic to
identify the actual codec being registered to set things up accordingly.

Signed-off-by: Randolph Chung <tausq@parisc-linux.org>
---
 sound/soc/codecs/tlv320aic3x.c |   79 +++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/tlv320aic3x.h |    2 +
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 867bf1f..c074657 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -12,11 +12,11 @@
  *
  * Notes:
  *  The AIC3X is a driver for a low power stereo audio
- *  codecs aic31, aic32, aic33.
+ *  codecs aic31, aic32, aic33, aic3007.
  *
  *  It supports full aic33 codec functionality.
- *  The compatibility with aic32, aic31 is as follows:
- *        aic32        |        aic31
+ *  The compatibility with aic32, aic31 and aic3007 is as follows:
+ *    aic32/aic3007    |        aic31
  *  ---------------------------------------
  *   MONO_LOUT -> N/A  |  MONO_LOUT -> N/A
  *                     |  IN1L -> LINE1L
@@ -70,6 +70,10 @@ struct aic3x_priv {
 	unsigned int sysclk;
 	int master;
 	int gpio_reset;
+#define AIC3X_MODEL_3X 0
+#define AIC3X_MODEL_33 1
+#define AIC3X_MODEL_3007 2
+	u16 model;
 };
 
 /*
@@ -361,6 +365,14 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
 };
 
+/*
+ * Class-D amplifier gain. From 0 to 18 dB in 6 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(classd_amp_tlv, 0, 600, 0);
+
+static const struct snd_kcontrol_new aic3x_classd_amp_gain_ctrl =
+	SOC_DOUBLE_TLV("Class-D Amplifier Gain", CLASSD_CTRL, 6, 4, 3, 0, classd_amp_tlv);
+
 /* Left DAC Mux */
 static const struct snd_kcontrol_new aic3x_left_dac_mux_controls =
 SOC_DAPM_ENUM("Route", aic3x_enum[LDAC_ENUM]);
@@ -589,6 +601,15 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINE2R"),
 };
 
+static const struct snd_soc_dapm_widget aic3007_dapm_widgets[] = {
+	/* Class-D outputs */
+	SND_SOC_DAPM_PGA("Left Class-D Out", CLASSD_CTRL, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Class-D Out", CLASSD_CTRL, 2, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("SPOP"),
+	SND_SOC_DAPM_OUTPUT("SPOM"),
+};
+
 static const struct snd_soc_dapm_route intercon[] = {
 	/* Left Output */
 	{"Left DAC Mux", "DAC_L1", "Left DAC"},
@@ -759,14 +780,30 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
 };
 
+static const struct snd_soc_dapm_route intercon_3007[] = {
+	/* Class-D outputs */
+	{"Left Class-D Out", NULL, "Left Line Out"},
+	{"Right Class-D Out", NULL, "Left Line Out"},
+	{"SPOP", NULL, "Left Class-D Out"},
+	{"SPOM", NULL, "Right Class-D Out"},
+};
+
 static int aic3x_add_widgets(struct snd_soc_codec *codec)
 {
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+
 	snd_soc_dapm_new_controls(codec, aic3x_dapm_widgets,
 				  ARRAY_SIZE(aic3x_dapm_widgets));
 
 	/* set up audio path interconnects */
 	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
 
+	if (aic3x->model == AIC3X_MODEL_3007) {
+		snd_soc_dapm_new_controls(codec, aic3007_dapm_widgets,
+			ARRAY_SIZE(aic3007_dapm_widgets));
+		snd_soc_dapm_add_routes(codec, intercon_3007, ARRAY_SIZE(intercon_3007));
+	}
+
 	return 0;
 }
 
@@ -1151,6 +1188,7 @@ static int aic3x_resume(struct snd_soc_codec *codec)
  */
 static int aic3x_init(struct snd_soc_codec *codec)
 {
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int reg;
 
 	aic3x_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
@@ -1219,6 +1257,17 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	aic3x_write(codec, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
 	aic3x_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
+	if (aic3x->model == AIC3X_MODEL_3007) {
+		/* Class-D speaker driver init; datasheet p. 46 */
+		aic3x_write(codec, AIC3X_PAGE_SELECT, 0x0D);
+		aic3x_write(codec, 0xD, 0x0D);
+		aic3x_write(codec, 0x8, 0x5C);
+		aic3x_write(codec, 0x8, 0x5D);
+		aic3x_write(codec, 0x8, 0x5C);
+		aic3x_write(codec, AIC3X_PAGE_SELECT, 0x00);
+		aic3x_write(codec, CLASSD_CTRL, 0);
+	}
+
 	/* off, with power on */
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1244,6 +1293,8 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, aic3x_snd_controls,
 			     ARRAY_SIZE(aic3x_snd_controls));
+	if (aic3x->model == AIC3X_MODEL_3007)
+		snd_soc_add_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
 
 	aic3x_add_widgets(codec);
 
@@ -1275,6 +1326,14 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
  * 0x18, 0x19, 0x1A, 0x1B
  */
 
+static const struct i2c_device_id aic3x_i2c_id[] = {
+	[AIC3X_MODEL_3X] = { "tlv320aic3x", 0 },
+	[AIC3X_MODEL_33] = { "tlv320aic33", 0 },
+	[AIC3X_MODEL_3007] = { "tlv320aic3007", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
+
 /*
  * If the i2c layer weren't so broken, we could pass this kind of data
  * around
@@ -1286,6 +1345,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	struct aic3x_setup_data *setup = pdata->setup;
 	struct aic3x_priv *aic3x;
 	int ret, i;
+	const struct i2c_device_id *tbl;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
@@ -1306,6 +1366,12 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		gpio_direction_output(aic3x->gpio_reset, 0);
 	}
 
+	for (tbl = aic3x_i2c_id; tbl->name[0]; tbl++) {
+		if (!strcmp(tbl->name, id->name))
+			break;
+	}
+	aic3x->model = tbl - aic3x_i2c_id;
+
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
 
@@ -1360,13 +1426,6 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id aic3x_i2c_id[] = {
-	{ "tlv320aic3x", 0 },
-	{ "tlv320aic33", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
-
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index f6e3d9b..98e4439 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -111,6 +111,8 @@
 #define DACL1_2_MONOLOPM_VOL		75
 #define DACR1_2_MONOLOPM_VOL		78
 #define MONOLOPM_CTRL			79
+/* Class-D speaker driver on tlv320aic3007 */
+#define CLASSD_CTRL			73
 /* Line Output Plus/Minus control registers */
 #define LINE2L_2_LLOPM_VOL		80
 #define LINE2L_2_RLOPM_VOL		87
-- 
1.6.2.5
