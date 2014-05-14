From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/6] ASoC: ak4642: Add driver data and driver
	private struct
Date: Wed, 14 May 2014 09:37:35 +0200
Message-ID: <1400053058-1115-4-git-send-email-s.hauer@pengutronix.de>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 65D382652C6
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 09:38:14 +0200 (CEST)
In-Reply-To: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Currently unused, this is done to let the driver distinguish between
the different supported codec types in later patches.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/ak4642.c | 51 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 90d2d93..b568692 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -134,6 +134,14 @@
 /* MD_CTL4 */
 #define DACH		(1 << 0)
 
+struct ak4642_drvdata {
+	const struct regmap_config *regmap_config;
+};
+
+struct ak4642_priv {
+	const struct ak4642_drvdata *drvdata;
+};
+
 /*
  * Playback Volume (table 39)
  *
@@ -507,30 +515,51 @@ static const struct regmap_config ak4648_regmap = {
 	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
 };
 
+static const struct ak4642_drvdata ak4642_drvdata = {
+	.regmap_config = &ak4642_regmap,
+};
+
+static const struct ak4642_drvdata ak4643_drvdata = {
+	.regmap_config = &ak4642_regmap,
+};
+
+static const struct ak4642_drvdata ak4648_drvdata = {
+	.regmap_config = &ak4648_regmap,
+};
+
 static struct of_device_id ak4642_of_match[];
 static int ak4642_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct device_node *np = i2c->dev.of_node;
-	const struct regmap_config *regmap_config = NULL;
+	const struct ak4642_drvdata *drvdata = NULL;
 	struct regmap *regmap;
+	struct ak4642_priv *priv;
 
 	if (np) {
 		const struct of_device_id *of_id;
 
 		of_id = of_match_device(ak4642_of_match, &i2c->dev);
 		if (of_id)
-			regmap_config = of_id->data;
+			drvdata = of_id->data;
 	} else {
-		regmap_config = (const struct regmap_config *)id->driver_data;
+		drvdata = (const struct ak4642_drvdata *)id->driver_data;
 	}
 
-	if (!regmap_config) {
+	if (!drvdata) {
 		dev_err(&i2c->dev, "Unknown device type\n");
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->drvdata = drvdata;
+
+	i2c_set_clientdata(i2c, priv);
+
+	regmap = devm_regmap_init_i2c(i2c, drvdata->regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
@@ -545,17 +574,17 @@ static int ak4642_i2c_remove(struct i2c_client *client)
 }
 
 static struct of_device_id ak4642_of_match[] = {
-	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_regmap},
-	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4642_regmap},
-	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_regmap},
+	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_drvdata},
+	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4643_drvdata},
+	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_drvdata},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ak4642_of_match);
 
 static const struct i2c_device_id ak4642_i2c_id[] = {
-	{ "ak4642", (kernel_ulong_t)&ak4642_regmap },
-	{ "ak4643", (kernel_ulong_t)&ak4642_regmap },
-	{ "ak4648", (kernel_ulong_t)&ak4648_regmap },
+	{ "ak4642", (kernel_ulong_t)&ak4642_drvdata },
+	{ "ak4643", (kernel_ulong_t)&ak4643_drvdata },
+	{ "ak4648", (kernel_ulong_t)&ak4648_drvdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
-- 
2.0.0.rc0
