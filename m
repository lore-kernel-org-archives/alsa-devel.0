From: pascal.huerst@gmail.com
Subject: [PATCH resend] ASoC: adau1701: add regulator consumer
	support
Date: Mon, 20 Apr 2015 11:12:03 +0200
Message-ID: <1429521123-12764-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Pascal Huerst <pascal.huerst@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

The adau1701 has two power domains, DVDD and AVDD.
Enable them both as long as the codec is in use.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 .../devicetree/bindings/sound/adi,adau1701.txt     |   4 +
 sound/soc/codecs/adau1701.c                        | 125 ++++++++++++++++++---
 2 files changed, 114 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
index 547a49b..0d1128c 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
@@ -20,6 +20,8 @@ Optional properties:
 			pin configurations as described in the datasheet,
 			table 53. Note that the value of this property has
 			to be prefixed with '/bits/ 8'.
+ - avdd-supply: 	Power supply for AVDD, providing 3.3V
+ - dvdd-supply: 	Power supply for DVDD, providing 3.3V

 Examples:

@@ -28,6 +30,8 @@ Examples:
 			compatible = "adi,adau1701";
 			reg = <0x34>;
 			reset-gpio = <&gpio 23 0>;
+			avdd-supply = <&vdd_3v3_reg>;
+			dvdd-supply = <&vdd_3v3_reg>;
 			adi,pll-mode-gpios = <&gpio 24 0 &gpio 25 0>;
 			adi,pin-config = /bits/ 8 <0x4 0x7 0x5 0x5 0x4 0x4
                                                    0x4 0x4 0x4 0x4 0x4 0x4>;
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index d4e219b..ca94ae8 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -101,6 +102,10 @@

 #define ADAU1701_FIRMWARE "adau1701.bin"

+static const char * const supply_names[] = {
+	"dvdd", "avdd"
+};
+
 struct adau1701 {
 	int gpio_nreset;
 	int gpio_pll_mode[2];
@@ -112,6 +117,7 @@ struct adau1701 {
 	u8 pin_config[12];

 	struct sigmadsp *sigmadsp;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };

 static const struct snd_kcontrol_new adau1701_controls[] = {
@@ -669,6 +675,13 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;

+	ret = regulator_bulk_enable(ARRAY_SIZE(adau1701->supplies),
+				    adau1701->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	/*
 	 * Let the pll_clkdiv variable default to something that won't happen
 	 * at runtime. That way, we can postpone the firmware download from
@@ -680,7 +693,7 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	/* initalize with pre-configured pll mode settings */
 	ret = adau1701_reset(codec, adau1701->pll_clkdiv, 0);
 	if (ret < 0)
-		return ret;
+		goto exit_regulators_disable;

 	/* set up pin config */
 	val = 0;
@@ -696,10 +709,60 @@ static int adau1701_probe(struct snd_soc_codec *codec)
 	regmap_write(adau1701->regmap, ADAU1701_PINCONF_1, val);

 	return 0;
+
+exit_regulators_disable:
+
+	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies), adau1701->supplies);
+	return ret;
 }

+static int adau1701_remove(struct snd_soc_codec *codec)
+{
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(adau1701->gpio_nreset))
+		gpio_set_value_cansleep(adau1701->gpio_nreset, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies), adau1701->supplies);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int adau1701_suspend(struct snd_soc_codec *codec)
+{
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+
+	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies),
+			       adau1701->supplies);
+
+	return 0;
+}
+
+static int adau1701_resume(struct snd_soc_codec *codec)
+{
+	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+        ret = regulator_bulk_enable(ARRAY_SIZE(adau1701->supplies),
+				    adau1701->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	return adau1701_reset(codec, adau1701->pll_clkdiv, 0);
+}
+#else
+#define adau1701_resume 	NULL
+#define adau1701_suspend 	NULL
+#endif /* CONFIG_PM */
+
 static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.probe			= adau1701_probe,
+	.remove			= adau1701_remove,
+	.resume			= adau1701_resume,
+	.suspend		= adau1701_suspend,
 	.set_bias_level		= adau1701_set_bias_level,
 	.idle_bias_off		= true,

@@ -730,32 +793,58 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	int gpio_nreset = -EINVAL;
 	int gpio_pll_mode[2] = { -EINVAL, -EINVAL };
-	int ret;
+	int ret, i;

 	adau1701 = devm_kzalloc(dev, sizeof(*adau1701), GFP_KERNEL);
 	if (!adau1701)
 		return -ENOMEM;

+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		adau1701->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(adau1701->supplies),
+			adau1701->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(adau1701->supplies),
+			adau1701->supplies);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	adau1701->client = client;
 	adau1701->regmap = devm_regmap_init(dev, NULL, client,
 					    &adau1701_regmap);
