From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] ASoC: tlv320aic32x4: Change codec input config options
Date: Tue, 30 Jun 2015 13:25:12 +0300
Message-ID: <2eba5618456e1ee08d9c5eb8b92c879458dbb7ad.1435569929.git.kimmo.saarela@gmail.com>
References: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add more of paramenters for codec initial configuration, similar options
are also added to pdata. Add input level selections to mixer. Now probe
function ties unused input pins to common mode as should, according to
tlv320aic3204 datasheet.

Signed-off-by: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/sound/tlv320aic32x4.h    |   8 ++
 sound/soc/codecs/tlv320aic32x4.c | 199 +++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/tlv320aic32x4.h |  10 ++
 3 files changed, 198 insertions(+), 19 deletions(-)

diff --git a/include/sound/tlv320aic32x4.h b/include/sound/tlv320aic32x4.h
index 24e5d99..43ea355 100644
--- a/include/sound/tlv320aic32x4.h
+++ b/include/sound/tlv320aic32x4.h
@@ -18,13 +18,21 @@
 #define AIC32X4_PWR_AIC32X4_LDO_ENABLE		0x00000004
 #define AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36	0x00000008
 #define AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED	0x00000010
+#define AIC32X4_PWR_AIC32X4_LDO_DVDD_1_77	0x00000020
+#define AIC32X4_PWR_AIC32X4_LDO_AVDD_1_77	0x00000040
+#define AIC32X4_PWR_MICBIAS_OFF			0x00000080
+
+#define AIC32X4_PWR_AIC32X4_MASK		0x000000ff
 
 #define AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K	0x00000001
 #define AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K	0x00000002
