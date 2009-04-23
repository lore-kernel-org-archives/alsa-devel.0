From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/21] ASoC: Implement WM8903 digital sidetone
	support
Date: Thu, 23 Apr 2009 20:55:48 +0100
Message-ID: <1240516555-22249-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ACAFE1038AD
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:05 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index bec418a..d8a9222 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -533,6 +533,7 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 /* ALSA can only do steps of .01dB */
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
 
+static const DECLARE_TLV_DB_SCALE(digital_sidetone_tlv, -3600, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -5700, 100, 0);
 
 static const DECLARE_TLV_DB_SCALE(drc_tlv_thresh, 0, 75, 0);
@@ -651,6 +652,16 @@ static const struct soc_enum rinput_inv_enum =
 	SOC_ENUM_SINGLE(WM8903_ANALOGUE_RIGHT_INPUT_1, 4, 3, rinput_mux_text);
 
 
+static const char *sidetone_text[] = {
+	"None", "Left", "Right"
+};
+
+static const struct soc_enum lsidetone_enum =
+	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 2, 3, sidetone_text);
+
+static const struct soc_enum rsidetone_enum =
+	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 0, 3, sidetone_text);
+
 static const struct snd_kcontrol_new wm8903_snd_controls[] = {
 
 /* Input PGAs - No TLV since the scale depends on PGA mode */
@@ -694,6 +705,9 @@ SOC_DOUBLE_R_TLV("Digital Capture Volume", WM8903_ADC_DIGITAL_VOLUME_LEFT,
 SOC_ENUM("ADC Companding Mode", adc_companding),
 SOC_SINGLE("ADC Companding Switch", WM8903_AUDIO_INTERFACE_0, 3, 1, 0),
 
+SOC_DOUBLE_TLV("Digital Sidetone Volume", WM8903_DAC_DIGITAL_0, 4, 8,
+	       12, 0, digital_sidetone_tlv),
+
 /* DAC */
 SOC_DOUBLE_R_TLV("Digital Playback Volume", WM8903_DAC_DIGITAL_VOLUME_LEFT,
 		 WM8903_DAC_DIGITAL_VOLUME_RIGHT, 1, 120, 0, digital_tlv),
@@ -756,6 +770,12 @@ static const struct snd_kcontrol_new rinput_mux =
 static const struct snd_kcontrol_new rinput_inv_mux =
 	SOC_DAPM_ENUM("Right Inverting Input Mux", rinput_inv_enum);
 
+static const struct snd_kcontrol_new lsidetone_mux =
+	SOC_DAPM_ENUM("DACL Sidetone Mux", lsidetone_enum);
+
+static const struct snd_kcontrol_new rsidetone_mux =
+	SOC_DAPM_ENUM("DACR Sidetone Mux", rsidetone_enum);
+
 static const struct snd_kcontrol_new left_output_mixer[] = {
 SOC_DAPM_SINGLE("DACL Switch", WM8903_ANALOGUE_LEFT_MIX_0, 3, 1, 0),
 SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_LEFT_MIX_0, 2, 1, 0),
@@ -822,6 +842,9 @@ SND_SOC_DAPM_PGA("Right Input PGA", WM8903_POWER_MANAGEMENT_0, 0, 0, NULL, 0),
 SND_SOC_DAPM_ADC("ADCL", "Left HiFi Capture", WM8903_POWER_MANAGEMENT_6, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", "Right HiFi Capture", WM8903_POWER_MANAGEMENT_6, 0, 0),
 
+SND_SOC_DAPM_MUX("DACL Sidetone", SND_SOC_NOPM, 0, 0, &lsidetone_mux),
+SND_SOC_DAPM_MUX("DACR Sidetone", SND_SOC_NOPM, 0, 0, &rsidetone_mux),
+
 SND_SOC_DAPM_DAC("DACL", "Left Playback", WM8903_POWER_MANAGEMENT_6, 3, 0),
 SND_SOC_DAPM_DAC("DACR", "Right Playback", WM8903_POWER_MANAGEMENT_6, 2, 0),
 
@@ -910,7 +933,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "ADCR", NULL, "Right Input PGA" },
 	{ "ADCR", NULL, "CLK_DSP" },
 
+	{ "DACL Sidetone", "Left", "ADCL" },
+	{ "DACL Sidetone", "Right", "ADCR" },
+	{ "DACR Sidetone", "Left", "ADCL" },
+	{ "DACR Sidetone", "Right", "ADCR" },
+
+	{ "DACL", NULL, "DACL Sidetone" },
 	{ "DACL", NULL, "CLK_DSP" },
+	{ "DACR", NULL, "DACR Sidetone" },
 	{ "DACR", NULL, "CLK_DSP" },
 
 	{ "Left Output Mixer", "Left Bypass Switch", "Left Input PGA" },
-- 
1.5.6.3
