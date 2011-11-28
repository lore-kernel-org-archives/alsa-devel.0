From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: ad193X: Use table based DAPM and controls setup
Date: Mon, 28 Nov 2011 17:28:06 +0100
Message-ID: <1322497692-27868-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad193x.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 1901cd2..1dfda5c 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -345,7 +345,6 @@ static struct snd_soc_dai_driver ad193x_dai = {
 static int ad193x_probe(struct snd_soc_codec *codec)
 {
 	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
 	codec->control_data = ad193x->regmap;
@@ -371,17 +370,17 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
 	snd_soc_write(codec, AD193X_PLL_CLK_CTRL1, 0x04);
 
-	snd_soc_add_controls(codec, ad193x_snd_controls,
-			     ARRAY_SIZE(ad193x_snd_controls));
-	snd_soc_dapm_new_controls(dapm, ad193x_dapm_widgets,
-				  ARRAY_SIZE(ad193x_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_paths, ARRAY_SIZE(audio_paths));
-
 	return ret;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
 	.probe = 	ad193x_probe,
+	.controls = ad193x_snd_controls,
+	.num_controls = ARRAY_SIZE(ad193x_snd_controls),
+	.dapm_widgets = ad193x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ad193x_dapm_widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.7.3