+#define AIC32X4_MICPGA_ROUTE_MASK		0x00000003
 
 struct aic32x4_pdata {
 	u32 power_cfg;
 	u32 micpga_routing;
+	u32 inputs[6];
+	u32 cmode[2];
 	bool swapdacs;
 	int rstn_gpio;
 };
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index d3636c1..f75b17f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -70,6 +70,8 @@ struct aic32x4_priv {
 	bool swapdacs;
 	int rstn_gpio;
 	struct clk *mclk;
+	u32 inputs[6];
+	u32 cmode[2];
 
 	struct regulator *supply_ldo;
 	struct regulator *supply_iov;
@@ -85,6 +87,8 @@ static DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
 static DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
 /* -12dB min, 0.5dB steps */
 static DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
+/* -12.0dB min, 6dB steps */
+static DECLARE_TLV_DB_SCALE(tlv_in_mix, -1200, 600, 0);
 
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
@@ -182,15 +186,41 @@ static const struct snd_kcontrol_new lor_output_mixer_controls[] = {
 };
 
 static const struct snd_kcontrol_new left_input_mixer_controls[] = {
-	SOC_DAPM_SINGLE("IN1_L P Switch", AIC32X4_LMICPGAPIN, 6, 1, 0),
-	SOC_DAPM_SINGLE("IN2_L P Switch", AIC32X4_LMICPGAPIN, 4, 1, 0),
-	SOC_DAPM_SINGLE("IN3_L P Switch", AIC32X4_LMICPGAPIN, 2, 1, 0),
+	SOC_DAPM_SINGLE_TLV("IN1_L P Switch", AIC32X4_LMICPGAPIN, 6, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN2_L P Switch", AIC32X4_LMICPGAPIN, 4, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN3_L P Switch", AIC32X4_LMICPGAPIN, 2, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN1_R P Switch", AIC32X4_LMICPGAPIN, 0, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN2_R N Switch", AIC32X4_LMICPGANIN, 4, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN3_R N Switch", AIC32X4_LMICPGANIN, 2, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("CM1_L N Switch", AIC32X4_LMICPGANIN, 6, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("CM2_L N Switch", AIC32X4_LMICPGANIN, 0, 3, 0,
+			    tlv_in_mix),
 };
 
 static const struct snd_kcontrol_new right_input_mixer_controls[] = {
-	SOC_DAPM_SINGLE("IN1_R P Switch", AIC32X4_RMICPGAPIN, 6, 1, 0),
-	SOC_DAPM_SINGLE("IN2_R P Switch", AIC32X4_RMICPGAPIN, 4, 1, 0),
-	SOC_DAPM_SINGLE("IN3_R P Switch", AIC32X4_RMICPGAPIN, 2, 1, 0),
+	SOC_DAPM_SINGLE_TLV("IN1_R P Switch", AIC32X4_RMICPGAPIN, 6, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN2_R P Switch", AIC32X4_RMICPGAPIN, 4, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN3_R P Switch", AIC32X4_RMICPGAPIN, 2, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN2_L P Switch", AIC32X4_RMICPGAPIN, 0, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN1_L N Switch", AIC32X4_RMICPGANIN, 4, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("IN3_L N Switch", AIC32X4_RMICPGANIN, 2, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("CM1_R N Switch", AIC32X4_RMICPGANIN, 6, 3, 0,
+			    tlv_in_mix),
+	SOC_DAPM_SINGLE_TLV("CM2_R N Switch", AIC32X4_RMICPGANIN, 0, 3, 0,
+			    tlv_in_mix),
 };
 
 static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
@@ -234,6 +264,10 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN2_R"),
 	SND_SOC_DAPM_INPUT("IN3_L"),
 	SND_SOC_DAPM_INPUT("IN3_R"),
+	SND_SOC_DAPM_INPUT("CM1_L"),
+	SND_SOC_DAPM_INPUT("CM1_R"),
+	SND_SOC_DAPM_INPUT("CM2_L"),
+	SND_SOC_DAPM_INPUT("CM2_R"),
 };
 
 static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
@@ -265,6 +299,11 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"Left Input Mixer", "IN1_L P Switch", "IN1_L"},
 	{"Left Input Mixer", "IN2_L P Switch", "IN2_L"},
 	{"Left Input Mixer", "IN3_L P Switch", "IN3_L"},
+	{"Left Input Mixer", "IN1_R P Switch", "IN1_R"},
+	{"Left Input Mixer", "IN2_R N Switch", "IN2_R"},
+	{"Left Input Mixer", "IN3_R N Switch", "IN3_R"},
+	{"Left Input Mixer", "CM1_L N Switch", "CM1_L"},
+	{"Left Input Mixer", "CM2_L N Switch", "CM2_L"},
 
 	{"Left ADC", NULL, "Left Input Mixer"},
 
@@ -272,6 +311,11 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"Right Input Mixer", "IN1_R P Switch", "IN1_R"},
 	{"Right Input Mixer", "IN2_R P Switch", "IN2_R"},
 	{"Right Input Mixer", "IN3_R P Switch", "IN3_R"},
+	{"Right Input Mixer", "IN2_L P Switch", "IN2_L"},
+	{"Right Input Mixer", "IN1_L N Switch", "IN1_L"},
+	{"Right Input Mixer", "IN3_L N Switch", "IN3_L"},
+	{"Right Input Mixer", "CM1_R N Switch", "CM1_R"},
+	{"Right Input Mixer", "CM2_R N Switch", "CM2_R"},
 
 	{"Right ADC", NULL, "Right Input Mixer"},
 };
@@ -621,29 +665,49 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 {
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
+	bool micbias_on = 0;
+	int i;
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
 		ndelay(10);
 		gpio_set_value(aic32x4->rstn_gpio, 1);
 	}
 
+	micbias_on = !(aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_OFF);
+
 	snd_soc_write(codec, AIC32X4_RESET, 0x01);
 
 	/* Power platform configuration */
-	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
+	if ((aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) &&
+			micbias_on)
 		snd_soc_write(codec, AIC32X4_MICBIAS, AIC32X4_MICBIAS_LDOIN |
 						      AIC32X4_MICBIAS_2075V);
-	}
+
 	if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE)
 		snd_soc_write(codec, AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE);
 
