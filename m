From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Use shared controls for input signal
	path in WM8915
Date: Tue,  3 May 2011 19:43:17 +0100
Message-ID: <1304448198-6189-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 246FF243B2
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 20:43:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Gives finer grained power management.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 4a3c5cc..0dc1dd7 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -991,10 +991,10 @@ SND_SOC_DAPM_MICBIAS("MICB1", WM8915_POWER_MANAGEMENT_1, 8, 0),
 SND_SOC_DAPM_PGA("IN1L PGA", WM8915_POWER_MANAGEMENT_2, 5, 0, NULL, 0),
 SND_SOC_DAPM_PGA("IN1R PGA", WM8915_POWER_MANAGEMENT_2, 4, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA("ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
-
-SND_SOC_DAPM_MUX("IN1 Mux", SND_SOC_NOPM, 0, 0, &in1_mux),
-SND_SOC_DAPM_MUX("IN2 Mux", SND_SOC_NOPM, 0, 0, &in2_mux),
+SND_SOC_DAPM_MUX("IN1L Mux", SND_SOC_NOPM, 0, 0, &in1_mux),
+SND_SOC_DAPM_MUX("IN1R Mux", SND_SOC_NOPM, 0, 0, &in1_mux),
+SND_SOC_DAPM_MUX("IN2L Mux", SND_SOC_NOPM, 0, 0, &in2_mux),
+SND_SOC_DAPM_MUX("IN2R Mux", SND_SOC_NOPM, 0, 0, &in2_mux),
 
 SND_SOC_DAPM_PGA("IN1L", WM8915_POWER_MANAGEMENT_7, 2, 0, NULL, 0),
 SND_SOC_DAPM_PGA("IN1R", WM8915_POWER_MANAGEMENT_7, 3, 0, NULL, 0),
@@ -1172,28 +1172,33 @@ static const struct snd_soc_dapm_route wm8915_dapm_routes[] = {
 	{ "DMIC1L", NULL, "DMIC1" },
 	{ "DMIC1R", NULL, "DMIC1" },
 
-	{ "ADC", NULL, "ADCL" },
-	{ "ADC", NULL, "ADCR" },
+	{ "IN1L Mux", "ADC", "ADCL" },
+	{ "IN1L Mux", "DMIC1", "DMIC1L" },
+	{ "IN1L Mux", "DMIC2", "DMIC2L" },
+
+	{ "IN1R Mux", "ADC", "ADCR" },
+	{ "IN1R Mux", "DMIC1", "DMIC1R" },
+	{ "IN1R Mux", "DMIC2", "DMIC2R" },
 
-	{ "IN1 Mux", "ADC", "ADC" },
-	{ "IN1 Mux", "DMIC1", "DMIC1" },
-	{ "IN1 Mux", "DMIC2", "DMIC2" },
+	{ "IN2L Mux", "ADC", "ADCL" },
+	{ "IN2L Mux", "DMIC1", "DMIC1L" },
+	{ "IN2L Mux", "DMIC2", "DMIC2L" },
 
-	{ "IN2 Mux", "ADC", "ADC" },
-	{ "IN2 Mux", "DMIC1", "DMIC1" },
-	{ "IN2 Mux", "DMIC2", "DMIC2" },
+	{ "IN2R Mux", "ADC", "ADCR" },
+	{ "IN2R Mux", "DMIC1", "DMIC1R" },
+	{ "IN2R Mux", "DMIC2", "DMIC2R" },
 
-	{ "Left Sidetone", "IN1", "IN1 Mux" },
-	{ "Left Sidetone", "IN2", "IN2 Mux" },
+	{ "Left Sidetone", "IN1", "IN1L Mux" },
+	{ "Left Sidetone", "IN2", "IN2L Mux" },
 
-	{ "Right Sidetone", "IN1", "IN1 Mux" },
-	{ "Right Sidetone", "IN2", "IN2 Mux" },
+	{ "Right Sidetone", "IN1", "IN1R Mux" },
+	{ "Right Sidetone", "IN2", "IN2R Mux" },
 
-	{ "DSP1TXL", "IN1 Switch", "IN1 Mux" },
-	{ "DSP1TXR", "IN1 Switch", "IN1 Mux" },
+	{ "DSP1TXL", "IN1 Switch", "IN1L Mux" },
+	{ "DSP1TXR", "IN1 Switch", "IN1R Mux" },
 
-	{ "DSP2TXL", "IN1 Switch", "IN2 Mux" },
-	{ "DSP2TXR", "IN1 Switch", "IN2 Mux" },
+	{ "DSP2TXL", "IN1 Switch", "IN2L Mux" },
+	{ "DSP2TXR", "IN1 Switch", "IN2R Mux" },
 
 	{ "AIF1TX0", NULL, "DSP1TXL" },
 	{ "AIF1TX1", NULL, "DSP1TXR" },
-- 
1.7.4.1
