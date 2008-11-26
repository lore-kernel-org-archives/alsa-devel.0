From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] Allow more routing features for	tlv320aic3x
Date: Wed, 26 Nov 2008 17:47:36 +0100
Message-ID: <20081126164736.GC20913@buzzloop.caiaq.de>
References: <20081126144854.GA20061@buzzloop.caiaq.de>
	<20081126150404.GE6234@sirena.org.uk>
	<20081126155645.GA20913@buzzloop.caiaq.de>
	<20081126162810.GF6234@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 437CC2474C
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 17:47:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081126162810.GF6234@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2008 at 04:28:11PM +0000, Mark Brown wrote:
> > -	SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> > +	SOC_DOUBLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> > +		     PGAR_2_HPLOUT_VOL, 0, 0x7f, 1),
> 
> Meh, sorry - I meant SOC_SINGLE here.  My mistake.

Sorry, once more. I was a little too quick with my last submission.

Best regards,
Daniel


--9Ek0hoCL9XbhcSqy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="tlv320aic3x-routing.diff"

This patch enables more routing functions for tlv320aic3x codecs.
It is now possible to

 - control the volume of the PGA bypass path for the HPL, HPR, HPLCOM
   and HPRCOM outputs individually
 - route right line1 input to the left ADC channel
 - route left line1 input to the right ADC channel
 - route right mic3 input to left DAC channel
 - route left mic3 input to right DAC channel
 - route left line1 input to right line1 output
 - route right line1 input to left line1 output

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index cff276e..2047c66 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -272,8 +272,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 		     DACR1_2_HPROUT_VOL, 0, 0x7f, 1),
 	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
-	SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
-		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
+	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
+		     0, 0x7f, 1),
+	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
+		     0, 0x7f, 1),
 	SOC_DOUBLE_R("HP Line2 Bypass Playback Volume", LINE2L_2_HPLOUT_VOL,
 		     LINE2R_2_HPROUT_VOL, 0, 0x7f, 1),
 
@@ -281,8 +283,10 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 		     DACR1_2_HPRCOM_VOL, 0, 0x7f, 1),
 	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
-	SOC_DOUBLE_R("HPCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
-		     PGAR_2_HPRCOM_VOL, 0, 0x7f, 1),
+	SOC_SINGLE("HPLCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
+		     0, 0x7f, 1),
+	SOC_SINGLE("HPRCOM PGA Bypass Playback Volume", PGAL_2_HPRCOM_VOL,
+		     0, 0x7f, 1),
 	SOC_DOUBLE_R("HPCOM Line2 Bypass Playback Volume", LINE2L_2_HPLCOM_VOL,
 		     LINE2R_2_HPRCOM_VOL, 0, 0x7f, 1),
 
@@ -333,7 +337,8 @@ SOC_DAPM_ENUM("Route", aic3x_enum[RHPCOM_ENUM]);
 
 /* Left DAC_L1 Mixer */
 static const struct snd_kcontrol_new aic3x_left_dac_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", DACL1_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", DACL1_2_MONOLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HP Switch", DACL1_2_HPLOUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HPCOM Switch", DACL1_2_HPLCOM_VOL, 7, 1, 0),
@@ -341,7 +346,8 @@ static const struct snd_kcontrol_new aic3x_left_dac_mixer_controls[] = {
 
 /* Right DAC_R1 Mixer */
 static const struct snd_kcontrol_new aic3x_right_dac_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", DACR1_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", DACR1_2_MONOLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HP Switch", DACR1_2_HPROUT_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HPCOM Switch", DACR1_2_HPRCOM_VOL, 7, 1, 0),
@@ -350,14 +356,18 @@ static const struct snd_kcontrol_new aic3x_right_dac_mixer_controls[] = {
 /* Left PGA Mixer */
 static const struct snd_kcontrol_new aic3x_left_pga_mixer_controls[] = {
 	SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_LADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_LADC_CTRL, 3, 1, 1),
 	SOC_DAPM_SINGLE_AIC3X("Line2L Switch", LINE2L_2_LADC_CTRL, 3, 1, 1),
 	SOC_DAPM_SINGLE_AIC3X("Mic3L Switch", MIC3LR_2_LADC_CTRL, 4, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_LADC_CTRL, 0, 1, 1),
 };
 
 /* Right PGA Mixer */
 static const struct snd_kcontrol_new aic3x_right_pga_mixer_controls[] = {
 	SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_RADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_RADC_CTRL, 3, 1, 1),
 	SOC_DAPM_SINGLE_AIC3X("Line2R Switch", LINE2R_2_RADC_CTRL, 3, 1, 1),
