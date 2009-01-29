From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Add analog loopback support
Date: Thu, 29 Jan 2009 14:57:50 +0200
Message-ID: <1233233870-22700-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E163103869
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 13:57:57 +0100 (CET)
In-Reply-To: <1233233870-22700-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the analog loopback/bypass support for twl4030 codec.

Details for the implementation:
It seams that the analog loopback needs the DAC powered on on the channel,
where the loopback is selected. The switch for the DACs has been moved from
the DAPM_DAC to the "Analog XX Playback Mixer". In this way the DAC will be
powered while the audio playback is used or/and the loopback is enabled for
the channel.

The twl4030 codec powering has been reworked. Now the codec will be powered as
long as it does not receives the SND_SOC_BIAS_OFF event. The exceptions are
when the given change in the registers needs the codec power down/up cycle in
order to take effect. Otherwise the codec is on.

When the codec enters to STANDBY state and none of the loopback paths are
enabled, than the amplifiers, which are no in the DAPM path are forced to turn
off and the PLL is disabled. When playback/capture starts the disabled gains
are restored and the PLL is enabled.

When one of the loopback enabled in STANDBY mode, the disabled gains are
restored and the PLL is enabled also.

In short: the codec always goes to the lowest power state based on the
bias_level and the bypass_state.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  212 +++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/twl4030.h |   15 +++
 2 files changed, 214 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f985bef..c26854b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -117,6 +117,13 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_MISC_SET_2		(0x49)	*/
 };
 
+/* codec private data */
+struct twl4030_priv {
+	unsigned int bypass_state;
+	unsigned int codec_powered;
+	unsigned int codec_muted;
+};
+
 /*
  * read twl4030 register cache
  */
@@ -156,8 +163,12 @@ static int twl4030_write(struct snd_soc_codec *codec,
 
 static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 {
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 mode;
 
+	if (enable == twl4030->codec_powered)
+		return;
+
 	mode = twl4030_read_reg_cache(codec, TWL4030_REG_CODEC_MODE);
 	if (enable)
 		mode |= TWL4030_CODECPDZ;
@@ -165,6 +176,7 @@ static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 		mode &= ~TWL4030_CODECPDZ;
 
 	twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
+	twl4030->codec_powered = enable;
 
 	/* REVISIT: this delay is present in TI sample drivers */
 	/* but there seems to be no TRM requirement for it     */
@@ -184,11 +196,82 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 }
 
+static void twl4030_codec_mute(struct snd_soc_codec *codec, int mute)
+{
+	struct twl4030_priv *twl4030 = codec->private_data;
+	u8 reg_val;
+
+	if (mute == twl4030->codec_muted)
+		return;
+
+	if (mute) {
+		/* Bypass the reg_cache and mute the volumes
+		 * Headset mute is done in it's own event handler
+		 * Things to mute:  Earpiece, PreDrivL/R, CarkitL/R
+		 */
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_EAR_CTL);
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					reg_val & (~TWL4030_EAR_GAIN),
+					TWL4030_REG_EAR_CTL);
+
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PREDL_CTL);
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					reg_val & (~TWL4030_PREDL_GAIN),
+					TWL4030_REG_PREDL_CTL);
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PREDR_CTL);
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					reg_val & (~TWL4030_PREDR_GAIN),
+					TWL4030_REG_PREDL_CTL);
+
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PRECKL_CTL);
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					reg_val & (~TWL4030_PRECKL_GAIN),
+					TWL4030_REG_PRECKL_CTL);
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PRECKR_CTL);
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					reg_val & (~TWL4030_PRECKL_GAIN),
+					TWL4030_REG_PRECKR_CTL);
+
+		/* Disable PLL */
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
+		reg_val &= ~TWL4030_APLL_EN;
+		twl4030_write(codec, TWL4030_REG_APLL_CTL, reg_val);
+	} else {
+		/* Restore the volumes
+		 * Headset mute is done in it's own event handler
+		 * Things to restore:  Earpiece, PreDrivL/R, CarkitL/R
+		 */
+		twl4030_write(codec, TWL4030_REG_EAR_CTL,
+			twl4030_read_reg_cache(codec, TWL4030_REG_EAR_CTL));
+
+		twl4030_write(codec, TWL4030_REG_PREDL_CTL,
+			twl4030_read_reg_cache(codec, TWL4030_REG_PREDL_CTL));
+		twl4030_write(codec, TWL4030_REG_PREDR_CTL,
+			twl4030_read_reg_cache(codec, TWL4030_REG_PREDR_CTL));
+
+		twl4030_write(codec, TWL4030_REG_PRECKL_CTL,
+			twl4030_read_reg_cache(codec, TWL4030_REG_PRECKL_CTL));
+		twl4030_write(codec, TWL4030_REG_PRECKR_CTL,
+			twl4030_read_reg_cache(codec, TWL4030_REG_PRECKR_CTL));
+
+		/* Enable PLL */
+		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
+		reg_val |= TWL4030_APLL_EN;
+		twl4030_write(codec, TWL4030_REG_APLL_CTL, reg_val);
+	}
+
+	twl4030->codec_muted = mute;
+}
+
 static void twl4030_power_up(struct snd_soc_codec *codec)
 {
+	struct twl4030_priv *twl4030 = codec->private_data;
 	u8 anamicl, regmisc1, byte;
 	int i = 0;
 
+	if (twl4030->codec_powered)
+		return;
+
 	/* set CODECPDZ to turn on codec */
 	twl4030_codec_enable(codec, 1);
 
@@ -220,6 +303,9 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 	twl4030_codec_enable(codec, 1);
 }
 
