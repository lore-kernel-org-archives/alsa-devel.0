From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Use specific r/w function for
	DSP mode
Date: Mon, 27 Oct 2014 10:52:31 +0800
Message-ID: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EA622606D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 03:53:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In DSP mode, the register r/w should use the specific function to access
that is invoked by address mapping of the DSP.

The MX-65[1] is for switching DSP or codec mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 222 ++++++++++++++++++++++++++++++----------------
 sound/soc/codecs/rt5677.h |   2 +
 2 files changed, 149 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 413bccb..74f65ff 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -539,53 +539,113 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static int rt5677_hw_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *client = context;
+	struct i2c_msg xfer[2];
+	u8 r[1];
+	u8 data[2];
+	int ret;
+
+	/* Write register */
+	r[0] = reg & 0xff;
+	xfer[0].addr = client->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = &r[0];
+
+	/* Read data */
+	xfer[1].addr = client->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 2;
+	xfer[1].buf = data;
+
+	ret = i2c_transfer(client->adapter, xfer, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
+		return -EIO;
+	}
+
+	*val = (data[0] << 8) | data[1];
+
+	dev_dbg(&client->dev, "read %02x => %04x\n", reg, *val);
+
+	return 0;
+}
+
+static int rt5677_hw_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *client = context;
+	u8 data[3];
+	int ret;
+
+	data[0] = reg & 0xff;
+	data[1] = (0xff00 & val) >> 8;
+	data[2] = val & 0xff;
+
+	dev_dbg(&client->dev, "write %02x = %04x\n", reg, val);
+
+	ret = i2c_master_send(client, data, 3);
+	if (ret == 3)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 /**
  * rt5677_dsp_mode_i2c_write_addr - Write value to address on DSP mode.
- * @codec: SoC audio codec device.
+ * @rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
  *
  *
  * Returns 0 for success or negative error code.
  */
-static int rt5677_dsp_mode_i2c_write_addr(struct snd_soc_codec *codec,
+static int rt5677_dsp_mode_i2c_write_addr(struct rt5677_priv *rt5677,
 		unsigned int addr, unsigned int value, unsigned int opcode)
 {
-	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *client = rt5677->i2c;
 	int ret;
 
 	mutex_lock(&rt5677->dsp_cmd_lock);
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set addr msb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set addr msb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_LSB,
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_ADDR_LSB,
 		addr & 0xffff);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set addr lsb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set addr lsb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_DATA_MSB,
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_DATA_MSB,
 		value >> 16);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set data msb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set data msb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_DATA_LSB,
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_DATA_LSB,
 		value & 0xffff);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set data lsb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set data lsb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_OP_CODE, opcode);
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_OP_CODE, opcode);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set op code value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set op code value: %d\n",
+			ret);
 		goto err;
 	}
 
@@ -597,42 +657,45 @@ err:
 
 /**
  * rt5677_dsp_mode_i2c_read_addr - Read value from address on DSP mode.
- * @codec: SoC audio codec device.
+ * rt5677: Private Data.
  * @addr: Address index.
  * @value: Address data.
  *
+ *
  * Returns 0 for success or negative error code.
  */
 static int rt5677_dsp_mode_i2c_read_addr(
-	struct snd_soc_codec *codec, unsigned int addr, unsigned int *value)
+	struct rt5677_priv *rt5677, unsigned int addr, unsigned int *value)
 {
-	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *client = rt5677->i2c;
 	int ret;
 	unsigned int msb, lsb;
 
 	mutex_lock(&rt5677->dsp_cmd_lock);
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_ADDR_MSB, addr >> 16);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set addr msb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set addr msb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_ADDR_LSB,
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_ADDR_LSB,
 		addr & 0xffff);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set addr lsb value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set addr lsb value: %d\n",
+			ret);
 		goto err;
 	}
 
-	ret = regmap_write(rt5677->regmap, RT5677_DSP_I2C_OP_CODE , 0x0002);
+	ret = rt5677_hw_write(client, RT5677_DSP_I2C_OP_CODE , 0x0002);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set op code value: %d\n", ret);
+		dev_err(&client->dev, "Failed to set op code value: %d\n", ret);
 		goto err;
 	}
 
