From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 1/2] ASoC: TWL4030: Add VDL analog bypass
Date: Thu, 30 Apr 2009 21:47:22 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A59F24733
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 04:47:32 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This patch adds voice downlink analog bypass switch. It follows
the same approach as in other analog bypass switches.
DAC switch is moved from 'DAC Voice' to 'Analog Voice Playback Mixer',
that will also allow voice DAC to be powered in digital voice
loopback (sidetone).

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/codecs/twl4030.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index efa1a80..efb371f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -468,6 +468,10 @@ static const struct snd_kcontrol_new twl4030_dapm_abypassr2_control =
 static const struct snd_kcontrol_new twl4030_dapm_abypassl2_control =
 	SOC_DAPM_SINGLE("Switch", TWL4030_REG_ARXL2_APGA_CTL, 2, 1, 0);
 
+/* Analog bypass for Voice */
+static const struct snd_kcontrol_new twl4030_dapm_abypassv_control =
+	SOC_DAPM_SINGLE("Switch", TWL4030_REG_VDL_APGA_CTL, 2, 1, 0);
+
 /* Digital bypass gain, 0 mutes the bypass */
 static const unsigned int twl4030_dapm_dbypass_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
@@ -585,7 +589,7 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 	struct soc_mixer_control *m =
 		(struct soc_mixer_control *)w->kcontrols->private_value;
 	struct twl4030_priv *twl4030 = w->codec->private_data;
-	unsigned char reg;
+	unsigned char reg, misc;
 
 	reg = twl4030_read_reg_cache(w->codec, m->reg);
 
@@ -597,14 +601,28 @@ static int bypass_event(struct snd_soc_dapm_widget *w,
 		else
 			twl4030->bypass_state &=
 				~(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
+	} else if (m->reg == TWL4030_REG_VDL_APGA_CTL) {
+		/* Analog voice bypass */
+		if (reg & (1 << m->shift))
+			twl4030->bypass_state |= (1 << 4);
+		else
+			twl4030->bypass_state &= ~(1 << 4);
 	} else {
 		/* Digital bypass */
 		if (reg & (0x7 << m->shift))
-			twl4030->bypass_state |= (1 << (m->shift ? 5 : 4));
+			twl4030->bypass_state |= (1 << (m->shift ? 6 : 5));
 		else
-			twl4030->bypass_state &= ~(1 << (m->shift ? 5 : 4));
+			twl4030->bypass_state &= ~(1 << (m->shift ? 6 : 5));
 	}
 
+	/* Enable master analog loopback mode if any analog switch is enabled*/
+	misc = twl4030_read_reg_cache(w->codec, TWL4030_REG_MISC_SET_1);
+	if (twl4030->bypass_state & 0x1F)
+		misc |= TWL4030_FMLOOP_EN;
+	else
+		misc &= ~TWL4030_FMLOOP_EN;
+	twl4030_write(w->codec, TWL4030_REG_MISC_SET_1, misc);
+
 	if (w->codec->bias_level == SND_SOC_BIAS_STANDBY) {
 		if (twl4030->bypass_state)
 			twl4030_codec_mute(w->codec, 0);
@@ -935,7 +953,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear Playback",
 			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Voice", "Voice Playback",
-			TWL4030_REG_AVDAC_CTL, 4, 0),
+			SND_SOC_NOPM, 0, 0),
 
 	/* Analog PGAs */
 	SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
@@ -962,6 +980,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH_E("Left2 Analog Loopback", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_abypassl2_control,
 			bypass_event, SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("Voice Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassv_control,
+			bypass_event, SND_SOC_DAPM_POST_REG),
 
 	/* Digital bypasses */
 	SND_SOC_DAPM_SWITCH_E("Left Digital Loopback", SND_SOC_NOPM, 0, 0,
@@ -979,6 +1000,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			2, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
 			3, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("Analog Voice Playback Mixer", TWL4030_REG_AVDAC_CTL,
+			4, 0, NULL, 0),
 
 	/* Output MIXER controls */
 	/* Earpiece */
@@ -1067,13 +1090,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Analog R1 Playback Mixer", NULL, "DAC Right1"},
 	{"Analog L2 Playback Mixer", NULL, "DAC Left2"},
 	{"Analog R2 Playback Mixer", NULL, "DAC Right2"},
+	{"Analog Voice Playback Mixer", NULL, "DAC Voice"},
 
 	{"ARXL1_APGA", NULL, "Analog L1 Playback Mixer"},
 	{"ARXR1_APGA", NULL, "Analog R1 Playback Mixer"},
 	{"ARXL2_APGA", NULL, "Analog L2 Playback Mixer"},
 	{"ARXR2_APGA", NULL, "Analog R2 Playback Mixer"},
-
-	{"VDL_APGA", NULL, "DAC Voice"},
+	{"VDL_APGA", NULL, "Analog Voice Playback Mixer"},
 
 	/* Internal playback routings */
 	/* Earpiece */
@@ -1169,11 +1192,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left1 Analog Loopback", "Switch", "Analog Left Capture Route"},
 	{"Right2 Analog Loopback", "Switch", "Analog Right Capture Route"},
 	{"Left2 Analog Loopback", "Switch", "Analog Left Capture Route"},
+	{"Voice Analog Loopback", "Switch", "Analog Left Capture Route"},
 
 	{"Analog R1 Playback Mixer", NULL, "Right1 Analog Loopback"},
 	{"Analog L1 Playback Mixer", NULL, "Left1 Analog Loopback"},
 	{"Analog R2 Playback Mixer", NULL, "Right2 Analog Loopback"},
 	{"Analog L2 Playback Mixer", NULL, "Left2 Analog Loopback"},
+	{"Analog Voice Playback Mixer", NULL, "Voice Analog Loopback"},
 
 	/* Digital bypass routes */
 	{"Right Digital Loopback", "Volume", "TX1 Capture Route"},
-- 
1.5.4.3
