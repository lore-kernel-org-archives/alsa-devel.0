From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: add more settings for rt5639
Date: Wed, 9 Apr 2014 20:19:49 +0800
Message-ID: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B491E26086C
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 14:20:07 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the the list of OF compatible strings, the binding document and
the list of I2C device IDs for rt5639.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5639.txt |  48 ++++++++++
 sound/soc/codecs/rt5640.c                          | 103 ++++++++++++++++++++-
 2 files changed, 147 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5639.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5639.txt b/Documentation/devicetree/bindings/sound/rt5639.txt
new file mode 100644
index 0000000..d63c662
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5639.txt
@@ -0,0 +1,48 @@
+RT5639 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5639".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- realtek,in1-differential
+- realtek,in2-differential
+  Boolean. Indicate MIC1/2 input are differential, rather than single-ended.
+
+- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
+
+Pins on the device (for linking into audio routes):
+
+  * DMIC1
+  * DMIC2
+  * MICBIAS1
+  * IN1P
+  * IN1R
+  * IN2P
+  * IN2R
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * SPOLP
+  * SPOLN
+  * SPORP
+  * SPORN
+
+Example:
+
+rt5639 {
+	compatible = "realtek,rt5639";
+	reg = <0x1c>;
+	interrupt-parent = <&gpio>;
+	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	realtek,ldo1-en-gpios =
+		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+};
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index d672f44..d7d6cad 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1,5 +1,5 @@
 /*
- * rt5640.c  --  RT5640 ALSA SoC audio codec driver
+ * rt5640.c  --  RT5640/RT5639 ALSA SoC audio codec driver
  *
  * Copyright 2011 Realtek Semiconductor Corp.
  * Author: Johnny Hsu <johnnyhsu@realtek.com>
@@ -2131,6 +2131,47 @@ static struct snd_soc_dai_driver rt5640_dai[] = {
 	},
 };
 
+static struct snd_soc_dai_driver rt5639_dai[] = {
+	{
+		.name = "rt5639-aif1",
+		.id = RT5640_AIF1,
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5640_STEREO_RATES,
+			.formats = RT5640_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5640_STEREO_RATES,
+			.formats = RT5640_FORMATS,
+		},
+		.ops = &rt5640_aif_dai_ops,
+	},
+	{
+		.name = "rt5639-aif2",
+		.id = RT5640_AIF2,
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5640_STEREO_RATES,
+			.formats = RT5640_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AIF2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = RT5640_STEREO_RATES,
+			.formats = RT5640_FORMATS,
+		},
+		.ops = &rt5640_aif_dai_ops,
+	},
+};
+
 static struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
 	.probe = rt5640_probe,
 	.remove = rt5640_remove,
@@ -2168,12 +2209,38 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 
+static const struct i2c_device_id rt5639_i2c_id[] = {
+	{ "rt5639", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
+
+#if defined(CONFIG_OF)
+static const struct of_device_id rt5640_of_match[] = {
+	{ .compatible = "realtek,rt5640", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5640_of_match);
+
+static const struct of_device_id rt5639_of_match[] = {
+	{ .compatible = "realtek,rt5639", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5639_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
+
+static struct acpi_device_id rt5639_acpi_match[] = {
+	{ "INT33CA", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt5639_acpi_match);
 #endif
 
 static int rt5640_parse_dt(struct rt5640_priv *rt5640, struct device_node *np)
@@ -2293,8 +2360,18 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 
 	rt5640->hp_mute = 1;
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
-			rt5640_dai, ARRAY_SIZE(rt5640_dai));
+	regmap_read(rt5640->regmap, RT5640_RESET, &val);
+	switch (val) {
+	case RT5640_RESET_ID:
+		ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
+				rt5640_dai, ARRAY_SIZE(rt5640_dai));
+		break;
+	case RT5639_RESET_ID:
+		ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
+				rt5639_dai, ARRAY_SIZE(rt5639_dai));
+		break;
+	}
+
 	if (ret < 0)
 		goto err;
 
@@ -2315,6 +2392,9 @@ static struct i2c_driver rt5640_i2c_driver = {
 		.name = "rt5640",
 		.owner = THIS_MODULE,
 		.acpi_match_table = ACPI_PTR(rt5640_acpi_match),
+#if defined(CONFIG_OF)
+		.of_match_table = of_match_ptr(rt5640_of_match),
+#endif
 	},
 	.probe = rt5640_i2c_probe,
 	.remove   = rt5640_i2c_remove,
@@ -2322,6 +2402,21 @@ static struct i2c_driver rt5640_i2c_driver = {
 };
 module_i2c_driver(rt5640_i2c_driver);
 
-MODULE_DESCRIPTION("ASoC RT5640 driver");
+static struct i2c_driver rt5639_i2c_driver = {
+	.driver = {
+		.name = "rt5639",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(rt5639_acpi_match),
+#if defined(CONFIG_OF)
+		.of_match_table = of_match_ptr(rt5639_of_match),
+#endif
+	},
+	.probe = rt5640_i2c_probe,
+	.remove   = rt5640_i2c_remove,
+	.id_table = rt5639_i2c_id,
+};
+module_i2c_driver(rt5639_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC RT5640/RT5639 driver");
 MODULE_AUTHOR("Johnny Hsu <johnnyhsu@realtek.com>");
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.1.439.g50a6b54
