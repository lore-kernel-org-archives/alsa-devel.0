From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: Convert wm8978 to table based DAPM
	and control init
Date: Thu, 29 Dec 2011 11:49:11 +0000
Message-ID: <1325159355-31686-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44C5924707
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:26 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 2ba8f8c..36468f8 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -302,7 +302,7 @@ static const struct snd_soc_dapm_widget wm8978_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("RSPK"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8978_dapm_routes[] = {
 	/* Output mixer */
 	{"Right Output Mixer", "PCM Playback Switch", "Right DAC"},
 	{"Right Output Mixer", "Aux Playback Switch", "RAUX"},
@@ -351,18 +351,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Left Input Mixer", "MicP Switch", "LMICP"},
 };
 
-static int wm8978_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8978_dapm_widgets,
-				  ARRAY_SIZE(wm8978_dapm_widgets));
-	/* set up the WM8978 audio map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 /* PLL divisors */
 struct wm8978_pll_div {
 	u32 k;
@@ -975,10 +963,6 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	snd_soc_add_controls(codec, wm8978_snd_controls,
-			     ARRAY_SIZE(wm8978_snd_controls));
-	wm8978_add_widgets(codec);
-
 	return 0;
 }
 
@@ -998,6 +982,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.reg_cache_size = ARRAY_SIZE(wm8978_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8978_reg,
+
+	.controls = wm8978_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8978_snd_controls),
+	.dapm_widgets = wm8978_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8978_dapm_widgets),
+	.dapm_routes = wm8978_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8978_dapm_routes),
 };
 
 static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
-- 
1.7.7.3
