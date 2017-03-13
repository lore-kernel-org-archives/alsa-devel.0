From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs35l35: Add local variable for dev in probe" to the asoc tree
Date: Mon, 13 Mar 2017 16:58:35 +0000
Message-ID: <E1cnTIp-0005AI-2o@debutante>
References: <1488991371-22513-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488991371-22513-4-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add local variable for dev in probe

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1f758cd9da61a1ae2202405746d259ba640d1e8a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Wed, 8 Mar 2017 16:42:50 +0000
Subject: [PATCH] ASoC: cs35l35: Add local variable for dev in probe

Tidy up the code a little by adding a local variable for i2c_client->dev
rather than referring to it explicitly everytime.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/cs35l35.c | 66 ++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 5a9fe5addb86..99bcdb962359 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1354,16 +1354,14 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 			      const struct i2c_device_id *id)
 {
 	struct cs35l35_private *cs35l35;
-	struct cs35l35_platform_data *pdata =
-		dev_get_platdata(&i2c_client->dev);
+	struct device *dev = &i2c_client->dev;
+	struct cs35l35_platform_data *pdata = dev_get_platdata(dev);
 	int i;
 	int ret;
 	unsigned int devid = 0;
 	unsigned int reg;
 
-	cs35l35 = devm_kzalloc(&i2c_client->dev,
-			       sizeof(struct cs35l35_private),
-			       GFP_KERNEL);
+	cs35l35 = devm_kzalloc(dev, sizeof(struct cs35l35_private), GFP_KERNEL);
 	if (!cs35l35)
 		return -ENOMEM;
 
@@ -1371,7 +1369,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	cs35l35->regmap = devm_regmap_init_i2c(i2c_client, &cs35l35_regmap);
 	if (IS_ERR(cs35l35->regmap)) {
 		ret = PTR_ERR(cs35l35->regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
+		dev_err(dev, "regmap_init() failed: %d\n", ret);
 		goto err;
 	}
 
@@ -1379,22 +1377,18 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 		cs35l35->supplies[i].supply = cs35l35_supplies[i];
 		cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
 
-	ret = devm_regulator_bulk_get(&i2c_client->dev,
-			cs35l35->num_supplies,
-			cs35l35->supplies);
+	ret = devm_regulator_bulk_get(dev, cs35l35->num_supplies,
+				      cs35l35->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
-			"Failed to request core supplies: %d\n",
-			ret);
+		dev_err(dev, "Failed to request core supplies: %d\n", ret);
 		return ret;
 	}
 
 	if (pdata) {
 		cs35l35->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs35l35_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(dev, sizeof(struct cs35l35_platform_data),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 		if (i2c_client->dev.of_node) {
@@ -1409,24 +1403,21 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	ret = regulator_bulk_enable(cs35l35->num_supplies,
 					cs35l35->supplies);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev,
-			"Failed to enable core supplies: %d\n",
-			ret);
+		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
 		return ret;
 	}
 
 	/* returning NULL can be valid if in stereo mode */
-	cs35l35->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-		"reset", GPIOD_OUT_LOW);
+	cs35l35->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l35->reset_gpio)) {
 		ret = PTR_ERR(cs35l35->reset_gpio);
 		if (ret == -EBUSY) {
-			dev_info(&i2c_client->dev,
+			dev_info(dev,
 				 "Reset line busy, assuming shared reset\n");
 			cs35l35->reset_gpio = NULL;
 		} else {
-			dev_err(&i2c_client->dev,
-				"Failed to get reset GPIO: %d\n", ret);
+			dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
 			goto err;
 		}
 	}
@@ -1435,11 +1426,11 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 
 	init_completion(&cs35l35->pdn_done);
 
-	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
-			cs35l35_irq, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-			"cs35l35", cs35l35);
+	ret = devm_request_threaded_irq(dev, i2c_client->irq, NULL, cs35l35_irq,
+					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					"cs35l35", cs35l35);
 	if (ret != 0) {
-		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
+		dev_err(dev, "Failed to request IRQ: %d\n", ret);
 		goto err;
 	}
 	/* initialize codec */
@@ -1452,8 +1443,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	devid |= (reg & 0xF0) >> 4;
 
 	if (devid != CS35L35_CHIP_ID) {
-		dev_err(&i2c_client->dev,
-			"CS35L35 Device ID (%X). Expected ID %X\n",
+		dev_err(dev, "CS35L35 Device ID (%X). Expected ID %X\n",
 			devid, CS35L35_CHIP_ID);
 		ret = -ENODEV;
 		goto err;
@@ -1461,21 +1451,19 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 
 	ret = regmap_read(cs35l35->regmap, CS35L35_REV_ID, &reg);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Get Revision ID failed: %d\n", ret);
+		dev_err(dev, "Get Revision ID failed: %d\n", ret);
 		goto err;
 	}
 
 	ret = regmap_register_patch(cs35l35->regmap, cs35l35_errata_patch,
 				    ARRAY_SIZE(cs35l35_errata_patch));
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Failed to apply errata patch: %d\n",
-			ret);
+		dev_err(dev, "Failed to apply errata patch: %d\n", ret);
 		goto err;
 	}
 
-	dev_info(&i2c_client->dev,
-		 "Cirrus Logic CS35L35 (%x), Revision: %02X\n", devid,
-		ret & 0xFF);
+	dev_info(dev, "Cirrus Logic CS35L35 (%x), Revision: %02X\n",
+		 devid, ret & 0xFF);
 
 	/* Set the INT Masks for critical errors */
 	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_1,
@@ -1507,12 +1495,10 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
 		CS35L35_AMP_MUTE_MASK, 1 << CS35L35_AMP_MUTE_SHIFT);
 
-	ret =  snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_dev_cs35l35, cs35l35_dai,
-			ARRAY_SIZE(cs35l35_dai));
+	ret =  snd_soc_register_codec(dev, &soc_codec_dev_cs35l35, cs35l35_dai,
+				      ARRAY_SIZE(cs35l35_dai));
 	if (ret < 0) {
-		dev_err(&i2c_client->dev,
-			"Failed to register codec: %d\n", ret);
+		dev_err(dev, "Failed to register codec: %d\n", ret);
 		goto err;
 	}
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
