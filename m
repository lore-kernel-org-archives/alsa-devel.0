From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [RFC PATCH 1/6] ASoC: sgtl5000: fix regulator support
Date: Thu, 26 Feb 2015 15:54:28 -0700
Message-ID: <1424991273-10081-2-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id BB35726149E
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:54:42 +0100 (CET)
Received: by pabrd3 with SMTP id rd3so17562690pab.4
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:54:41 -0800 (PST)
In-Reply-To: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: fabio.estevam@freescale.com, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

Regulator support on SGTL5000 is broken because the VDDIO and
VDDA and VDDD should be powered on before enabling MCLK as
shown in Figure 4 of [1]. This requires moving control of the
regulators from the codec block to the I2C block of the driver.

The bulk of this patch consists of swapping the codec device with
the i2c client. The new field num_supplies in struct sgtl5000_priv
is used instead of ARRAY_SIZE(supplies) to handle the special case
when the internal LDO is used instead of external VDDD.

Note that ER1 in the SGTL5000 Errata document [2] suggests that
all designs should use external VDDD.

Since the internal LDO can only be enabled after I2C is available,
there's no benefit in treating it as a regulator, so this patch
removes the regulator structure surrounding it.

Instead, a single block of code in sgtl5000_i2c_probe() performs
the initialization sequence in section 2.2.1.1 of [3] and page
26 of [1].

References:
[1] SGTL5000 data sheet
    http://cache.freescale.com/files/analog/doc/data_sheet/SGTL5000.pdf
[2] SGTL5000 errata
    http://cache.freescale.com/files/analog/doc/errata/SGTL5000ER.pdf
[3] SGTL5000 Initialization and programming app note
    http://cache.freescale.com/files/analog/doc/app_note/AN3663.pdf

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 343 ++++++++++----------------------------------
 1 file changed, 78 insertions(+), 265 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index e182e65..8f755e8 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -92,36 +92,8 @@ static const char *supply_names[SGTL5000_SUPPLY_NUM] = {
 	"VDDD"
 };
 
-#define LDO_CONSUMER_NAME	"VDDD_LDO"
 #define LDO_VOLTAGE		1200000
 
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
-};
-
 enum sgtl5000_micbias_resistor {
 	SGTL5000_MICBIAS_OFF = 0,
 	SGTL5000_MICBIAS_2K = 2,
@@ -135,7 +107,7 @@ struct sgtl5000_priv {
 	int master;	/* i2s master or not */
 	int fmt;	/* i2s data format */
 	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
-	struct ldo_regulator *ldo;
+	int num_supplies;
 	struct regmap *regmap;
 	struct clk *mclk;
 	int revision;
@@ -778,155 +750,6 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
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
-	/* when internal ldo is enabled, simple digital power can be disabled */
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
-	if (!ldo)
-		return -ENOMEM;
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
@@ -950,7 +773,7 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(
-						ARRAY_SIZE(sgtl5000->supplies),
+						sgtl5000->num_supplies,
 						sgtl5000->supplies);
 			if (ret)
 				return ret;
@@ -964,7 +787,7 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 					"Failed to restore cache: %d\n", ret);
 
 				regcache_cache_only(sgtl5000->regmap, true);
-				regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
+				regulator_bulk_disable(sgtl5000->num_supplies,
 						       sgtl5000->supplies);
 
 				return ret;
@@ -974,8 +797,8 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_OFF:
 		regcache_cache_only(sgtl5000->regmap, true);
-		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
+		regulator_bulk_disable(sgtl5000->num_supplies,
+				       sgtl5000->supplies);
 		break;
 	}
 
@@ -1115,7 +938,9 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 
 	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
 	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
-	vddd  = regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
+	vddd  = (sgtl5000->num_supplies > VDDD)
+		? regulator_get_voltage(sgtl5000->supplies[VDDD].consumer)
+		: LDO_VOLTAGE;
 
 	vdda  = vdda / 1000;
 	vddio = vddio / 1000;
