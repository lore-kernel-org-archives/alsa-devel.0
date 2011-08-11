From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add VMID widget for wm_hubs devices
Date: Thu, 11 Aug 2011 10:57:19 +0900
Message-ID: <1313027840-11894-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D747624459
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 04:10:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently this does not actually do anything, it is being introduced in
order to facilitate additional power optimisations for current generation
devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    4 ++++
 sound/soc/codecs/wm8994.c  |    3 +++
 sound/soc/codecs/wm_hubs.c |   16 ++++++++++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index f014e56..eec8e14 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -847,6 +847,7 @@ SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8993_BUS_CONTROL_1, 1, 0, clk_sys_event,
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_SUPPLY("TOCLK", WM8993_CLOCKING_1, 14, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("CLK_DSP", WM8993_CLOCKING_3, 0, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_ADC("ADCL", NULL, WM8993_POWER_MANAGEMENT_2, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, WM8993_POWER_MANAGEMENT_2, 0, 0),
@@ -880,6 +881,9 @@ SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route routes[] = {
+	{ "MICBIAS1", NULL, "VMID" },
+	{ "MICBIAS2", NULL, "VMID" },
+
 	{ "ADCL", NULL, "CLK_SYS" },
 	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCR", NULL, "CLK_SYS" },
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b70901d..2fb3807 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1171,6 +1171,7 @@ SND_SOC_DAPM_INPUT("Clock"),
 
 SND_SOC_DAPM_SUPPLY_S("MICBIAS Supply", 1, SND_SOC_NOPM, 0, 0, micbias_ev,
 		      SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("CLK_SYS", SND_SOC_NOPM, 0, 0, clk_sys_event,
 		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1488,6 +1489,8 @@ static const struct snd_soc_dapm_route wm8994_revd_intercon[] = {
 static const struct snd_soc_dapm_route wm8994_intercon[] = {
 	{ "AIF2DACL", NULL, "AIF2DAC Mux" },
 	{ "AIF2DACR", NULL, "AIF2DAC Mux" },
+	{ "MICBIAS1", NULL, "VMID" },
+	{ "MICBIAS2", NULL, "VMID" },
 };
 
 static const struct snd_soc_dapm_route wm8958_intercon[] = {
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 017522e..ca8ce03 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -711,6 +711,11 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "IN1L PGA", "IN1LP Switch", "IN1LP" },
 	{ "IN1L PGA", "IN1LN Switch", "IN1LN" },
 
+	{ "IN1L PGA", NULL, "VMID" },
+	{ "IN1R PGA", NULL, "VMID" },
+	{ "IN2L PGA", NULL, "VMID" },
+	{ "IN2R PGA", NULL, "VMID" },
+
 	{ "IN1R PGA", "IN1RP Switch", "IN1RP" },
 	{ "IN1R PGA", "IN1RN Switch", "IN1RN" },
 
@@ -728,12 +733,14 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "MIXINL", NULL, "Direct Voice" },
 	{ "MIXINL", NULL, "IN1LP" },
 	{ "MIXINL", NULL, "Left Output Mixer" },
+	{ "MIXINL", NULL, "VMID" },
 
 	{ "MIXINR", "IN1R Switch", "IN1R PGA" },
 	{ "MIXINR", "IN2R Switch", "IN2R PGA" },
 	{ "MIXINR", NULL, "Direct Voice" },
 	{ "MIXINR", NULL, "IN1RP" },
 	{ "MIXINR", NULL, "Right Output Mixer" },
+	{ "MIXINR", NULL, "VMID" },
 
 	{ "ADCL", NULL, "MIXINL" },
 	{ "ADCR", NULL, "MIXINR" },
@@ -764,6 +771,7 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "Earpiece Mixer", "Left Output Switch", "Left Output PGA" },
 	{ "Earpiece Mixer", "Right Output Switch", "Right Output PGA" },
 
+	{ "Earpiece Driver", NULL, "VMID" },
 	{ "Earpiece Driver", NULL, "Earpiece Mixer" },
 	{ "HPOUT2N", NULL, "Earpiece Driver" },
 	{ "HPOUT2P", NULL, "Earpiece Driver" },
@@ -786,9 +794,11 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 	{ "SPKR Boost", "SPKR Switch", "SPKR" },
 	{ "SPKR Boost", "SPKL Switch", "SPKL" },
 
+	{ "SPKL Driver", NULL, "VMID" },
 	{ "SPKL Driver", NULL, "SPKL Boost" },
 	{ "SPKL Driver", NULL, "CLK_SYS" },
 
+	{ "SPKR Driver", NULL, "VMID" },
 	{ "SPKR Driver", NULL, "SPKR Boost" },
 	{ "SPKR Driver", NULL, "CLK_SYS" },
 
@@ -802,12 +812,18 @@ static const struct snd_soc_dapm_route analogue_routes[] = {
 
 	{ "Headphone PGA", NULL, "Left Headphone Mux" },
 	{ "Headphone PGA", NULL, "Right Headphone Mux" },
+	{ "Headphone PGA", NULL, "VMID" },
 	{ "Headphone PGA", NULL, "CLK_SYS" },
 	{ "Headphone PGA", NULL, "Headphone Supply" },
 
 	{ "HPOUT1L", NULL, "Headphone PGA" },
 	{ "HPOUT1R", NULL, "Headphone PGA" },
 
+	{ "LINEOUT1N Driver", NULL, "VMID" },
+	{ "LINEOUT1P Driver", NULL, "VMID" },
+	{ "LINEOUT2N Driver", NULL, "VMID" },
+	{ "LINEOUT2P Driver", NULL, "VMID" },
+
 	{ "LINEOUT1N", NULL, "LINEOUT1N Driver" },
 	{ "LINEOUT1P", NULL, "LINEOUT1P Driver" },
 	{ "LINEOUT2N", NULL, "LINEOUT2N Driver" },
-- 
1.7.5.4
