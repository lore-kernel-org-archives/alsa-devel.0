From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 6/6] ASoC: TWL4030: Add analog loopback support
Date: Tue, 27 Jan 2009 11:29:44 +0200
Message-ID: <1233048584-29662-7-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-5-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B4EB10382C
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:10 +0100 (CET)
In-Reply-To: <1233048584-29662-6-git-send-email-peter.ujfalusi@nokia.com>
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

After the loopback registers are changed, the event callback will update the
bypass bitfield, so we will know if any of the bypass paths are
enabled. If the codec is in STANDBY mode, the decision is made to keep/switch
the codec off or keep/switch the codec on to allow the bypass.
Also after the codec switches from ON to STANDBY the same check will be done.

In short: if none of the loopbacks are enabled, the codec behaves in the
same way as it used to. If the loopback is enabled the codec will be kept powered
as long as the bypass is enabled.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  132 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8c77271..7fdc959 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -117,6 +117,12 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_MISC_SET_2		(0x49)	*/
 };
 
+/* codec private data */
+struct twl4030_priv {
+	unsigned int bypass_state;
+	unsigned int codec_powered;
+};
+
 /*
  * read twl4030 register cache
  */
@@ -156,8 +162,13 @@ static int twl4030_write(struct snd_soc_codec *codec,
 
 static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 {
+	struct twl4030_priv *twl4030 =
+		(struct twl4030_priv *)codec->private_data;
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
@@ -186,9 +198,14 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
 {
+	struct twl4030_priv *twl4030 =
+		(struct twl4030_priv *)codec->private_data;
 	u8 anamicl, regmisc1, byte;
 	int i = 0;
 
+	if (twl4030->codec_powered)
+		return;
+
 	/* set CODECPDZ to turn on codec */
 	twl4030_codec_enable(codec, 1);
 
@@ -222,8 +239,15 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 
 static void twl4030_power_down(struct snd_soc_codec *codec)
 {
-	/* power down */
-	twl4030_codec_enable(codec, 0);
+	struct twl4030_priv *twl4030 =
+		(struct twl4030_priv *)codec->private_data;
+
+	if (twl4030->bypass_state)
+		/* Power up, or leave the power on */
+		twl4030_power_up(codec);
+	else
+		/* power down */
+		twl4030_codec_enable(codec, 0);
 }
 
 /* Earpiece */
@@ -402,6 +426,22 @@ static const struct soc_enum twl4030_micpathtx2_enum =
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
@@ -497,6 +537,29 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int bypass_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct soc_mixer_control *m =
+		(struct soc_mixer_control *)w->kcontrols->private_value;
+	struct twl4030_priv *twl4030 =
+		(struct twl4030_priv *)w->codec->private_data;
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
+	if (w->codec->bias_level == SND_SOC_BIAS_STANDBY)
+		twl4030_power_down(w->codec);
+
+	return 0;
+}
+
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -775,13 +838,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
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
@@ -793,6 +856,29 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
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
@@ -866,10 +952,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
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
@@ -951,6 +1042,17 @@ static const struct snd_soc_dapm_route intercon[] = {
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
@@ -1038,6 +1140,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 
 	if (mode != old_mode) {
 		/* change rate and set CODECPDZ */
+		twl4030_codec_enable(codec, 0);
 		twl4030_write(codec, TWL4030_REG_CODEC_MODE, mode);
 		twl4030_codec_enable(codec, 1);
 	}
@@ -1258,11 +1361,19 @@ static int twl4030_probe(struct platform_device *pdev)
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
 	socdev->codec = codec;
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -1282,6 +1393,7 @@ static int twl4030_remove(struct platform_device *pdev)
 	printk(KERN_INFO "TWL4030 Audio Codec remove\n");
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
+	kfree(codec->private_data);
 	kfree(codec);
 
 	return 0;
-- 
1.6.1