+/*
+ * Unconditional power down
+ */
 static void twl4030_power_down(struct snd_soc_codec *codec)
 {
 	/* power down */
@@ -402,6 +488,22 @@ static const struct soc_enum twl4030_micpathtx2_enum =
 static const struct snd_kcontrol_new twl4030_dapm_micpathtx2_control =
 SOC_DAPM_ENUM("Route", twl4030_micpathtx2_enum);
 
+/* Analog bypass for AudioR1 */
+static const struct snd_kcontrol_new twl4030_dapm_abypassr1_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXR1_APGA_CTL, 2, 1, 0);
+
+/* Analog bypass for AudioL1 */
+static const struct snd_kcontrol_new twl4030_dapm_abypassl1_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXL1_APGA_CTL, 2, 1, 0);
+
+/* Analog bypass for AudioR2 */
+static const struct snd_kcontrol_new twl4030_dapm_abypassr2_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXR2_APGA_CTL, 2, 1, 0);
+
+/* Analog bypass for AudioL2 */
+static const struct snd_kcontrol_new twl4030_dapm_abypassl2_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXL2_APGA_CTL, 2, 1, 0);
+
 static int micpath_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -497,6 +599,31 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int bypass_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct soc_mixer_control *m =
+		(struct soc_mixer_control *)w->kcontrols->private_value;
+	struct twl4030_priv *twl4030 = w->codec->private_data;
+	unsigned char reg;
+
+	reg = twl4030_read_reg_cache(w->codec, m->reg);
+	if (reg & (1 << m->shift))
+		twl4030->bypass_state |=
+			(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+	else
+		twl4030->bypass_state &=
+			~(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+
+	if (w->codec->bias_level == SND_SOC_BIAS_STANDBY) {
+		if (twl4030->bypass_state)
+			twl4030_codec_mute(w->codec, 0);
+		else
+			twl4030_codec_mute(w->codec, 1);
+	}
+	return 0;
+}
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -775,13 +902,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	/* DACs */
 	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
-			TWL4030_REG_AVDAC_CTL, 0, 0),
+			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
-			TWL4030_REG_AVDAC_CTL, 1, 0),
+			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear Playback",
-			TWL4030_REG_AVDAC_CTL, 2, 0),
+			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear Playback",
-			TWL4030_REG_AVDAC_CTL, 3, 0),
+			SND_SOC_NOPM, 0, 0),
 
 	/* Analog PGAs */
 	SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
@@ -793,6 +920,29 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("ARXL2_APGA", TWL4030_REG_ARXL2_APGA_CTL,
 			0, 0, NULL, 0),
 
+	/* Analog bypasses */
+	SND_SOC_DAPM_SWITCH_E("Right1 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassr1_control, bypass_event,
+			SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Left1 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassl1_control,
+			bypass_event, SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Right2 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassr2_control,
+			bypass_event, SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Left2 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassl2_control,
+			bypass_event, SND_SOC_DAPM_POST_REG),
+
+	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
+			0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Analog L1 Playback Mixer", TWL4030_REG_AVDAC_CTL,
+			1, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Analog R2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
+			2, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
+			3, 0, NULL, 0),
+
 	/* Output MUX controls */
 	/* Earpiece */
 	SND_SOC_DAPM_VALUE_MUX("Earpiece Mux", SND_SOC_NOPM, 0, 0,
@@ -863,13 +1013,19 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 0),
 	SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
 	SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL, 2, 0),
