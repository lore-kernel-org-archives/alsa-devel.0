From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Properly implement the
	positive and negative pins into the mixers" to the asoc tree
Date: Fri, 13 May 2016 13:26:30 +0100
Message-ID: <E1b1CAo-0007Op-QF@finisterre>
References: <1462993793-22952-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78C752668DD
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:26:47 +0200 (CEST)
In-Reply-To: <1462993793-22952-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Properly implement the positive and negative pins into the mixers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2213fc350841e99598e52232b56add7b873529a0 Mon Sep 17 00:00:00 2001
From: Jeremy McDermond <nh6z@nh6z.net>
Date: Wed, 11 May 2016 12:09:53 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Properly implement the positive and
 negative pins into the mixers

The TLV320AIC32x4 has a very flexible mixer on the inputs to the ADCs.  Each
mixer has an available set of available pins that can be connected to the
ADC positive and negative pins via three different resistor values.  This
allows for configuration of differential inputs as well as doing level
manipulation between sources going into the mixers.

The current code only provides positive pins and I implemented the resistors
in an earlier patch.  It turns out that it appears to more accurately model
what's happening to implement each of the pins as a MUX rather than on/off
switches and a mixer.  This way each pin can be set to its desired resistor
value.  Since there are no switches, the mixer is no longer necessary in the
DAPM path.  I set the DAPM paths such that the "off" position of any of the
MUXes turns the path off.

This should allow for any input confiuration available on the codec.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 210 ++++++++++++++++++++++++++++++---------
 1 file changed, 161 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 0eb8acc8cd66..85d4978d0384 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -187,36 +187,67 @@ static const char * const resistor_text[] = {
 	"Off", "10 kOhm", "20 kOhm", "40 kOhm",
 };
 
-static SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0,
-		resistor_text);
-
-static const struct snd_kcontrol_new left_input_mixer_controls[] = {
-	SOC_DAPM_ENUM("IN1_L P Switch", in1l_lpga_p_enum),
-	SOC_DAPM_ENUM("IN2_L P Switch", in2l_lpga_p_enum),
-	SOC_DAPM_ENUM("IN3_L P Switch", in3l_lpga_p_enum),
-	SOC_DAPM_ENUM("IN1_R P Switch", in1r_lpga_p_enum),
+/* Left mixer pins */
+static SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0, resistor_text);
+
+static SOC_ENUM_SINGLE_DECL(cml_lpga_n_enum, AIC32X4_LMICPGANIN, 6, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2r_lpga_n_enum, AIC32X4_LMICPGANIN, 4, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3r_lpga_n_enum, AIC32X4_LMICPGANIN, 2, resistor_text);
+
+static const struct snd_kcontrol_new in1l_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN1_L L+ Switch", in1l_lpga_p_enum),
+};
+static const struct snd_kcontrol_new in2l_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN2_L L+ Switch", in2l_lpga_p_enum),
+};
+static const struct snd_kcontrol_new in3l_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN3_L L+ Switch", in3l_lpga_p_enum),
+};
+static const struct snd_kcontrol_new in1r_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN1_R L+ Switch", in1r_lpga_p_enum),
+};
+static const struct snd_kcontrol_new cml_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("CM_L L- Switch", cml_lpga_n_enum),
+};
+static const struct snd_kcontrol_new in2r_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN2_R L- Switch", in2r_lpga_n_enum),
+};
+static const struct snd_kcontrol_new in3r_to_lmixer_controls[] = {
+	SOC_DAPM_ENUM("IN3_R L- Switch", in3r_lpga_n_enum),
 };
 
-static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2,
-		resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0,
-		resistor_text);
-
-static const struct snd_kcontrol_new right_input_mixer_controls[] = {
-	SOC_DAPM_ENUM("IN1_R P Switch", in1r_rpga_p_enum),
-	SOC_DAPM_ENUM("IN2_R P Switch", in2r_rpga_p_enum),
-	SOC_DAPM_ENUM("IN3_R P Switch", in3r_rpga_p_enum),
-	SOC_DAPM_ENUM("IN2_L P Switch", in2l_rpga_p_enum),
+/*  Right mixer pins */
+static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0, resistor_text);
+static SOC_ENUM_SINGLE_DECL(cmr_rpga_n_enum, AIC32X4_RMICPGANIN, 6, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in1l_rpga_n_enum, AIC32X4_RMICPGANIN, 4, resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3l_rpga_n_enum, AIC32X4_RMICPGANIN, 2, resistor_text);
+
+static const struct snd_kcontrol_new in1r_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN1_R R+ Switch", in1r_rpga_p_enum),
+};
+static const struct snd_kcontrol_new in2r_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN2_R R+ Switch", in2r_rpga_p_enum),
+};
+static const struct snd_kcontrol_new in3r_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN3_R R+ Switch", in3r_rpga_p_enum),
+};
+static const struct snd_kcontrol_new in2l_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN2_L R+ Switch", in2l_rpga_p_enum),
+};
+static const struct snd_kcontrol_new cmr_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("CM_R R- Switch", cmr_rpga_n_enum),
+};
+static const struct snd_kcontrol_new in1l_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN1_L R- Switch", in1l_rpga_n_enum),
+};
+static const struct snd_kcontrol_new in3l_to_rmixer_controls[] = {
+	SOC_DAPM_ENUM("IN3_L R- Switch", in3l_rpga_n_enum),
 };
 
 static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
