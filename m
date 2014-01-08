From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: da9055: Partially fix device registration
Date: Wed,  8 Jan 2014 20:38:55 +0000
Message-ID: <1389213535-10801-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6252D262607
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 21:39:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anthony Olech <anthony.olech.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

It has never been possible to even load the da9055 driver since both the
MFD and CODEC drivers register the I2C device "da9055". Fix this by using
the usual pattern for MFDs with multiple I2C addresses and having the CODEC
driver reference an I2C dummy registered by the MFD.

Since I don't know which I2C address to use for the CODEC a FIXME has been
left in the MFD, this doesn't make anything any worse since the device has
never been able to load in the first place.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mfd/da9055-core.c       |  3 +++
 drivers/mfd/da9055-i2c.c        |  2 ++
 include/linux/mfd/da9055/core.h |  2 +-
 sound/soc/codecs/da9055.c       | 49 ++++++++++++++++++++---------------------
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index caf8dcffd0ad..fb0284cda4a5 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -365,6 +365,9 @@ static const struct mfd_cell da9055_devs[] = {
 		.of_compatible = "dialog,da9055-watchdog",
 		.name = "da9055-watchdog",
 	},
+	{
+		.name = "da9055-codec",
+	},
 };
 
 static struct regmap_irq_chip da9055_regmap_irq_chip = {
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 13af7e50021e..4f5e18750e1a 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -39,6 +39,8 @@ static int da9055_i2c_probe(struct i2c_client *i2c,
 	da9055->dev = &i2c->dev;
 	da9055->chip_irq = i2c->irq;
 
+	/* FIXME: Should use i2c_add_dummy() for the CODEC */
+
 	i2c_set_clientdata(i2c, da9055);
 
 	return da9055_device_init(da9055);
diff --git a/include/linux/mfd/da9055/core.h b/include/linux/mfd/da9055/core.h
index 956afa445998..e293797ded66 100644
--- a/include/linux/mfd/da9055/core.h
+++ b/include/linux/mfd/da9055/core.h
@@ -42,7 +42,7 @@ struct da9055 {
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *irq_data;
 	struct device *dev;
-	struct i2c_client *i2c_client;
+	struct i2c_client *i2c_client, *codec;
 
 	int irq_base;
 	int chip_irq;
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 52b79a487ac7..88c1a884aed8 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -14,10 +14,10 @@
  */
 
 #include <linux/delay.h>
-#include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mfd/da9055/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -1474,7 +1474,7 @@ static struct snd_soc_codec_driver soc_codec_dev_da9055 = {
 	.num_dapm_routes	= ARRAY_SIZE(da9055_audio_map),
 };
 
-static const struct regmap_config da9055_regmap_config = {
+static const struct regmap_config da9055_codec_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -1484,14 +1484,19 @@ static const struct regmap_config da9055_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int da9055_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int da9055_dev_probe(struct platform_device *pdev)
 {
+	struct da9055 *core = dev_get_drvdata(pdev->dev.parent);
 	struct da9055_priv *da9055;
-	struct da9055_platform_data *pdata = dev_get_platdata(&i2c->dev);
+	struct da9055_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
-	da9055 = devm_kzalloc(&i2c->dev, sizeof(struct da9055_priv),
+	if (!core->codec) {
+		dev_err(&pdev->dev, "No CODEC device registered\n");
+		return -ENODEV;
+	}
+
+	da9055 = devm_kzalloc(&pdev->dev, sizeof(struct da9055_priv),
 			      GFP_KERNEL);
 	if (!da9055)
 		return -ENOMEM;
@@ -1499,48 +1504,42 @@ static int da9055_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		da9055->pdata = pdata;
 
-	i2c_set_clientdata(i2c, da9055);
+	platform_set_drvdata(pdev, da9055);
 
-	da9055->regmap = devm_regmap_init_i2c(i2c, &da9055_regmap_config);
+	da9055->regmap = devm_regmap_init_i2c(core->codec,
+					      &da9055_codec_regmap_config);
 	if (IS_ERR(da9055->regmap)) {
 		ret = PTR_ERR(da9055->regmap);
-		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
+		dev_err(&pdev->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev,
+	ret = snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_da9055, &da9055_dai, 1);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to register da9055 codec: %d\n",
+		dev_err(&pdev->dev, "Failed to register da9055 codec: %d\n",
 			ret);
 	}
 	return ret;
 }
 
-static int da9055_remove(struct i2c_client *client)
+static int da9055_dev_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&client->dev);
+	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
-static const struct i2c_device_id da9055_i2c_id[] = {
-	{ "da9055", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
-
 /* I2C codec control layer */
-static struct i2c_driver da9055_i2c_driver = {
+static struct platform_driver da9055_codec_driver = {
 	.driver = {
-		.name = "da9055",
+		.name = "da9055-codec",
 		.owner = THIS_MODULE,
 	},
-	.probe		= da9055_i2c_probe,
-	.remove		= da9055_remove,
-	.id_table	= da9055_i2c_id,
+	.probe		= da9055_dev_probe,
+	.remove		= da9055_dev_remove,
 };
 
-module_i2c_driver(da9055_i2c_driver);
+module_platform_driver(da9055_codec_driver);
 
 MODULE_DESCRIPTION("ASoC DA9055 Codec driver");
 MODULE_AUTHOR("David Chen, Ashish Chavan");
-- 
1.8.5.2