+
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
-	{"ARXL1_APGA", NULL, "DAC Left1"},
-	{"ARXR1_APGA", NULL, "DAC Right1"},
-	{"ARXL2_APGA", NULL, "DAC Left2"},
-	{"ARXR2_APGA", NULL, "DAC Right2"},
+	{"Analog L1 Playback Mixer", NULL, "DAC Left1"},
+	{"Analog R1 Playback Mixer", NULL, "DAC Right1"},
+	{"Analog L2 Playback Mixer", NULL, "DAC Left2"},
+	{"Analog R2 Playback Mixer", NULL, "DAC Right2"},
+
+	{"ARXL1_APGA", NULL, "Analog L1 Playback Mixer"},
+	{"ARXR1_APGA", NULL, "Analog R1 Playback Mixer"},
+	{"ARXL2_APGA", NULL, "Analog L2 Playback Mixer"},
+	{"ARXR2_APGA", NULL, "Analog R2 Playback Mixer"},
 
 	/* Internal playback routings */
 	/* Earpiece */
@@ -951,6 +1107,17 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Virtual Left2", NULL, "TX2 Capture Route"},
 	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},
 
+	/* Analog bypass routes */
+	{"Right1 Analog Loopback", "Switch", "Analog Right Capture Route"},
+	{"Left1 Analog Loopback", "Switch", "Analog Left Capture Route"},
+	{"Right2 Analog Loopback", "Switch", "Analog Right Capture Route"},
+	{"Left2 Analog Loopback", "Switch", "Analog Left Capture Route"},
+
+	{"Analog R1 Playback Mixer", NULL, "Right1 Analog Loopback"},
+	{"Analog L1 Playback Mixer", NULL, "Left1 Analog Loopback"},
+	{"Analog R2 Playback Mixer", NULL, "Right2 Analog Loopback"},
+	{"Analog L2 Playback Mixer", NULL, "Left2 Analog Loopback"},
+
 };
 
 static int twl4030_add_widgets(struct snd_soc_codec *codec)
@@ -967,16 +1134,25 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
+	struct twl4030_priv *twl4030 = codec->private_data;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		twl4030_power_up(codec);
+		twl4030_codec_mute(codec, 0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		/* TODO: develop a twl4030_prepare function */
+		twl4030_power_up(codec);
+		if (twl4030->bypass_state)
+			twl4030_codec_mute(codec, 0);
+		else
+			twl4030_codec_mute(codec, 1);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* TODO: develop a twl4030_standby function */
-		twl4030_power_down(codec);
+		twl4030_power_up(codec);
+		if (twl4030->bypass_state)
+			twl4030_codec_mute(codec, 0);
+		else
+			twl4030_codec_mute(codec, 1);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_power_down(codec);
@@ -996,7 +1172,6 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	u8 mode, old_mode, format, old_format;
 
-
 	/* bit rate */
 	old_mode = twl4030_read_reg_cache(codec,
 			TWL4030_REG_CODEC_MODE) & ~TWL4030_CODECPDZ;
@@ -1038,6 +1213,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 
 	if (mode != old_mode) {
 		/* change rate and set CODECPDZ */
+		twl4030_codec_enable(codec, 0);
 		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
 		twl4030_codec_enable(codec, 1);
 	}
@@ -1258,11 +1434,19 @@ static int twl4030_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec;
+	struct twl4030_priv *twl4030;
 
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
 
+	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
+	if (twl4030 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = twl4030;
 	socdev->card->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -1280,8 +1464,10 @@ static int twl4030_remove(struct platform_device *pdev)
 	struct snd_soc_codec *codec = socdev->card->codec;
 
 	printk(KERN_INFO "TWL4030 Audio Codec remove\n");
+	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
+	kfree(codec->private_data);
 	kfree(codec);
 
 	return 0;
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 442e5a8..33dbb14 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -170,6 +170,9 @@
 #define TWL4030_CLK256FS_EN		0x02
 #define TWL4030_AIF_EN			0x01
 
+/* EAR_CTL (0x21) */
+#define TWL4030_EAR_GAIN		0x30
+
 /* HS_GAIN_SET (0x23) Fields */
 
 #define TWL4030_HSR_GAIN		0x0C
@@ -198,6 +201,18 @@
 #define TWL4030_RAMP_DELAY_2581MS	0x1C
 #define TWL4030_RAMP_EN			0x02
 
+/* PREDL_CTL (0x25) */
+#define TWL4030_PREDL_GAIN		0x30
+
+/* PREDR_CTL (0x26) */
+#define TWL4030_PREDR_GAIN		0x30
+
+/* PRECKL_CTL (0x27) */
+#define TWL4030_PRECKL_GAIN		0x30
+
+/* PRECKR_CTL (0x28) */
+#define TWL4030_PRECKR_GAIN		0x30
+
 /* HFL_CTL (0x29, 0x2A) Fields */
 #define TWL4030_HF_CTL_HB_EN		0x04
 #define TWL4030_HF_CTL_LOOP_EN		0x08
-- 
1.6.1
