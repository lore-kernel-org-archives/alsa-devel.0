From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] sound: codec: tlv320aic3x: remove mono controls
Date: Fri, 17 Jun 2011 15:17:57 +0200
Message-ID: <1308316677-6307-1-git-send-email-j.weitzel@phytec.de>
References: <20110617130528.GB18493@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from root.phytec.de (mail.phytec.co.uk [217.6.246.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 18715103813
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 15:18:00 +0200 (CEST)
In-Reply-To: <20110617130528.GB18493@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, Jan Weitzel <j.weitzel@phytec.de>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

if codec driver is used for AIC3X_MODEL_3007 the mono iout controls overwrite
registers for class-d amplifier.
classd amplifier controls are only used for AIC3X_MODEL_3007.

Removing all mono snd_kcontrol_new, snd_soc_dapm_widget, snd_soc_dapm_route
and aic3x_init stuff from common code and call only for not AIC3X_MODEL_3007
codecs.

Testet only with AIC3X_MODEL_3007

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>

with aic34
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |  106 ++++++++++++++++++++++++---------------
 1 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c3d96fc..7146832 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,16 +324,6 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_LLOPM_VOL, DACR1_2_RLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Volume",
-			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
-			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("Mono PGA Bypass Volume",
-			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
-			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
-			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
-			 0, 118, 1, output_stage_tlv),
-
 	SOC_DOUBLE_R_TLV("HP Line2 Bypass Volume",
 			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
@@ -357,7 +347,6 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output pin mute controls */
 	SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
 		     0x01, 0),
-	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
@@ -377,6 +366,19 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
 };
 
+static const struct snd_kcontrol_new aic3x_mono_controls[] = {
+	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Volume",
+			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("Mono PGA Bypass Volume",
+			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
+			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+};
+
 /*
  * Class-D amplifier gain. From 0 to 18 dB in 6 dB steps
  */
@@ -526,9 +528,6 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Right HP Out", HPROUT_CTRL, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Right HP Com", HPRCOM_CTRL, 0, 0, NULL, 0),
 
-	/* Mono Output */
-	SND_SOC_DAPM_PGA("Mono Out", MONOLOPM_CTRL, 0, 0, NULL, 0),
-
 	/* Inputs to Left ADC */
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", LINE1L_2_LADC_CTRL, 2, 0),
 	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
@@ -590,9 +589,6 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Right Line Mixer", SND_SOC_NOPM, 0, 0,
 			   &aic3x_right_line_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_right_line_mixer_controls)),
-	SND_SOC_DAPM_MIXER("Mono Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_mono_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_mono_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Left HP Mixer", SND_SOC_NOPM, 0, 0,
 			   &aic3x_left_hp_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_left_hp_mixer_controls)),
@@ -608,7 +604,6 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUTPUT("LLOUT"),
 	SND_SOC_DAPM_OUTPUT("RLOUT"),
-	SND_SOC_DAPM_OUTPUT("MONO_LOUT"),
 	SND_SOC_DAPM_OUTPUT("HPLOUT"),
 	SND_SOC_DAPM_OUTPUT("HPROUT"),
 	SND_SOC_DAPM_OUTPUT("HPLCOM"),
@@ -630,6 +625,18 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Detection"),
 };
 