-	tmp_reg = (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) ?
-			AIC32X4_LDOCTLEN : 0;
+
+	tmp_reg = snd_soc_read(codec, AIC32X4_LDOCTL);
+
+	/* Clear overcurrent status bit from reg */
+	tmp_reg &= ~0x06;
+
+	if (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_ENABLE) {
+		tmp_reg &= ~AIC32X4_ANALOG_DISABLE;
+		tmp_reg |= AIC32X4_LDOCTLEN;
+	}
+	if (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_DVDD_1_77)
+		tmp_reg |= AIC32X4_LDO_DVDD_1_77;
+
+	if (aic32x4->power_cfg & AIC32X4_PWR_AIC32X4_LDO_AVDD_1_77)
+		tmp_reg |= AIC32X4_LDO_AVDD_1_77;
+
 	snd_soc_write(codec, AIC32X4_LDOCTL, tmp_reg);
 
 	tmp_reg = snd_soc_read(codec, AIC32X4_CMMODE);
 	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36)
 		tmp_reg |= AIC32X4_LDOIN_18_36;
+
 	if (aic32x4->power_cfg & AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED)
 		tmp_reg |= AIC32X4_LDOIN2HP;
 	snd_soc_write(codec, AIC32X4_CMMODE, tmp_reg);