-	regmap_read(rt5677->regmap, RT5677_DSP_I2C_DATA_MSB, &msb);
-	regmap_read(rt5677->regmap, RT5677_DSP_I2C_DATA_LSB, &lsb);
+	rt5677_hw_read(client, RT5677_DSP_I2C_DATA_MSB, &msb);
+	rt5677_hw_read(client, RT5677_DSP_I2C_DATA_LSB, &lsb);
 	*value = (msb << 16) | lsb;
 
 err:
@@ -643,17 +706,17 @@ err:
 
 /**
  * rt5677_dsp_mode_i2c_write - Write register on DSP mode.
- * @codec: SoC audio codec device.
+ * rt5677: Private Data.
  * @reg: Register index.
  * @value: Register data.
  *
  *
  * Returns 0 for success or negative error code.
  */
-static int rt5677_dsp_mode_i2c_write(struct snd_soc_codec *codec,
+static int rt5677_dsp_mode_i2c_write(struct rt5677_priv *rt5677,
 		unsigned int reg, unsigned int value)
 {
-	return rt5677_dsp_mode_i2c_write_addr(codec, 0x18020000 + reg * 2,
+	return rt5677_dsp_mode_i2c_write_addr(rt5677, 0x18020000 + reg * 2,
 		value, 0x0001);
 }
 
@@ -661,57 +724,33 @@ static int rt5677_dsp_mode_i2c_write(struct snd_soc_codec *codec,
  * rt5677_dsp_mode_i2c_read - Read register on DSP mode.
  * @codec: SoC audio codec device.
  * @reg: Register index.
+ * @value: Register data.
  *
  *
- * Returns Register value.
+ * Returns 0 for success or negative error code.
  */
-static unsigned int rt5677_dsp_mode_i2c_read(
-	struct snd_soc_codec *codec, unsigned int reg)
+static int rt5677_dsp_mode_i2c_read(
+	struct rt5677_priv *rt5677, unsigned int reg, unsigned int *value)
 {
-	unsigned int value = 0;
+	int ret = rt5677_dsp_mode_i2c_read_addr(rt5677, 0x18020000 + reg * 2,
+		value);
 
-	rt5677_dsp_mode_i2c_read_addr(codec, 0x18020000 + reg * 2, &value);
+	*value &= 0xffff;
 
-	return value;
+	return ret;
 }
 
-/**
- * rt5677_dsp_mode_i2c_update_bits - update register on DSP mode.
- * @codec: audio codec
- * @reg: register index.
- * @mask: register mask
- * @value: new value
- *
- *
- * Returns 1 for change, 0 for no change, or negative error code.
- */
-static int rt5677_dsp_mode_i2c_update_bits(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int mask, unsigned int value)
+static void rt5677_set_dsp_mode(struct snd_soc_codec *codec, bool on)
 {
-	unsigned int old, new;
-	int change, ret;
-
-	ret = rt5677_dsp_mode_i2c_read(codec, reg);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to read reg: %d\n", ret);
-		goto err;
-	}
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
-	old = ret;
-	new = (old & ~mask) | (value & mask);
-	change = old != new;
-	if (change) {
-		ret = rt5677_dsp_mode_i2c_write(codec, reg, new);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"Failed to write reg: %d\n", ret);
-			goto err;
-		}
+	if (on) {
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_DSP1, 0x2, 0x2);
+		rt5677->is_dsp_mode = true;
+	} else {
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_DSP1, 0x2, 0x0);
+		rt5677->is_dsp_mode = false;
 	}
-	return change;
-
-err:
-	return ret;
 }
 
 static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
@@ -733,9 +772,14 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 			RT5677_LDO1_SEL_MASK, 0x0);
 		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
 			RT5677_PWR_LDO1, RT5677_PWR_LDO1);
