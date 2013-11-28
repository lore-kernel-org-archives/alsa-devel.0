From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: ak4642: Convert to direct regmap API
	usage
Date: Thu, 28 Nov 2013 18:04:48 +0000
Message-ID: <1385661888-11924-3-git-send-email-broonie@kernel.org>
References: <1385661888-11924-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A63EE2652E4
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 19:04:56 +0100 (CET)
In-Reply-To: <1385661888-11924-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This moves us towards being able to remove the ASoC level I/O code which
duplicates regmap functionality. Currently the only difference between
the supported devices in the driver is the regmap so we can replace the
CODEC driver selections with regmap selection instead.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4642.c | 113 ++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index d16c4ac5b27d..1f646c6e90c6 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -198,30 +199,30 @@ static const struct snd_soc_dapm_route ak4642_intercon[] = {
 /*
  * ak4642 register cache
  */
-static const u8 ak4642_reg[] = {
-	0x00, 0x00, 0x01, 0x00,
-	0x02, 0x00, 0x00, 0x00,
-	0xe1, 0xe1, 0x18, 0x00,
-	0xe1, 0x18, 0x11, 0x08,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00,
+static const struct reg_default ak4642_reg[] = {
+	{  0, 0x00 }, {  1, 0x00 }, {  2, 0x01 }, {  3, 0x00 },
+	{  4, 0x02 }, {  5, 0x00 }, {  6, 0x00 }, {  7, 0x00 },
+	{  8, 0xe1 }, {  9, 0xe1 }, { 10, 0x18 }, { 11, 0x00 },
+	{ 12, 0xe1 }, { 13, 0x18 }, { 14, 0x11 }, { 15, 0x08 },
+	{ 16, 0x00 }, { 17, 0x00 }, { 18, 0x00 }, { 19, 0x00 },
+	{ 20, 0x00 }, { 21, 0x00 }, { 22, 0x00 }, { 23, 0x00 },
+	{ 24, 0x00 }, { 25, 0x00 }, { 26, 0x00 }, { 27, 0x00 },
+	{ 28, 0x00 }, { 29, 0x00 }, { 30, 0x00 }, { 31, 0x00 },
+	{ 32, 0x00 }, { 33, 0x00 }, { 34, 0x00 }, { 35, 0x00 },
+	{ 36, 0x00 },
 };
 
-static const u8 ak4648_reg[] = {
-	0x00, 0x00, 0x01, 0x00,
-	0x02, 0x00, 0x00, 0x00,
-	0xe1, 0xe1, 0x18, 0x00,
-	0xe1, 0x18, 0x11, 0xb8,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x00, 0x88, 0x88, 0x08,
+static const struct reg_default ak4648_reg[] = {
+	{  0, 0x00 }, {  1, 0x00 }, {  2, 0x01 }, {  3, 0x00 },
+	{  4, 0x02 }, {  5, 0x00 }, {  6, 0x00 }, {  7, 0x00 },
+	{  8, 0xe1 }, {  9, 0xe1 }, { 10, 0x18 }, { 11, 0x00 },
+	{ 12, 0xe1 }, { 13, 0x18 }, { 14, 0x11 }, { 15, 0xb8 },
+	{ 16, 0x00 }, { 17, 0x00 }, { 18, 0x00 }, { 19, 0x00 },
+	{ 20, 0x00 }, { 21, 0x00 }, { 22, 0x00 }, { 23, 0x00 },
+	{ 24, 0x00 }, { 25, 0x00 }, { 26, 0x00 }, { 27, 0x00 },
+	{ 28, 0x00 }, { 29, 0x00 }, { 30, 0x00 }, { 31, 0x00 },
+	{ 32, 0x00 }, { 33, 0x00 }, { 34, 0x00 }, { 35, 0x00 },
+	{ 36, 0x00 }, { 37, 0x88 }, { 38, 0x88 }, { 39, 0x08 },
 };
 
 static int ak4642_dai_startup(struct snd_pcm_substream *substream,
@@ -454,7 +455,10 @@ static struct snd_soc_dai_driver ak4642_dai = {
 
 static int ak4642_resume(struct snd_soc_codec *codec)
 {
-	snd_soc_cache_sync(codec);
+	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+
+	regcache_mark_dirty(regmap);
+	regcache_sync(regmap);
 	return 0;
 }
 
@@ -463,7 +467,7 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -485,9 +489,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.remove			= ak4642_remove,
 	.resume			= ak4642_resume,
 	.set_bias_level		= ak4642_set_bias_level,
-	.reg_cache_default	= ak4642_reg,			/* ak4642 reg */
-	.reg_cache_size		= ARRAY_SIZE(ak4642_reg),	/* ak4642 reg */
-	.reg_word_size		= sizeof(u8),
 	.controls		= ak4642_snd_controls,
 	.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
 	.dapm_widgets		= ak4642_dapm_widgets,
@@ -496,20 +497,20 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_ak4648 = {
-	.probe			= ak4642_probe,
-	.remove			= ak4642_remove,
-	.resume			= ak4642_resume,
-	.set_bias_level		= ak4642_set_bias_level,
-	.reg_cache_default	= ak4648_reg,			/* ak4648 reg */
-	.reg_cache_size		= ARRAY_SIZE(ak4648_reg),	/* ak4648 reg */
-	.reg_word_size		= sizeof(u8),
-	.controls		= ak4642_snd_controls,
-	.num_controls		= ARRAY_SIZE(ak4642_snd_controls),
-	.dapm_widgets		= ak4642_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(ak4642_dapm_widgets),
-	.dapm_routes		= ak4642_intercon,
-	.num_dapm_routes	= ARRAY_SIZE(ak4642_intercon),
+static const struct regmap_config ak4642_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= ARRAY_SIZE(ak4642_reg) + 1,
+	.reg_defaults		= ak4642_reg,
+	.num_reg_defaults	= ARRAY_SIZE(ak4642_reg),
+};
+
+static const struct regmap_config ak4648_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= ARRAY_SIZE(ak4648_reg) + 1,
+	.reg_defaults		= ak4648_reg,
+	.num_reg_defaults	= ARRAY_SIZE(ak4648_reg),
 };
 
 static struct of_device_id ak4642_of_match[];
@@ -517,26 +518,30 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct device_node *np = i2c->dev.of_node;
-	const struct snd_soc_codec_driver *driver;
+	const struct regmap_config *regmap_config = NULL;
+	struct regmap *regmap;
 
-	driver = NULL;
 	if (np) {
 		const struct of_device_id *of_id;
 
 		of_id = of_match_device(ak4642_of_match, &i2c->dev);
 		if (of_id)
-			driver = of_id->data;
+			regmap_config = of_id->data;
 	} else {
-		driver = (struct snd_soc_codec_driver *)id->driver_data;
+		regmap_config = (const struct regmap_config *)id->driver_data;
 	}
 
-	if (!driver) {
-		dev_err(&i2c->dev, "no driver\n");
+	if (!regmap_config) {
+		dev_err(&i2c->dev, "Unknown device type\n");
 		return -EINVAL;
 	}
 
+	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	return snd_soc_register_codec(&i2c->dev,
-				      driver, &ak4642_dai, 1);
+				      &soc_codec_dev_ak4642, &ak4642_dai, 1);
 }
 
 static int ak4642_i2c_remove(struct i2c_client *client)
@@ -546,17 +551,17 @@ static int ak4642_i2c_remove(struct i2c_client *client)
 }
 
 static struct of_device_id ak4642_of_match[] = {
-	{ .compatible = "asahi-kasei,ak4642",	.data = &soc_codec_dev_ak4642},
-	{ .compatible = "asahi-kasei,ak4643",	.data = &soc_codec_dev_ak4642},
-	{ .compatible = "asahi-kasei,ak4648",	.data = &soc_codec_dev_ak4648},
+	{ .compatible = "asahi-kasei,ak4642",	.data = &ak4642_regmap},
+	{ .compatible = "asahi-kasei,ak4643",	.data = &ak4642_regmap},
+	{ .compatible = "asahi-kasei,ak4648",	.data = &ak4648_regmap},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ak4642_of_match);
 
 static const struct i2c_device_id ak4642_i2c_id[] = {
-	{ "ak4642", (kernel_ulong_t)&soc_codec_dev_ak4642 },
-	{ "ak4643", (kernel_ulong_t)&soc_codec_dev_ak4642 },
-	{ "ak4648", (kernel_ulong_t)&soc_codec_dev_ak4648 },
+	{ "ak4642", (kernel_ulong_t)&ak4642_regmap },
+	{ "ak4643", (kernel_ulong_t)&ak4642_regmap },
+	{ "ak4648", (kernel_ulong_t)&ak4648_regmap },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
-- 
1.8.4.4