@@ -651,16 +715,82 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	/* Mic PGA routing */
 	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K)
 		snd_soc_write(codec, AIC32X4_LMICPGANIN,
-				AIC32X4_LMICPGANIN_IN2R_10K);
-	else
-		snd_soc_write(codec, AIC32X4_LMICPGANIN,
-				AIC32X4_LMICPGANIN_CM1L_10K);
+			      AIC32X4_LMICPGANIN_IN2R_10K);
+
 	if (aic32x4->micpga_routing & AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K)
 		snd_soc_write(codec, AIC32X4_RMICPGANIN,
-				AIC32X4_RMICPGANIN_IN1L_10K);
-	else
-		snd_soc_write(codec, AIC32X4_RMICPGANIN,
-				AIC32X4_RMICPGANIN_CM1R_10K);
+			      AIC32X4_RMICPGANIN_IN1L_10K);
+
+	/* Connect unused inputs weakly to common mode */
+	tmp_reg = 0;
+	for (i = 0; i < ARRAY_SIZE(aic32x4->inputs); i++)
+		tmp_reg |= (aic32x4->inputs[i] == 0) ? (1 << i) : 0;
+
+	snd_soc_write(codec, AIC32X4_FLOATINGINPUT, tmp_reg);
+
+	/* Setup left positive connections register */
+	tmp_reg = 0;
+	if (aic32x4->inputs[0] & 3)
+		tmp_reg |= (aic32x4->inputs[0] & 3) << 6;
+
+	if (aic32x4->inputs[2] & 3)
+		tmp_reg |= (aic32x4->inputs[2] & 3) << 4;
+
+	if (aic32x4->inputs[4] & 3)
+		tmp_reg |= (aic32x4->inputs[4] & 3) << 2;
+
+	if ((aic32x4->inputs[1] >> 4) & 3)
+		tmp_reg |= ((aic32x4->inputs[1] >> 4) & 3);
+
+	snd_soc_write(codec, AIC32X4_LMICPGAPIN, tmp_reg);
+
+	/* Setup left negative connections register */
+	tmp_reg = 0;
+	if (aic32x4->cmode[0] & 3)
+		tmp_reg |= (aic32x4->cmode[0] & 3) << 6;
+
+	if ((aic32x4->inputs[3] >> 4) & 3)
+		tmp_reg |= ((aic32x4->inputs[3] >> 4) & 3) << 4;
+
+	if ((aic32x4->inputs[5] >> 4) & 3)
+		tmp_reg |= ((aic32x4->inputs[5] >> 4) & 3) << 2;
+
+	if (aic32x4->cmode[1] & 3)
+		tmp_reg |= (aic32x4->cmode[1] & 3);
+
+	snd_soc_write(codec, AIC32X4_LMICPGANIN, tmp_reg);
+
+	/* Setup right positive connections register */
+	tmp_reg = 0;
+	if (aic32x4->inputs[1] & 3)
+		tmp_reg |= (aic32x4->inputs[1] & 3) << 6;
+
+	if (aic32x4->inputs[3] & 3)
+		tmp_reg |= (aic32x4->inputs[3] & 3) << 4;
+
+	if (aic32x4->inputs[5] & 3)
+		tmp_reg |= (aic32x4->inputs[5] & 3) << 2;
+
+	if (aic32x4->inputs[2] & 3)
+		tmp_reg |= (aic32x4->inputs[2] & 3);
+
+	snd_soc_write(codec, AIC32X4_RMICPGAPIN, tmp_reg);
+
+	/* Setup right negative connections register */
+	tmp_reg = 0;
+	if ((aic32x4->cmode[0] >> 4) & 3)
+		tmp_reg |= ((aic32x4->cmode[0] >> 4) & 3) << 6;
+
+	if ((aic32x4->inputs[0] >> 4) & 3)
+		tmp_reg |= ((aic32x4->inputs[0] >> 4) & 3) << 4;
+
+	if ((aic32x4->inputs[4] >> 4) & 3)
+		tmp_reg |= ((aic32x4->inputs[4] >> 4) & 3) << 2;
+
+	if ((aic32x4->cmode[1] >> 4) & 3)
+		tmp_reg |= ((aic32x4->cmode[1] >> 4) & 3);
+
+	snd_soc_write(codec, AIC32X4_RMICPGANIN, tmp_reg);
 
 	/*
 	 * Workaround: for an unknown reason, the ADC needs to be powered up
@@ -691,10 +821,41 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
 		struct device_node *np)
 {
-	aic32x4->swapdacs = false;
+	u32 value;
+	u32 inputs[6];
+	u32 cmode[2];
+
 	aic32x4->micpga_routing = 0;
+
 	aic32x4->rstn_gpio = of_get_named_gpio(np, "reset-gpios", 0);
 
+	aic32x4->swapdacs = 0;
+	if (!of_property_read_u32(np, "swapdacs", &value)) {
+		if (value > 0)
+			aic32x4->swapdacs = 1;
+	}
+
+	aic32x4->power_cfg = 0;
+	if (!of_property_read_u32(np, "powercfg", &value)) {
+		value &= AIC32X4_PWR_AIC32X4_MASK;
+		aic32x4->power_cfg = value;
+	}
+
+	if (!of_property_read_u32_array(np, "input-use", inputs, 6)) {
+		memcpy(aic32x4->inputs, inputs,
+			sizeof(aic32x4->inputs));
+	} else {
+		memset(aic32x4->inputs, 0,
+			sizeof(aic32x4->inputs));
+	}
+	if (!of_property_read_u32_array(np, "cmode", cmode, 2)) {
+		memcpy(aic32x4->cmode, cmode,
+			sizeof(aic32x4->cmode));
+	} else {
+		memset(aic32x4->cmode, 0,
+			sizeof(aic32x4->cmode));
+	}
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 995f033..75bb727 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -104,6 +104,9 @@
 
 #define AIC32X4_AVDDWEAKDISABLE		0x08
 #define AIC32X4_LDOCTLEN		0x01
+#define AIC32X4_ANALOG_DISABLE		0x08
+#define AIC32X4_LDO_DVDD_1_77		0x80
+#define AIC32X4_LDO_AVDD_1_77		0x20
 
 #define AIC32X4_LDOIN_18_36		0x01
 #define AIC32X4_LDOIN2HP		0x02
@@ -124,6 +127,13 @@
 #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
 #define AIC32X4_RMICPGANIN_CM1R_10K	0x40
 
+#define AIC32X4_MICPGA_IN1L_NO_FLOAT	0x80
+#define AIC32X4_MICPGA_IN1R_NO_FLOAT	0x40
+#define AIC32X4_MICPGA_IN2L_NO_FLOAT	0x20
+#define AIC32X4_MICPGA_IN2R_NO_FLOAT	0x10
+#define AIC32X4_MICPGA_IN3L_NO_FLOAT	0x08
+#define AIC32X4_MICPGA_IN3R_NO_FLOAT	0x04
+
 #define AIC32X4_LMICPGAVOL_NOGAIN	0x80
 #define AIC32X4_RMICPGAVOL_NOGAIN	0x80
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