-		regmap_write(rt5677->regmap, RT5677_GLB_CLK2, 0x0080);
+		regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK1,
+			RT5677_MCLK_SRC_MASK, RT5677_MCLK2_SRC);
+		regmap_update_bits(rt5677->regmap, RT5677_GLB_CLK2,
+			RT5677_PLL2_PR_SRC_MASK | RT5677_DSP_CLK_SRC_MASK,
+			RT5677_PLL2_PR_SRC_MCLK2 | RT5677_DSP_CLK_SRC_BYPASS);
 		regmap_write(rt5677->regmap, RT5677_PWR_DSP2, 0x07ff);
-		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x07ff);
+		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x07fd);
+		rt5677_set_dsp_mode(codec, true);
 
 		ret = request_firmware(&rt5677->fw1, RT5677_FIRMWARE1,
 			codec->dev);
@@ -751,8 +795,7 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 			release_firmware(rt5677->fw2);
 		}
 
-		rt5677_dsp_mode_i2c_update_bits(codec, RT5677_PWR_DSP1, 0x1,
-			0x0);
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_DSP1, 0x1, 0x0);
 
 		regcache_cache_bypass(rt5677->regmap, false);
 		regcache_cache_only(rt5677->regmap, true);
@@ -762,9 +805,9 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 		regcache_cache_only(rt5677->regmap, false);
 		regcache_cache_bypass(rt5677->regmap, true);
 
-		rt5677_dsp_mode_i2c_update_bits(codec, RT5677_PWR_DSP1, 0x1,
-			0x1);
-		rt5677_dsp_mode_i2c_write(codec, RT5677_PWR_DSP1, 0x0001);
+		regmap_update_bits(rt5677->regmap, RT5677_PWR_DSP1, 0x1, 0x1);
+		rt5677_set_dsp_mode(codec, false);
+		regmap_write(rt5677->regmap, RT5677_PWR_DSP1, 0x0001);
 
 		regmap_write(rt5677->regmap, RT5677_RESET, 0x10ec);
 
@@ -3804,6 +3847,32 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 #define rt5677_resume NULL
 #endif
 
+static int rt5677_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct i2c_client *client = context;
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(client);
+
+	if (rt5677->is_dsp_mode)
+		rt5677_dsp_mode_i2c_read(rt5677, reg, val);
+	else
+		rt5677_hw_read(context, reg, val);
+
+	return 0;
+}
+
+static int rt5677_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct i2c_client *client = context;
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(client);
+
+	if (rt5677->is_dsp_mode)
+		rt5677_dsp_mode_i2c_write(rt5677, reg, val);
+	else
+		rt5677_hw_write(context, reg, val);
+
+	return 0;
+}
+
 #define RT5677_STEREO_RATES SNDRV_PCM_RATE_8000_96000
 #define RT5677_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
@@ -3938,6 +4007,8 @@ static const struct regmap_config rt5677_regmap = {
 
 	.volatile_reg = rt5677_volatile_register,
 	.readable_reg = rt5677_readable_register,
+	.reg_read = rt5677_read,
+	.reg_write = rt5677_write,
 
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5677_reg,
@@ -4063,6 +4134,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, rt5677);
+	rt5677->i2c = i2c;
 
 	if (pdata)
 		rt5677->pdata = *pdata;
@@ -4094,7 +4166,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		msleep(10);
 	}
 
-	rt5677->regmap = devm_regmap_init_i2c(i2c, &rt5677_regmap);
+	rt5677->regmap = devm_regmap_init(&i2c->dev, NULL, i2c, &rt5677_regmap);
 	if (IS_ERR(rt5677->regmap)) {
 		ret = PTR_ERR(rt5677->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index d2c743c..ab81659f 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1599,6 +1599,7 @@ struct rt5677_priv {
 	struct regmap *regmap;
 	const struct firmware *fw1, *fw2;
 	struct mutex dsp_cmd_lock;
+	struct i2c_client *i2c;
 
 	int sysclk;
 	int sysclk_src;
@@ -1614,6 +1615,7 @@ struct rt5677_priv {
 #endif
 	bool dsp_vad_en;
 	struct regmap_irq_chip_data *irq_data;
+	bool is_dsp_mode;
 };
 
 #endif /* __RT5677_H__ */
-- 
1.8.1.1.439.g50a6b54
