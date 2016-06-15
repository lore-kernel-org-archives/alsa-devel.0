From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: adau17x1: Add support for specifying the
	MCLK using the CCF
Date: Wed, 15 Jun 2016 13:09:47 +0200
Message-ID: <1465988987-29458-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 160292651C7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 13:09:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The devices from the ADAU17X1 family all have a MCLK clock input which
supplies the master clock for the device. The master clock is used as the
input clock for the PLL. Currently the MCLK rate as well as the desired PLL
output frequency need to be supplied by calling snd_soc_dai_set_pll() form
a machine driver.

Add support for specifying the MCLK using the common clock framework. In
addition to that also automatically configure the PLL to a suitable rate
if the master clock was provided using the CCW. This allows to use the
CODEC driver without any special configuration requirements from the
machine driver.

While the PLL output frequency can be configured over a (more or less)
continuous range the narrowness of the range and the other constraints of
the clocking tree usually only result in two output frequencies that will
actually be chosen. One for 44.1kHz based rates and one for 48kHz based
rates, these are the rates that the automatic PLL configuration will use.
For the rare case where a non-standard setup is required a machine driver
can disable the auto-configuration and configure a custom frequency using
the existing mechanisms.

If the common clock framework is not enabled clk_get() will return NULL and
the driver will function as before and the clock rate needs to be
configured manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 .../devicetree/bindings/sound/adi,adau17x1.txt     |   8 +
 sound/soc/codecs/adau1761-i2c.c                    |   2 +-
 sound/soc/codecs/adau1761-spi.c                    |   2 +-
 sound/soc/codecs/adau1781-i2c.c                    |   2 +-
 sound/soc/codecs/adau1781-spi.c                    |   2 +-
 sound/soc/codecs/adau17x1.c                        | 219 +++++++++++++++------
 sound/soc/codecs/adau17x1.h                        |   6 +
 7 files changed, 179 insertions(+), 62 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
index 8dbce0e..1447dec 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
@@ -13,6 +13,11 @@ Required properties:
  - reg:			The i2c address. Value depends on the state of ADDR0
 			and ADDR1, as wired in hardware.
 
+Optional properties:
+ - clock-names:		If provided must be "mclk".
+ - clocks:		phandle + clock-specifiers for the clock that provides
+			the audio master clock for the device.
+
 Examples:
 #include <dt-bindings/sound/adau17x1.h>
 
@@ -20,5 +25,8 @@ Examples:
 		adau1361@38 {
 			compatible = "adi,adau1761";
 			reg = <0x38>;
+
+			clock-names = "mclk";
+			clocks = <&audio_clock>;
 		};
 	};
diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau1761-i2c.c
index 8de010f..9e7f257 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -31,7 +31,7 @@ static int adau1761_i2c_probe(struct i2c_client *client,
 
 static int adau1761_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
+	adau17x1_remove(&client->dev);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau1761-spi.c
index d917124..a0b214b 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -48,7 +48,7 @@ static int adau1761_spi_probe(struct spi_device *spi)
 
 static int adau1761_spi_remove(struct spi_device *spi)
 {
-	snd_soc_unregister_codec(&spi->dev);
+	adau17x1_remove(&spi->dev);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/adau1781-i2c.c b/sound/soc/codecs/adau1781-i2c.c
index 06cbca8..7b9d180 100644
--- a/sound/soc/codecs/adau1781-i2c.c
+++ b/sound/soc/codecs/adau1781-i2c.c
@@ -31,7 +31,7 @@ static int adau1781_i2c_probe(struct i2c_client *client,
 
 static int adau1781_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
+	adau17x1_remove(&client->dev);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/adau1781-spi.c b/sound/soc/codecs/adau1781-spi.c
index 3d965a0..9b23354 100644
--- a/sound/soc/codecs/adau1781-spi.c
+++ b/sound/soc/codecs/adau1781-spi.c
@@ -48,7 +48,7 @@ static int adau1781_spi_probe(struct spi_device *spi)
 
 static int adau1781_spi_remove(struct spi_device *spi)
 {
-	snd_soc_unregister_codec(&spi->dev);
+	adau17x1_remove(&spi->dev);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 66a6e06..439aa3f 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -303,6 +304,116 @@ bool adau17x1_has_dsp(struct adau *adau)
 }
 EXPORT_SYMBOL_GPL(adau17x1_has_dsp);
 
+static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
+	int source, unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct adau *adau = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	if (freq_in < 8000000 || freq_in > 27000000)
+		return -EINVAL;
+
+	ret = adau_calc_pll_cfg(freq_in, freq_out, adau->pll_regs);
+	if (ret < 0)
+		return ret;
+
+	/* The PLL register is 6 bytes long and can only be written at once. */
+	ret = regmap_raw_write(adau->regmap, ADAU17X1_PLL_CONTROL,
+			adau->pll_regs, ARRAY_SIZE(adau->pll_regs));
+	if (ret)
+		return ret;
+
+	adau->pll_freq = freq_out;
+
+	return 0;
+}
+
+static int adau17x1_set_dai_sysclk(struct snd_soc_dai *dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(dai->codec);
+	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+	bool is_pll;
+	bool was_pll;
+
+	switch (clk_id) {
+	case ADAU17X1_CLK_SRC_MCLK:
+		is_pll = false;
+		break;
+	case ADAU17X1_CLK_SRC_PLL_AUTO:
+		if (!adau->mclk)
+			return -EINVAL;
+		/* Fall-through */
+	case ADAU17X1_CLK_SRC_PLL:
+		is_pll = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (adau->clk_src) {
+	case ADAU17X1_CLK_SRC_MCLK:
+		was_pll = false;
+		break;
+	case ADAU17X1_CLK_SRC_PLL:
+	case ADAU17X1_CLK_SRC_PLL_AUTO:
+		was_pll = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adau->sysclk = freq;
+
+	if (is_pll != was_pll) {
+		if (is_pll) {
+			snd_soc_dapm_add_routes(dapm,
+				&adau17x1_dapm_pll_route, 1);
+		} else {
+			snd_soc_dapm_del_routes(dapm,
+				&adau17x1_dapm_pll_route, 1);
+		}
+	}
+
+	adau->clk_src = clk_id;
+
+	return 0;
+}
+
+static int adau17x1_auto_pll(struct snd_soc_dai *dai,
+	struct snd_pcm_hw_params *params)
+{
+	struct adau *adau = snd_soc_dai_get_drvdata(dai);
+	unsigned int pll_rate;
+
+	switch (params_rate(params)) {
+	case 48000:
+	case 8000:
+	case 12000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 96000:
+		pll_rate = 48000 * 1024;
+		break;
+	case 44100:
+	case 7350:
+	case 11025:
+	case 14700:
+	case 22050:
+	case 29400:
+	case 88200:
+		pll_rate = 44100 * 1024;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return adau17x1_set_dai_pll(dai, ADAU17X1_PLL, ADAU17X1_PLL_SRC_MCLK,
+		clk_get_rate(adau->mclk), pll_rate);
+}
+
 static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -312,10 +423,19 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 	unsigned int freq;
 	int ret;
 
-	if (adau->clk_src == ADAU17X1_CLK_SRC_PLL)
+	switch (adau->clk_src) {
+	case ADAU17X1_CLK_SRC_PLL_AUTO:
+		ret = adau17x1_auto_pll(dai, params);
+		if (ret)
+			return ret;
+		/* Fall-through */
+	case ADAU17X1_CLK_SRC_PLL:
 		freq = adau->pll_freq;
-	else
+		break;
+	default:
 		freq = adau->sysclk;
+		break;
+	}
 
 	if (freq % params_rate(params) != 0)
 		return -EINVAL;
@@ -387,62 +507,6 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 			ADAU17X1_SERIAL_PORT1_DELAY_MASK, val);
 }
 
-static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
-	int source, unsigned int freq_in, unsigned int freq_out)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct adau *adau = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	if (freq_in < 8000000 || freq_in > 27000000)
-		return -EINVAL;
-
-	ret = adau_calc_pll_cfg(freq_in, freq_out, adau->pll_regs);
-	if (ret < 0)
-		return ret;
-
-	/* The PLL register is 6 bytes long and can only be written at once. */
-	ret = regmap_raw_write(adau->regmap, ADAU17X1_PLL_CONTROL,
-			adau->pll_regs, ARRAY_SIZE(adau->pll_regs));
-	if (ret)
-		return ret;
-
-	adau->pll_freq = freq_out;
-
-	return 0;
-}
-
-static int adau17x1_set_dai_sysclk(struct snd_soc_dai *dai,
-		int clk_id, unsigned int freq, int dir)
-{
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(dai->codec);
-	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
-
-	switch (clk_id) {
-	case ADAU17X1_CLK_SRC_MCLK:
-	case ADAU17X1_CLK_SRC_PLL:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	adau->sysclk = freq;
-
-	if (adau->clk_src != clk_id) {
-		if (clk_id == ADAU17X1_CLK_SRC_PLL) {
-			snd_soc_dapm_add_routes(dapm,
-				&adau17x1_dapm_pll_route, 1);
-		} else {
-			snd_soc_dapm_del_routes(dapm,
-				&adau17x1_dapm_pll_route, 1);
-		}
-	}
-
-	adau->clk_src = clk_id;
-
-	return 0;
-}
-
 static int adau17x1_set_dai_fmt(struct snd_soc_dai *dai,
 		unsigned int fmt)
 {
@@ -827,6 +891,10 @@ int adau17x1_add_routes(struct snd_soc_codec *codec)
 		ret = snd_soc_dapm_add_routes(dapm, adau17x1_no_dsp_dapm_routes,
 			ARRAY_SIZE(adau17x1_no_dsp_dapm_routes));
 	}
+
+	if (adau->clk_src != ADAU17X1_CLK_SRC_MCLK)
+		snd_soc_dapm_add_routes(dapm, &adau17x1_dapm_pll_route, 1);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(adau17x1_add_routes);
@@ -849,6 +917,7 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	const char *firmware_name)
 {
 	struct adau *adau;
+	int ret;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -857,6 +926,30 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	if (!adau)
 		return -ENOMEM;
 
+	adau->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(adau->mclk)) {
+		if (PTR_ERR(adau->mclk) != -ENOENT)
+			return PTR_ERR(adau->mclk);
+		/* Clock is optional (for the driver) */
+		adau->mclk = NULL;
+	} else if (adau->mclk) {
+		adau->clk_src = ADAU17X1_CLK_SRC_PLL_AUTO;
+
+		/*
+		 * Any valid PLL output rate will work at this point, use one
+		 * that is likely to be chosen later as well. The register will
+		 * be written when the PLL is powered up for the first time.
+		 */
+		ret = adau_calc_pll_cfg(clk_get_rate(adau->mclk), 48000 * 1024,
+				adau->pll_regs);
+		if (ret < 0)
+			return ret;
+
+		ret = clk_prepare_enable(adau->mclk);
+		if (ret)
+			return ret;
+	}
+
 	adau->regmap = regmap;
 	adau->switch_mode = switch_mode;
 	adau->type = type;
@@ -880,6 +973,16 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 }
 EXPORT_SYMBOL_GPL(adau17x1_probe);
 
