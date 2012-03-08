From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH] ASoC: da7210: Update for using I2C regmap
Date: Thu, 8 Mar 2012 19:04:56 +0530
Message-ID: <1331213696.17383.7.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A04710BA87
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:24:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Current DA7210 driver has I2C support using older register cache
methods. This patch updates it for latest regmap framework.

This has been tested on DA7210 EVB with Samsung SMDK6410 board.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |  234 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 196 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index ab38e93..0c23f19 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -17,6 +17,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/pcm.h>
@@ -626,41 +627,170 @@ static const struct snd_soc_dapm_route da7210_audio_map[] = {
 
 /* Codec private data */
 struct da7210_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 };
 
-/*
- * Register cache
- */
-static const u8 da7210_reg[] = {
-	0x00, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R0  - R7  */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,	/* R8  - RF  */
-	0x00, 0x00, 0x00, 0x00, 0x08, 0x10, 0x10, 0x54,	/* R10 - R17 */
-	0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R18 - R1F */
-	0x00, 0x00, 0x00, 0x02, 0x00, 0x76, 0x00, 0x00,	/* R20 - R27 */
-	0x04, 0x00, 0x00, 0x30, 0x2A, 0x00, 0x40, 0x00,	/* R28 - R2F */
-	0x40, 0x00, 0x40, 0x00, 0x40, 0x00, 0x40, 0x00,	/* R30 - R37 */
-	0x40, 0x00, 0x40, 0x00, 0x40, 0x00, 0x00, 0x00,	/* R38 - R3F */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R40 - R4F */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R48 - R4F */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R50 - R57 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R58 - R5F */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R60 - R67 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R68 - R6F */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R70 - R77 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x54, 0x00,	/* R78 - R7F */
-	0x00, 0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00,	/* R80 - R87 */
-	0x00,						/* R88       */
+static struct reg_default da7210_reg_defaults[] = {
+	{ 0x00, 0x00 },
+	{ 0x01, 0x11 },
+	{ 0x02, 0x00 },
+	{ 0x03, 0x00 },
+	{ 0x04, 0x00 },
+	{ 0x05, 0x00 },
+	{ 0x06, 0x00 },
+	{ 0x07, 0x00 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x00 },
+	{ 0x0a, 0x00 },
+	{ 0x0b, 0x00 },
+	{ 0x0c, 0x00 },
+	{ 0x0d, 0x00 },
+	{ 0x0e, 0x00 },
+	{ 0x0f, 0x08 },
+	{ 0x10, 0x00 },
+	{ 0x11, 0x00 },
+	{ 0x12, 0x00 },
+	{ 0x13, 0x00 },
+	{ 0x14, 0x08 },
+	{ 0x15, 0x10 },
+	{ 0x16, 0x10 },
+	{ 0x17, 0x54 },
+	{ 0x18, 0x40 },
+	{ 0x19, 0x00 },
+	{ 0x1a, 0x00 },
+	{ 0x1b, 0x00 },
+	{ 0x1c, 0x00 },
+	{ 0x1d, 0x00 },
+	{ 0x1e, 0x00 },
+	{ 0x1f, 0x00 },
+	{ 0x20, 0x00 },
+	{ 0x21, 0x00 },
+	{ 0x22, 0x00 },
+	{ 0x23, 0x02 },
+	{ 0x24, 0x00 },
+	{ 0x25, 0x76 },
+	{ 0x26, 0x00 },
+	{ 0x27, 0x00 },
+	{ 0x28, 0x04 },
+	{ 0x29, 0x00 },
+	{ 0x2a, 0x00 },
+	{ 0x2b, 0x30 },
+	{ 0x2c, 0x2A },
+	{ 0x2d, 0x00 },
+	{ 0x2e, 0x40 },
+	{ 0x2f, 0x00 },
+	{ 0x30, 0x40 },
+	{ 0x31, 0x00 },
+	{ 0x32, 0x40 },
+	{ 0x33, 0x00 },
+	{ 0x34, 0x40 },
+	{ 0x35, 0x00 },
+	{ 0x36, 0x40 },
+	{ 0x37, 0x00 },
+	{ 0x38, 0x40 },
+	{ 0x39, 0x00 },
+	{ 0x3a, 0x40 },
+	{ 0x3b, 0x00 },
+	{ 0x3c, 0x40 },
+	{ 0x3d, 0x00 },
+	{ 0x3e, 0x00 },
+	{ 0x3f, 0x00 },
+	{ 0x40, 0x00 },
+	{ 0x41, 0x00 },
+	{ 0x42, 0x00 },
+	{ 0x43, 0x00 },
+	{ 0x44, 0x00 },
+	{ 0x45, 0x00 },
+	{ 0x46, 0x00 },
+	{ 0x47, 0x00 },
+	{ 0x48, 0x00 },
+	{ 0x49, 0x00 },
+	{ 0x4a, 0x00 },
+	{ 0x4b, 0x00 },
+	{ 0x4c, 0x00 },
+	{ 0x4d, 0x00 },
+	{ 0x4e, 0x00 },
+	{ 0x4f, 0x00 },
+	{ 0x50, 0x00 },
+	{ 0x51, 0x00 },
+	{ 0x52, 0x00 },
+	{ 0x53, 0x00 },
+	{ 0x54, 0x00 },
+	{ 0x55, 0x00 },
+	{ 0x56, 0x00 },
+	{ 0x57, 0x00 },
+	{ 0x58, 0x00 },
+	{ 0x59, 0x00 },
+	{ 0x5a, 0x00 },
+	{ 0x5b, 0x00 },
+	{ 0x5c, 0x00 },
+	{ 0x5d, 0x00 },
+	{ 0x5e, 0x00 },
+	{ 0x5f, 0x00 },
+	{ 0x60, 0x00 },
+	{ 0x61, 0x00 },
+	{ 0x62, 0x00 },
+	{ 0x63, 0x00 },
+	{ 0x64, 0x00 },
+	{ 0x65, 0x00 },
+	{ 0x66, 0x00 },
+	{ 0x67, 0x00 },
+	{ 0x68, 0x00 },
+	{ 0x69, 0x00 },
+	{ 0x6a, 0x00 },
+	{ 0x6b, 0x00 },
+	{ 0x6c, 0x00 },
+	{ 0x6d, 0x00 },
+	{ 0x6e, 0x00 },
+	{ 0x6f, 0x00 },
+	{ 0x70, 0x00 },
+	{ 0x71, 0x00 },
+	{ 0x72, 0x00 },
+	{ 0x73, 0x00 },
+	{ 0x74, 0x00 },
+	{ 0x75, 0x00 },
+	{ 0x76, 0x00 },
+	{ 0x77, 0x00 },
+	{ 0x78, 0x00 },
+	{ 0x79, 0x00 },
+	{ 0x7a, 0x00 },
+	{ 0x7b, 0x00 },
+	{ 0x7c, 0x00 },
+	{ 0x7d, 0x54 },
+	{ 0x7e, 0x54 },
+	{ 0x7f, 0x00 },
+	{ 0x80, 0x00 },
+	{ 0x81, 0x00 },
+	{ 0x82, 0x2c },
+	{ 0x83, 0x00 },
+	{ 0x84, 0x00 },
+	{ 0x85, 0x00 },
+	{ 0x86, 0x00 },
+	{ 0x87, 0x00 },
+	{ 0x88, 0x00 },
 };
 
-static int da7210_volatile_register(struct snd_soc_codec *codec,
+static bool da7210_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case DA7210_A_HID_UNLOCK:
+	case DA7210_A_TEST_UNLOCK:
+	case DA7210_A_PLL1:
+	case DA7210_A_CP_MODE:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool da7210_volatile_register(struct device *dev,
 				    unsigned int reg)
 {
 	switch (reg) {
 	case DA7210_STATUS:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -866,7 +996,8 @@ static int da7210_probe(struct snd_soc_codec *codec)
 
 	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, da7210->control_type);
+	codec->control_data = da7210->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -983,12 +1114,14 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
 
 	/* As suggested by Dialog */
-	snd_soc_write(codec, DA7210_A_HID_UNLOCK,	0x8B); /* unlock */
-	snd_soc_write(codec, DA7210_A_TEST_UNLOCK,	0xB4);
-	snd_soc_write(codec, DA7210_A_PLL1,		0x01);
-	snd_soc_write(codec, DA7210_A_CP_MODE,		0x7C);
-	snd_soc_write(codec, DA7210_A_HID_UNLOCK,	0x00); /* re-lock */
-	snd_soc_write(codec, DA7210_A_TEST_UNLOCK,	0x00);
+	/* unlock */
+	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x8B);
+	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0xB4);
+	regmap_write(da7210->regmap, DA7210_A_PLL1,		0x01);
+	regmap_write(da7210->regmap, DA7210_A_CP_MODE,		0x7C);
+	/* re-lock */
+	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x00);
+	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0x00);
 
 	/* Activate all enabled subsystem */
 	snd_soc_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
