From: Songjun Wu <songjun.wu@atmel.com>
Subject: [RESEND RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
Date: Fri, 13 Mar 2015 15:46:02 +0800
Message-ID: <1426232762-3304-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, fabio.estevam@freescale.com, manuel.lauss@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@vger.kernel.org, voice.shen@atmel.com, linux-sound@vger.kernel.org
Cc: Songjun Wu <songjun.wu@atmel.com>
List-Id: alsa-devel@alsa-project.org

Enable WM8731 to support common clock framework.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---
 sound/soc/codecs/wm8731.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 098c143..8df1550 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/of_device.h>
 #include <linux/mutex.h>
+#include <linux/clk.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -45,6 +46,7 @@ static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8731_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 	struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
 	const struct snd_pcm_hw_constraint_list *constraints;
 	unsigned int sysclk;
@@ -390,6 +392,8 @@ static int wm8731_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	switch (clk_id) {
 	case WM8731_SYSCLK_XTAL:
 	case WM8731_SYSCLK_MCLK:
+		if (wm8731->mclk && clk_set_rate(wm8731->mclk, freq))
+			return -EINVAL;
 		wm8731->sysclk_type = clk_id;
 		break;
 	default:
@@ -491,6 +495,8 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		if (wm8731->mclk)
+			clk_prepare_enable(wm8731->mclk);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
@@ -509,6 +515,8 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
+		if (wm8731->mclk)
+			clk_disable_unprepare(wm8731->mclk);
 		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
@@ -667,6 +675,19 @@ static int wm8731_spi_probe(struct spi_device *spi)
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(wm8731->mclk)) {
+		ret = PTR_ERR(wm8731->mclk);
+		if (ret == -ENOENT) {
+			wm8731->mclk = NULL;
+			dev_warn(&spi->dev, "Assuming static MCLK\n");
+		} else {
+			dev_err(&spi->dev, "Failed to get MCLK: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	mutex_init(&wm8731->lock);
 
 	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
@@ -718,6 +739,19 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
+	wm8731->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(wm8731->mclk)) {
+		ret = PTR_ERR(wm8731->mclk);
+		if (ret == -ENOENT) {
+			wm8731->mclk = NULL;
+			dev_warn(&i2c->dev, "Assuming static MCLK\n");
+		} else {
+			dev_err(&i2c->dev, "Failed to get MCLK: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	mutex_init(&wm8731->lock);
 
 	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
-- 
1.7.9.5

