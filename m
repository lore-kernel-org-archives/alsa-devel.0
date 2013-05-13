From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] ASoC: sgtl5000: Simplify the handling of
	VDDD
Date: Mon, 13 May 2013 12:39:19 -0300
Message-ID: <1368459567-26780-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 68088261719
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 17:40:02 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

sgtl5000 has two power supplies that are mandatory: VDDA and VDDIO.

VDDD is an optional supply and can be left unconnected and in this case an 
internal regulator is used.

Current code always use the internal regulator even if an external VDDD supply 
is provided and the sglt5000 revision is equal or greater than 0x11.

It is better to simplify the code to handle VDDD and always turn on the internal
regulator since all the production sgtl5000 have revision equal or greater 0x11.

While at it, turn on the regulators prior to reading the SGTL5000_CHIP_ID
register.

Tested on a mx51evk board that has VDDA and VDDIO provided by the PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |  394 ++++++++-----------------------------------
 1 file changed, 70 insertions(+), 324 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1c3b20f..2e56d00 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -65,45 +65,12 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
 enum sgtl5000_regulator_supplies {
 	VDDA,
 	VDDIO,
-	VDDD,
 	SGTL5000_SUPPLY_NUM
 };
 
-/* vddd is optional supply */
 static const char *supply_names[SGTL5000_SUPPLY_NUM] = {
 	"VDDA",
 	"VDDIO",
-	"VDDD"
-};
-
-#define LDO_CONSUMER_NAME	"VDDD_LDO"
-#define LDO_VOLTAGE		1200000
-
-static struct regulator_consumer_supply ldo_consumer[] = {
-	REGULATOR_SUPPLY(LDO_CONSUMER_NAME, NULL),
-};
-
-static struct regulator_init_data ldo_init_data = {
-	.constraints = {
-		.min_uV                 = 1200000,
-		.max_uV                 = 1200000,
-		.valid_modes_mask       = REGULATOR_MODE_NORMAL,
-		.valid_ops_mask         = REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies = 1,
-	.consumer_supplies = &ldo_consumer[0],
-};
-
-/*
- * sgtl5000 internal ldo regulator,
- * enabled when VDDD not provided
- */
-struct ldo_regulator {
-	struct regulator_desc desc;
-	struct regulator_dev *dev;
-	int voltage;
-	void *codec_data;
-	bool enabled;
 };
 
 /* sgtl5000 private structure in codec */
@@ -112,7 +79,7 @@ struct sgtl5000_priv {
 	int master;	/* i2s master or not */
 	int fmt;	/* i2s data format */
 	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
-	struct ldo_regulator *ldo;
+	struct regulator *vddd;
 	struct regmap *regmap;
 };
 
@@ -732,157 +699,6 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#ifdef CONFIG_REGULATOR
-static int ldo_regulator_is_enabled(struct regulator_dev *dev)
-{
-	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
-
-	return ldo->enabled;
-}
-
-static int ldo_regulator_enable(struct regulator_dev *dev)
-{
-	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
-	struct snd_soc_codec *codec = (struct snd_soc_codec *)ldo->codec_data;
-	int reg;
-
-	if (ldo_regulator_is_enabled(dev))
-		return 0;
-
-	/* set regulator value firstly */
-	reg = (1600 - ldo->voltage / 1000) / 50;
-	reg = clamp(reg, 0x0, 0xf);
-
-	/* amend the voltage value, unit: uV */
-	ldo->voltage = (1600 - reg * 50) * 1000;
-
-	/* set voltage to register */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
-				SGTL5000_LINREG_VDDD_MASK, reg);
-
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINEREG_D_POWERUP,
-				SGTL5000_LINEREG_D_POWERUP);
-
-	/* when internal ldo enabled, simple digital power can be disabled */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP,
-				0);
-
-	ldo->enabled = 1;
-	return 0;
-}
-
-static int ldo_regulator_disable(struct regulator_dev *dev)
-{
-	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
-	struct snd_soc_codec *codec = (struct snd_soc_codec *)ldo->codec_data;
-
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINEREG_D_POWERUP,
-				0);
-
-	/* clear voltage info */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
-				SGTL5000_LINREG_VDDD_MASK, 0);
-
-	ldo->enabled = 0;
-
-	return 0;
-}
-
-static int ldo_regulator_get_voltage(struct regulator_dev *dev)
-{
-	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
-
-	return ldo->voltage;
-}
-
-static struct regulator_ops ldo_regulator_ops = {
-	.is_enabled = ldo_regulator_is_enabled,
-	.enable = ldo_regulator_enable,
-	.disable = ldo_regulator_disable,
-	.get_voltage = ldo_regulator_get_voltage,
-};
-
-static int ldo_regulator_register(struct snd_soc_codec *codec,
-				struct regulator_init_data *init_data,
-				int voltage)
-{
-	struct ldo_regulator *ldo;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-	struct regulator_config config = { };
-
-	ldo = kzalloc(sizeof(struct ldo_regulator), GFP_KERNEL);
-
-	if (!ldo) {
-		dev_err(codec->dev, "failed to allocate ldo_regulator\n");
-		return -ENOMEM;
-	}
-
-	ldo->desc.name = kstrdup(dev_name(codec->dev), GFP_KERNEL);
-	if (!ldo->desc.name) {
-		kfree(ldo);
-		dev_err(codec->dev, "failed to allocate decs name memory\n");
-		return -ENOMEM;
-	}
-
-	ldo->desc.type  = REGULATOR_VOLTAGE;
-	ldo->desc.owner = THIS_MODULE;
-	ldo->desc.ops   = &ldo_regulator_ops;
-	ldo->desc.n_voltages = 1;
-
-	ldo->codec_data = codec;
-	ldo->voltage = voltage;
-
-	config.dev = codec->dev;
-	config.driver_data = ldo;
-	config.init_data = init_data;
-
-	ldo->dev = regulator_register(&ldo->desc, &config);
-	if (IS_ERR(ldo->dev)) {
-		int ret = PTR_ERR(ldo->dev);
-
-		dev_err(codec->dev, "failed to register regulator\n");
-		kfree(ldo->desc.name);
-		kfree(ldo);
-
-		return ret;
-	}
-	sgtl5000->ldo = ldo;
-
-	return 0;
-}
-
-static int ldo_regulator_remove(struct snd_soc_codec *codec)
-{
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-	struct ldo_regulator *ldo = sgtl5000->ldo;
-
-	if (!ldo)
-		return 0;
-
-	regulator_unregister(ldo->dev);
-	kfree(ldo->desc.name);
-	kfree(ldo);
-
-	return 0;
-}
-#else
-static int ldo_regulator_register(struct snd_soc_codec *codec,
-				struct regulator_init_data *init_data,
-				int voltage)
-{
-	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
-	return -EINVAL;
-}
-
-static int ldo_regulator_remove(struct snd_soc_codec *codec)
-{
-	return 0;
-}
-#endif
-
 /*
  * set dac bias
  * common state changes:
@@ -910,6 +726,11 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 						sgtl5000->supplies);
 			if (ret)
 				return ret;
+			if (sgtl5000->vddd) {
+				ret = regulator_enable(sgtl5000->vddd);
+				if (ret)
+					return ret;
+			}
 			udelay(10);
 		}
 
@@ -917,6 +738,8 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_OFF:
 		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
+		if (sgtl5000->vddd)
+			regulator_disable(sgtl5000->vddd);
 		break;
 	}
 
@@ -1136,7 +959,10 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 
 	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
 	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
-	vddd  = regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
+	if (sgtl5000->vddd)
+		vddd  = regulator_get_voltage(sgtl5000->vddd);
+	else
+		vddd = 0;
 
 	vdda  = vdda / 1000;
 	vddio = vddio / 1000;
@@ -1198,15 +1024,14 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	 * simple digital supply should be clear to get
 	 * proper VDDD voltage.
 	 */
