From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Manage thermal shutdown for WM8962
Date: Fri,  4 Nov 2011 21:07:36 +0000
Message-ID: <1320440856-5623-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A926D10384A
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 22:07:55 +0100 (CET)
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

Disable the thermal shutdown circuits for headphone and speaker when the
relevant outputs are not enabled in order to save current in idle modes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5202eff..dc85b85 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2692,6 +2692,8 @@ SND_SOC_DAPM_SUPPLY("TOCLK", WM8962_ADDITIONAL_CONTROL_1, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY_S("DSP2", 1, WM8962_DSP2_POWER_MANAGEMENT,
 		      WM8962_DSP2_ENA_SHIFT, 0, dsp2_event,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_SUPPLY("TEMP_HP", WM8962_ADDITIONAL_CONTROL_4, 2, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("TEMP_SPK", WM8962_ADDITIONAL_CONTROL_4, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_MIXER("INPGAL", WM8962_LEFT_INPUT_PGA_CONTROL, 4, 0,
 		   inpgal, ARRAY_SIZE(inpgal)),
@@ -2847,6 +2849,9 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
 
 	{ "HPOUTL", NULL, "HPOUT" },
 	{ "HPOUTR", NULL, "HPOUT" },
+
+	{ "HPOUTL", NULL, "TEMP_HP" },
+	{ "HPOUTR", NULL, "TEMP_HP" },
 };
 
 static const struct snd_soc_dapm_route wm8962_spk_mono_intercon[] = {
@@ -2863,6 +2868,7 @@ static const struct snd_soc_dapm_route wm8962_spk_mono_intercon[] = {
 	{ "Speaker Output", NULL, "Speaker PGA" },
 	{ "Speaker Output", NULL, "SYSCLK" },
 	{ "Speaker Output", NULL, "TOCLK" },
+	{ "Speaker Output", NULL, "TEMP_SPK" },
 
 	{ "SPKOUT", NULL, "Speaker Output" },
 };
@@ -2891,10 +2897,12 @@ static const struct snd_soc_dapm_route wm8962_spk_stereo_intercon[] = {
 	{ "SPKOUTL Output", NULL, "SPKOUTL PGA" },
 	{ "SPKOUTL Output", NULL, "SYSCLK" },
 	{ "SPKOUTL Output", NULL, "TOCLK" },
+	{ "SPKOUTL Output", NULL, "TEMP_SPK" },
 
 	{ "SPKOUTR Output", NULL, "SPKOUTR PGA" },
 	{ "SPKOUTR Output", NULL, "SYSCLK" },
 	{ "SPKOUTR Output", NULL, "TOCLK" },
+	{ "SPKOUTR Output", NULL, "TEMP_SPK" },
 
 	{ "SPKOUTL", NULL, "SPKOUTL Output" },
 	{ "SPKOUTR", NULL, "SPKOUTR Output" },
-- 
1.7.7.1
