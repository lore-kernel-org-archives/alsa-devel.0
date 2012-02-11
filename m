From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 06/12] ASoC: alc5632: Refactored DAPM routes
	to add voice support
Date: Sat, 11 Feb 2012 23:26:32 +0200
Message-ID: <1328995598-8788-7-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F19E21039F0
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:27:00 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1256798eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:27:00 -0800 (PST)
In-Reply-To: <1328995598-8788-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Refactored DAPM routes to add voice support.

- Added undocumented register
- Used AIF in/out
- Added missed voice items and routes
- Added DMIC input
- Romoved unrelevant items

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |   85 +++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/alc5632.h |    1 +
 2 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 11da806..b1e9af4 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -266,16 +266,20 @@ SOC_DAPM_SINGLE("SPK2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 1, 1, 1),
 SOC_DAPM_SINGLE("MONO2REC_R Capture Switch", ALC5632_ADC_REC_MIXER, 0, 1, 1),
 };
 
-static const char *alc5632_spk_n_sour_sel[] = {
+static const char * const alc5632_spk_n_sour_sel[] = {
 		"RN/-R", "RP/+R", "LN/-R", "Mute"};
-static const char *alc5632_hpl_out_input_sel[] = {
+static const char * const alc5632_hpl_out_input_sel[] = {
 		"Vmid", "HP Left Mix"};
-static const char *alc5632_hpr_out_input_sel[] = {
+static const char * const alc5632_hpr_out_input_sel[] = {
 		"Vmid", "HP Right Mix"};
-static const char *alc5632_spkout_input_sel[] = {
+static const char * const alc5632_spkout_input_sel[] = {
 		"Vmid", "HPOut Mix", "Speaker Mix", "Mono Mix"};
-static const char *alc5632_aux_out_input_sel[] = {
+static const char * const alc5632_aux_out_input_sel[] = {
 		"Vmid", "HPOut Mix", "Speaker Mix", "Mono Mix"};
+static const char * const alc5632_adcr_func_sel[] = {
+		"Stereo ADC", "Voice ADC"};
+static const char * const alc5632_i2s_out_sel[] = {
+		"ADC LR", "Voice Stereo Digital"};
 
 /* auxout output mux */
 static const struct soc_enum alc5632_aux_out_input_enum =
@@ -314,6 +318,17 @@ static const struct soc_enum alc5632_amp_enum =
 static const struct snd_kcontrol_new alc5632_amp_mux_controls =
 	SOC_DAPM_ENUM("AB-D Amp Mux", alc5632_amp_enum);
 
+/* ADC output select */
+static const struct soc_enum alc5632_adcr_func_enum =
+	SOC_ENUM_SINGLE(ALC5632_DAC_FUNC_SELECT, 5, 2, alc5632_adcr_func_sel);
+static const struct snd_kcontrol_new alc5632_adcr_func_controls =
+	SOC_DAPM_ENUM("ADCR Mux", alc5632_adcr_func_enum);
+
+/* I2S out select */
+static const struct soc_enum alc5632_i2s_out_enum =
+	SOC_ENUM_SINGLE(ALC5632_I2S_OUT_CTL, 5, 2, alc5632_i2s_out_sel);
+static const struct snd_kcontrol_new alc5632_i2s_out_controls =
+	SOC_DAPM_ENUM("I2SOut Mux", alc5632_i2s_out_enum);
 
 static const struct snd_soc_dapm_widget alc5632_dapm_widgets[] = {
 /* Muxes */
@@ -327,6 +342,10 @@ SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0,
 	&alc5632_hpr_out_mux_controls),
 SND_SOC_DAPM_MUX("SpeakerOut N Mux", SND_SOC_NOPM, 0, 0,
 	&alc5632_spkoutn_mux_controls),
+SND_SOC_DAPM_MUX("ADCR Mux", SND_SOC_NOPM, 0, 0,
+	&alc5632_adcr_func_controls),
+SND_SOC_DAPM_MUX("I2SOut Mux", SND_SOC_NOPM, 0, 0,
+	&alc5632_i2s_out_controls),
 
 /* output mixers */
 SND_SOC_DAPM_MIXER("HP Mix", SND_SOC_NOPM, 0, 0,
@@ -354,20 +373,28 @@ SND_SOC_DAPM_MIXER("Right Capture Mix", ALC5632_PWR_MANAG_ADD2, 0, 0,
 	&alc5632_captureR_mixer_controls[0],
 	ARRAY_SIZE(alc5632_captureR_mixer_controls)),
 
-SND_SOC_DAPM_DAC("Left DAC", "HiFi Playback",
-	ALC5632_PWR_MANAG_ADD2, 9, 0),
-SND_SOC_DAPM_DAC("Right DAC", "HiFi Playback",
-	ALC5632_PWR_MANAG_ADD2, 8, 0),
+SND_SOC_DAPM_AIF_IN("AIFRXL", "Left HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("AIFRXR", "Right HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIFTXL", "Left HiFi Capture", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("AIFTXR", "Right HiFi Capture", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_IN("VAIFRX", "Voice Playback", 0, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_AIF_OUT("VAIFTX", "Voice Capture", 0, SND_SOC_NOPM, 0, 0),
+
+SND_SOC_DAPM_DAC("Voice DAC", NULL, ALC5632_PWR_MANAG_ADD2, 10, 0),
+SND_SOC_DAPM_DAC("Left DAC", NULL, ALC5632_PWR_MANAG_ADD2, 9, 0),
+SND_SOC_DAPM_DAC("Right DAC", NULL, ALC5632_PWR_MANAG_ADD2, 8, 0),
+SND_SOC_DAPM_ADC("Left ADC", NULL, ALC5632_PWR_MANAG_ADD2, 7, 0),
+SND_SOC_DAPM_ADC("Right ADC", NULL, ALC5632_PWR_MANAG_ADD2, 6, 0),
+
 SND_SOC_DAPM_MIXER("DAC Left Channel", ALC5632_PWR_MANAG_ADD1, 15, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("DAC Right Channel",
 	ALC5632_PWR_MANAG_ADD1, 14, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("I2S Mix", ALC5632_PWR_MANAG_ADD1, 11, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Phone Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Line Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
-SND_SOC_DAPM_ADC("Left ADC", "HiFi Capture",
-	ALC5632_PWR_MANAG_ADD2, 7, 0),
-SND_SOC_DAPM_ADC("Right ADC", "HiFi Capture",
-	ALC5632_PWR_MANAG_ADD2, 6, 0),
+SND_SOC_DAPM_MIXER("Voice Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("ADCLR", SND_SOC_NOPM, 0, 0, NULL, 0),
+
 SND_SOC_DAPM_PGA("Left Headphone", ALC5632_PWR_MANAG_ADD3, 11, 0, NULL, 0),
 SND_SOC_DAPM_PGA("Right Headphone", ALC5632_PWR_MANAG_ADD3, 10, 0, NULL, 0),
 SND_SOC_DAPM_PGA("Left Speaker", ALC5632_PWR_MANAG_ADD3, 13, 0, NULL, 0),
@@ -395,10 +422,12 @@ SND_SOC_DAPM_OUTPUT("HPL"),
 SND_SOC_DAPM_OUTPUT("HPR"),
 SND_SOC_DAPM_OUTPUT("SPKOUT"),
 SND_SOC_DAPM_OUTPUT("SPKOUTN"),
+
 SND_SOC_DAPM_INPUT("LINEINL"),
 SND_SOC_DAPM_INPUT("LINEINR"),
 SND_SOC_DAPM_INPUT("PHONEP"),
 SND_SOC_DAPM_INPUT("PHONEN"),
+SND_SOC_DAPM_INPUT("DMICDAT"),
 SND_SOC_DAPM_INPUT("MIC1"),
 SND_SOC_DAPM_INPUT("MIC2"),
 SND_SOC_DAPM_VMID("Vmid"),
@@ -406,6 +435,10 @@ SND_SOC_DAPM_VMID("Vmid"),
 
 
 static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
+	/* Playback streams */
+	{"Left DAC", NULL, "AIFRXL"},
+	{"Right DAC", NULL, "AIFRXR"},
+
 	/* virtual mixer - mixes left & right channels */
 	{"I2S Mix",	NULL,	"Left DAC"},
 	{"I2S Mix",	NULL,	"Right DAC"},
@@ -428,7 +461,7 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"HP Mix",	"PHONE2HP Playback Switch",	"Phone Mix"},
 	{"HP Mix",	"MIC12HP Playback Switch",	"MIC1 PGA"},
 	{"HP Mix",	"MIC22HP Playback Switch",	"MIC2 PGA"},
-
+	{"HP Mix", "VOICE2HP Playback Switch",	"Voice Mix"},
 	{"HPR Mix", "DACR2HP Playback Switch",	"DAC Right Channel"},
 	{"HPL Mix", "DACL2HP Playback Switch",	"DAC Left Channel"},
 
@@ -438,6 +471,7 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Speaker Mix", "MIC12SPK Playback Switch",	"MIC1 PGA"},
 	{"Speaker Mix", "MIC22SPK Playback Switch",	"MIC2 PGA"},
 	{"Speaker Mix", "DAC2SPK Playback Switch",	"DAC Left Channel"},
+	{"Speaker Mix", "VOICE2SPK Playback Switch",	"Voice Mix"},
 
 	/* mono mixer */
 	{"Mono Mix", "ADC2MONO_L Playback Switch",	"Left Capture Mix"},
@@ -446,6 +480,7 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Mono Mix", "MIC12MONO Playback Switch",	"MIC1 PGA"},
 	{"Mono Mix", "MIC22MONO Playback Switch",	"MIC2 PGA"},
 	{"Mono Mix", "DAC2MONO Playback Switch",	"DAC Left Channel"},
+	{"Mono Mix", "VOICE2MONO Playback Switch",	"Voice Mix"},
 
 	/* Left record mixer */
 	{"Left Capture Mix", "LIL2REC Capture Switch", "LINEINL"},
@@ -503,10 +538,28 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 
 	/* left ADC */
 	{"Left ADC", NULL,				"Left Capture Mix"},
+	{"Left ADC", NULL,				"DMICDAT"},
+	{"ADCLR", NULL,					"Left ADC"},
 
 	/* right ADC */
-	{"Right ADC", NULL,				"Right Capture Mix"},
-
+	{"Right ADC", NULL, "Right Capture Mix"},
+	{"Right ADC", NULL, "DMICDAT"},
+	{"ADCR Mux", "Stereo ADC", "Right ADC"},
+	{"ADCR Mux", "Voice ADC", "Right ADC"},
+	{"ADCLR", NULL, "ADCR Mux"},
+	{"VAIFTX", NULL, "ADCR Mux"},
+
+	/* Digital I2S out */
+	{"I2SOut Mux", "ADC LR", "ADCLR"},
+	{"I2SOut Mux", "Voice Stereo Digital", "VAIFRX"},
+	{"AIFTXL", NULL, "I2SOut Mux"},
+	{"AIFTXR", NULL, "I2SOut Mux"},
+
+	/* Voice Mix */
+	{"Voice DAC", NULL, "VAIFRX"},
+	{"Voice Mix", NULL, "Voice DAC"},
+
+	/* Speaker Output */
 	{"SpeakerOut N Mux", "RN/-R",			"Left Speaker"},
 	{"SpeakerOut N Mux", "RP/+R",			"Left Speaker"},
 	{"SpeakerOut N Mux", "LN/-R",			"Left Speaker"},
diff --git a/sound/soc/codecs/alc5632.h b/sound/soc/codecs/alc5632.h
index 357651e..1b5bda5 100644
--- a/sound/soc/codecs/alc5632.h
+++ b/sound/soc/codecs/alc5632.h
@@ -51,6 +51,7 @@
 #define ALC5632_ADC_REC_MONOMIX			(1 << 0)
 
 #define ALC5632_VOICE_DAC_VOL			0x18 /* voice dac vol */
+#define ALC5632_I2S_OUT_CTL				0x1A /* undocumented reg. found in path scheme */
 /* ALC5632_OUTPUT_MIXER_CTRL :			*/
 /* same remark as for reg 2 line vs speaker	*/
 #define ALC5632_OUTPUT_MIXER_CTRL		0x1C /* out mix ctrl */
-- 
1.7.3.4