-	if (ana_pwr & SGTL5000_LINEREG_D_POWERUP)
-		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				SGTL5000_LINEREG_D_POWERUP,
+				SGTL5000_LINEREG_D_POWERUP);
+
+	/* when internal ldo enabled, simple digital power can be disabled */
+	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				SGTL5000_LINREG_SIMPLE_POWERUP,
 				0);
-	else
-		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP |
-				SGTL5000_STARTUP_POWERUP,
-				0);
 
 	/*
 	 * set ADC/DAC VAG to vdda / 2,
@@ -1245,110 +1070,6 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
-{
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	/* set internal ldo to 1.2v */
-	ret = ldo_regulator_register(codec, &ldo_init_data, LDO_VOLTAGE);
-	if (ret) {
-		dev_err(codec->dev,
-			"Failed to register vddd internal supplies: %d\n", ret);
-		return ret;
-	}
-
-	sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
-			sgtl5000->supplies);
-
-	if (ret) {
-		ldo_regulator_remove(codec);
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
-	}
-
-	dev_info(codec->dev, "Using internal LDO instead of VDDD\n");
-	return 0;
-}
-
-static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
-{
-	int reg;
-	int ret;
-	int rev;
-	int i;
-	int external_vddd = 0;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
-	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
-		sgtl5000->supplies[i].supply = supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	if (!ret)
-		external_vddd = 1;
-	else {
-		ret = sgtl5000_replace_vddd_with_ldo(codec);
-		if (ret)
-			return ret;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-	if (ret)
-		goto err_regulator_free;
-
-	/* wait for all power rails bring up */
-	udelay(10);
-
-	/*
-	 * workaround for revision 0x11 and later,
-	 * roll back to use internal LDO
-	 */
-
-	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
-		goto err_regulator_disable;
-
-	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
-
-	if (external_vddd && rev >= 0x11) {
-		/* disable all regulator first */
-		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-		/* free VDDD regulator */
-		regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-
-		ret = sgtl5000_replace_vddd_with_ldo(codec);
-		if (ret)
-			return ret;
-
-		ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-		if (ret)
-			goto err_regulator_free;
-
-		/* wait for all power rails bring up */
-		udelay(10);
-	}
-
-	return 0;
-
-err_regulator_disable:
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-err_regulator_free:
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	if (external_vddd)
-		ldo_regulator_remove(codec);
-	return ret;
-
-}
-
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -1362,14 +1083,10 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = sgtl5000_enable_regulators(codec);
-	if (ret)
-		return ret;
-
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
-		goto err;
+		return ret;
 
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
@@ -1412,32 +1129,16 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	/* leading to standby state */
 	ret = sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	if (ret)
-		goto err;
+		return ret;
 
 	return 0;
 
-err:
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
-	return ret;
 }
 
 static int sgtl5000_remove(struct snd_soc_codec *codec)
 {
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
 	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
 	return 0;
 }
 