@@ -240,14 +271,39 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 			   &lor_output_mixer_controls[0],
 			   ARRAY_SIZE(lor_output_mixer_controls)),
 	SND_SOC_DAPM_PGA("LOR Power", AIC32X4_OUTPWRCTL, 2, 0, NULL, 0),
-	SND_SOC_DAPM_MIXER("Left Input Mixer", SND_SOC_NOPM, 0, 0,
-			   &left_input_mixer_controls[0],
-			   ARRAY_SIZE(left_input_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Right Input Mixer", SND_SOC_NOPM, 0, 0,
-			   &right_input_mixer_controls[0],
-			   ARRAY_SIZE(right_input_mixer_controls)),
-	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", AIC32X4_ADCSETUP, 7, 0),
+
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", AIC32X4_ADCSETUP, 6, 0),
+	SND_SOC_DAPM_MUX("IN1_R to Right Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in1r_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("IN2_R to Right Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in2r_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("IN3_R to Right Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in3r_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("IN2_L to Right Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in2l_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("CM_R to Right Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			cmr_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("IN1_L to Right Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			in1l_to_rmixer_controls),
+	SND_SOC_DAPM_MUX("IN3_L to Right Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			in3l_to_rmixer_controls),
+
+	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", AIC32X4_ADCSETUP, 7, 0),
+	SND_SOC_DAPM_MUX("IN1_L to Left Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in1l_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("IN2_L to Left Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in2l_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("IN3_L to Left Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in3l_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("IN1_R to Left Mixer Positive Resistor", SND_SOC_NOPM, 0, 0,
+			in1r_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("CM_L to Left Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			cml_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("IN2_R to Left Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			in2r_to_lmixer_controls),
+	SND_SOC_DAPM_MUX("IN3_R to Left Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
+			in3r_to_lmixer_controls),
+
 	SND_SOC_DAPM_MICBIAS("Mic Bias", AIC32X4_MICBIAS, 6, 0),
 
 	SND_SOC_DAPM_OUTPUT("HPL"),
@@ -287,21 +343,77 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"LOR Power", NULL, "LOR Output Mixer"},
 	{"LOR", NULL, "LOR Power"},
 
-	/* Left input */
-	{"Left Input Mixer", "IN1_L P Switch", "IN1_L"},
-	{"Left Input Mixer", "IN2_L P Switch", "IN2_L"},
-	{"Left Input Mixer", "IN3_L P Switch", "IN3_L"},
-	{"Left Input Mixer", "IN1_R P Switch", "IN1_R"},
-
-	{"Left ADC", NULL, "Left Input Mixer"},
-
 	/* Right Input */
-	{"Right Input Mixer", "IN1_R P Switch", "IN1_R"},
-	{"Right Input Mixer", "IN2_R P Switch", "IN2_R"},
-	{"Right Input Mixer", "IN3_R P Switch", "IN3_R"},
-	{"Right Input Mixer", "IN2_L P Switch", "IN2_L"},
-
-	{"Right ADC", NULL, "Right Input Mixer"},
+	{"Right ADC", NULL, "IN1_R to Right Mixer Positive Resistor"},
+	{"IN1_R to Right Mixer Positive Resistor", "10 kOhm", "IN1_R"},
+	{"IN1_R to Right Mixer Positive Resistor", "20 kOhm", "IN1_R"},
+	{"IN1_R to Right Mixer Positive Resistor", "40 kOhm", "IN1_R"},
+
+	{"Right ADC", NULL, "IN2_R to Right Mixer Positive Resistor"},
+	{"IN2_R to Right Mixer Positive Resistor", "10 kOhm", "IN2_R"},
+	{"IN2_R to Right Mixer Positive Resistor", "20 kOhm", "IN2_R"},
+	{"IN2_R to Right Mixer Positive Resistor", "40 kOhm", "IN2_R"},
+
+	{"Right ADC", NULL, "IN3_R to Right Mixer Positive Resistor"},
+	{"IN3_R to Right Mixer Positive Resistor", "10 kOhm", "IN3_R"},
+	{"IN3_R to Right Mixer Positive Resistor", "20 kOhm", "IN3_R"},
+	{"IN3_R to Right Mixer Positive Resistor", "40 kOhm", "IN3_R"},
+
+	{"Right ADC", NULL, "IN2_L to Right Mixer Positive Resistor"},
+	{"IN2_L to Right Mixer Positive Resistor", "10 kOhm", "IN2_L"},
+	{"IN2_L to Right Mixer Positive Resistor", "20 kOhm", "IN2_L"},
+	{"IN2_L to Right Mixer Positive Resistor", "40 kOhm", "IN2_L"},
+
+	{"Right ADC", NULL, "CM_R to Right Mixer Negative Resistor"},
+	{"CM_R to Right Mixer Negative Resistor", "10 kOhm", "CM_R"},
+	{"CM_R to Right Mixer Negative Resistor", "20 kOhm", "CM_R"},
+	{"CM_R to Right Mixer Negative Resistor", "40 kOhm", "CM_R"},
+
+	{"Right ADC", NULL, "IN1_L to Right Mixer Negative Resistor"},
+	{"IN1_L to Right Mixer Negative Resistor", "10 kOhm", "IN1_L"},
+	{"IN1_L to Right Mixer Negative Resistor", "20 kOhm", "IN1_L"},
+	{"IN1_L to Right Mixer Negative Resistor", "40 kOhm", "IN1_L"},
+
+	{"Right ADC", NULL, "IN3_L to Right Mixer Negative Resistor"},
+	{"IN3_L to Right Mixer Negative Resistor", "10 kOhm", "IN3_L"},
+	{"IN3_L to Right Mixer Negative Resistor", "20 kOhm", "IN3_L"},
+	{"IN3_L to Right Mixer Negative Resistor", "40 kOhm", "IN3_L"},
+
+	/* Left Input */
+	{"Left ADC", NULL, "IN1_L to Left Mixer Positive Resistor"},
+	{"IN1_L to Left Mixer Positive Resistor", "10 kOhm", "IN1_L"},
+	{"IN1_L to Left Mixer Positive Resistor", "20 kOhm", "IN1_L"},
+	{"IN1_L to Left Mixer Positive Resistor", "40 kOhm", "IN1_L"},
+
+	{"Left ADC", NULL, "IN2_L to Left Mixer Positive Resistor"},
+	{"IN2_L to Left Mixer Positive Resistor", "10 kOhm", "IN2_L"},
+	{"IN2_L to Left Mixer Positive Resistor", "20 kOhm", "IN2_L"},
+	{"IN2_L to Left Mixer Positive Resistor", "40 kOhm", "IN2_L"},
+
+	{"Left ADC", NULL, "IN3_L to Left Mixer Positive Resistor"},
+	{"IN3_L to Left Mixer Positive Resistor", "10 kOhm", "IN3_L"},
+	{"IN3_L to Left Mixer Positive Resistor", "20 kOhm", "IN3_L"},
+	{"IN3_L to Left Mixer Positive Resistor", "40 kOhm", "IN3_L"},
+
+	{"Left ADC", NULL, "IN1_R to Left Mixer Positive Resistor"},
+	{"IN1_R to Left Mixer Positive Resistor", "10 kOhm", "IN1_R"},
+	{"IN1_R to Left Mixer Positive Resistor", "20 kOhm", "IN1_R"},
+	{"IN1_R to Left Mixer Positive Resistor", "40 kOhm", "IN1_R"},
+
+	{"Left ADC", NULL, "CM_L to Left Mixer Negative Resistor"},
+	{"CM_L to Left Mixer Negative Resistor", "10 kOhm", "CM_L"},
+	{"CM_L to Left Mixer Negative Resistor", "20 kOhm", "CM_L"},
+	{"CM_L to Left Mixer Negative Resistor", "40 kOhm", "CM_L"},
+
+	{"Left ADC", NULL, "IN2_R to Left Mixer Negative Resistor"},
+	{"IN2_R to Left Mixer Negative Resistor", "10 kOhm", "IN2_R"},
+	{"IN2_R to Left Mixer Negative Resistor", "20 kOhm", "IN2_R"},
+	{"IN2_R to Left Mixer Negative Resistor", "40 kOhm", "IN2_R"},
+
+	{"Left ADC", NULL, "IN3_R to Left Mixer Negative Resistor"},
+	{"IN3_R to Left Mixer Negative Resistor", "10 kOhm", "IN3_R"},
+	{"IN3_R to Left Mixer Negative Resistor", "20 kOhm", "IN3_R"},
+	{"IN3_R to Left Mixer Negative Resistor", "40 kOhm", "IN3_R"},
 };
 
 static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
-- 
2.8.1