-	if (IS_ERR(adau1701->regmap))
-		return PTR_ERR(adau1701->regmap);
+	if (IS_ERR(adau1701->regmap)) {
+		ret = PTR_ERR(adau1701->regmap);
+		goto exit_regulators_disable;
+	}
+

 	if (dev->of_node) {
 		gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
-		if (gpio_nreset < 0 && gpio_nreset != -ENOENT)
-			return gpio_nreset;
+		if (gpio_nreset < 0 && gpio_nreset != -ENOENT) {
+			ret = gpio_nreset;
+			goto exit_regulators_disable;
+		}

 		gpio_pll_mode[0] = of_get_named_gpio(dev->of_node,
 						   "adi,pll-mode-gpios", 0);
-		if (gpio_pll_mode[0] < 0 && gpio_pll_mode[0] != -ENOENT)
-			return gpio_pll_mode[0];
+		if (gpio_pll_mode[0] < 0 && gpio_pll_mode[0] != -ENOENT) {
+			ret = gpio_pll_mode[0];
+			goto exit_regulators_disable;
+		}

 		gpio_pll_mode[1] = of_get_named_gpio(dev->of_node,
 						   "adi,pll-mode-gpios", 1);
-		if (gpio_pll_mode[1] < 0 && gpio_pll_mode[1] != -ENOENT)
-			return gpio_pll_mode[1];
+		if (gpio_pll_mode[1] < 0 && gpio_pll_mode[1] != -ENOENT) {
+			ret = gpio_pll_mode[1];
+			goto exit_regulators_disable;
+		}

 		of_property_read_u32(dev->of_node, "adi,pll-clkdiv",
 				     &adau1701->pll_clkdiv);
@@ -769,7 +858,7 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 		ret = devm_gpio_request_one(dev, gpio_nreset, GPIOF_OUT_INIT_LOW,
 					    "ADAU1701 Reset");
 		if (ret < 0)
-			return ret;
+			goto exit_regulators_disable;
 	}

 	if (gpio_is_valid(gpio_pll_mode[0]) &&
@@ -778,13 +867,13 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 					    GPIOF_OUT_INIT_LOW,
 					    "ADAU1701 PLL mode 0");
 		if (ret < 0)
-			return ret;
+			goto exit_regulators_disable;

 		ret = devm_gpio_request_one(dev, gpio_pll_mode[1],
 					    GPIOF_OUT_INIT_LOW,
 					    "ADAU1701 PLL mode 1");
 		if (ret < 0)
-			return ret;
+			goto exit_regulators_disable;
 	}

 	adau1701->gpio_nreset = gpio_nreset;
@@ -795,11 +884,17 @@ static int adau1701_i2c_probe(struct i2c_client *client,

 	adau1701->sigmadsp = devm_sigmadsp_init_i2c(client,
 		&adau1701_sigmadsp_ops, ADAU1701_FIRMWARE);
-	if (IS_ERR(adau1701->sigmadsp))
-		return PTR_ERR(adau1701->sigmadsp);
+	if (IS_ERR(adau1701->sigmadsp)) {
+		ret = PTR_ERR(adau1701->sigmadsp);
+		goto exit_regulators_disable;
+	}

 	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
 			&adau1701_dai, 1);
+
+exit_regulators_disable:
+
+	regulator_bulk_disable(ARRAY_SIZE(adau1701->supplies), adau1701->supplies);
 	return ret;
 }

--
1.9.3
