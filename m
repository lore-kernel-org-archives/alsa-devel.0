From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add a configuration option for
	LDO2_POW pin
Date: Wed, 17 Sep 2014 13:14:20 -0700
Message-ID: <1410984860-40626-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f202.google.com (mail-ob0-f202.google.com
 [209.85.214.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E21E2650FE
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 22:14:37 +0200 (CEST)
Received: by mail-ob0-f202.google.com with SMTP id vb8so45774obc.3
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 13:14:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some boards have this pin statically tied and do not require any configuration,
some other boards allow to enable chip using GPIO.

Add an option that tells which GPIO is used to power the audio codec.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt | 41 ++++++++++++++++
 sound/soc/codecs/rt5677.c                          | 54 ++++++++++++++++++++++
 sound/soc/codecs/rt5677.h                          |  1 +
 3 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5677.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
new file mode 100644
index 0000000..98509fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -0,0 +1,41 @@
+RT5677 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5677".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- realtek,pow-ldo2-gpio : The GPIO that controls the CODEC's POW_LDO2 pin.
+
+Pins on the device (for linking into audio routes):
+
+  * IN1P
+  * IN1N
+  * IN2P
+  * IN2N
+  * MICBIAS1
+  * DMIC1
+  * DMIC2
+  * DMIC3
+  * DMIC4
+  * LOUT1
+  * LOUT2
+  * LOUT3
+
+Example:
+
+rt5677 {
+	compatible = "realtek,rt5677";
+	reg = <0x2c>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	realtek,pow-ldo2-gpio =
+		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+};
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 9847473..83785db 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
@@ -3319,6 +3320,8 @@ static int rt5677_remove(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
+	if (gpio_is_valid(rt5677->pow_ldo2))
+		gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
 
 	return 0;
 }
@@ -3330,6 +3333,8 @@ static int rt5677_suspend(struct snd_soc_codec *codec)
 
 	regcache_cache_only(rt5677->regmap, true);
 	regcache_mark_dirty(rt5677->regmap);
+	if (gpio_is_valid(rt5677->pow_ldo2))
+		gpio_set_value_cansleep(rt5677->pow_ldo2, 0);
 
 	return 0;
 }
@@ -3338,6 +3343,10 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
+	if (gpio_is_valid(rt5677->pow_ldo2)) {
+		gpio_set_value_cansleep(rt5677->pow_ldo2, 1);
+		msleep(10);
+	}
 	regcache_cache_only(rt5677->regmap, false);
 	regcache_sync(rt5677->regmap);
 
@@ -3495,6 +3504,24 @@ static const struct i2c_device_id rt5677_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
+static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
+{
+	rt5677->pow_ldo2 = of_get_named_gpio(np,
+					"realtek,pow-ldo2-gpio", 0);
+
+	/*
+	 * POW_LDO2 is optional (it may be statically tied on the board).
+	 * -ENOENT means that the property doesn't exist, i.e. there is no
+	 * GPIO, so is not an error. Any other error code means the property
+	 * exists, but could not be parsed.
+	 */
+	if (!gpio_is_valid(rt5677->pow_ldo2) &&
+			(rt5677->pow_ldo2 != -ENOENT))
+		return rt5677->pow_ldo2;
+
+	return 0;
+}
+
 static int rt5677_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3513,6 +3540,33 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt5677->pdata = *pdata;
 
+	if (i2c->dev.of_node) {
+		ret = rt5677_parse_dt(rt5677, i2c->dev.of_node);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to parse device tree: %d\n",
+				ret);
+			return ret;
+		}
+	} else {
+		rt5677->pow_ldo2 = -EINVAL;
+	}
+
+	if (gpio_is_valid(rt5677->pow_ldo2)) {
+		ret = devm_gpio_request_one(&i2c->dev, rt5677->pow_ldo2,
+					    GPIOF_OUT_INIT_HIGH,
+					    "RT5677 POW_LDO2");
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to request POW_LDO2 %d: %d\n",
+				rt5677->pow_ldo2, ret);
+			return ret;
+		}
+		/* Wait a while until I2C bus becomes available. The datasheet
+		 * does not specify the exact we should wait but startup
+		 * sequence mentiones at least a few milliseconds.
+		 */
+		msleep(10);
+	}
+
 	rt5677->regmap = devm_regmap_init_i2c(i2c, &rt5677_regmap);
 	if (IS_ERR(rt5677->regmap)) {
 		ret = PTR_ERR(rt5677->regmap);
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index b61b72c..222a4137 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1550,6 +1550,7 @@ struct rt5677_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+	int pow_ldo2; /* POW_LDO2 pin */
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
 #endif
-- 
2.1.0.rc2.206.gedb03e5