@@ -1000,10 +1133,6 @@ static int da7210_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.probe			= da7210_probe,
-	.reg_cache_size		= ARRAY_SIZE(da7210_reg),
-	.reg_word_size		= sizeof(u8),
-	.reg_cache_default	= da7210_reg,
-	.volatile_register	= da7210_volatile_register,
 
 	.controls		= da7210_snd_controls,
 	.num_controls		= ARRAY_SIZE(da7210_snd_controls),
@@ -1014,6 +1143,17 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
 };
 
+static struct regmap_config da7210_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.reg_defaults = da7210_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(da7210_reg_defaults),
+	.volatile_reg = da7210_volatile_register,
+	.readable_reg = da7210_readable_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 			   	      const struct i2c_device_id *id)
@@ -1027,16 +1167,34 @@ static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, da7210);
-	da7210->control_type = SND_SOC_I2C;
+
+	da7210->regmap = regmap_init_i2c(i2c, &da7210_regmap);
+	if (IS_ERR(da7210->regmap)) {
+		ret = PTR_ERR(da7210->regmap);
+		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
+		return ret;
+	}
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_da7210, &da7210_dai, 1);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		goto err_regmap;
+	}
+	return ret;
+
+err_regmap:
+	regmap_exit(da7210->regmap);
+
 	return ret;
 }
 
 static int __devexit da7210_i2c_remove(struct i2c_client *client)
 {
+	struct da7210_priv *da7210 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+	regmap_exit(da7210->regmap);
 	return 0;
 }
 
-- 
1.7.1
