From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: cs35l35: Add local variable for dev
	in probe
Date: Wed, 8 Mar 2017 16:42:50 +0000
Message-ID: <1488991371-22513-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C1A9266B15
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 17:41:49 +0100 (CET)
In-Reply-To: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Tidy up the code a little by adding a local variable for i2c_client->dev
rather than referring to it explicitly everytime.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 66 ++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 5a9fe5a..99bcdb9 100644
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
2.1.4
