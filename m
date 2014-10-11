From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: Add option to configure gpio as
	floating/pullup/pulldown
Date: Fri, 10 Oct 2014 20:46:36 -0700
Message-ID: <1412999196-14395-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CFE4B2605AC
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 05:46:42 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id g10so2666018pdj.4
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 20:46:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org, dgreid@chromium.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

gpio_config is array of 6 elements that allows to set GPIO as
floating, pullup, pulldown.

Sponsored: Google ChromeOS
Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt |  7 ++++
 include/sound/rt5677.h                             |  3 ++
 sound/soc/codecs/rt5677.c                          | 39 ++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index 0701b83..f82f0e9 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -27,6 +27,12 @@ Optional properties:
   Boolean. Indicate MIC1/2 input and LOUT1/2/3 outputs are differential,
   rather than single-ended.
 
+- realtek,gpio-config
+  Array of six 8bit elements that configures GPIO.
+    0 - floating (reset value)
+    1 - pull down
+    2 - pull up
+
 Pins on the device (for linking into audio routes):
 
   * IN1P
@@ -56,4 +62,5 @@ rt5677 {
 	realtek,pow-ldo2-gpio =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 	realtek,in1-differential = "true";
+	realtek,gpio-config = /bits/ 8  <0 0 0 0 0 2>;   /* pull up GPIO6 */
 };
diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
index 082670e..a56b429 100644
--- a/include/sound/rt5677.h
+++ b/include/sound/rt5677.h
@@ -27,6 +27,9 @@ struct rt5677_platform_data {
 	bool lout3_diff;
 	/* DMIC2 clock source selection */
 	enum rt5677_dmic2_clk dmic2_clk_pin;
+
+	/* configures GPIO, 0 - floating, 1 - pulldown, 2 - pullup */
+	u8 gpio_config[6];
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 16aa4d9..a454df3 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3309,6 +3309,38 @@ static int rt5677_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+/** Configures the gpio as
+ *   0 - floating
+ *   1 - pull down
+ *   2 - pull up
+ */
+static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
+		int value)
+{
+	int shift;
+
+	switch (offset) {
+	case RT5677_GPIO1 ... RT5677_GPIO2:
+		shift = 2 * (1 - offset);
+		regmap_update_bits(rt5677->regmap,
+			RT5677_PR_BASE + RT5677_DIG_IN_PIN_ST_CTRL2,
+			0x3 << shift,
+			(value & 0x3) << shift);
+		break;
+
+	case RT5677_GPIO3 ... RT5677_GPIO6:
+		shift = 2 * (9 - offset);
+		regmap_update_bits(rt5677->regmap,
+			RT5677_PR_BASE + RT5677_DIG_IN_PIN_ST_CTRL3,
+			0x3 << shift,
+			(value & 0x3) << shift);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static struct gpio_chip rt5677_template_chip = {
 	.label			= "rt5677",
 	.owner			= THIS_MODULE,
@@ -3353,6 +3385,7 @@ static void rt5677_free_gpio(struct i2c_client *i2c)
 static int rt5677_probe(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	int i;
 
 	rt5677->codec = codec;
 
@@ -3371,6 +3404,9 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 	regmap_write(rt5677->regmap, RT5677_DIG_MISC, 0x0020);
 	regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x0c00);
 
+	for (i = 0; i < RT5677_GPIO_NUM; i++)
+		rt5677_gpio_config(rt5677, i, rt5677->pdata.gpio_config[i]);
+
 	return 0;
 }
 
@@ -3590,6 +3626,9 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 			(rt5677->pow_ldo2 != -ENOENT))
 		return rt5677->pow_ldo2;
 
+	of_property_read_u8_array(np, "realtek,gpio-config",
+		rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
+
 	return 0;
 }
 
-- 
2.1.2
