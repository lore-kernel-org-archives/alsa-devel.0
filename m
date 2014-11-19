From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: sigmadsp: Restructure in preparation
	for fw v2 support
Date: Wed, 19 Nov 2014 18:29:05 +0100
Message-ID: <1416418148-14803-4-git-send-email-lars@metafoo.de>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-042.synserver.de
 [212.40.185.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 63EC926063A
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 18:29:13 +0100 (CET)
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
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

The v2 file format of the SigmaDSP takes a more declarative style compared
to the imperative style of the v1 format. In addition some features that are
supported with v2 require the driver to keep state around for the firmware.
This requires a bit of restructuring of both the firmware loader itself and
the drivers making use of the firmware loader.

Instead of loading and executing the firmware in place when the DSP is
configured the firmware is now loaded at driver probe time. This is required
since the new firmware format will in addition to the firmware data itself
contain meta information describing the firmware and its requirements and
capabilities. Those will for example be used to restrict the supported
samplerates advertised by the driver to userspace to the list of samplerates
supported for the firmware.

This only does the restructuring required by the v2 format, but does not
yet add support for the new format itself.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1701.c        |  33 ++++-
 sound/soc/codecs/adau1761.c        |  21 ++-
 sound/soc/codecs/adau1781.c        |  30 ++---
 sound/soc/codecs/adau17x1.c        |  54 +++++++-
 sound/soc/codecs/adau17x1.h        |   9 +-
 sound/soc/codecs/sigmadsp-i2c.c    |  52 ++++++--
 sound/soc/codecs/sigmadsp-regmap.c |  38 ++++--
 sound/soc/codecs/sigmadsp.c        | 255 +++++++++++++++++++++++++++++++------
 sound/soc/codecs/sigmadsp.h        |  53 +++++---
 9 files changed, 424 insertions(+), 121 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 370b742..05d5eb5 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -103,6 +103,8 @@ struct adau1701 {
 	unsigned int sysclk;
 	struct regmap *regmap;
 	u8 pin_config[12];
+
+	struct sigmadsp *sigmadsp;
 };
 
 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -238,12 +240,14 @@ static int adau1701_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
-static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
+static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv,
+	unsigned int rate)
 {
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *client = to_i2c_client(codec->dev);
 	int ret;
 
+	sigmadsp_reset(adau1701->sigmadsp);
+
 	if (clkdiv != ADAU1707_CLKDIV_UNSET &&
 	    gpio_is_valid(adau1701->gpio_pll_mode[0]) &&
 	    gpio_is_valid(adau1701->gpio_pll_mode[1])) {
@@ -284,7 +288,7 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
 	 * know the correct PLL setup
 	 */
 	if (clkdiv != ADAU1707_CLKDIV_UNSET) {
-		ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
+		ret = sigmadsp_setup(adau1701->sigmadsp, rate);
 		if (ret) {
 			dev_warn(codec->dev, "Failed to load firmware\n");
 			return ret;
@@ -385,7 +389,7 @@ static int adau1701_hw_params(struct snd_pcm_substream *substream,
 	 * firmware upload.
 	 */
 	if (clkdiv != adau1701->pll_clkdiv) {
-		ret = adau1701_reset(codec, clkdiv);
+		ret = adau1701_reset(codec, clkdiv, params_rate(params));
 		if (ret < 0)
 			return ret;
 	}
@@ -554,6 +558,14 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	return 0;
 }
 
+static int adau1701_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(dai->codec);
+
+	return sigmadsp_restrict_params(adau1701->sigmadsp, substream);
+}
+
 #define ADAU1701_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
 	SNDRV_PCM_RATE_192000)
 
@@ -564,6 +576,7 @@ static const struct snd_soc_dai_ops adau1701_dai_ops = {
 	.set_fmt	= adau1701_set_dai_fmt,
 	.hw_params	= adau1701_hw_params,
 	.digital_mute	= adau1701_digital_mute,
+	.startup	= adau1701_startup,
 };
 
 static struct snd_soc_dai_driver adau1701_dai = {
@@ -600,6 +613,10 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	unsigned int val;
 	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
 
+	ret = sigmadsp_attach(adau1701->sigmadsp, &codec->component);
+	if (ret)
+		return ret;
+
 	/*
 	 * Let the pll_clkdiv variable default to something that won't happen
 	 * at runtime. That way, we can postpone the firmware download from
@@ -609,7 +626,7 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	adau1701->pll_clkdiv = ADAU1707_CLKDIV_UNSET;
 
 	/* initalize with pre-configured pll mode settings */
-	ret = adau1701_reset(codec, adau1701->pll_clkdiv);
+	ret = adau1701_reset(codec, adau1701->pll_clkdiv, 0);
 	if (ret < 0)
 		return ret;
 
@@ -722,6 +739,12 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	adau1701->gpio_pll_mode[1] = gpio_pll_mode[1];
 
 	i2c_set_clientdata(client, adau1701);
+
+	adau1701->sigmadsp = devm_sigmadsp_init_i2c(client, NULL,
+		ADAU1701_FIRMWARE);
+	if (IS_ERR(adau1701->sigmadsp))
+		return PTR_ERR(adau1701->sigmadsp);
+
 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
 			&adau1701_dai, 1);
 	return ret;
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index d4c0fd7..a1baeee 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -703,11 +703,6 @@ static int adau1761_codec_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(adau1761_dapm_routes));
 		if (ret)
 			return ret;
-
-		ret = adau17x1_load_firmware(adau, codec->dev,
-			ADAU1761_FIRMWARE);
-		if (ret)
-			dev_warn(codec->dev, "Failed to firmware\n");
 	}
 
 	ret = adau17x1_add_routes(codec);
