From: Stephen Warren <swarren@nvidia.com>
Subject: WM8903 DMIC, and stereo mux vs. 2 mono muxes
Date: Sat, 16 Apr 2011 22:29:45 -0600
Message-ID: <1303014585-32331-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC5D1037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Apr 2011 06:30:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

In the WM8903, most muxes are implemented separately for the L and R
paths, such that for each channel, there is a soc_enum, and kcontrol_new
containing a SOC_DAPM_ENUM, a widget of type SND_SOC_DAPM_MUX, and of
course a separate register bit for each. In other words, 1 mono muxes.

I couldn't find any obvious cases where other codecs deviated from this.

However, the DMIC mux in the wm8903 is a single register bit that
controls both channels. In other words, a single stereo mux. I'm having
trouble working out how to represent this to DAPM. 

I ended up with the patch below (note: not against mainline yet), which
seems to work OK, but ends up showing two controls in alsamixer rather
than just one. A least when one control is changed, the other reflects
the change, so they stay in sync.

I tried other setups, such as a single widget of type SND_SOC_DAPM_MUX,
and having the DAPM routes for that connect to both ADCL and ADCR paths,
but (a) that confused the ASoC core, such that controls for subsequent
paths in the list were not created, and those related to the ADC input
paths would not work, and (b) I suspect that if it worked, it'd produce
non-optimal HW programming in the case where only a single ADC channel
was actually used, since the mux would imply it was hooked up to both,
so both ADCs would be powered even though only one was needed.

So, is there a way to correctly represent this while only exposing a
single control for it?

Thanks!

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ae1cadf..bbc9aff 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -636,6 +636,13 @@ static const struct soc_enum lsidetone_enum =
 static const struct soc_enum rsidetone_enum =
 	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 0, 3, sidetone_text);
 
+static const char *dsp_text[] = {
+	"ADC", "DMIC"
+};
+
+static const struct soc_enum dsp_enum =
+	SOC_ENUM_SINGLE(WM8903_CLOCK_RATE_TEST_4, 9, 2, dsp_text);
+
 static const char *aif_text[] = {
 	"Left", "Right"
 };
@@ -769,6 +776,9 @@ static const struct snd_kcontrol_new lsidetone_mux =
 static const struct snd_kcontrol_new rsidetone_mux =
 	SOC_DAPM_ENUM("DACR Sidetone Mux", rsidetone_enum);
 
+static const struct snd_kcontrol_new dsp_mux =
+	SOC_DAPM_ENUM("DSP Mux", dsp_enum);
+
 static const struct snd_kcontrol_new lcapture_mux =
 	SOC_DAPM_ENUM("Left Capture Mux", lcapture_enum);
 
@@ -819,6 +829,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
 SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
+SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
 SND_SOC_DAPM_OUTPUT("HPOUTR"),
@@ -847,6 +858,12 @@ SND_SOC_DAPM_PGA("Right Input PGA", WM8903_POWER_MANAGEMENT_0, 0, 0, NULL, 0),
 SND_SOC_DAPM_ADC("ADCL", NULL, WM8903_POWER_MANAGEMENT_6, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, WM8903_POWER_MANAGEMENT_6, 0, 0),
 
+SND_SOC_DAPM_ADC("DMICL", NULL, SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_ADC("DMICR", NULL, SND_SOC_NOPM, 0, 0),
+
+SND_SOC_DAPM_MUX("Left DSP Mux", SND_SOC_NOPM, 0, 0, &dsp_mux),
+SND_SOC_DAPM_MUX("Right DSP Mux", SND_SOC_NOPM, 0, 0, &dsp_mux),
+
 SND_SOC_DAPM_MUX("Left Capture Mux", SND_SOC_NOPM, 0, 0, &lcapture_mux),
 SND_SOC_DAPM_MUX("Right Capture Mux", SND_SOC_NOPM, 0, 0, &rcapture_mux),
 
@@ -975,11 +992,17 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Left Input PGA", NULL, "Left Input Mode Mux" },
 	{ "Right Input PGA", NULL, "Right Input Mode Mux" },
 
-	{ "Left Capture Mux", "Left", "ADCL" },
-	{ "Left Capture Mux", "Right", "ADCR" },
+	{ "Left DSP Mux", "ADC", "ADCL" },
+	{ "Left DSP Mux", "DMIC", "DMICL" },
+
+	{ "Right DSP Mux", "ADC", "ADCR" },
+	{ "Right DSP Mux", "DMIC", "DMICR" },
 
-	{ "Right Capture Mux", "Left", "ADCL" },
-	{ "Right Capture Mux", "Right", "ADCR" },
+	{ "Left Capture Mux", "Left", "Left DSP Mux" },
+	{ "Left Capture Mux", "Right", "Right DSP Mux" },
+
+	{ "Right Capture Mux", "Left", "Left DSP Mux" },
+	{ "Right Capture Mux", "Right", "Right DSP Mux" },
 
 	{ "AIFTXL", NULL, "Left Capture Mux" },
 	{ "AIFTXR", NULL, "Right Capture Mux" },
@@ -989,6 +1012,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "ADCR", NULL, "Right Input PGA" },
 	{ "ADCR", NULL, "CLK_DSP" },
 
+	{ "DMICL", NULL, "DMICDAT" },
+	{ "DMICL", NULL, "CLK_DSP" },
+	{ "DMICR", NULL, "DMICDAT" },
+	{ "DMICR", NULL, "CLK_DSP" },
+
 	{ "Left Playback Mux", "Left", "AIFRXL" },
 	{ "Left Playback Mux", "Right", "AIFRXR" },
 
