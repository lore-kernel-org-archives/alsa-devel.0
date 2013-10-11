From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 2/2] ASoC: mc13783: add more DAPM routes
Date: Fri, 11 Oct 2013 12:28:14 +0200
Message-ID: <1381487294-20406-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1381487294-20406-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5A7EA26567B
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:28:51 +0200 (CEST)
In-Reply-To: <1381487294-20406-1-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kernel@pengutronix.de, Mark Brown <broonie@kernel.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Add more infrastructure (i.e. routes, muxes, switches) to the mc13783 DAPM.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
	- move DAPM controls to extra patch

 sound/soc/codecs/mc13783.c | 58 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 2b62737..f5472ad 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -427,6 +427,29 @@ static const struct snd_kcontrol_new right_input_mux =
 static const struct snd_kcontrol_new samp_ctl =
 	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 3, 1, 0);
 
+static const char * const speaker_amp_source_text[] = {
+	"CODEC", "Right"
+};
+static const SOC_ENUM_SINGLE_DECL(speaker_amp_source, MC13783_AUDIO_RX0, 4,
+				  speaker_amp_source_text);
+static const struct snd_kcontrol_new speaker_amp_source_mux =
+	SOC_DAPM_ENUM("Speaker Amp Source MUX", speaker_amp_source);
+
+static const char * const headset_amp_source_text[] = {
+	"CODEC", "Mixer"
+};
+
+static const SOC_ENUM_SINGLE_DECL(headset_amp_source, MC13783_AUDIO_RX0, 11,
+				  headset_amp_source_text);
+static const struct snd_kcontrol_new headset_amp_source_mux =
+	SOC_DAPM_ENUM("Headset Amp Source MUX", headset_amp_source);
+
+static const struct snd_kcontrol_new cdcout_ctl =
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 18, 1, 0);
+
+static const struct snd_kcontrol_new adc_bypass_ctl =
+	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_CODEC, 16, 1, 0);
+
 static const struct snd_kcontrol_new lamp_ctl =
 	SOC_DAPM_SINGLE("Switch", MC13783_AUDIO_RX0, 5, 1, 0);
 
@@ -464,12 +487,22 @@ static const struct snd_soc_dapm_widget mc13783_dapm_widgets[] = {
 	SND_SOC_DAPM_VIRT_MUX("PGA Right Input Mux", SND_SOC_NOPM, 0, 0,
 			      &right_input_mux),
 
+	SND_SOC_DAPM_MUX("Speaker Amp Source MUX", SND_SOC_NOPM, 0, 0,
+			 &speaker_amp_source_mux),
+
+	SND_SOC_DAPM_MUX("Headset Amp Source MUX", SND_SOC_NOPM, 0, 0,
+			 &headset_amp_source_mux),
+
 	SND_SOC_DAPM_PGA("PGA Left Input", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("PGA Right Input", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_ADC("ADC", "Capture", MC13783_AUDIO_CODEC, 11, 0),
 	SND_SOC_DAPM_SUPPLY("ADC_Reset", MC13783_AUDIO_CODEC, 15, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("Voice CODEC PGA", MC13783_AUDIO_RX1, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SWITCH("Voice CODEC Bypass", MC13783_AUDIO_CODEC, 16, 0,
+			&adc_bypass_ctl),
+
 /* Output */
 	SND_SOC_DAPM_SUPPLY("DAC_E", MC13783_AUDIO_DAC, 11, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DAC_Reset", MC13783_AUDIO_DAC, 15, 0, NULL, 0),
@@ -477,10 +510,15 @@ static const struct snd_soc_dapm_widget mc13783_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("RXOUTR"),
 	SND_SOC_DAPM_OUTPUT("HSL"),
 	SND_SOC_DAPM_OUTPUT("HSR"),
+	SND_SOC_DAPM_OUTPUT("LSPL"),
 	SND_SOC_DAPM_OUTPUT("LSP"),
 	SND_SOC_DAPM_OUTPUT("SP"),
+	SND_SOC_DAPM_OUTPUT("CDCOUT"),
 
-	SND_SOC_DAPM_SWITCH("Speaker Amp", MC13783_AUDIO_RX0, 3, 0, &samp_ctl),
+	SND_SOC_DAPM_SWITCH("CDCOUT Switch", MC13783_AUDIO_RX0, 18, 0,
+			&cdcout_ctl),
+	SND_SOC_DAPM_SWITCH("Speaker Amp Switch", MC13783_AUDIO_RX0, 3, 0,
+			&samp_ctl),
 	SND_SOC_DAPM_SWITCH("Loudspeaker Amp", SND_SOC_NOPM, 0, 0, &lamp_ctl),
 	SND_SOC_DAPM_SWITCH("Headset Amp Left", MC13783_AUDIO_RX0, 10, 0,
 			&hlamp_ctl),
@@ -515,20 +553,28 @@ static struct snd_soc_dapm_route mc13783_routes[] = {
 	{ "ADC", NULL, "PGA Right Input"},
 	{ "ADC", NULL, "ADC_Reset"},
 
+	{ "Voice CODEC PGA", "Voice CODEC Bypass", "ADC" },
+
+	{ "Speaker Amp Source MUX", "CODEC", "Voice CODEC PGA"},
+	{ "Speaker Amp Source MUX", "Right", "DAC PGA"},
+
+	{ "Headset Amp Source MUX", "CODEC", "Voice CODEC PGA"},
+	{ "Headset Amp Source MUX", "Mixer", "DAC PGA"},
+
 /* Output */
 	{ "HSL", NULL, "Headset Amp Left" },
 	{ "HSR", NULL, "Headset Amp Right"},
 	{ "RXOUTL", NULL, "Line out Amp Left"},
 	{ "RXOUTR", NULL, "Line out Amp Right"},
-	{ "SP", NULL, "Speaker Amp"},
-	{ "Speaker Amp", NULL, "DAC PGA"},
-	{ "LSP", NULL, "DAC PGA"},
-	{ "Headset Amp Left", NULL, "DAC PGA"},
-	{ "Headset Amp Right", NULL, "DAC PGA"},
+	{ "SP", "Speaker Amp Switch", "Speaker Amp Source MUX"},
+	{ "LSP", "Loudspeaker Amp", "Speaker Amp Source MUX"},
+	{ "HSL", "Headset Amp Left", "Headset Amp Source MUX"},
+	{ "HSR", "Headset Amp Right", "Headset Amp Source MUX"},
 	{ "Line out Amp Left", NULL, "DAC PGA"},
 	{ "Line out Amp Right", NULL, "DAC PGA"},
 	{ "DAC PGA", NULL, "DAC"},
 	{ "DAC", NULL, "DAC_E"},
+	{ "CDCOUT", "CDCOUT Switch", "Voice CODEC PGA"},
 };
 
 static const char * const mc13783_3d_mixer[] = {"Stereo", "Phase Mix",
-- 
1.8.4.rc3