+void adau17x1_remove(struct device *dev)
+{
+	struct adau *adau = dev_get_drvdata(dev);
+
+	snd_soc_unregister_codec(dev);
+	if (adau->mclk)
+		clk_disable_unprepare(adau->mclk);
+}
+EXPORT_SYMBOL_GPL(adau17x1_remove);
+
 MODULE_DESCRIPTION("ASoC ADAU1X61/ADAU1X81 common code");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index 5ae87a0..e9fbc3b 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -24,11 +24,16 @@ enum adau17x1_pll_src {
 enum adau17x1_clk_src {
 	ADAU17X1_CLK_SRC_MCLK,
 	ADAU17X1_CLK_SRC_PLL,
+	/* Automatically configure PLL based on the sample rate */
+	ADAU17X1_CLK_SRC_PLL_AUTO,
 };
 
+struct clk;
+
 struct adau {
 	unsigned int sysclk;
 	unsigned int pll_freq;
+	struct clk *mclk;
 
 	enum adau17x1_clk_src clk_src;
 	enum adau17x1_type type;
@@ -52,6 +57,7 @@ int adau17x1_add_routes(struct snd_soc_codec *codec);
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
 	const char *firmware_name);
+void adau17x1_remove(struct device *dev);
 int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
-- 
2.1.4