@@ -1224,78 +1049,43 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
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
-	dev_info(codec->dev, "Using internal LDO instead of VDDD\n");
-	return 0;
-}
-
-static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
+static int sgtl5000_enable_regulators(struct i2c_client *client)
 {
 	int ret;
 	int i;
 	int external_vddd = 0;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 	struct regulator *vddd;
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
 		sgtl5000->supplies[i].supply = supply_names[i];
 
-	/* External VDDD only works before revision 0x11 */
-	if (sgtl5000->revision < 0x11) {
-		vddd = regulator_get_optional(codec->dev, "VDDD");
-		if (IS_ERR(vddd)) {
-			/* See if it's just not registered yet */
-			if (PTR_ERR(vddd) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-		} else {
-			external_vddd = 1;
-			regulator_put(vddd);
-		}
-	}
-
-	if (!external_vddd) {
-		ret = sgtl5000_replace_vddd_with_ldo(codec);
-		if (ret)
-			return ret;
+	vddd = regulator_get_optional(&client->dev, "VDDD");
+	if (IS_ERR(vddd)) {
+		/* See if it's just not registered yet */
+		if (PTR_ERR(vddd) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		external_vddd = 1;
+		regulator_put(vddd);
 	}
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
+	sgtl5000->num_supplies = ARRAY_SIZE(sgtl5000->supplies)
+				 - 1 + external_vddd;
+	ret = regulator_bulk_get(&client->dev, sgtl5000->num_supplies,
 				 sgtl5000->supplies);
 	if (ret)
-		goto err_ldo_remove;
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
-					sgtl5000->supplies);
-	if (ret)
-		goto err_regulator_free;
-
-	/* wait for all power rails bring up */
-	udelay(10);
+		return ret;
 
-	return 0;
+	ret = regulator_bulk_enable(sgtl5000->num_supplies,
+				    sgtl5000->supplies);
+	if (!ret)
+		usleep_range(10, 20);
+	else
+		regulator_bulk_free(sgtl5000->num_supplies,
+				    sgtl5000->supplies);
 
-err_regulator_free:
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-err_ldo_remove:
-	if (!external_vddd)
-		ldo_regulator_remove(codec);
 	return ret;
-
 }
 
 static int sgtl5000_probe(struct snd_soc_codec *codec)
@@ -1303,10 +1093,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
-	ret = sgtl5000_enable_regulators(codec);
-	if (ret)
-		return ret;
-
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
@@ -1357,25 +1143,11 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err:
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
 	return ret;
 }
 
 static int sgtl5000_remove(struct snd_soc_codec *codec)
 {
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
-	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
-						sgtl5000->supplies);
-	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
-				sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
 	return 0;
 }
 
@@ -1443,11 +1215,17 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (!sgtl5000)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, sgtl5000);
+
+	ret = sgtl5000_enable_regulators(client);
+	if (ret)
+		return ret;
+
 	sgtl5000->regmap = devm_regmap_init_i2c(client, &sgtl5000_regmap);
 	if (IS_ERR(sgtl5000->regmap)) {
 		ret = PTR_ERR(sgtl5000->regmap);
 		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
-		return ret;
+		goto disable_regs;
 	}
 
 	sgtl5000->mclk = devm_clk_get(&client->dev, NULL);
@@ -1456,21 +1234,25 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
 		/* Defer the probe to see if the clk will be provided later */
 		if (ret == -ENOENT)
-			return -EPROBE_DEFER;
-		return ret;
+			ret = -EPROBE_DEFER;
+		goto disable_regs;
 	}
 
 	ret = clk_prepare_enable(sgtl5000->mclk);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(&client->dev, "Error  enabling clock %d\n", ret);
+		goto disable_regs;
+	}
 
 	/* Need 8 clocks before I2C accesses */
 	udelay(1);
 
 	/* read chip information */
 	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
+	if (ret) {
+		dev_err(&client->dev, "Error reading chip id %d\n", ret);
 		goto disable_clk;
+	}
 
 	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
 	    SGTL5000_PARTID_PART_ID) {
@@ -1484,6 +1266,31 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
 	sgtl5000->revision = rev;
 
+	/* Follow section 2.2.1.1 of AN3663 */
+	if (sgtl5000->num_supplies <= VDDD) {
+		/* internal VDDD at 1.2V */
+		regmap_update_bits(sgtl5000->regmap,
+				   SGTL5000_CHIP_LINREG_CTRL,
+				   SGTL5000_LINREG_VDDD_MASK, 8);
+		regmap_update_bits(sgtl5000->regmap,
+				   SGTL5000_CHIP_ANA_POWER,
+				   SGTL5000_LINEREG_D_POWERUP
+				   | SGTL5000_LINREG_SIMPLE_POWERUP,
+				   SGTL5000_LINEREG_D_POWERUP);
+		dev_info(&client->dev, "Using internal LDO instead of VDDD: check ER1\n");
+	} else {
+		/* using external LDO for VDDD
+		 * Clear startup powerup and simple powerup
+		 * bits to save power
+		 */
+		regmap_update_bits(sgtl5000->regmap,
+				   SGTL5000_CHIP_ANA_POWER,
+				   SGTL5000_STARTUP_POWERUP
+				   | SGTL5000_LINREG_SIMPLE_POWERUP,
+				   0);
+		dev_dbg(&client->dev, "Using external VDDD\n");
+	}
+
 	if (np) {
 		if (!of_property_read_u32(np,
 			"micbias-resistor-k-ohms", &value)) {
@@ -1525,8 +1332,6 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	i2c_set_clientdata(client, sgtl5000);
-
 	/* Ensure sgtl5000 will start with sane register values */
 	ret = sgtl5000_fill_defaults(sgtl5000);
 	if (ret)
@@ -1541,6 +1346,11 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 disable_clk:
 	clk_disable_unprepare(sgtl5000->mclk);
+
+disable_regs:
+	regulator_bulk_disable(sgtl5000->num_supplies, sgtl5000->supplies);
+	regulator_bulk_free(sgtl5000->num_supplies, sgtl5000->supplies);
+
 	return ret;
 }
 
@@ -1550,6 +1360,9 @@ static int sgtl5000_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	clk_disable_unprepare(sgtl5000->mclk);
+	regulator_bulk_disable(sgtl5000->num_supplies, sgtl5000->supplies);
+	regulator_bulk_free(sgtl5000->num_supplies, sgtl5000->supplies);
+
 	return 0;
 }
 
-- 
1.9.1
