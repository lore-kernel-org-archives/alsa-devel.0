From: pascal.huerst@gmail.com
Subject: [RESEND PATCH] ASoC: cs4271: add regulator consumer
	support
Date: Tue, 16 Feb 2016 16:19:06 +0100
Message-ID: <1455635946-16267-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D33D3260824
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 16:19:24 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id c200so166864790wme.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 07:19:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul.Handrigan@cirrus.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Pascal Huerst <pascal.huerst@gmail.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Pascal Huerst <pascal.huerst@gmail.com>

The cs4271 has three power domains: vd, vl and va.
Enable them all, as long as the codec is in use.

While at it, factored out the reset code into its own function.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 Documentation/devicetree/bindings/sound/cs4271.txt |  7 +++
 sound/soc/codecs/cs4271.c                          | 69 +++++++++++++++++++---
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cs4271.txt b/Documentation/devicetree/bindings/sound/cs4271.txt
index e2cd1d7..6e699ce 100644
--- a/Documentation/devicetree/bindings/sound/cs4271.txt
+++ b/Documentation/devicetree/bindings/sound/cs4271.txt
@@ -33,12 +33,19 @@ Optional properties:
 	Note that this is not needed in case the clocks are stable
 	throughout the entire runtime of the codec.
 
+ - vd-supply:	Digital power
+ - vl-supply:	Logic power
+ - va-supply:	Analog Power
+
 Examples:
 
 	codec_i2c: cs4271@10 {
 		compatible = "cirrus,cs4271";
 		reg = <0x10>;
 		reset-gpio = <&gpio 23 0>;
+		vd-supply = <&vdd_3v3_reg>;
+		vl-supply = <&vdd_3v3_reg>;
+		va-supply = <&vdd_3v3_reg>;
 	};
 
 	codec_spi: cs4271@0 {
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index e770ee6..0c0010b 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
@@ -157,6 +158,10 @@ static bool cs4271_volatile_reg(struct device *dev, unsigned int reg)
 	return reg == CS4271_CHIPID;
 }
 
+static const char * const supply_names[] = {
+	"vd", "vl", "va"
+};
+
 struct cs4271_private {
 	unsigned int			mclk;
 	bool				master;
@@ -170,6 +175,7 @@ struct cs4271_private {
 	int				gpio_disable;
 	/* enable soft reset workaround */
 	bool				enable_soft_reset;
+	struct regulator_bulk_data      supplies[ARRAY_SIZE(supply_names)];
 };
 
 static const struct snd_soc_dapm_widget cs4271_dapm_widgets[] = {
@@ -487,6 +493,20 @@ static struct snd_soc_dai_driver cs4271_dai = {
 	.symmetric_rates = 1,
 };
 
+static int cs4271_reset(struct snd_soc_codec *codec)
+{
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(cs4271->gpio_nreset)) {
+		gpio_set_value(cs4271->gpio_nreset, 0);
+		mdelay(1);
+		gpio_set_value(cs4271->gpio_nreset, 1);
+		mdelay(1);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int cs4271_soc_suspend(struct snd_soc_codec *codec)
 {
@@ -499,6 +519,9 @@ static int cs4271_soc_suspend(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
+	regcache_mark_dirty(cs4271->regmap);
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+
 	return 0;
 }
 
@@ -507,6 +530,16 @@ static int cs4271_soc_resume(struct snd_soc_codec *codec)
 	int ret;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs4271->supplies),
+				    cs4271->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	/* Do a proper reset after power up */
+	cs4271_reset(codec);
+
 	/* Restore codec state */
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
@@ -553,19 +586,24 @@ static int cs4271_codec_probe(struct snd_soc_codec *codec)
 	}
 #endif
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs4271->supplies),
+				    cs4271->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
 	if (cs4271plat) {
 		amutec_eq_bmutec = cs4271plat->amutec_eq_bmutec;
 		cs4271->enable_soft_reset = cs4271plat->enable_soft_reset;
 	}
 
-	if (gpio_is_valid(cs4271->gpio_nreset)) {
-		/* Reset codec */
-		gpio_direction_output(cs4271->gpio_nreset, 0);
-		mdelay(1);
-		gpio_set_value(cs4271->gpio_nreset, 1);
-		/* Give the codec time to wake up */
-		mdelay(1);
-	}
+	/* Reset codec */
+	cs4271_reset(codec);
+
+	ret = regcache_sync(cs4271->regmap);
+	if (ret < 0)
+		return ret;
 
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
@@ -595,6 +633,9 @@ static int cs4271_codec_remove(struct snd_soc_codec *codec)
 		/* Set codec to the reset state */
 		gpio_set_value(cs4271->gpio_nreset, 0);
 
+	regcache_mark_dirty(cs4271->regmap);
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+
 	return 0;
 };
 
@@ -617,6 +658,7 @@ static int cs4271_common_probe(struct device *dev,
 {
 	struct cs4271_platform_data *cs4271plat = dev->platform_data;
 	struct cs4271_private *cs4271;
+	int i, ret;
 
 	cs4271 = devm_kzalloc(dev, sizeof(*cs4271), GFP_KERNEL);
 	if (!cs4271)
@@ -638,6 +680,17 @@ static int cs4271_common_probe(struct device *dev,
 			return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		cs4271->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(cs4271->supplies),
+					cs4271->supplies);
+
+	if (ret < 0) {
+		dev_err(dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
 	*c = cs4271;
 	return 0;
 }
-- 
2.4.3