+	SOC_DAPM_SINGLE_AIC3X("Mic3L Switch", MIC3LR_2_RADC_CTRL, 4, 1, 1),
 	SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0, 1, 1),
 };
 
@@ -379,34 +389,42 @@ SOC_DAPM_ENUM("Route", aic3x_enum[LINE2R_ENUM]);
 
 /* Left PGA Bypass Mixer */
 static const struct snd_kcontrol_new aic3x_left_pga_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", PGAL_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", PGAL_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPL Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPR Switch", PGAL_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPLCOM Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPRCOM Switch", PGAL_2_HPRCOM_VOL, 7, 1, 0),
 };
 
 /* Right PGA Bypass Mixer */
 static const struct snd_kcontrol_new aic3x_right_pga_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", PGAR_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", PGAR_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPL Switch", PGAR_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPR Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPLCOM Switch", PGAR_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPRCOM Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
 };
 
 /* Left Line2 Bypass Mixer */
 static const struct snd_kcontrol_new aic3x_left_line2_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", LINE2L_2_MONOLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HP Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPLCOM Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
 };
 
 /* Right Line2 Bypass Mixer */
 static const struct snd_kcontrol_new aic3x_right_line2_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Line Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineL Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("LineR Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("Mono Switch", LINE2R_2_MONOLOPM_VOL, 7, 1, 0),
 	SOC_DAPM_SINGLE("HP Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("HPRCOM Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
@@ -439,22 +457,26 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	/* Mono Output */
 	SND_SOC_DAPM_PGA("Mono Out", MONOLOPM_CTRL, 0, 0, NULL, 0),
 
-	/* Left Inputs to Left ADC */
+	/* Inputs to Left ADC */
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", LINE1L_2_LADC_CTRL, 2, 0),
 	SND_SOC_DAPM_MIXER("Left PGA Mixer", SND_SOC_NOPM, 0, 0,
 			   &aic3x_left_pga_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_left_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Left Line1L Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_line1_mux_controls),
+	SND_SOC_DAPM_MUX("Left Line1R Mux", SND_SOC_NOPM, 0, 0,
+			 &aic3x_left_line1_mux_controls),
 	SND_SOC_DAPM_MUX("Left Line2L Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_line2_mux_controls),
 
-	/* Right Inputs to Right ADC */
+	/* Inputs to Right ADC */
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture",
 			 LINE1R_2_RADC_CTRL, 2, 0),
 	SND_SOC_DAPM_MIXER("Right PGA Mixer", SND_SOC_NOPM, 0, 0,
 			   &aic3x_right_pga_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_right_pga_mixer_controls)),
+	SND_SOC_DAPM_MUX("Right Line1L Mux", SND_SOC_NOPM, 0, 0,
+			 &aic3x_right_line1_mux_controls),
 	SND_SOC_DAPM_MUX("Right Line1R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line1_mux_controls),
 	SND_SOC_DAPM_MUX("Right Line2R Mux", SND_SOC_NOPM, 0, 0,
@@ -531,7 +553,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left DAC Mux", "DAC_L2", "Left DAC"},
 	{"Left DAC Mux", "DAC_L3", "Left DAC"},
 
-	{"Left DAC_L1 Mixer", "Line Switch", "Left DAC Mux"},
+	{"Left DAC_L1 Mixer", "LineL Switch", "Left DAC Mux"},
+	{"Left DAC_L1 Mixer", "LineR Switch", "Left DAC Mux"},
 	{"Left DAC_L1 Mixer", "Mono Switch", "Left DAC Mux"},
 	{"Left DAC_L1 Mixer", "HP Switch", "Left DAC Mux"},
 	{"Left DAC_L1 Mixer", "HPCOM Switch", "Left DAC Mux"},
@@ -557,7 +580,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right DAC Mux", "DAC_R2", "Right DAC"},
 	{"Right DAC Mux", "DAC_R3", "Right DAC"},
 
-	{"Right DAC_R1 Mixer", "Line Switch", "Right DAC Mux"},
+	{"Right DAC_R1 Mixer", "LineL Switch", "Right DAC Mux"},
+	{"Right DAC_R1 Mixer", "LineR Switch", "Right DAC Mux"},
 	{"Right DAC_R1 Mixer", "Mono Switch", "Right DAC Mux"},
 	{"Right DAC_R1 Mixer", "HP Switch", "Right DAC Mux"},
 	{"Right DAC_R1 Mixer", "HPCOM Switch", "Right DAC Mux"},
@@ -592,8 +616,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left Line2L Mux", "differential", "LINE2L"},
 
 	{"Left PGA Mixer", "Line1L Switch", "Left Line1L Mux"},
+	{"Left PGA Mixer", "Line1R Switch", "Left Line1R Mux"},
 	{"Left PGA Mixer", "Line2L Switch", "Left Line2L Mux"},
 	{"Left PGA Mixer", "Mic3L Switch", "MIC3L"},
+	{"Left PGA Mixer", "Mic3R Switch", "MIC3R"},
 
 	{"Left ADC", NULL, "Left PGA Mixer"},
 	{"Left ADC", NULL, "GPIO1 dmic modclk"},
@@ -605,18 +631,23 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right Line2R Mux", "single-ended", "LINE2R"},
 	{"Right Line2R Mux", "differential", "LINE2R"},
 
+	{"Right PGA Mixer", "Line1L Switch", "Right Line1L Mux"},
 	{"Right PGA Mixer", "Line1R Switch", "Right Line1R Mux"},
 	{"Right PGA Mixer", "Line2R Switch", "Right Line2R Mux"},
+	{"Right PGA Mixer", "Mic3L Switch", "MIC3L"},
 	{"Right PGA Mixer", "Mic3R Switch", "MIC3R"},
 
 	{"Right ADC", NULL, "Right PGA Mixer"},
 	{"Right ADC", NULL, "GPIO1 dmic modclk"},
 
 	/* Left PGA Bypass */
-	{"Left PGA Bypass Mixer", "Line Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "LineL Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "LineR Switch", "Left PGA Mixer"},
 	{"Left PGA Bypass Mixer", "Mono Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HP Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HPCOM Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "HPL Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "HPR Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "HPLCOM Switch", "Left PGA Mixer"},
+	{"Left PGA Bypass Mixer", "HPRCOM Switch", "Left PGA Mixer"},
 
 	{"Left HPCOM Mux", "differential of HPLOUT", "Left PGA Bypass Mixer"},
 	{"Left HPCOM Mux", "constant VCM", "Left PGA Bypass Mixer"},
@@ -627,10 +658,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left HP Out", NULL, "Left PGA Bypass Mixer"},
 
 	/* Right PGA Bypass */
-	{"Right PGA Bypass Mixer", "Line Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "LineL Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "LineR Switch", "Right PGA Mixer"},
 	{"Right PGA Bypass Mixer", "Mono Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HP Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HPCOM Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "HPL Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "HPR Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "HPLCOM Switch", "Right PGA Mixer"},
+	{"Right PGA Bypass Mixer", "HPRCOM Switch", "Right PGA Mixer"},
 
 	{"Right HPCOM Mux", "differential of HPROUT", "Right PGA Bypass Mixer"},
 	{"Right HPCOM Mux", "constant VCM", "Right PGA Bypass Mixer"},
@@ -643,10 +677,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right HP Out", NULL, "Right PGA Bypass Mixer"},
 
 	/* Left Line2 Bypass */
-	{"Left Line2 Bypass Mixer", "Line Switch", "Left Line2L Mux"},
+	{"Left Line2 Bypass Mixer", "LineL Switch", "Left Line2L Mux"},
+	{"Left Line2 Bypass Mixer", "LineR Switch", "Left Line2L Mux"},
 	{"Left Line2 Bypass Mixer", "Mono Switch", "Left Line2L Mux"},
 	{"Left Line2 Bypass Mixer", "HP Switch", "Left Line2L Mux"},
-	{"Left Line2 Bypass Mixer", "HPCOM Switch", "Left Line2L Mux"},
+	{"Left Line2 Bypass Mixer", "HPLCOM Switch", "Left Line2L Mux"},
 
 	{"Left HPCOM Mux", "differential of HPLOUT", "Left Line2 Bypass Mixer"},
 	{"Left HPCOM Mux", "constant VCM", "Left Line2 Bypass Mixer"},
@@ -657,10 +692,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Left HP Out", NULL, "Left Line2 Bypass Mixer"},
 
 	/* Right Line2 Bypass */
-	{"Right Line2 Bypass Mixer", "Line Switch", "Right Line2R Mux"},
+	{"Right Line2 Bypass Mixer", "LineL Switch", "Right Line2R Mux"},
+	{"Right Line2 Bypass Mixer", "LineR Switch", "Right Line2R Mux"},
 	{"Right Line2 Bypass Mixer", "Mono Switch", "Right Line2R Mux"},
 	{"Right Line2 Bypass Mixer", "HP Switch", "Right Line2R Mux"},
-	{"Right Line2 Bypass Mixer", "HPCOM Switch", "Right Line2R Mux"},
+	{"Right Line2 Bypass Mixer", "HPRCOM Switch", "Right Line2R Mux"},
 
 	{"Right HPCOM Mux", "differential of HPROUT", "Right Line2 Bypass Mixer"},
 	{"Right HPCOM Mux", "constant VCM", "Right Line2 Bypass Mixer"},
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 00a195a..7e982ac 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -48,7 +48,9 @@
 #define MIC3LR_2_RADC_CTRL		18
 /* Line1 Input control registers */
 #define LINE1L_2_LADC_CTRL		19
+#define LINE1R_2_LADC_CTRL		21
 #define LINE1R_2_RADC_CTRL		22
+#define LINE1L_2_RADC_CTRL		24
 /* Line2 Input control registers */
 #define LINE2L_2_LADC_CTRL		20
 #define LINE2R_2_RADC_CTRL		23
@@ -79,6 +81,8 @@
 #define LINE2L_2_HPLOUT_VOL		45
 #define LINE2R_2_HPROUT_VOL		62
 #define PGAL_2_HPLOUT_VOL		46
+#define PGAL_2_HPROUT_VOL		60
+#define PGAR_2_HPLOUT_VOL		49
 #define PGAR_2_HPROUT_VOL		63
 #define DACL1_2_HPLOUT_VOL		47
 #define DACR1_2_HPROUT_VOL		64
@@ -88,6 +92,8 @@
 #define LINE2L_2_HPLCOM_VOL		52
 #define LINE2R_2_HPRCOM_VOL		69
 #define PGAL_2_HPLCOM_VOL		53
+#define PGAR_2_HPLCOM_VOL		56
+#define PGAL_2_HPRCOM_VOL		67
 #define PGAR_2_HPRCOM_VOL		70
 #define DACL1_2_HPLCOM_VOL		54
 #define DACR1_2_HPRCOM_VOL		71
@@ -103,11 +109,17 @@
 #define MONOLOPM_CTRL			79
 /* Line Output Plus/Minus control registers */
 #define LINE2L_2_LLOPM_VOL		80
+#define LINE2L_2_RLOPM_VOL		87
+#define LINE2R_2_LLOPM_VOL		83
 #define LINE2R_2_RLOPM_VOL		90
 #define PGAL_2_LLOPM_VOL		81
+#define PGAL_2_RLOPM_VOL		88
+#define PGAR_2_LLOPM_VOL		84
 #define PGAR_2_RLOPM_VOL		91
 #define DACL1_2_LLOPM_VOL		82
+#define DACL1_2_RLOPM_VOL		89
 #define DACR1_2_RLOPM_VOL		92
+#define DACR1_2_LLOPM_VOL		85
 #define LLOPM_CTRL			86
 #define RLOPM_CTRL			93
 /* GPIO/IRQ registers */

--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--9Ek0hoCL9XbhcSqy--
