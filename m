From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: WM8903: Implement DMIC support
Date: Mon, 18 Apr 2011 20:58:11 -0600
Message-ID: <1303181891-25064-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D8EF103837
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Apr 2011 04:58:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

In addition to the currently supported analog capture path, the WM8903
also supports digital mics.

The analog and digital capture paths are exclusive; a mux is present to
select the capture source.

Logically, the mux exists to select the decimator's input, from either
the ADC or DMIC block outputs. However, the ADC power domain also
includes the DMIC interface. Consequently, this change represents the
mux as existing immediately before the ADC, and selecting between the
Input PGA and DMIC block outputs.

An alternative might be to represent the mux in its correct location,
and associate the ADC power enable controls with both the real ADC, and
a fake ADC for the DMIC?

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/wm8903.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d53f206..f3cab84 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -634,6 +634,13 @@ static const struct soc_enum lsidetone_enum =
 static const struct soc_enum rsidetone_enum =
 	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 0, 3, sidetone_text);
 
+static const char *adcinput_text[] = {
+	"ADC", "DMIC"
+};
+
+static const struct soc_enum adcinput_enum =
+	SOC_ENUM_SINGLE(WM8903_CLOCK_RATE_TEST_4, 9, 2, adcinput_text);
+
 static const char *aif_text[] = {
 	"Left", "Right"
 };
@@ -767,6 +774,9 @@ static const struct snd_kcontrol_new lsidetone_mux =
 static const struct snd_kcontrol_new rsidetone_mux =
 	SOC_DAPM_ENUM("DACR Sidetone Mux", rsidetone_enum);
 
+static const struct snd_kcontrol_new adcinput_mux =
+	SOC_DAPM_ENUM("ADC Input", adcinput_enum);
+
 static const struct snd_kcontrol_new lcapture_mux =
 	SOC_DAPM_ENUM("Left Capture Mux", lcapture_enum);
 
@@ -817,6 +827,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
 SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
+SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
 SND_SOC_DAPM_OUTPUT("HPOUTR"),
@@ -842,6 +853,9 @@ SND_SOC_DAPM_MUX("Right Input Mode Mux", SND_SOC_NOPM, 0, 0, &rinput_mode_mux),
 SND_SOC_DAPM_PGA("Left Input PGA", WM8903_POWER_MANAGEMENT_0, 1, 0, NULL, 0),
 SND_SOC_DAPM_PGA("Right Input PGA", WM8903_POWER_MANAGEMENT_0, 0, 0, NULL, 0),
 
+SND_SOC_DAPM_MUX("Left ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
+SND_SOC_DAPM_MUX("Right ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
+
 SND_SOC_DAPM_ADC("ADCL", NULL, WM8903_POWER_MANAGEMENT_6, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, WM8903_POWER_MANAGEMENT_6, 0, 0),
 
@@ -979,6 +993,11 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "Left Input PGA", NULL, "Left Input Mode Mux" },
 	{ "Right Input PGA", NULL, "Right Input Mode Mux" },
 
+	{ "Left ADC Input", "ADC", "Left Input PGA" },
+	{ "Left ADC Input", "DMIC", "DMICDAT" },
+	{ "Right ADC Input", "ADC", "Right Input PGA" },
+	{ "Right ADC Input", "DMIC", "DMICDAT" },
+
 	{ "Left Capture Mux", "Left", "ADCL" },
 	{ "Left Capture Mux", "Right", "ADCR" },
 
@@ -988,9 +1007,9 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "AIFTXL", NULL, "Left Capture Mux" },
 	{ "AIFTXR", NULL, "Right Capture Mux" },
 
-	{ "ADCL", NULL, "Left Input PGA" },
+	{ "ADCL", NULL, "Left ADC Input" },
 	{ "ADCL", NULL, "CLK_DSP" },
-	{ "ADCR", NULL, "Right Input PGA" },
+	{ "ADCR", NULL, "Right ADC Input" },
 	{ "ADCR", NULL, "CLK_DSP" },
 
 	{ "Left Playback Mux", "Left", "AIFRXL" },
-- 
1.7.1
