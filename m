From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: wm8985: Convert to table based DAPM
	and control init
Date: Sat, 21 Jan 2012 15:45:24 +0000
Message-ID: <1327160727-1546-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D3D3103836
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2012 16:45:33 +0100 (CET)
In-Reply-To: <1327160727-1546-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8985.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index e62a4c5..ee3aba3 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -428,7 +428,7 @@ static const struct snd_soc_dapm_widget wm8985_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPKR")
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 	{ "Right Output Mixer", "PCM Switch", "Right DAC" },
 	{ "Right Output Mixer", "Aux Switch", "AUXR" },
 	{ "Right Output Mixer", "Line Switch", "Right Boost Mixer" },
@@ -531,17 +531,6 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int wm8985_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8985_dapm_widgets,
-				  ARRAY_SIZE(wm8985_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map,
-				ARRAY_SIZE(audio_map));
-	return 0;
-}
-
 static int wm8985_reset(struct snd_soc_codec *codec)
 {
 	return snd_soc_write(codec, WM8985_SOFTWARE_RESET, 0x0);
@@ -1017,10 +1006,6 @@ static int wm8985_probe(struct snd_soc_codec *codec)
 	cache[WM8985_BIAS_CTRL] |= WM8985_BIASCUT;
 	codec->cache_sync = 1;
 
-	snd_soc_add_controls(codec, wm8985_snd_controls,
-			     ARRAY_SIZE(wm8985_snd_controls));
-	wm8985_add_widgets(codec);
-
 	wm8985_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 
@@ -1068,9 +1053,16 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.suspend = wm8985_suspend,
 	.resume = wm8985_resume,
 	.set_bias_level = wm8985_set_bias_level,
+
+	.controls = wm8985_snd_controls,
+	.num_controls = ARRAY_SIZE(wm8985_snd_controls),
+	.dapm_widgets = wm8985_dapm_widgets,
 	.reg_cache_size = ARRAY_SIZE(wm8985_reg_defs),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8985_reg_defs
+	.num_dapm_widgets = ARRAY_SIZE(wm8985_dapm_widgets),
+	.dapm_routes = wm8985_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(wm8985_dapm_routes),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.7.3
