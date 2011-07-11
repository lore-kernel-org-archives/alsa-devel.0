From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use late enable handling for direct
	voice, speaker and headphone
Date: Mon, 11 Jul 2011 10:04:31 +0900
Message-ID: <1310346271-17734-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DA9810384A
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 12:36:08 +0200 (CEST)
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

This ensures appropriate clocking for bypass paths to speaker and
headphone and direct voice paths on affected revisions.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    2 +-
 sound/soc/codecs/wm8994.c  |   30 +++++++++++++++++++++---------
 sound/soc/codecs/wm_hubs.c |    3 ---
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 03af7ad..6e85b88 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -876,7 +876,7 @@ SND_SOC_DAPM_MIXER("SPKL", WM8993_POWER_MANAGEMENT_3, 8, 0,
 		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
 SND_SOC_DAPM_MIXER("SPKR", WM8993_POWER_MANAGEMENT_3, 9, 0,
 		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
-
+SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route routes[] = {
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8d1258c..96ea69b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1146,13 +1146,33 @@ SND_SOC_DAPM_PGA_E("Late DAC2L Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
 	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
 SND_SOC_DAPM_PGA_E("Late DAC2R Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
 	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0,
+	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+
+SND_SOC_DAPM_MIXER_E("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
+		     left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer),
+		     late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_MIXER_E("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
+		     right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer),
+		     late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_MUX_E("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux,
+		   late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_MUX_E("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux,
+		   late_enable_ev, SND_SOC_DAPM_PRE_PMU),
 
 SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
 };
 
 static const struct snd_soc_dapm_widget wm8994_lateclk_widgets[] = {
 SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0)
+SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
+		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
+SND_SOC_DAPM_MIXER("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
+		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
+SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
+SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
 };
 
 static const struct snd_soc_dapm_widget wm8994_dac_revd_widgets[] = {
@@ -1283,14 +1303,6 @@ SND_SOC_DAPM_ADC("DMIC1R", NULL, WM8994_POWER_MANAGEMENT_4, 2, 0),
 SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 1, 0),
 SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
-SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
-SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
-
-SND_SOC_DAPM_MIXER("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
-		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
-SND_SOC_DAPM_MIXER("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
-		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
-
 SND_SOC_DAPM_POST("Debug log", post_ev),
 };
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2d6c88b..7e60e22 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -598,9 +598,6 @@ SND_SOC_DAPM_MIXER("IN2L PGA", WM8993_POWER_MANAGEMENT_2, 7, 0,
 SND_SOC_DAPM_MIXER("IN2R PGA", WM8993_POWER_MANAGEMENT_2, 5, 0,
 		   in2r_pga, ARRAY_SIZE(in2r_pga)),
 
-/* Dummy widgets to represent differential paths */
-SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
-
 SND_SOC_DAPM_MIXER("MIXINL", WM8993_POWER_MANAGEMENT_2, 9, 0,
 		   mixinl, ARRAY_SIZE(mixinl)),
 SND_SOC_DAPM_MIXER("MIXINR", WM8993_POWER_MANAGEMENT_2, 8, 0,
-- 
1.7.5.4
