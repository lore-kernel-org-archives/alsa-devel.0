From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8960: Convert to direct regmap API
	usage
Date: Mon, 10 Sep 2012 19:26:38 +0800
Message-ID: <1347276398-28337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 625972650A4
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 13:36:39 +0200 (CEST)
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
 sound/soc/codecs/wm8960.c |  107 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 804f411..7cb0d07c 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -52,25 +52,72 @@
  * We can't read the WM8960 register space when we are
  * using 2 wire for device control, so we cache them instead.
  */
-static const u16 wm8960_reg[WM8960_CACHEREGNUM] = {
-	0x0097, 0x0097, 0x0000, 0x0000,
-	0x0000, 0x0008, 0x0000, 0x000a,
-	0x01c0, 0x0000, 0x00ff, 0x00ff,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x007b, 0x0100, 0x0032,
-	0x0000, 0x00c3, 0x00c3, 0x01c0,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0100, 0x0100, 0x0050, 0x0050,
-	0x0050, 0x0050, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0040, 0x0000,
-	0x0000, 0x0050, 0x0050, 0x0000,
-	0x0002, 0x0037, 0x004d, 0x0080,
-	0x0008, 0x0031, 0x0026, 0x00e9,
+static const struct reg_default wm8960_reg_defaults[] = {
+	{  0x0, 0x0097 },
+	{  0x1, 0x0097 },
+	{  0x2, 0x0000 },
+	{  0x3, 0x0000 },
+	{  0x4, 0x0000 },
+	{  0x5, 0x0008 },
+	{  0x6, 0x0000 },
+	{  0x7, 0x000a },
+	{  0x8, 0x01c0 },
+	{  0x9, 0x0000 },
+	{  0xa, 0x00ff },
+	{  0xb, 0x00ff },
+
+	{ 0x10, 0x0000 },
+	{ 0x11, 0x007b },
+	{ 0x12, 0x0100 },
+	{ 0x13, 0x0032 },
+	{ 0x14, 0x0000 },
+	{ 0x15, 0x00c3 },
+	{ 0x16, 0x00c3 },
+	{ 0x17, 0x01c0 },
+	{ 0x18, 0x0000 },
+	{ 0x19, 0x0000 },
+	{ 0x1a, 0x0000 },
+	{ 0x1b, 0x0000 },
+	{ 0x1c, 0x0000 },
+	{ 0x1d, 0x0000 },
+
+	{ 0x20, 0x0100 },
+	{ 0x21, 0x0100 },
+	{ 0x22, 0x0050 },
+
+	{ 0x25, 0x0050 },
+	{ 0x26, 0x0000 },
+	{ 0x27, 0x0000 },
+	{ 0x28, 0x0000 },
+	{ 0x29, 0x0000 },
+	{ 0x2a, 0x0040 },
+	{ 0x2b, 0x0000 },
+	{ 0x2c, 0x0000 },
+	{ 0x2d, 0x0050 },
+	{ 0x2e, 0x0050 },
+	{ 0x2f, 0x0000 },
+	{ 0x30, 0x0002 },
+	{ 0x31, 0x0037 },
+
+	{ 0x33, 0x0080 },
+	{ 0x34, 0x0008 },
+	{ 0x35, 0x0031 },
+	{ 0x36, 0x0026 },
+	{ 0x37, 0x00e9 },
 };
 
+static bool wm8960_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8960_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct wm8960_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int (*set_bias_level)(struct snd_soc_codec *,
 			      enum snd_soc_bias_level level);
 	struct snd_soc_dapm_widget *lout1;
@@ -555,6 +602,8 @@ static int wm8960_mute(struct snd_soc_dai *dai, int mute)
 static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      enum snd_soc_bias_level level)
 {
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -566,7 +615,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8960->regmap);
 
 			/* Enable anti-pop features */
 			snd_soc_write(codec, WM8960_APOP1,
@@ -667,7 +716,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 			break;
 
 		case SND_SOC_BIAS_OFF:
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8960->regmap);
 			break;
 		default:
 			break;
@@ -915,7 +964,7 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 			wm8960->set_bias_level = wm8960_set_bias_level_capless;
 	}
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8960->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -963,9 +1012,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8960 = {
 	.suspend =	wm8960_suspend,
 	.resume =	wm8960_resume,
 	.set_bias_level = wm8960_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8960_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8960_reg,
+};
+
+static const struct regmap_config wm8960_regmap = {
+	.reg_bits = 7,
+	.val_bits = 9,
+	.max_register = WM8960_PLL4,
+
+	.reg_defaults = wm8960_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8960_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8960_volatile,
 };
 
 static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
@@ -979,8 +1037,11 @@ static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
+	wm8960->regmap = regmap_init_i2c(i2c, &wm8960_regmap);
+	if (IS_ERR(wm8960->regmap))
+		return PTR_ERR(wm8960->regmap);
+
 	i2c_set_clientdata(i2c, wm8960);
-	wm8960->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8960, &wm8960_dai, 1);
-- 
1.7.10.4
