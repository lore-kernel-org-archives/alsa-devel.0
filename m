From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8971: Convert to direct regmap API
	usage
Date: Wed, 10 Oct 2012 21:44:15 +0900
Message-ID: <1349873055-384-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32046261742
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8971.c |   80 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 5ce6477..70dd27e 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -34,7 +35,6 @@ static struct workqueue_struct *wm8971_workq = NULL;
 
 /* codec private data */
 struct wm8971_priv {
-	enum snd_soc_control_type control_type;
 	unsigned int sysclk;
 };
 
@@ -43,18 +43,50 @@ struct wm8971_priv {
  * We can't read the WM8971 register space when we
  * are using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8971_reg[] = {
-	0x0097, 0x0097, 0x0079, 0x0079,  /*  0 */
-	0x0000, 0x0008, 0x0000, 0x000a,  /*  4 */
-	0x0000, 0x0000, 0x00ff, 0x00ff,  /*  8 */
-	0x000f, 0x000f, 0x0000, 0x0000,  /* 12 */
-	0x0000, 0x007b, 0x0000, 0x0032,  /* 16 */
-	0x0000, 0x00c3, 0x00c3, 0x00c0,  /* 20 */
-	0x0000, 0x0000, 0x0000, 0x0000,  /* 24 */
-	0x0000, 0x0000, 0x0000, 0x0000,  /* 28 */
-	0x0000, 0x0000, 0x0050, 0x0050,  /* 32 */
-	0x0050, 0x0050, 0x0050, 0x0050,  /* 36 */
-	0x0079, 0x0079, 0x0079,          /* 40 */
+static const struct reg_default wm8971_reg_defaults[] = {
+	{  0, 0x0097 },
+	{  1, 0x0097 },
+	{  2, 0x0079 },
+	{  3, 0x0079 },
+	{  4, 0x0000 },
+	{  5, 0x0008 },
+	{  6, 0x0000 },
+	{  7, 0x000a },
+	{  8, 0x0000 },
+	{  9, 0x0000 },
+	{ 10, 0x00ff },
+	{ 11, 0x00ff },
+	{ 12, 0x000f },
+	{ 13, 0x000f },
+	{ 14, 0x0000 },
+	{ 15, 0x0000 },
+	{ 16, 0x0000 },
+	{ 17, 0x007b },
+	{ 18, 0x0000 },
+	{ 19, 0x0032 },
+	{ 20, 0x0000 },
+	{ 21, 0x00c3 },
+	{ 22, 0x00c3 },
+	{ 23, 0x00c0 },
+	{ 24, 0x0000 },
+	{ 25, 0x0000 },
+	{ 26, 0x0000 },
+	{ 27, 0x0000 },
+	{ 28, 0x0000 },
+	{ 29, 0x0000 },
+	{ 30, 0x0000 },
+	{ 31, 0x0000 },
+	{ 32, 0x0000 },
+	{ 33, 0x0000 },
+	{ 34, 0x0050 },
+	{ 35, 0x0050 },
+	{ 36, 0x0050 },
+	{ 37, 0x0050 },
+	{ 38, 0x0050 },
+	{ 39, 0x0050 },
+	{ 40, 0x0079 },
+	{ 41, 0x0079 },
+	{ 42, 0x0079 },
 };
 
 #define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
@@ -613,11 +645,10 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
-	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 	u16 reg;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8971->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -667,9 +698,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.suspend =	wm8971_suspend,
 	.resume =	wm8971_resume,
 	.set_bias_level = wm8971_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8971_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8971_reg,
 
 	.controls = wm8971_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8971_snd_controls),
@@ -679,10 +707,21 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8971_dapm_routes),
 };
 
+static const struct regmap_config wm8971_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8971_MOUTV,
+
+	.reg_defaults = wm8971_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8971_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static __devinit int wm8971_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
+	struct regmap *regmap;
 	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
@@ -690,7 +729,10 @@ static __devinit int wm8971_i2c_probe(struct i2c_client *i2c,
 	if (wm8971 == NULL)
 		return -ENOMEM;
 
-	wm8971->control_type = SND_SOC_I2C;
+	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	i2c_set_clientdata(i2c, wm8971);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
