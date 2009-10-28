From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: TWL4030: Remove bypass tracking
Date: Wed, 28 Oct 2009 10:57:04 +0200
Message-ID: <1256720225-6853-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 584F8244FA
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 09:57:18 +0100 (CET)
In-Reply-To: <1256720225-6853-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Since ASoC core now handling the codec bias differently
there is no need to do the tracking of bypass switch states
anymore.

Handling of the common bit for analog loopbacks is done with
DAPM_SUPPLY for the bypass paths.

Now this bit is only enabled when there is a complete analog
bypass path, compared to the previous implementation, when the
global switch was enabled if there were any of the analog
bypass switch was on (regardless if there were complete path or
not)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  128 ++++++++++---------------------------------
 1 files changed, 30 insertions(+), 98 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 5c5a4c0..2400226 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -122,7 +122,6 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 struct twl4030_priv {
 	struct snd_soc_codec codec;
 
-	unsigned int bypass_state;
 	unsigned int codec_powered;
 	unsigned int codec_muted;
 
@@ -725,67 +724,6 @@ static int headsetrpga_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int bypass_event(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kcontrol, int event)
-{
-	struct soc_mixer_control *m =
-		(struct soc_mixer_control *)w->kcontrols->private_value;
-	struct twl4030_priv *twl4030 = w->codec->private_data;
-	unsigned char reg, misc;
-
-	reg = twl4030_read_reg_cache(w->codec, m->reg);
-
-	/*
-	 * bypass_state[0:3] - analog HiFi bypass
-	 * bypass_state[4]   - analog voice bypass
-	 * bypass_state[5]   - digital voice bypass
-	 * bypass_state[6:7] - digital HiFi bypass
-	 */
-	if (m->reg == TWL4030_REG_VSTPGA) {
-		/* Voice digital bypass */
-		if (reg)
-			twl4030->bypass_state |= (1 << 5);
-		else
-			twl4030->bypass_state &= ~(1 << 5);
-	} else if (m->reg <= TWL4030_REG_ARXR2_APGA_CTL) {
-		/* Analog bypass */
-		if (reg & (1 << m->shift))
-			twl4030->bypass_state |=
-				(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
-		else
-			twl4030->bypass_state &=
-				~(1 << (m->reg - TWL4030_REG_ARXL1_APGA_CTL));
-	} else if (m->reg == TWL4030_REG_VDL_APGA_CTL) {
-		/* Analog voice bypass */
-		if (reg & (1 << m->shift))
-			twl4030->bypass_state |= (1 << 4);
-		else
-			twl4030->bypass_state &= ~(1 << 4);
-	} else {
-		/* Digital bypass */
-		if (reg & (0x7 << m->shift))
-			twl4030->bypass_state |= (1 << (m->shift ? 7 : 6));
-		else
-			twl4030->bypass_state &= ~(1 << (m->shift ? 7 : 6));
-	}
-
-	/* Enable master analog loopback mode if any analog switch is enabled*/
-	misc = twl4030_read_reg_cache(w->codec, TWL4030_REG_MISC_SET_1);
-	if (twl4030->bypass_state & 0x1F)
-		misc |= TWL4030_FMLOOP_EN;
-	else
-		misc &= ~TWL4030_FMLOOP_EN;
-	twl4030_write(w->codec, TWL4030_REG_MISC_SET_1, misc);
-
-	if (w->codec->bias_level == SND_SOC_BIAS_STANDBY) {
-		if (twl4030->bypass_state)
-			twl4030_codec_mute(w->codec, 0);
-		else
-			twl4030_codec_mute(w->codec, 1);
-	}
-	return 0;
-}
-
 /*
  * Some of the gain controls in TWL (mostly those which are associated with
  * the outputs) are implemented in an interesting way:
@@ -1193,32 +1131,28 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0),
 
 	/* Analog bypasses */
-	SND_SOC_DAPM_SWITCH_E("Right1 Analog Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_abypassr1_control, bypass_event,
-			SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Left1 Analog Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_abypassl1_control,
-			bypass_event, SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Right2 Analog Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_abypassr2_control,
-			bypass_event, SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Left2 Analog Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_abypassl2_control,
-			bypass_event, SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Voice Analog Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_abypassv_control,
-			bypass_event, SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH("Right1 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassr1_control),
+	SND_SOC_DAPM_SWITCH("Left1 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassl1_control),
+	SND_SOC_DAPM_SWITCH("Right2 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassr2_control),
+	SND_SOC_DAPM_SWITCH("Left2 Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassl2_control),
+	SND_SOC_DAPM_SWITCH("Voice Analog Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_abypassv_control),
+
+	/* Master analog loopback switch */
+	SND_SOC_DAPM_SUPPLY("FM Loop Enable", TWL4030_REG_MISC_SET_1, 5, 0,
+			    NULL, 0),
 
 	/* Digital bypasses */
-	SND_SOC_DAPM_SWITCH_E("Left Digital Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_dbypassl_control, bypass_event,
-			SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Right Digital Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_dbypassr_control, bypass_event,
-			SND_SOC_DAPM_POST_REG),
-	SND_SOC_DAPM_SWITCH_E("Voice Digital Loopback", SND_SOC_NOPM, 0, 0,
-			&twl4030_dapm_dbypassv_control, bypass_event,
-			SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH("Left Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassl_control),
+	SND_SOC_DAPM_SWITCH("Right Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassr_control),
+	SND_SOC_DAPM_SWITCH("Voice Digital Loopback", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_dbypassv_control),
 
 	/* Digital mixers, power control for the physical DACs */
 	SND_SOC_DAPM_MIXER("Digital R1 Playback Mixer",
@@ -1490,6 +1424,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left2 Analog Loopback", "Switch", "Analog Left"},
 	{"Voice Analog Loopback", "Switch", "Analog Left"},
 
+	/* Supply for the Analog loopbacks */
+	{"Right1 Analog Loopback", NULL, "FM Loop Enable"},
+	{"Left1 Analog Loopback", NULL, "FM Loop Enable"},
+	{"Right2 Analog Loopback", NULL, "FM Loop Enable"},
+	{"Left2 Analog Loopback", NULL, "FM Loop Enable"},
+	{"Voice Analog Loopback", NULL, "FM Loop Enable"},
+
 	{"Analog R1 Playback Mixer", NULL, "Right1 Analog Loopback"},
 	{"Analog L1 Playback Mixer", NULL, "Left1 Analog Loopback"},
 	{"Analog R2 Playback Mixer", NULL, "Right2 Analog Loopback"},
@@ -1521,25 +1462,16 @@ static int twl4030_add_widgets(struct snd_soc_codec *codec)
 static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
-	struct twl4030_priv *twl4030 = codec->private_data;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		twl4030_codec_mute(codec, 0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		twl4030_power_up(codec);
-		if (twl4030->bypass_state)
-			twl4030_codec_mute(codec, 0);
-		else
-			twl4030_codec_mute(codec, 1);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		twl4030_power_up(codec);
-		if (twl4030->bypass_state)
-			twl4030_codec_mute(codec, 0);
-		else
-			twl4030_codec_mute(codec, 1);
+		if (codec->bias_level == SND_SOC_BIAS_OFF)
+			twl4030_power_up(codec);
+		twl4030_codec_mute(codec, 1);
 		break;
 	case SND_SOC_BIAS_OFF:
 		twl4030_power_down(codec);
-- 
1.6.5.1
