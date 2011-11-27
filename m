From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM8903 MICBIAS to a supply widget
Date: Sun, 27 Nov 2011 12:21:57 +0000
Message-ID: <1322396517-7122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7705524395
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 13:28:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Also rename it to MICBIAS to reflect the pin name and help any out of tree
users notice the change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c      |    4 ++--
 sound/soc/tegra/tegra_wm8903.c |   18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 0cf78c1..12dae43 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -843,7 +843,7 @@ SND_SOC_DAPM_OUTPUT("LON"),
 SND_SOC_DAPM_OUTPUT("ROP"),
 SND_SOC_DAPM_OUTPUT("RON"),
 
-SND_SOC_DAPM_MICBIAS("Mic Bias", WM8903_MIC_BIAS_CONTROL_0, 0, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS", WM8903_MIC_BIAS_CONTROL_0, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_MUX("Left Input Mux", SND_SOC_NOPM, 0, 0, &linput_mux),
 SND_SOC_DAPM_MUX("Left Input Inverting Mux", SND_SOC_NOPM, 0, 0,
@@ -952,7 +952,7 @@ SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8903_CLOCK_RATES_2, 2, 0, NULL, 0),
 static const struct snd_soc_dapm_route wm8903_intercon[] = {
 
 	{ "CLK_DSP", NULL, "CLK_SYS" },
-	{ "Mic Bias", NULL, "CLK_SYS" },
+	{ "MICBIAS", NULL, "CLK_SYS" },
 	{ "HPL_DCS", NULL, "CLK_SYS" },
 	{ "HPR_DCS", NULL, "CLK_SYS" },
 	{ "LINEOUTL_DCS", NULL, "CLK_SYS" },
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index b260f54..2f5b107 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -201,8 +201,8 @@ static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"Int Spk", NULL, "RON"},
 	{"Int Spk", NULL, "LOP"},
 	{"Int Spk", NULL, "LON"},
-	{"Mic Bias", NULL, "Mic Jack"},
-	{"IN1L", NULL, "Mic Bias"},
+	{"Mic Jack", NULL, "MICBIAS"},
+	{"IN1L", NULL, "Mic Jack"},
 };
 
 static const struct snd_soc_dapm_route seaboard_audio_map[] = {
@@ -212,8 +212,8 @@ static const struct snd_soc_dapm_route seaboard_audio_map[] = {
 	{"Int Spk", NULL, "RON"},
 	{"Int Spk", NULL, "LOP"},
 	{"Int Spk", NULL, "LON"},
-	{"Mic Bias", NULL, "Mic Jack"},
-	{"IN1R", NULL, "Mic Bias"},
+	{"Mic Jack", NULL, "MICBIAS"},
+	{"IN1R", NULL, "Mic Jack"},
 };
 
 static const struct snd_soc_dapm_route kaen_audio_map[] = {
@@ -223,8 +223,8 @@ static const struct snd_soc_dapm_route kaen_audio_map[] = {
 	{"Int Spk", NULL, "RON"},
 	{"Int Spk", NULL, "LOP"},
 	{"Int Spk", NULL, "LON"},
-	{"Mic Bias", NULL, "Mic Jack"},
-	{"IN2R", NULL, "Mic Bias"},
+	{"Mic Jack", NULL, "MICBIAS"},
+	{"IN2R", NULL, "Mic Jack"},
 };
 
 static const struct snd_soc_dapm_route aebl_audio_map[] = {
@@ -232,8 +232,8 @@ static const struct snd_soc_dapm_route aebl_audio_map[] = {
 	{"Headphone Jack", NULL, "HPOUTL"},
 	{"Int Spk", NULL, "LINEOUTR"},
 	{"Int Spk", NULL, "LINEOUTL"},
-	{"Mic Bias", NULL, "Mic Jack"},
-	{"IN1R", NULL, "Mic Bias"},
+	{"Mic Jack", NULL, "MICBIAS"},
+	{"IN1R", NULL, "Mic Jack"},
 };
 
 static const struct snd_kcontrol_new tegra_wm8903_controls[] = {
@@ -329,7 +329,7 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 	wm8903_mic_detect(codec, &tegra_wm8903_mic_jack, SND_JACK_MICROPHONE,
 				0);
 
-	snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
 
 	return 0;
 }
-- 
1.7.7.3
