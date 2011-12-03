From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/21] ASoC: Convert WM8580 to table based DAPM
	and control init
Date: Sat,  3 Dec 2011 21:33:21 +0000
Message-ID: <1322948009-27658-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54E78243E3
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:40 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 764b2bf..b1c8d3d 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -272,7 +272,7 @@ SND_SOC_DAPM_INPUT("AINL"),
 SND_SOC_DAPM_INPUT("AINR"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8580_dapm_routes[] = {
 	{ "VOUT1L", NULL, "DAC1" },
 	{ "VOUT1R", NULL, "DAC1" },
 
@@ -286,17 +286,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{ "ADC", NULL, "AINR" },
 };
 
-static int wm8580_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets,
-				  ARRAY_SIZE(wm8580_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /* PLL divisors */
 struct _pll_div {
 	u32 prescale:1;
@@ -856,10 +845,6 @@ static int wm8580_probe(struct snd_soc_codec *codec)
 
 	wm8580_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8580_snd_controls,
-			     ARRAY_SIZE(wm8580_snd_controls));
-	wm8580_add_widgets(codec);
-
 	return 0;
 
 err_regulator_enable:
@@ -889,6 +874,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.reg_cache_size = ARRAY_SIZE(wm8580_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8580_reg,
+
+	.controls = wm8580_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8580_snd_controls),
+	.dapm_widgets = wm8580_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8580_dapm_widgets),
+	.dapm_routes = wm8580_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8580_dapm_routes),
 };
 
 static const struct of_device_id wm8580_of_match[] = {
-- 
1.7.7.3
