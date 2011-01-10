From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Add DAPM selection for LOM
	invert
Date: Mon, 10 Jan 2011 15:39:49 +0200
Message-ID: <1294666789-16272-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C1A71038BD
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 14:39:50 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The L/R LOM line can be invertined side of the
corresponding DAC, or inverted from the corresponding
LOP.
Add control for user space to select the source of the
LOM inversion.
When only the analog bypass is enabled, and the LOM
is inverted from DAC output, we need to power the
corresponding DAC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   55 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 13d521c..71d7be8 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -298,7 +298,6 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 	if (unlikely(!dac33->chip_power))
 		return;
 
-	/* 44-46: DAC Control Registers */
 	/* A : DAC sample rate Fsref/1.5 */
 	dac33_write(codec, DAC33_DAC_CTRL_A, DAC33_DACRATE(0));
 	/* B : DAC src=normal, not muted */
@@ -321,6 +320,10 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 		    dac33_read_reg_cache(codec, DAC33_LINEL_TO_LLO_VOL));
 	dac33_write(codec, DAC33_LINER_TO_RLO_VOL,
 		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
+
+	dac33_write(codec, DAC33_OUT_AMP_CTRL,
+		    dac33_read_reg_cache(codec, DAC33_OUT_AMP_CTRL));
+
 }
 
 static inline int dac33_read_id(struct snd_soc_codec *codec)
@@ -523,6 +526,25 @@ static const struct snd_kcontrol_new dac33_dapm_abypassl_control =
 static const struct snd_kcontrol_new dac33_dapm_abypassr_control =
 	SOC_DAPM_SINGLE("Switch", DAC33_LINER_TO_RLO_VOL, 7, 1, 1);
 
+/* LOP L/R invert selection */
+static const char *dac33_lr_lom_texts[] = {"DAC", "LOP"};
+
+static const struct soc_enum dac33_left_lom_enum =
+	SOC_ENUM_SINGLE(DAC33_OUT_AMP_CTRL, 3,
+			ARRAY_SIZE(dac33_lr_lom_texts),
+			dac33_lr_lom_texts);
+
+static const struct snd_kcontrol_new dac33_dapm_left_lom_control =
+SOC_DAPM_ENUM("Route", dac33_left_lom_enum);
+
+static const struct soc_enum dac33_right_lom_enum =
+	SOC_ENUM_SINGLE(DAC33_OUT_AMP_CTRL, 2,
+			ARRAY_SIZE(dac33_lr_lom_texts),
+			dac33_lr_lom_texts);
+
+static const struct snd_kcontrol_new dac33_dapm_right_lom_control =
+SOC_DAPM_ENUM("Route", dac33_right_lom_enum);
+
 static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("LEFT_LO"),
 	SND_SOC_DAPM_OUTPUT("RIGHT_LO"),
@@ -539,6 +561,18 @@ static const struct snd_soc_dapm_widget dac33_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Analog Right Bypass", SND_SOC_NOPM, 0, 0,
 				&dac33_dapm_abypassr_control),
 
+	SND_SOC_DAPM_MUX("Left LOM Inverted From", SND_SOC_NOPM, 0, 0,
+		&dac33_dapm_left_lom_control),
+	SND_SOC_DAPM_MUX("Right LOM Inverted From", SND_SOC_NOPM, 0, 0,
+		&dac33_dapm_right_lom_control),
+	/*
+	 * For DAPM path, when only the anlog bypass path is enabled, and the
+	 * LOP inverted from the corresponding DAC side.
+	 * This is needed, so we can attach the DAC power supply in this case.
+	 */
+	SND_SOC_DAPM_PGA("Left Bypass PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Right Bypass PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Left Amplifier",
 			 DAC33_OUT_AMP_PWR_CTRL, 6, 3, 3, 0),
 	SND_SOC_DAPM_REG(snd_soc_dapm_mixer, "Output Right Amplifier",
@@ -561,11 +595,22 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Output Left Amplifier", NULL, "DACL"},
 	{"Output Right Amplifier", NULL, "DACR"},
 
-	{"Output Left Amplifier", NULL, "Analog Left Bypass"},
-	{"Output Right Amplifier", NULL, "Analog Right Bypass"},
+	{"Left Bypass PGA", NULL, "Analog Left Bypass"},
+	{"Right Bypass PGA", NULL, "Analog Right Bypass"},
+
+	{"Left LOM Inverted From", "DAC", "Left Bypass PGA"},
+	{"Right LOM Inverted From", "DAC", "Right Bypass PGA"},
+	{"Left LOM Inverted From", "LOP", "Analog Left Bypass"},
+	{"Right LOM Inverted From", "LOP", "Analog Right Bypass"},
+
+	{"Output Left Amplifier", NULL, "Left LOM Inverted From"},
+	{"Output Right Amplifier", NULL, "Right LOM Inverted From"},
+
+	{"DACL", NULL, "Left DAC Power"},
+	{"DACR", NULL, "Right DAC Power"},
 
-	{"Output Left Amplifier", NULL, "Left DAC Power"},
-	{"Output Right Amplifier", NULL, "Right DAC Power"},
+	{"Left Bypass PGA", NULL, "Left DAC Power"},
+	{"Right Bypass PGA", NULL, "Right DAC Power"},
 
 	/* output */
 	{"LEFT_LO", NULL, "Output Left Amplifier"},
-- 
1.7.4.rc1
