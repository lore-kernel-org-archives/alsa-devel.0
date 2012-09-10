From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: cs4270: Convert to direct regmap API
	usage
Date: Mon, 10 Sep 2012 12:58:45 +0800
Message-ID: <1347253125-8250-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347253125-8250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC200264F23
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 07:01:17 +0200 (CEST)
In-Reply-To: <1347253125-8250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |   54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 64c29b8..f276ab8 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -112,14 +112,15 @@
  * This array contains the power-on default values of the registers, with the
  * exception of the "CHIPID" register (01h).  The lower four bits of that
  * register contain the hardware revision, so it is treated as volatile.
- *
- * Also note that on the CS4270, the first readable register is 1, but ASoC
- * assumes the first register is 0.  Therfore, the array must have an entry for
- * register 0, but we use cs4270_reg_is_readable() to tell ASoC that it can't
- * be read.
  */
-static const u8 cs4270_default_reg_cache[CS4270_LASTREG + 1] = {
-	0x00, 0x00, 0x00, 0x30, 0x00, 0x60, 0x20, 0x00, 0x00
+static const struct reg_default cs4270_reg_defaults[] = {
+	{ 2, 0x00 },
+	{ 3, 0x30 },
+	{ 4, 0x00 },
+	{ 5, 0x60 },
+	{ 6, 0x20 },
+	{ 7, 0x00 },
+	{ 8, 0x00 },
 };
 
 static const char *supply_names[] = {
@@ -128,7 +129,7 @@ static const char *supply_names[] = {
 
 /* Private data for the CS4270 */
 struct cs4270_private {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
@@ -193,12 +194,12 @@ static struct cs4270_mode_ratios cs4270_mode_ratios[] = {
 /* The number of MCLK/LRCK ratios supported by the CS4270 */
 #define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
-static int cs4270_reg_is_readable(struct snd_soc_codec *codec, unsigned int reg)
+static bool cs4270_reg_is_readable(struct device *dev, unsigned int reg)
 {
 	return (reg >= CS4270_FIRSTREG) && (reg <= CS4270_LASTREG);
 }
 
-static int cs4270_reg_is_volatile(struct snd_soc_codec *codec, unsigned int reg)
+static bool cs4270_reg_is_volatile(struct device *dev, unsigned int reg)
 {
 	/* Unreadable registers are considered volatile */
 	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
@@ -492,7 +493,7 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	/* Tell ASoC what kind of I/O to use to read the registers.  ASoC will
 	 * then do the I2C transactions itself.
 	 */
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs4270->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to set cache I/O (ret=%i)\n", ret);
 		return ret;
@@ -587,7 +588,7 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
 	ndelay(500);
 
 	/* first restore the entire register cache ... */
-	snd_soc_cache_sync(codec);
+	regcache_sync(cs4270->regmap);
 
 	/* ... then disable the power-down bits */
 	reg = snd_soc_read(codec, CS4270_PWRCTL);
@@ -611,11 +612,6 @@ static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
 
 	.controls =		cs4270_snd_controls,
 	.num_controls =		ARRAY_SIZE(cs4270_snd_controls),
-	.volatile_register =	cs4270_reg_is_volatile,
-	.readable_register =	cs4270_reg_is_readable,
-	.reg_cache_size =	CS4270_LASTREG + 1,
-	.reg_word_size =	sizeof(u8),
-	.reg_cache_default =	cs4270_default_reg_cache,
 };
 
 /*
@@ -627,6 +623,17 @@ static const struct of_device_id cs4270_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, cs4270_of_match);
 
+static const struct regmap_config cs4270_regmap = {
+	.reg_bits =		8,
+	.val_bits =		8,
+	.max_register =		CS4270_LASTREG,
+	.reg_defaults =		cs4270_reg_defaults,
+	.num_reg_defaults =	ARRAY_SIZE(cs4270_reg_defaults),
+
+	.readable_reg =		cs4270_reg_is_readable,
+	.volatile_reg =		cs4270_reg_is_volatile,
+};
+
 /**
  * cs4270_i2c_probe - initialize the I2C interface of the CS4270
  * @i2c_client: the I2C client object
@@ -640,6 +647,7 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 {
 	struct device_node *np = i2c_client->dev.of_node;
 	struct cs4270_private *cs4270;
+	unsigned int val;
 	int ret, i;
 
 	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
@@ -674,16 +682,19 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		}
 	}
 
-	/* Verify that we have a CS4270 */
+	cs4270->regmap = devm_regmap_init_i2c(i2c_client, &cs4270_regmap);
+	if (IS_ERR(cs4270->regmap))
+		return PTR_ERR(cs4270->regmap);
 
-	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
+	/* Verify that we have a CS4270 */
+	ret = regmap_read(cs4270->regmap, CS4270_CHIPID, &val);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "failed to read i2c at addr %X\n",
 		       i2c_client->addr);
 		return ret;
 	}
 	/* The top four bits of the chip ID should be 1100. */
-	if ((ret & 0xF0) != 0xC0) {
+	if ((val & 0xF0) != 0xC0) {
 		dev_err(&i2c_client->dev, "device at addr %X is not a CS4270\n",
 		       i2c_client->addr);
 		return -ENODEV;
@@ -691,10 +702,9 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 	dev_info(&i2c_client->dev, "found device at i2c address %X\n",
 		i2c_client->addr);
-	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
+	dev_info(&i2c_client->dev, "hardware revision %X\n", val & 0xF);
 
 	i2c_set_clientdata(i2c_client, cs4270);
-	cs4270->control_type = SND_SOC_I2C;
 
 	ret = snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_device_cs4270, &cs4270_dai, 1);
-- 
1.7.10.4