+static const struct snd_soc_dapm_widget aic3x_dapm_mono_widgets[] = {
+	/* Mono Output */
+	SND_SOC_DAPM_PGA("Mono Out", MONOLOPM_CTRL, 0, 0, NULL, 0),
+
+	/* Output mixers */
+	SND_SOC_DAPM_MIXER("Mono Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_mono_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_mono_mixer_controls)),
+
+	SND_SOC_DAPM_OUTPUT("MONO_LOUT"),
+};
+
 static const struct snd_soc_dapm_widget aic3007_dapm_widgets[] = {
 	/* Class-D outputs */
 	SND_SOC_DAPM_PGA("Left Class-D Out", CLASSD_CTRL, 3, 0, NULL, 0),
@@ -714,17 +721,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right Line Out", NULL, "Right DAC Mux"},
 	{"RLOUT", NULL, "Right Line Out"},
 
-	/* Mono Output */
-	{"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
-	{"Mono Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
-	{"Mono Mixer", "DACL1 Switch", "Left DAC Mux"},
-	{"Mono Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
-	{"Mono Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
-	{"Mono Mixer", "DACR1 Switch", "Right DAC Mux"},
-
-	{"Mono Out", NULL, "Mono Mixer"},
-	{"MONO_LOUT", NULL, "Mono Out"},
-
 	/* Left HP Output */
 	{"Left HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
 	{"Left HP Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
@@ -780,6 +776,19 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HPRCOM", NULL, "Right HP Com"},
 };
 
+static const struct snd_soc_dapm_route intercon_mono[] = {
+	/* Mono Output */
+	{"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Mono Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Mono Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Mono Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Mono Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Mono Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Mono Out", NULL, "Mono Mixer"},
+	{"MONO_LOUT", NULL, "Mono Out"},
+};
+
 static const struct snd_soc_dapm_route intercon_3007[] = {
 	/* Class-D outputs */
 	{"Left Class-D Out", NULL, "Left Line Out"},
@@ -804,6 +813,11 @@ static int aic3x_add_widgets(struct snd_soc_codec *codec)
 			ARRAY_SIZE(aic3007_dapm_widgets));
 		snd_soc_dapm_add_routes(dapm, intercon_3007,
 					ARRAY_SIZE(intercon_3007));
+	} else {
+		snd_soc_dapm_new_controls(dapm, aic3x_dapm_mono_widgets,
+			ARRAY_SIZE(aic3x_dapm_mono_widgets));
+		snd_soc_dapm_add_routes(dapm, intercon_mono,
+					ARRAY_SIZE(intercon_mono));
 	}
 
 	return 0;
@@ -1290,17 +1304,12 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	/* DAC to Line Out default volume and route to Output mixer */
 	snd_soc_write(codec, DACL1_2_LLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
 	snd_soc_write(codec, DACR1_2_RLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
-	/* DAC to Mono Line Out default volume and route to Output mixer */
-	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
-	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
 
 	/* unmute all outputs */
 	reg = snd_soc_read(codec, LLOPM_CTRL);
 	snd_soc_write(codec, LLOPM_CTRL, reg | UNMUTE);
 	reg = snd_soc_read(codec, RLOPM_CTRL);
 	snd_soc_write(codec, RLOPM_CTRL, reg | UNMUTE);
-	reg = snd_soc_read(codec, MONOLOPM_CTRL);
-	snd_soc_write(codec, MONOLOPM_CTRL, reg | UNMUTE);
 	reg = snd_soc_read(codec, HPLOUT_CTRL);
 	snd_soc_write(codec, HPLOUT_CTRL, reg | UNMUTE);
 	reg = snd_soc_read(codec, HPROUT_CTRL);
@@ -1325,9 +1334,6 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	/* PGA to Line Out default volume, disconnect from Output Mixer */
 	snd_soc_write(codec, PGAL_2_LLOPM_VOL, DEFAULT_VOL);
 	snd_soc_write(codec, PGAR_2_RLOPM_VOL, DEFAULT_VOL);
-	/* PGA to Mono Line Out default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, PGAL_2_MONOLOPM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, PGAR_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	/* Line2 to HP Bypass default volume, disconnect from Output Mixer */
 	snd_soc_write(codec, LINE2L_2_HPLOUT_VOL, DEFAULT_VOL);
@@ -1337,14 +1343,30 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	/* Line2 Line Out default volume, disconnect from Output Mixer */
 	snd_soc_write(codec, LINE2L_2_LLOPM_VOL, DEFAULT_VOL);
 	snd_soc_write(codec, LINE2R_2_RLOPM_VOL, DEFAULT_VOL);
-	/* Line2 to Mono Out default volume, disconnect from Output Mixer */
-	snd_soc_write(codec, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
-	snd_soc_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	if (aic3x->model == AIC3X_MODEL_3007) {
 		aic3x_init_3007(codec);
 		snd_soc_write(codec, CLASSD_CTRL, 0);
+
+		return 0;
 	}
+	/* Not on AIC3X_MODEL_3007 init */
+
+	/* DAC to Mono Line Out default volume and route to Output mixer */
+	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+
+	/* unmute outputs */
+	reg = snd_soc_read(codec, MONOLOPM_CTRL);
+	snd_soc_write(codec, MONOLOPM_CTRL, reg | UNMUTE);
+
+	/* PGA to Mono Line Out default volume, disconnect from Output Mixer */
+	snd_soc_write(codec, PGAL_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, PGAR_2_MONOLOPM_VOL, DEFAULT_VOL);
+
+	/* Line2 to Mono Out default volume, disconnect from Output Mixer */
+	snd_soc_write(codec, LINE2L_2_MONOLOPM_VOL, DEFAULT_VOL);
+	snd_soc_write(codec, LINE2R_2_MONOLOPM_VOL, DEFAULT_VOL);
 
 	return 0;
 }
@@ -1423,7 +1445,9 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(aic3x_snd_controls));
 	if (aic3x->model == AIC3X_MODEL_3007)
 		snd_soc_add_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
-
+	else
+		snd_soc_add_controls(codec, aic3x_mono_controls,
+					ARRAY_SIZE(aic3x_mono_controls));
 	aic3x_add_widgets(codec);
 	list_add(&aic3x->list, &reset_list);
 
-- 
1.7.0.4
