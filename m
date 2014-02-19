From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: cs4271: claim reset GPIO in bus probe
	function
Date: Wed, 19 Feb 2014 14:05:54 +0100
Message-ID: <1392815154-24728-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F884261609
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 14:06:03 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id na10so196825bkb.0
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 05:06:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, subaparts@yandex.ru
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Move the GPIO acquisition from the codec to the bus probe functions.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/cs4271.c | 60 +++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ce05fd9..6bfe021 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -540,14 +540,10 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
 	int ret;
-	int gpio_nreset = -EINVAL;
 	bool amutec_eq_bmutec = false;
 
 #ifdef CONFIG_OF
 	if (of_match_device(cs4271_dt_ids, codec->dev)) {
-		gpio_nreset = of_get_named_gpio(codec->dev->of_node,
-						"reset-gpio", 0);
-
 		if (of_get_property(codec->dev->of_node,
 				     "cirrus,amutec-eq-bmutec", NULL))
 			amutec_eq_bmutec = true;
@@ -559,27 +555,19 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 #endif
 
 	if (cs4271plat) {
-		if (gpio_is_valid(cs4271plat->gpio_nreset))
-			gpio_nreset = cs4271plat->gpio_nreset;
-
 		amutec_eq_bmutec = cs4271plat->amutec_eq_bmutec;
 		cs4271->enable_soft_reset = cs4271plat->enable_soft_reset;
 	}
 
-	if (gpio_nreset >= 0)
-		if (devm_gpio_request(codec->dev, gpio_nreset, "CS4271 Reset"))
-			gpio_nreset = -EINVAL;
-	if (gpio_nreset >= 0) {
+	if (gpio_is_valid(cs4271->gpio_nreset)) {
 		/* Reset codec */
-		gpio_direction_output(gpio_nreset, 0);
+		gpio_direction_output(cs4271->gpio_nreset, 0);
 		udelay(1);
-		gpio_set_value(gpio_nreset, 1);
+		gpio_set_value(cs4271->gpio_nreset, 1);
 		/* Give the codec time to wake up */
 		udelay(1);
 	}
 
-	cs4271->gpio_nreset = gpio_nreset;
-
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
 				 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);
@@ -641,14 +629,45 @@ static const struct regmap_config cs4271_spi_regmap = {
 	.volatile_reg = cs4271_volatile_reg,
 };
 
-static int cs4271_spi_probe(struct spi_device *spi)
+static int cs4271_common_probe(struct device *dev,
+			       struct cs4271_private **c)
 {
+	struct cs4271_platform_data *cs4271plat = dev->platform_data;
 	struct cs4271_private *cs4271;
 
-	cs4271 = devm_kzalloc(&spi->dev, sizeof(*cs4271), GFP_KERNEL);
+	cs4271 = devm_kzalloc(dev, sizeof(*cs4271), GFP_KERNEL);
 	if (!cs4271)
 		return -ENOMEM;
 
+	if (of_match_device(cs4271_dt_ids, dev))
+		cs4271->gpio_nreset =
+			of_get_named_gpio(dev->of_node, "reset-gpio", 0);
+
+	if (cs4271plat)
+		cs4271->gpio_nreset = cs4271plat->gpio_nreset;
+
+	if (gpio_is_valid(cs4271->gpio_nreset)) {
+		int ret;
+
+		ret = devm_gpio_request(dev, cs4271->gpio_nreset,
+					"CS4271 Reset");
+		if (ret < 0)
+			return ret;
+	}
+
+	*c = cs4271;
+	return 0;
+}
+
+static int cs4271_spi_probe(struct spi_device *spi)
+{
+	struct cs4271_private *cs4271;
+	int ret;
+
+	ret = cs4271_common_probe(&spi->dev, &cs4271);
+	if (ret < 0)
+		return ret;
+
 	spi_set_drvdata(spi, cs4271);
 	cs4271->regmap = devm_regmap_init_spi(spi, &cs4271_spi_regmap);
 	if (IS_ERR(cs4271->regmap))
@@ -698,10 +717,11 @@ static int cs4271_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
 	struct cs4271_private *cs4271;
+	int ret;
 
-	cs4271 = devm_kzalloc(&client->dev, sizeof(*cs4271), GFP_KERNEL);
-	if (!cs4271)
-		return -ENOMEM;
+	ret = cs4271_common_probe(&client->dev, &cs4271);
+	if (ret < 0)
+		return ret;
 
 	i2c_set_clientdata(client, cs4271);
 	cs4271->regmap = devm_regmap_init_i2c(client, &cs4271_i2c_regmap);
-- 
1.8.5.3
