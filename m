From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l51: split i2c from codec driver
Date: Tue, 15 Apr 2014 15:49:33 -0500
Message-ID: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heelrod (unknown [141.131.2.3])
 by alsa0.perex.cz (Postfix) with ESMTP id B2E372651B9
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 22:49:09 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

This patch removes the i2c bus code from the codec driver and creates seperate i2c driver.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/Kconfig       |    6 +++-
 sound/soc/codecs/Makefile      |    2 ++
 sound/soc/codecs/cs42l51-i2c.c |   59 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l51.c     |   77 +++++++++++-----------------------------
 sound/soc/codecs/cs42l51.h     |    5 +++
 5 files changed, 91 insertions(+), 58 deletions(-)
 create mode 100644 sound/soc/codecs/cs42l51-i2c.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 983d087a..5ee2eb5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -32,7 +32,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_ALC5632 if I2C
 	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
-	select SND_SOC_CS42L51 if I2C
+	select SND_SOC_CS42L51_I2C if I2C
 	select SND_SOC_CS42L52 if I2C
 	select SND_SOC_CS42L73 if I2C
 	select SND_SOC_CS4270 if I2C
@@ -233,6 +233,10 @@ config SND_SOC_CQ0093VC
 config SND_SOC_CS42L51
 	tristate
 
+config SND_SOC_CS42L51_I2C
+	tristate
+	select SND_SOC_CS42L51
+
 config SND_SOC_CS42L52
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bc12676..3046dc0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -19,6 +19,7 @@ snd-soc-ak5386-objs := ak5386.o
 snd-soc-arizona-objs := arizona.o
 snd-soc-cq93vc-objs := cq93vc.o
 snd-soc-cs42l51-objs := cs42l51.o
+snd-soc-cs42l51-i2c-objs := cs42l51-i2c.o
 snd-soc-cs42l52-objs := cs42l52.o
 snd-soc-cs42l73-objs := cs42l73.o
 snd-soc-cs4270-objs := cs4270.o
@@ -152,6 +153,7 @@ obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
+obj-$(CONFIG_SND_SOC_CS42L51_I2C)	+= snd-soc-cs42l51-i2c.o
 obj-$(CONFIG_SND_SOC_CS42L52)	+= snd-soc-cs42l52.o
 obj-$(CONFIG_SND_SOC_CS42L73)	+= snd-soc-cs42l73.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
new file mode 100644
index 0000000..50d42ef
--- /dev/null
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -0,0 +1,59 @@
+/*
+ * cs42l56.c -- CS42L51 ALSA SoC I2C audio driver
+ *
+ * Copyright 2014 CirrusLogic, Inc.
+ *
+ * Author: Brian Austin <brian.austin@cirrus.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include "cs42l51.h"
+
+static struct i2c_device_id cs42l51_i2c_id[] = {
+	{"cs42l51", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs42l51_i2c_id);
+
+static int cs42l51_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct regmap_config config;
+
+	config = cs42l51_regmap;
+	config.val_bits = 8;
+	config.reg_bits = 8;
+
+	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
+}
+
+static int cs42l51_i2c_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+static struct i2c_driver cs42l51_i2c_driver = {
+	.driver = {
+		.name = "cs42l51",
+		.owner = THIS_MODULE,
+	},
+	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
+	.id_table = cs42l51_i2c_id,
+};
+
+module_i2c_driver(cs42l51_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CS42L51 I2C Driver");
+MODULE_AUTHOR("Brian Austin, Cirrus Logic Inc, <brian.austin@cirrus.com>");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 65fc37c..68ab2eb 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -29,7 +29,6 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
-#include <linux/i2c.h>
 #include <linux/regmap.h>
 
 #include "cs42l51.h"
@@ -484,7 +483,7 @@ static struct snd_soc_dai_driver cs42l51_dai = {
 	.ops = &cs42l51_dai_ops,
 };
 
-static int cs42l51_probe(struct snd_soc_codec *codec)
+static int cs42l51_codec_probe(struct snd_soc_codec *codec)
 {
 	int ret, reg;
 
@@ -511,7 +510,7 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
-	.probe = cs42l51_probe,
+	.probe = cs42l51_codec_probe,
 
 	.controls = cs42l51_snd_controls,
 	.num_controls = ARRAY_SIZE(cs42l51_snd_controls),
@@ -521,91 +520,55 @@ static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.num_dapm_routes = ARRAY_SIZE(cs42l51_routes),
 };
 
-static const struct regmap_config cs42l51_regmap = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
+const struct regmap_config cs42l51_regmap = {
 	.max_register = CS42L51_CHARGE_FREQ,
 	.cache_type = REGCACHE_RBTREE,
 };
+EXPORT_SYMBOL_GPL(cs42l51_regmap);
 
-static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
-	const struct i2c_device_id *id)
+int cs42l51_probe(struct device *dev, struct regmap *regmap)
 {
 	struct cs42l51_private *cs42l51;
-	struct regmap *regmap;
 	unsigned int val;
 	int ret;
-
-	regmap = devm_regmap_init_i2c(i2c_client, &cs42l51_regmap);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		dev_err(&i2c_client->dev, "Failed to create regmap: %d\n",
-			ret);
-		return ret;
-	}
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	cs42l51 = devm_kzalloc(dev, sizeof(struct cs42l51_private),
+			       GFP_KERNEL);
+	if (!cs42l51)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, cs42l51);
 
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to read I2C\n");
+		dev_err(dev, "failed to read I2C\n");
 		goto error;
 	}
 
 	if ((val != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_A)) &&
 	    (val != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_B))) {
-		dev_err(&i2c_client->dev, "Invalid chip id: %x\n", val);
+		dev_err(dev, "Invalid chip id: %x\n", val);
 		ret = -ENODEV;
 		goto error;
 	}
+	dev_info(dev, "Cirrus Logic CS42L51, Revision: %02X\n", val & 0xFF);
 
-	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
-		 val & 7);
-
-	cs42l51 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l51_private),
-			       GFP_KERNEL);
-	if (!cs42l51)
-		return -ENOMEM;
-
-	i2c_set_clientdata(i2c_client, cs42l51);
-
-	ret =  snd_soc_register_codec(&i2c_client->dev,
+	ret =  snd_soc_register_codec(dev,
 			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
 error:
 	return ret;
 }
-
-static int cs42l51_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
-static const struct i2c_device_id cs42l51_id[] = {
-	{"cs42l51", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cs42l51_id);
+EXPORT_SYMBOL_GPL(cs42l51_probe);
 
 static const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cs42l51_of_match);
-
-static struct i2c_driver cs42l51_i2c_driver = {
-	.driver = {
-		.name = "cs42l51-codec",
-		.owner = THIS_MODULE,
-		.of_match_table = cs42l51_of_match,
-	},
-	.id_table = cs42l51_id,
-	.probe = cs42l51_i2c_probe,
-	.remove = cs42l51_i2c_remove,
-};
-
-module_i2c_driver(cs42l51_i2c_driver);
-
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Cirrus Logic CS42L51 ALSA SoC Codec Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 2beeb17..641ef18 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -18,6 +18,11 @@
 #ifndef _CS42L51_H
 #define _CS42L51_H
 
+struct device;
+
+extern const struct regmap_config cs42l51_regmap;
+int cs42l51_probe(struct device *dev, struct regmap *regmap);
+
 #define CS42L51_CHIP_ID			0x1B
 #define CS42L51_CHIP_REV_A		0x00
 #define CS42L51_CHIP_REV_B		0x01
-- 
1.7.9.5