@@ -1497,30 +1198,63 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
 	struct sgtl5000_priv *sgtl5000;
-	int ret, reg, rev;
+	int ret, reg, rev, i;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
 								GFP_KERNEL);
 	if (!sgtl5000)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
+		sgtl5000->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(&client->dev,
+			ARRAY_SIZE(sgtl5000->supplies), sgtl5000->supplies);
+	if (ret) {
+		dev_err(&client->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
+				    sgtl5000->supplies);
+	if (ret) {
+		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	sgtl5000->vddd = devm_regulator_get(&client->dev, "VDDD");
+	if (!IS_ERR(sgtl5000->vddd)) {
+		ret = regulator_enable(sgtl5000->vddd);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to enable VDDD: %d\n", ret);
+			goto err_bulk;
+		}
+	} else {
+		sgtl5000->vddd = NULL;
+	}
+
+	/* wait for all power rails bring up */
+	udelay(10);
+
 	sgtl5000->regmap = devm_regmap_init_i2c(client, &sgtl5000_regmap);
 	if (IS_ERR(sgtl5000->regmap)) {
 		ret = PTR_ERR(sgtl5000->regmap);
 		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
-		return ret;
+		goto err_vddd;
 	}
 
 	/* read chip information */
 	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
 	if (ret)
-		return ret;
+		goto err_vddd;
 
 	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
 	    SGTL5000_PARTID_PART_ID) {
 		dev_err(&client->dev,
 			"Device with ID register %x is not a sgtl5000\n", reg);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_vddd;
 	}
 
 	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
@@ -1531,10 +1265,22 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	/* Ensure sgtl5000 will start with sane register values */
 	ret = sgtl5000_fill_defaults(sgtl5000);
 	if (ret)
-		return ret;
+		goto err_vddd;
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
+	if (ret)
+		goto err_vddd;
+
+	return 0;
+
+err_vddd:
+	if (sgtl5000->vddd)
+		regulator_disable(sgtl5000->vddd);
+err_bulk:
+	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
+						sgtl5000->supplies);
+
 	return ret;
 }
 
-- 
1.7.9.5