@@ -776,16 +771,20 @@ int adau1761_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
 {
 	struct snd_soc_dai_driver *dai_drv;
+	const char *firmware_name;
 	int ret;
 
-	ret = adau17x1_probe(dev, regmap, type, switch_mode);
-	if (ret)
-		return ret;
-
-	if (type == ADAU1361)
+	if (type == ADAU1361) {
 		dai_drv = &adau1361_dai_driver;
-	else
+		firmware_name = NULL;
+	} else {
 		dai_drv = &adau1761_dai_driver;
+		firmware_name = ADAU1761_FIRMWARE;
+	}
+
+	ret = adau17x1_probe(dev, regmap, type, switch_mode, firmware_name);
+	if (ret)
+		return ret;
 
 	return snd_soc_register_codec(dev, &adau1761_codec_driver, dai_drv, 1);
 }
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index c4dab80..35581f4 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -385,7 +385,6 @@ static int adau1781_codec_probe(struct snd_soc_codec *codec)
 {
 	struct adau1781_platform_data *pdata = dev_get_platdata(codec->dev);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
-	const char *firmware;
 	int ret;
 
 	ret = adau17x1_add_widgets(codec);
@@ -422,25 +421,10 @@ static int adau1781_codec_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	switch (adau->type) {
-	case ADAU1381:
-		firmware = ADAU1381_FIRMWARE;
-		break;
-	case ADAU1781:
-		firmware = ADAU1781_FIRMWARE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = adau17x1_add_routes(codec);
 	if (ret < 0)
 		return ret;
 
-	ret = adau17x1_load_firmware(adau, codec->dev, firmware);
-	if (ret)
-		dev_warn(codec->dev, "Failed to load firmware\n");
-
 	return 0;
 }
 
@@ -496,9 +480,21 @@ EXPORT_SYMBOL_GPL(adau1781_regmap_config);
 int adau1781_probe(struct device *dev, struct regmap *regmap,
 	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
 {
+	const char *firmware_name;
 	int ret;
 
-	ret = adau17x1_probe(dev, regmap, type, switch_mode);
+	switch (type) {
+	case ADAU1381:
+		firmware_name = ADAU1381_FIRMWARE;
+		break;
+	case ADAU1781:
+		firmware_name = ADAU1781_FIRMWARE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = adau17x1_probe(dev, regmap, type, switch_mode, firmware_name);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index c56420c..fa2e690 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -308,6 +308,7 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	unsigned int val, div, dsp_div;
 	unsigned int freq;
+	int ret;
 
 	if (adau->clk_src == ADAU17X1_CLK_SRC_PLL)
 		freq = adau->pll_freq;
@@ -357,6 +358,12 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 		regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, dsp_div);
 	}
 
+	if (adau->sigmadsp) {
+		ret = adau17x1_setup_firmware(adau, params_rate(params));
+		if (ret < 0)
+			return ret;
+	}
+
 	if (adau->dai_fmt != SND_SOC_DAIFMT_RIGHT_J)
 		return 0;
 
@@ -662,12 +669,24 @@ static int adau17x1_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int adau17x1_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
+
+	if (adau->sigmadsp)
+		return sigmadsp_restrict_params(adau->sigmadsp, substream);
+
+	return 0;
+}
+
 const struct snd_soc_dai_ops adau17x1_dai_ops = {
 	.hw_params	= adau17x1_hw_params,
 	.set_sysclk	= adau17x1_set_dai_sysclk,
 	.set_fmt	= adau17x1_set_dai_fmt,
 	.set_pll	= adau17x1_set_dai_pll,
 	.set_tdm_slot	= adau17x1_set_dai_tdm_slot,
+	.startup	= adau17x1_startup,
 };
 EXPORT_SYMBOL_GPL(adau17x1_dai_ops);
 
@@ -760,8 +779,7 @@ bool adau17x1_volatile_register(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
 
-int adau17x1_load_firmware(struct adau *adau, struct device *dev,
-	const char *firmware)
+int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
 {
 	int ret;
 	int dspsr;
@@ -773,7 +791,7 @@ int adau17x1_load_firmware(struct adau *adau, struct device *dev,
 	regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 1);
 	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, 0xf);
 
-	ret = process_sigma_firmware_regmap(dev, adau->regmap, firmware);
+	ret = sigmadsp_setup(adau->sigmadsp, rate);
 	if (ret) {
 		regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 0);
 		return ret;
@@ -782,7 +800,7 @@ int adau17x1_load_firmware(struct adau *adau, struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(adau17x1_load_firmware);
+EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
 
 int adau17x1_add_widgets(struct snd_soc_codec *codec)
 {
@@ -802,8 +820,21 @@ int adau17x1_add_widgets(struct snd_soc_codec *codec)
 		ret = snd_soc_dapm_new_controls(&codec->dapm,
 			adau17x1_dsp_dapm_widgets,
 			ARRAY_SIZE(adau17x1_dsp_dapm_widgets));
+		if (ret)
+			return ret;
+
+		if (!adau->sigmadsp)
+			return 0;
+
+		ret = sigmadsp_attach(adau->sigmadsp, &codec->component);
+		if (ret) {
+			dev_err(codec->dev, "Failed to attach firmware: %d\n",
+				ret);
+			return ret;
+		}
 	}
-	return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(adau17x1_add_widgets);
 
@@ -844,7 +875,8 @@ int adau17x1_resume(struct snd_soc_codec *codec)
 EXPORT_SYMBOL_GPL(adau17x1_resume);
 
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
-	enum adau17x1_type type, void (*switch_mode)(struct device *dev))
+	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
+	const char *firmware_name)
 {
 	struct adau *adau;
 
@@ -861,6 +893,16 @@ int adau17x1_probe(struct device *dev, struct regmap *regmap,
 
 	dev_set_drvdata(dev, adau);
 
+	if (firmware_name) {
+		adau->sigmadsp = devm_sigmadsp_init_regmap(dev, regmap, NULL,
+			firmware_name);
+		if (IS_ERR(adau->sigmadsp)) {
+			dev_warn(dev, "Could not find firmware file: %ld\n",
+				PTR_ERR(adau->sigmadsp));
+			adau->sigmadsp = NULL;
+		}
+	}
+
 	if (switch_mode)
 		switch_mode(dev);
 
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index 870cd32..e13583e 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -4,6 +4,8 @@
 #include <linux/regmap.h>
 #include <linux/platform_data/adau17x1.h>
 
+#include "sigmadsp.h"
+
 enum adau17x1_type {
 	ADAU1361,
 	ADAU1761,
@@ -42,12 +44,14 @@ struct adau {
 	bool dsp_bypass[2];
 
 	struct regmap *regmap;
+	struct sigmadsp *sigmadsp;
 };
 
 int adau17x1_add_widgets(struct snd_soc_codec *codec);
 int adau17x1_add_routes(struct snd_soc_codec *codec);
 int adau17x1_probe(struct device *dev, struct regmap *regmap,
-	enum adau17x1_type type, void (*switch_mode)(struct device *dev));
+	enum adau17x1_type type, void (*switch_mode)(struct device *dev),
+	const char *firmware_name);
 int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
 	enum adau17x1_micbias_voltage micbias);
 bool adau17x1_readable_register(struct device *dev, unsigned int reg);
@@ -57,8 +61,7 @@ int adau17x1_resume(struct snd_soc_codec *codec);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
 
-int adau17x1_load_firmware(struct adau *adau, struct device *dev,
-	const char *firmware);
+int adau17x1_setup_firmware(struct adau *adau, unsigned int rate);
 bool adau17x1_has_dsp(struct adau *adau);
 
 #define ADAU17X1_CLOCK_CONTROL			0x4000
diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
index 246081a..bf6a2be 100644
--- a/sound/soc/codecs/sigmadsp-i2c.c
+++ b/sound/soc/codecs/sigmadsp-i2c.c
@@ -6,29 +6,59 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/i2c.h>
 #include <linux/export.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
 
 #include "sigmadsp.h"
 
-static int sigma_action_write_i2c(void *control_data,
-	const struct sigma_action *sa, size_t len)
+static int sigmadsp_write_i2c(void *control_data,
+	unsigned int addr, const uint8_t data[], size_t len)
 {
-	return i2c_master_send(control_data, (const unsigned char *)&sa->addr,
-		len);
+	uint8_t *buf;
+	int ret;
+
+	buf = kzalloc(2 + len, GFP_KERNEL | GFP_DMA);
+	if (!buf)
+		return -ENOMEM;
+
+	put_unaligned_be16(addr, buf);
+	memcpy(buf + 2, data, len);
+
+	ret = i2c_master_send(control_data, buf, len + 2);
+
+	kfree(buf);
+
+	return ret;
 }
 
-int process_sigma_firmware(struct i2c_client *client, const char *name)
+/**
+ * devm_sigmadsp_init_i2c() - Initialize SigmaDSP instance
+ * @client: The parent I2C device
+ * @ops: The sigmadsp_ops to use for this instance
+ * @firmware_name: Name of the firmware file to load
+ *
+ * Allocates a SigmaDSP instance and loads the specified firmware file.
+ *
+ * Returns a pointer to a struct sigmadsp on success, or a PTR_ERR() on error.
+ */
+struct sigmadsp *devm_sigmadsp_init_i2c(struct i2c_client *client,
+	const struct sigmadsp_ops *ops,	const char *firmware_name)
 {
-	struct sigma_firmware ssfw;
+	struct sigmadsp *sigmadsp;
+
+	sigmadsp = devm_sigmadsp_init(&client->dev, ops, firmware_name);
+	if (IS_ERR(sigmadsp))
+		return sigmadsp;
 
-	ssfw.control_data = client;
-	ssfw.write = sigma_action_write_i2c;
+	sigmadsp->control_data = client;
+	sigmadsp->write = sigmadsp_write_i2c;
 
-	return _process_sigma_firmware(&client->dev, &ssfw, name);
+	return sigmadsp;
 }
-EXPORT_SYMBOL(process_sigma_firmware);
+EXPORT_SYMBOL_GPL(devm_sigmadsp_init_i2c);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("SigmaDSP I2C firmware loader");
diff --git a/sound/soc/codecs/sigmadsp-regmap.c b/sound/soc/codecs/sigmadsp-regmap.c
index f78ed8d..cdc5dda 100644
--- a/sound/soc/codecs/sigmadsp-regmap.c
+++ b/sound/soc/codecs/sigmadsp-regmap.c
@@ -12,24 +12,40 @@
 
 #include "sigmadsp.h"
 
-static int sigma_action_write_regmap(void *control_data,
-	const struct sigma_action *sa, size_t len)
+static int sigmadsp_write_regmap(void *control_data,
+	unsigned int addr, const uint8_t data[], size_t len)
 {
-	return regmap_raw_write(control_data, be16_to_cpu(sa->addr),
-		sa->payload, len - 2);
+	return regmap_raw_write(control_data, addr,
+		data, len);
 }
 
-int process_sigma_firmware_regmap(struct device *dev, struct regmap *regmap,
-	const char *name)
+/**
+ * devm_sigmadsp_init_i2c() - Initialize SigmaDSP instance
+ * @dev: The parent device
+ * @regmap: Regmap instance to use
+ * @ops: The sigmadsp_ops to use for this instance
+ * @firmware_name: Name of the firmware file to load
+ *
+ * Allocates a SigmaDSP instance and loads the specified firmware file.
+ *
+ * Returns a pointer to a struct sigmadsp on success, or a PTR_ERR() on error.
+ */
+struct sigmadsp *devm_sigmadsp_init_regmap(struct device *dev,
+	struct regmap *regmap, const struct sigmadsp_ops *ops,
+	const char *firmware_name)
 {
-	struct sigma_firmware ssfw;
+	struct sigmadsp *sigmadsp;
+
+	sigmadsp = devm_sigmadsp_init(dev, ops, firmware_name);
+	if (IS_ERR(sigmadsp))
+		return sigmadsp;
 
-	ssfw.control_data = regmap;
-	ssfw.write = sigma_action_write_regmap;
+	sigmadsp->control_data = regmap;
+	sigmadsp->write = sigmadsp_write_regmap;
 
-	return _process_sigma_firmware(dev, &ssfw, name);
+	return sigmadsp;
 }
-EXPORT_SYMBOL(process_sigma_firmware_regmap);
+EXPORT_SYMBOL_GPL(devm_sigmadsp_init_regmap);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("SigmaDSP regmap firmware loader");
diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 4fd3143..34e63b5 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -1,7 +1,7 @@
 /*
  * Load Analog Devices SigmaStudio firmware files
  *
- * Copyright 2009-2011 Analog Devices Inc.
+ * Copyright 2009-2014 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -12,11 +12,21 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+
+#include <sound/soc.h>
 
 #include "sigmadsp.h"
 
 #define SIGMA_MAGIC "ADISIGM"
 
+struct sigmadsp_data {
+	struct list_head head;
+	unsigned int addr;
+	unsigned int length;
+	uint8_t data[];
+};
+
 struct sigma_firmware_header {
 	unsigned char magic[7];
 	u8 version;
@@ -30,6 +40,20 @@ enum {
 	SIGMA_ACTION_END,
 };
 
+struct sigma_action {
+	u8 instr;
+	u8 len_hi;
+	__le16 len;
+	__be16 addr;
+	unsigned char payload[];
+} __packed;
+
+static int sigmadsp_write(struct sigmadsp *sigmadsp, unsigned int addr,
+	const uint8_t data[], size_t len)
+{
+	return sigmadsp->write(sigmadsp->control_data, addr, data, len);
+}
+
 static inline u32 sigma_action_len(struct sigma_action *sa)
 {
 	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
@@ -58,11 +82,11 @@ static size_t sigma_action_size(struct sigma_action *sa)
  * Returns a negative error value in case of an error, 0 if processing of
  * the firmware should be stopped after this action, 1 otherwise.
  */
-static int
-process_sigma_action(struct sigma_firmware *ssfw, struct sigma_action *sa)
+static int process_sigma_action(struct sigmadsp *sigmadsp,
+	struct sigma_action *sa)
 {
 	size_t len = sigma_action_len(sa);
-	int ret;
+	struct sigmadsp_data *data;
 
 	pr_debug("%s: instr:%i addr:%#x len:%zu\n", __func__,
 		sa->instr, sa->addr, len);
@@ -71,9 +95,17 @@ process_sigma_action(struct sigma_firmware *ssfw, struct sigma_action *sa)
 	case SIGMA_ACTION_WRITEXBYTES:
 	case SIGMA_ACTION_WRITESINGLE:
 	case SIGMA_ACTION_WRITESAFELOAD:
-		ret = ssfw->write(ssfw->control_data, sa, len);
-		if (ret < 0)
+		if (len < 3)
 			return -EINVAL;
+
+		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->addr = be16_to_cpu(sa->addr);
+		data->length = len - 2;
+		memcpy(data->data, sa->payload, data->length);
+		list_add_tail(&data->head, &sigmadsp->data_list);
 		break;
 	case SIGMA_ACTION_END:
 		return 0;
@@ -84,22 +116,24 @@ process_sigma_action(struct sigma_firmware *ssfw, struct sigma_action *sa)
 	return 1;
 }
 
-static int
-process_sigma_actions(struct sigma_firmware *ssfw)
+static int sigmadsp_fw_load_v1(struct sigmadsp *sigmadsp,
+	const struct firmware *fw)
 {
 	struct sigma_action *sa;
-	size_t size;
+	size_t size, pos;
 	int ret;
 
-	while (ssfw->pos + sizeof(*sa) <= ssfw->fw->size) {
-		sa = (struct sigma_action *)(ssfw->fw->data + ssfw->pos);
+	pos = sizeof(struct sigma_firmware_header);
+
+	while (pos + sizeof(*sa) <= fw->size) {
+		sa = (struct sigma_action *)(fw->data + pos);
 
 		size = sigma_action_size(sa);
-		ssfw->pos += size;
-		if (ssfw->pos > ssfw->fw->size || size == 0)
+		pos += size;
+		if (pos > fw->size || size == 0)
 			break;
 
-		ret = process_sigma_action(ssfw, sa);
+		ret = process_sigma_action(sigmadsp, sa);
 
 		pr_debug("%s: action returned %i\n", __func__, ret);
 
@@ -107,29 +141,40 @@ process_sigma_actions(struct sigma_firmware *ssfw)
 			return ret;
 	}
 
-	if (ssfw->pos != ssfw->fw->size)
+	if (pos != fw->size)
 		return -EINVAL;
 
 	return 0;
 }
 
-int _process_sigma_firmware(struct device *dev,
-	struct sigma_firmware *ssfw, const char *name)
+static void sigmadsp_firmware_release(struct sigmadsp *sigmadsp)
 {
-	int ret;
-	struct sigma_firmware_header *ssfw_head;
+	struct sigmadsp_data *data, *_data;
+
+	list_for_each_entry_safe(data, _data, &sigmadsp->data_list, head)
+		kfree(data);
+
+	INIT_LIST_HEAD(&sigmadsp->data_list);
+}
+
+static void devm_sigmadsp_release(struct device *dev, void *res)
+{
+	sigmadsp_firmware_release((struct sigmadsp *)res);
+}
+
+static int sigmadsp_firmware_load(struct sigmadsp *sigmadsp, const char *name)
+{
+	const struct sigma_firmware_header *ssfw_head;
 	const struct firmware *fw;
+	int ret;
 	u32 crc;
 
-	pr_debug("%s: loading firmware %s\n", __func__, name);
-
 	/* first load the blob */
-	ret = request_firmware(&fw, name, dev);
+	ret = request_firmware(&fw, name, sigmadsp->dev);
 	if (ret) {
 		pr_debug("%s: request_firmware() failed with %i\n", __func__, ret);
-		return ret;
+		goto done;
 	}
-	ssfw->fw = fw;
 
 	/* then verify the header */
 	ret = -EINVAL;
@@ -141,20 +186,13 @@ int _process_sigma_firmware(struct device *dev,
 	 * overflows later in the loading process.
 	 */
 	if (fw->size < sizeof(*ssfw_head) || fw->size >= 0x4000000) {
-		dev_err(dev, "Failed to load firmware: Invalid size\n");
+		dev_err(sigmadsp->dev, "Failed to load firmware: Invalid size\n");
 		goto done;
 	}
 
 	ssfw_head = (void *)fw->data;
 	if (memcmp(ssfw_head->magic, SIGMA_MAGIC, ARRAY_SIZE(ssfw_head->magic))) {
-		dev_err(dev, "Failed to load firmware: Invalid magic\n");
-		goto done;
-	}
-
-	if (ssfw_head->version != 1) {
-		dev_err(dev,
-			"Failed to load firmware: Invalid version %d. Supported firmware versions: 1\n",
-			ssfw_head->version);
+		dev_err(sigmadsp->dev, "Failed to load firmware: Invalid magic\n");
 		goto done;
 	}
 
@@ -162,23 +200,160 @@ int _process_sigma_firmware(struct device *dev,
 			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
 	if (crc != le32_to_cpu(ssfw_head->crc)) {
-		dev_err(dev, "Failed to load firmware: Wrong crc checksum: expected %x got %x\n",
+		dev_err(sigmadsp->dev, "Failed to load firmware: Wrong crc checksum: expected %x got %x\n",
 			le32_to_cpu(ssfw_head->crc), crc);
 		goto done;
 	}
 
-	ssfw->pos = sizeof(*ssfw_head);
+	switch (ssfw_head->version) {
+	case 1:
+		ret = sigmadsp_fw_load_v1(sigmadsp, fw);
+		break;
+	default:
+		dev_err(sigmadsp->dev,
+			"Failed to load firmware: Invalid version %d. Supported firmware versions: 1\n",
+			ssfw_head->version);
+		ret = -EINVAL;
+		break;
+	}
 
-	/* finally process all of the actions */
-	ret = process_sigma_actions(ssfw);
+	if (ret)
+		sigmadsp_firmware_release(sigmadsp);
 
- done:
+done:
 	release_firmware(fw);
 
-	pr_debug("%s: loaded %s\n", __func__, name);
+	return ret;
+}
+
+static int sigmadsp_init(struct sigmadsp *sigmadsp, struct device *dev,
+	const struct sigmadsp_ops *ops, const char *firmware_name)
+{
+	sigmadsp->ops = ops;
+	sigmadsp->dev = dev;
+
+	INIT_LIST_HEAD(&sigmadsp->data_list);
+
+	return sigmadsp_firmware_load(sigmadsp, firmware_name);
+}
+
+/**
+ * devm_sigmadsp_init() - Initialize SigmaDSP instance
+ * @dev: The parent device
+ * @ops: The sigmadsp_ops to use for this instance
+ * @firmware_name: Name of the firmware file to load
+ *
+ * Allocates a SigmaDSP instance and loads the specified firmware file.
+ *
+ * Returns a pointer to a struct sigmadsp on success, or a PTR_ERR() on error.
+ */
+struct sigmadsp *devm_sigmadsp_init(struct device *dev,
+	const struct sigmadsp_ops *ops, const char *firmware_name)
+{
+	struct sigmadsp *sigmadsp;
+	int ret;
+
+	sigmadsp = devres_alloc(devm_sigmadsp_release, sizeof(*sigmadsp),
+		GFP_KERNEL);
+	if (!sigmadsp)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sigmadsp_init(sigmadsp, dev, ops, firmware_name);
+	if (ret) {
+		devres_free(sigmadsp);
+		return ERR_PTR(ret);
+	}
+
+	devres_add(dev, sigmadsp);
+
+	return sigmadsp;
+}
+EXPORT_SYMBOL_GPL(devm_sigmadsp_init);
+
+/**
+ * sigmadsp_attach() - Attach a sigmadsp instance to a ASoC component
+ * @sigmadsp: The sigmadsp instance to attach
+ * @component: The component to attach to
+ *
+ * Typically called in the components probe callback.
+ *
+ * Note, once this function has been called the firmware must not be released
+ * until after the ALSA snd_card that the component belongs to has been
+ * disconnected, even if sigmadsp_attach() returns an error.
+ */
+int sigmadsp_attach(struct sigmadsp *sigmadsp,
+	struct snd_soc_component *component)
+{
+	sigmadsp->component = component;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sigmadsp_attach);
+
+/**
+ * sigmadsp_setup() - Setup the DSP for the specified samplerate
+ * @sigmadsp: The sigmadsp instance to configure
+ * @samplerate: The samplerate the DSP should be configured for
+ *
+ * Loads the appropriate firmware program and parameter memory (if not already
+ * loaded) and enables the controls for the specified samplerate. Any control
+ * parameter changes that have been made previously will be restored.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int samplerate)
+{
+	struct sigmadsp_data *data;
+	int ret;
+
+	if (sigmadsp->current_samplerate == samplerate)
+		return 0;
+
+	list_for_each_entry(data, &sigmadsp->data_list, head) {
+		ret = sigmadsp_write(sigmadsp, data->addr, data->data,
+			data->length);
+		if (ret)
+			goto err;
+	}
+
+	sigmadsp->current_samplerate = samplerate;
+
+	return 0;
+err:
+	sigmadsp_reset(sigmadsp);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(_process_sigma_firmware);
+EXPORT_SYMBOL_GPL(sigmadsp_setup);
+
+/**
+ * sigmadsp_reset() - Notify the sigmadsp instance that the DSP has been reset
+ * @sigmadsp: The sigmadsp instance to reset
+ *
+ * Should be called whenever the DSP has been reset and parameter and program
+ * memory need to be re-loaded.
+ */
+void sigmadsp_reset(struct sigmadsp *sigmadsp)
+{
+	sigmadsp->current_samplerate = 0;
+}
+EXPORT_SYMBOL_GPL(sigmadsp_reset);
+
+/**
+ * sigmadsp_restrict_params() - Applies DSP firmware specific constraints
+ * @sigmadsp: The sigmadsp instance
+ * @substream: The substream to restrict
+ *
+ * Applies samplerate constraints that may be required by the firmware Should
+ * typically be called from the CODEC/component drivers startup callback.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int sigmadsp_restrict_params(struct sigmadsp *sigmadsp,
+	struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sigmadsp_restrict_params);
 
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index c47cd23..a6be91a 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -11,31 +11,50 @@
 
 #include <linux/device.h>
 #include <linux/regmap.h>
+#include <linux/list.h>
 
-struct sigma_action {
-	u8 instr;
-	u8 len_hi;
-	__le16 len;
-	__be16 addr;
-	unsigned char payload[];
-} __packed;
+#include <sound/pcm.h>
 
-struct sigma_firmware {
-	const struct firmware *fw;
-	size_t pos;
+struct sigmadsp;
+struct snd_soc_component;
+struct snd_pcm_substream;
+
+struct sigmadsp_ops {
+	int (*safeload)(struct sigmadsp *sigmadsp, unsigned int addr,
+			const uint8_t *data, size_t len);
+};
+
+struct sigmadsp {
+	const struct sigmadsp_ops *ops;
+
+	struct list_head data_list;
+
+	unsigned int current_samplerate;
+	struct snd_soc_component *component;
+	struct device *dev;
 
 	void *control_data;
-	int (*write)(void *control_data, const struct sigma_action *sa,
-			size_t len);
+	int (*write)(void *, unsigned int, const uint8_t *, size_t);
 };
 
-int _process_sigma_firmware(struct device *dev,
-	struct sigma_firmware *ssfw, const char *name);
+struct sigmadsp *devm_sigmadsp_init(struct device *dev,
+	const struct sigmadsp_ops *ops, const char *firmware_name);
+void sigmadsp_reset(struct sigmadsp *sigmadsp);
+
+int sigmadsp_restrict_params(struct sigmadsp *sigmadsp,
+	struct snd_pcm_substream *substream);
 
 struct i2c_client;
 
-extern int process_sigma_firmware(struct i2c_client *client, const char *name);
-extern int process_sigma_firmware_regmap(struct device *dev,
-		struct regmap *regmap, const char *name);
+struct sigmadsp *devm_sigmadsp_init_regmap(struct device *dev,
+	struct regmap *regmap, const struct sigmadsp_ops *ops,
+	const char *firmware_name);
+struct sigmadsp *devm_sigmadsp_init_i2c(struct i2c_client *client,
+	const struct sigmadsp_ops *ops,	const char *firmware_name);
+
+int sigmadsp_attach(struct sigmadsp *sigmadsp,
+	struct snd_soc_component *component);
+int sigmadsp_setup(struct sigmadsp *sigmadsp, unsigned int rate);
+void sigmadsp_reset(struct sigmadsp *sigmadsp);
 
 #endif
-- 
1.8.0
