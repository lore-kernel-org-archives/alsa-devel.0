From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Factor out I/O for Wolfson 8 bit
	data 16 bit register CODECs
Date: Mon,  3 Aug 2009 17:09:49 +0100
Message-ID: <1249315790-22814-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E78CE24793
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:55 +0200 (CEST)
In-Reply-To: <1249315790-22814-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |   98 +++-----------
 sound/soc/codecs/wm8900.c |  319 ++++++++++++++++----------------------------
 sound/soc/codecs/wm8903.c |  244 ++++++++++++----------------------
 sound/soc/codecs/wm8940.c |  143 ++++++++-------------
 sound/soc/codecs/wm8961.c |  231 ++++++++++++---------------------
 sound/soc/codecs/wm8990.c |  194 +++++++++++-----------------
 sound/soc/codecs/wm9081.c |  229 ++++++++++++--------------------
 7 files changed, 521 insertions(+), 937 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 3b499ae..25870a4 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -62,7 +62,7 @@ static const u16 wm8523_reg[WM8523_REGISTER_COUNT] = {
 	0x0000,     /* R8 - ZERO_DETECT */
 };
 
-static int wm8523_volatile(unsigned int reg)
+static int wm8523_volatile_register(unsigned int reg)
 {
 	switch (reg) {
 	case WM8523_DEVICE_ID:
@@ -73,71 +73,9 @@ static int wm8523_volatile(unsigned int reg)
 	}
 }
 
-static int wm8523_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	struct wm8523_priv *wm8523 = codec->private_data;
-	u8 data[3];
-
-	BUG_ON(reg > WM8523_MAX_REGISTER);
-
-	data[0] = reg;
-	data[1] = (value >> 8) & 0x00ff;
-	data[2] = value & 0x00ff;
-
-	if (!wm8523_volatile(reg))
-		wm8523->reg_cache[reg] = value;
-	if (codec->hw_write(codec->control_data, data, 3) == 3)
-		return 0;
-	else
-		return -EIO;
-}
-
 static int wm8523_reset(struct snd_soc_codec *codec)
 {
-	return wm8523_write(codec, WM8523_DEVICE_ID, 0);
-}
-
-static unsigned int wm8523_read_hw(struct snd_soc_codec *codec, u8 reg)
-{
-	struct i2c_msg xfer[2];
-	u16 data;
-	int ret;
-	struct i2c_client *i2c = codec->control_data;
-
-	/* Write register */
-	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(i2c->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(codec->dev, "Failed to read 0x%x: %d\n", reg, ret);
-		return 0;
-	}
-
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-
-
-static unsigned int wm8523_read(struct snd_soc_codec *codec,
-				unsigned int reg)
-{
-	u16 *reg_cache = codec->reg_cache;
-
-	BUG_ON(reg > WM8523_MAX_REGISTER);
-
-	if (wm8523_volatile(reg))
-		return wm8523_read_hw(codec, reg);
-	else
-		return reg_cache[reg];
+	return snd_soc_write(codec, WM8523_DEVICE_ID, 0);
 }
 
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -10000, 25, 0);
@@ -228,8 +166,8 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8523_priv *wm8523 = codec->private_data;
 	int i;
-	u16 aifctrl1 = wm8523_read(codec, WM8523_AIF_CTRL1);
-	u16 aifctrl2 = wm8523_read(codec, WM8523_AIF_CTRL2);
+	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
+	u16 aifctrl2 = snd_soc_read(codec, WM8523_AIF_CTRL2);
 
 	/* Find a supported LRCLK ratio */
 	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
@@ -263,8 +201,8 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8523_write(codec, WM8523_AIF_CTRL1, aifctrl1);
-	wm8523_write(codec, WM8523_AIF_CTRL2, aifctrl2);
+	snd_soc_write(codec, WM8523_AIF_CTRL1, aifctrl1);
+	snd_soc_write(codec, WM8523_AIF_CTRL2, aifctrl2);
 
 	return 0;
 }
@@ -322,7 +260,7 @@ static int wm8523_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 aifctrl1 = wm8523_read(codec, WM8523_AIF_CTRL1);
+	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
 
 	aifctrl1 &= ~(WM8523_BCLK_INV_MASK | WM8523_LRCLK_INV_MASK |
 		      WM8523_FMT_MASK | WM8523_AIF_MSTR_MASK);
@@ -372,7 +310,7 @@ static int wm8523_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8523_write(codec, WM8523_AIF_CTRL1, aifctrl1);
+	snd_soc_write(codec, WM8523_AIF_CTRL1, aifctrl1);
 
 	return 0;
 }
@@ -411,7 +349,7 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 			/* Sync back default/cached values */
 			for (i = WM8523_AIF_CTRL1;
 			     i < WM8523_MAX_REGISTER; i++)
-				wm8523_write(codec, i, wm8523->reg_cache[i]);
+				snd_soc_write(codec, i, wm8523->reg_cache[i]);
 
 
 			msleep(100);
@@ -543,7 +481,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8523 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8523);
 
-static int wm8523_register(struct wm8523_priv *wm8523)
+static int wm8523_register(struct wm8523_priv *wm8523,
+			   enum snd_soc_control_type control)
 {
 	int ret;
 	struct snd_soc_codec *codec = &wm8523->codec;
@@ -561,14 +500,13 @@ static int wm8523_register(struct wm8523_priv *wm8523)
 	codec->private_data = wm8523;
 	codec->name = "WM8523";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8523_read;
-	codec->write = wm8523_write;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8523_set_bias_level;
 	codec->dai = &wm8523_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = WM8523_REGISTER_COUNT;
 	codec->reg_cache = &wm8523->reg_cache;
+	codec->volatile_register = wm8523_volatile_register;
 
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
@@ -576,6 +514,12 @@ static int wm8523_register(struct wm8523_priv *wm8523)
 
 	memcpy(codec->reg_cache, wm8523_reg, sizeof(wm8523_reg));
 
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm8523->supplies); i++)
 		wm8523->supplies[i].supply = wm8523_supply_names[i];
 
@@ -593,7 +537,7 @@ static int wm8523_register(struct wm8523_priv *wm8523)
 		goto err_get;
 	}
 
-	ret = wm8523_read(codec, WM8523_DEVICE_ID);
+	ret = snd_soc_read(codec, WM8523_DEVICE_ID);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to read ID register\n");
 		goto err_enable;
@@ -604,7 +548,7 @@ static int wm8523_register(struct wm8523_priv *wm8523)
 		goto err_enable;
 	}
 
-	ret = wm8523_read(codec, WM8523_REVISION);
+	ret = snd_soc_read(codec, WM8523_REVISION);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to read revision register\n");
 		goto err_enable;
@@ -684,7 +628,7 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 
 	codec->dev = &i2c->dev;
 
-	return wm8523_register(wm8523);
+	return wm8523_register(wm8523, SND_SOC_I2C);
 }
 
 static __devexit int wm8523_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index ac30899..5e9c855 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -183,111 +183,20 @@ static const u16 wm8900_reg_defaults[WM8900_MAXREG] = {
 	/* Remaining registers all zero */
 };
 
-/*
- * read wm8900 register cache
- */
-static inline unsigned int wm8900_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-
-	BUG_ON(reg >= WM8900_MAXREG);
-
-	if (reg == WM8900_REG_ID)
-		return 0;
-
-	return cache[reg];
-}
-
-/*
- * write wm8900 register cache
- */
-static inline void wm8900_write_reg_cache(struct snd_soc_codec *codec,
-	u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-
-	BUG_ON(reg >= WM8900_MAXREG);
-
-	cache[reg] = value;
-}
-
-/*
- * write to the WM8900 register space
- */
-static int wm8900_write(struct snd_soc_codec *codec, unsigned int reg,
-			unsigned int value)
-{
-	u8 data[3];
-
-	if (value == wm8900_read_reg_cache(codec, reg))
-		return 0;
-
-	/* data is
-	 *   D15..D9 WM8900 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = reg;
-	data[1] = value >> 8;
-	data[2] = value & 0x00ff;
-
-	wm8900_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 3) == 3)
-		return 0;
-	else
-		return -EIO;
-}
-
-/*
- * Read from the wm8900.
- */
-static unsigned int wm8900_chip_read(struct snd_soc_codec *codec, u8 reg)
-{
-	struct i2c_msg xfer[2];
-	u16 data;
-	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	BUG_ON(reg != WM8900_REG_ID && reg != WM8900_REG_POWER1);
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		printk(KERN_CRIT "i2c_transfer returned %d\n", ret);
-		return 0;
-	}
-
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-
-/*
- * Read from the WM8900 register space.  Most registers can't be read
- * and are therefore supplied from cache.
- */
-static unsigned int wm8900_read(struct snd_soc_codec *codec, unsigned int reg)
+static int wm8900_volatile_register(unsigned int reg)
 {
 	switch (reg) {
 	case WM8900_REG_ID:
-		return wm8900_chip_read(codec, reg);
+	case WM8900_REG_POWER1:
+		return 1;
 	default:
-		return wm8900_read_reg_cache(codec, reg);
+		return 0;
 	}
 }
 
 static void wm8900_reset(struct snd_soc_codec *codec)
 {
-	wm8900_write(codec, WM8900_REG_RESET, 0);
+	snd_soc_write(codec, WM8900_REG_RESET, 0);
 
 	memcpy(codec->reg_cache, wm8900_reg_defaults,
 	       sizeof(codec->reg_cache));
@@ -297,14 +206,14 @@ static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u16 hpctl1 = wm8900_read(codec, WM8900_REG_HPCTL1);
+	u16 hpctl1 = snd_soc_read(codec, WM8900_REG_HPCTL1);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Clamp headphone outputs */
 		hpctl1 = WM8900_REG_HPCTL1_HP_CLAMP_IP |
 			WM8900_REG_HPCTL1_HP_CLAMP_OP;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -313,41 +222,41 @@ static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
 		hpctl1 |= WM8900_REG_HPCTL1_HP_SHORT |
 			WM8900_REG_HPCTL1_HP_SHORT2 |
 			WM8900_REG_HPCTL1_HP_IPSTAGE_ENA;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 
 		msleep(400);
 
 		/* Enable the output stage */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_CLAMP_OP;
 		hpctl1 |= WM8900_REG_HPCTL1_HP_OPSTAGE_ENA;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Remove the shorts */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_SHORT2;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_SHORT;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Short the output */
 		hpctl1 |= WM8900_REG_HPCTL1_HP_SHORT;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Disable the output stage */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_OPSTAGE_ENA;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Clamp the outputs and power down input */
 		hpctl1 |= WM8900_REG_HPCTL1_HP_CLAMP_IP |
 			WM8900_REG_HPCTL1_HP_CLAMP_OP;
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_IPSTAGE_ENA;
-		wm8900_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable everything */
-		wm8900_write(codec, WM8900_REG_HPCTL1, 0);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, 0);
 		break;
 
 	default:
@@ -723,7 +632,7 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = socdev->card->codec;
 	u16 reg;
 
-	reg = wm8900_read(codec, WM8900_REG_AUDIO1) & ~0x60;
+	reg = snd_soc_read(codec, WM8900_REG_AUDIO1) & ~0x60;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -741,17 +650,17 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	wm8900_write(codec, WM8900_REG_AUDIO1, reg);
+	snd_soc_write(codec, WM8900_REG_AUDIO1, reg);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg = wm8900_read(codec, WM8900_REG_DACCTRL);
+		reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
 
 		if (params_rate(params) <= 24000)
 			reg |= WM8900_REG_DACCTRL_DAC_SB_FILT;
 		else
 			reg &= ~WM8900_REG_DACCTRL_DAC_SB_FILT;
 
-		wm8900_write(codec, WM8900_REG_DACCTRL, reg);
+		snd_soc_write(codec, WM8900_REG_DACCTRL, reg);
 	}
 
 	return 0;
@@ -845,18 +754,18 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 		return 0;
 
 	/* The digital side should be disabled during any change. */
-	reg = wm8900_read(codec, WM8900_REG_POWER1);
-	wm8900_write(codec, WM8900_REG_POWER1,
+	reg = snd_soc_read(codec, WM8900_REG_POWER1);
+	snd_soc_write(codec, WM8900_REG_POWER1,
 		     reg & (~WM8900_REG_POWER1_FLL_ENA));
 
 	/* Disable the FLL? */
 	if (!freq_in || !freq_out) {
-		reg = wm8900_read(codec, WM8900_REG_CLOCKING1);
-		wm8900_write(codec, WM8900_REG_CLOCKING1,
+		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
+		snd_soc_write(codec, WM8900_REG_CLOCKING1,
 			     reg & (~WM8900_REG_CLOCKING1_MCLK_SRC));
 
-		reg = wm8900_read(codec, WM8900_REG_FLLCTL1);
-		wm8900_write(codec, WM8900_REG_FLLCTL1,
+		reg = snd_soc_read(codec, WM8900_REG_FLLCTL1);
+		snd_soc_write(codec, WM8900_REG_FLLCTL1,
 			     reg & (~WM8900_REG_FLLCTL1_OSC_ENA));
 
 		wm8900->fll_in = freq_in;
@@ -873,33 +782,33 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 
 	/* The osclilator *MUST* be enabled before we enable the
 	 * digital circuit. */
-	wm8900_write(codec, WM8900_REG_FLLCTL1,
+	snd_soc_write(codec, WM8900_REG_FLLCTL1,
 		     fll_div.fll_ratio | WM8900_REG_FLLCTL1_OSC_ENA);
 
-	wm8900_write(codec, WM8900_REG_FLLCTL4, fll_div.n >> 5);
-	wm8900_write(codec, WM8900_REG_FLLCTL5,
+	snd_soc_write(codec, WM8900_REG_FLLCTL4, fll_div.n >> 5);
+	snd_soc_write(codec, WM8900_REG_FLLCTL5,
 		     (fll_div.fllclk_div << 6) | (fll_div.n & 0x1f));
 
 	if (fll_div.k) {
-		wm8900_write(codec, WM8900_REG_FLLCTL2,
+		snd_soc_write(codec, WM8900_REG_FLLCTL2,
 			     (fll_div.k >> 8) | 0x100);
-		wm8900_write(codec, WM8900_REG_FLLCTL3, fll_div.k & 0xff);
+		snd_soc_write(codec, WM8900_REG_FLLCTL3, fll_div.k & 0xff);
 	} else
-		wm8900_write(codec, WM8900_REG_FLLCTL2, 0);
+		snd_soc_write(codec, WM8900_REG_FLLCTL2, 0);
 
 	if (fll_div.fll_slow_lock_ref)
-		wm8900_write(codec, WM8900_REG_FLLCTL6,
+		snd_soc_write(codec, WM8900_REG_FLLCTL6,
 			     WM8900_REG_FLLCTL6_FLL_SLOW_LOCK_REF);
 	else
-		wm8900_write(codec, WM8900_REG_FLLCTL6, 0);
+		snd_soc_write(codec, WM8900_REG_FLLCTL6, 0);
 
-	reg = wm8900_read(codec, WM8900_REG_POWER1);
-	wm8900_write(codec, WM8900_REG_POWER1,
+	reg = snd_soc_read(codec, WM8900_REG_POWER1);
+	snd_soc_write(codec, WM8900_REG_POWER1,
 		     reg | WM8900_REG_POWER1_FLL_ENA);
 
 reenable:
-	reg = wm8900_read(codec, WM8900_REG_CLOCKING1);
-	wm8900_write(codec, WM8900_REG_CLOCKING1,
+	reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
+	snd_soc_write(codec, WM8900_REG_CLOCKING1,
 		     reg | WM8900_REG_CLOCKING1_MCLK_SRC);
 
 	return 0;
@@ -919,38 +828,38 @@ static int wm8900_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8900_BCLK_DIV:
-		reg = wm8900_read(codec, WM8900_REG_CLOCKING1);
-		wm8900_write(codec, WM8900_REG_CLOCKING1,
+		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
+		snd_soc_write(codec, WM8900_REG_CLOCKING1,
 			     div | (reg & WM8900_REG_CLOCKING1_BCLK_MASK));
 		break;
 	case WM8900_OPCLK_DIV:
-		reg = wm8900_read(codec, WM8900_REG_CLOCKING1);
-		wm8900_write(codec, WM8900_REG_CLOCKING1,
+		reg = snd_soc_read(codec, WM8900_REG_CLOCKING1);
+		snd_soc_write(codec, WM8900_REG_CLOCKING1,
 			     div | (reg & WM8900_REG_CLOCKING1_OPCLK_MASK));
 		break;
 	case WM8900_DAC_LRCLK:
-		reg = wm8900_read(codec, WM8900_REG_AUDIO4);
-		wm8900_write(codec, WM8900_REG_AUDIO4,
+		reg = snd_soc_read(codec, WM8900_REG_AUDIO4);
+		snd_soc_write(codec, WM8900_REG_AUDIO4,
 			     div | (reg & WM8900_LRC_MASK));
 		break;
 	case WM8900_ADC_LRCLK:
-		reg = wm8900_read(codec, WM8900_REG_AUDIO3);
-		wm8900_write(codec, WM8900_REG_AUDIO3,
+		reg = snd_soc_read(codec, WM8900_REG_AUDIO3);
+		snd_soc_write(codec, WM8900_REG_AUDIO3,
 			     div | (reg & WM8900_LRC_MASK));
 		break;
 	case WM8900_DAC_CLKDIV:
-		reg = wm8900_read(codec, WM8900_REG_CLOCKING2);
-		wm8900_write(codec, WM8900_REG_CLOCKING2,
+		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
+		snd_soc_write(codec, WM8900_REG_CLOCKING2,
 			     div | (reg & WM8900_REG_CLOCKING2_DAC_CLKDIV));
 		break;
 	case WM8900_ADC_CLKDIV:
-		reg = wm8900_read(codec, WM8900_REG_CLOCKING2);
-		wm8900_write(codec, WM8900_REG_CLOCKING2,
+		reg = snd_soc_read(codec, WM8900_REG_CLOCKING2);
+		snd_soc_write(codec, WM8900_REG_CLOCKING2,
 			     div | (reg & WM8900_REG_CLOCKING2_ADC_CLKDIV));
 		break;
 	case WM8900_LRCLK_MODE:
-		reg = wm8900_read(codec, WM8900_REG_DACCTRL);
-		wm8900_write(codec, WM8900_REG_DACCTRL,
+		reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
+		snd_soc_write(codec, WM8900_REG_DACCTRL,
 			     div | (reg & WM8900_REG_DACCTRL_AIF_LRCLKRATE));
 		break;
 	default:
@@ -967,10 +876,10 @@ static int wm8900_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	unsigned int clocking1, aif1, aif3, aif4;
 
-	clocking1 = wm8900_read(codec, WM8900_REG_CLOCKING1);
-	aif1 = wm8900_read(codec, WM8900_REG_AUDIO1);
-	aif3 = wm8900_read(codec, WM8900_REG_AUDIO3);
-	aif4 = wm8900_read(codec, WM8900_REG_AUDIO4);
+	clocking1 = snd_soc_read(codec, WM8900_REG_CLOCKING1);
+	aif1 = snd_soc_read(codec, WM8900_REG_AUDIO1);
+	aif3 = snd_soc_read(codec, WM8900_REG_AUDIO3);
+	aif4 = snd_soc_read(codec, WM8900_REG_AUDIO4);
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1066,10 +975,10 @@ static int wm8900_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8900_write(codec, WM8900_REG_CLOCKING1, clocking1);
-	wm8900_write(codec, WM8900_REG_AUDIO1, aif1);
-	wm8900_write(codec, WM8900_REG_AUDIO3, aif3);
-	wm8900_write(codec, WM8900_REG_AUDIO4, aif4);
+	snd_soc_write(codec, WM8900_REG_CLOCKING1, clocking1);
+	snd_soc_write(codec, WM8900_REG_AUDIO1, aif1);
+	snd_soc_write(codec, WM8900_REG_AUDIO3, aif3);
+	snd_soc_write(codec, WM8900_REG_AUDIO4, aif4);
 
 	return 0;
 }
@@ -1079,14 +988,14 @@ static int wm8900_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 reg;
 
-	reg = wm8900_read(codec, WM8900_REG_DACCTRL);
+	reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
 
 	if (mute)
 		reg |= WM8900_REG_DACCTRL_MUTE;
 	else
 		reg &= ~WM8900_REG_DACCTRL_MUTE;
 
-	wm8900_write(codec, WM8900_REG_DACCTRL, reg);
+	snd_soc_write(codec, WM8900_REG_DACCTRL, reg);
 
 	return 0;
 }
@@ -1135,11 +1044,11 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* Enable thermal shutdown */
-		reg = wm8900_read(codec, WM8900_REG_GPIO);
-		wm8900_write(codec, WM8900_REG_GPIO,
+		reg = snd_soc_read(codec, WM8900_REG_GPIO);
+		snd_soc_write(codec, WM8900_REG_GPIO,
 			     reg | WM8900_REG_GPIO_TEMP_ENA);
-		reg = wm8900_read(codec, WM8900_REG_ADDCTL);
-		wm8900_write(codec, WM8900_REG_ADDCTL,
+		reg = snd_soc_read(codec, WM8900_REG_ADDCTL);
+		snd_soc_write(codec, WM8900_REG_ADDCTL,
 			     reg | WM8900_REG_ADDCTL_TEMP_SD);
 		break;
 
@@ -1150,69 +1059,69 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 		/* Charge capacitors if initial power up */
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* STARTUP_BIAS_ENA on */
-			wm8900_write(codec, WM8900_REG_POWER1,
+			snd_soc_write(codec, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA);
 
 			/* Startup bias mode */
-			wm8900_write(codec, WM8900_REG_ADDCTL,
+			snd_soc_write(codec, WM8900_REG_ADDCTL,
 				     WM8900_REG_ADDCTL_BIAS_SRC |
 				     WM8900_REG_ADDCTL_VMID_SOFTST);
 
 			/* VMID 2x50k */
-			wm8900_write(codec, WM8900_REG_POWER1,
+			snd_soc_write(codec, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA | 0x1);
 
 			/* Allow capacitors to charge */
 			schedule_timeout_interruptible(msecs_to_jiffies(400));
 
 			/* Enable bias */
-			wm8900_write(codec, WM8900_REG_POWER1,
+			snd_soc_write(codec, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA |
 				     WM8900_REG_POWER1_BIAS_ENA | 0x1);
 
-			wm8900_write(codec, WM8900_REG_ADDCTL, 0);
+			snd_soc_write(codec, WM8900_REG_ADDCTL, 0);
 
-			wm8900_write(codec, WM8900_REG_POWER1,
+			snd_soc_write(codec, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_BIAS_ENA | 0x1);
 		}
 
-		reg = wm8900_read(codec, WM8900_REG_POWER1);
-		wm8900_write(codec, WM8900_REG_POWER1,
+		reg = snd_soc_read(codec, WM8900_REG_POWER1);
+		snd_soc_write(codec, WM8900_REG_POWER1,
 			     (reg & WM8900_REG_POWER1_FLL_ENA) |
 			     WM8900_REG_POWER1_BIAS_ENA | 0x1);
-		wm8900_write(codec, WM8900_REG_POWER2,
+		snd_soc_write(codec, WM8900_REG_POWER2,
 			     WM8900_REG_POWER2_SYSCLK_ENA);
-		wm8900_write(codec, WM8900_REG_POWER3, 0);
+		snd_soc_write(codec, WM8900_REG_POWER3, 0);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Startup bias enable */
-		reg = wm8900_read(codec, WM8900_REG_POWER1);
-		wm8900_write(codec, WM8900_REG_POWER1,
+		reg = snd_soc_read(codec, WM8900_REG_POWER1);
+		snd_soc_write(codec, WM8900_REG_POWER1,
 			     reg & WM8900_REG_POWER1_STARTUP_BIAS_ENA);
-		wm8900_write(codec, WM8900_REG_ADDCTL,
+		snd_soc_write(codec, WM8900_REG_ADDCTL,
 			     WM8900_REG_ADDCTL_BIAS_SRC |
 			     WM8900_REG_ADDCTL_VMID_SOFTST);
 
 		/* Discharge caps */
-		wm8900_write(codec, WM8900_REG_POWER1,
+		snd_soc_write(codec, WM8900_REG_POWER1,
 			     WM8900_REG_POWER1_STARTUP_BIAS_ENA);
 		schedule_timeout_interruptible(msecs_to_jiffies(500));
 
 		/* Remove clamp */
-		wm8900_write(codec, WM8900_REG_HPCTL1, 0);
+		snd_soc_write(codec, WM8900_REG_HPCTL1, 0);
 
 		/* Power down */
-		wm8900_write(codec, WM8900_REG_ADDCTL, 0);
-		wm8900_write(codec, WM8900_REG_POWER1, 0);
-		wm8900_write(codec, WM8900_REG_POWER2, 0);
-		wm8900_write(codec, WM8900_REG_POWER3, 0);
+		snd_soc_write(codec, WM8900_REG_ADDCTL, 0);
+		snd_soc_write(codec, WM8900_REG_POWER1, 0);
+		snd_soc_write(codec, WM8900_REG_POWER2, 0);
+		snd_soc_write(codec, WM8900_REG_POWER3, 0);
 
 		/* Need to let things settle before stopping the clock
 		 * to ensure that restart works, see "Stopping the
 		 * master clock" in the datasheet. */
 		schedule_timeout_interruptible(msecs_to_jiffies(1));
-		wm8900_write(codec, WM8900_REG_POWER2,
+		snd_soc_write(codec, WM8900_REG_POWER2,
 			     WM8900_REG_POWER2_SYSCLK_ENA);
 		break;
 	}
@@ -1275,7 +1184,7 @@ static int wm8900_resume(struct platform_device *pdev)
 
 	if (cache) {
 		for (i = 0; i < WM8900_MAXREG; i++)
-			wm8900_write(codec, i, cache[i]);
+			snd_soc_write(codec, i, cache[i]);
 		kfree(cache);
 	} else
 		dev_err(&pdev->dev, "Unable to allocate register cache\n");
@@ -1308,16 +1217,20 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 
 	codec->name = "WM8900";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8900_read;
-	codec->write = wm8900_write;
 	codec->dai = &wm8900_dai;
 	codec->num_dai = 1;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->control_data = i2c;
 	codec->set_bias_level = wm8900_set_bias_level;
+	codec->volatile_register = wm8900_volatile_register;
 	codec->dev = &i2c->dev;
 
-	reg = wm8900_read(codec, WM8900_REG_ID);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	reg = snd_soc_read(codec, WM8900_REG_ID);
 	if (reg != 0x8900) {
 		dev_err(&i2c->dev, "Device is not a WM8900 - ID %x\n", reg);
 		ret = -ENODEV;
@@ -1325,7 +1238,7 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Read back from the chip */
-	reg = wm8900_chip_read(codec, WM8900_REG_POWER1);
+	reg = snd_soc_read(codec, WM8900_REG_POWER1);
 	reg = (reg >> 12) & 0xf;
 	dev_info(&i2c->dev, "WM8900 revision %d\n", reg);
 
@@ -1335,29 +1248,29 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the volume update bits */
-	wm8900_write(codec, WM8900_REG_LINVOL,
-		     wm8900_read(codec, WM8900_REG_LINVOL) | 0x100);
-	wm8900_write(codec, WM8900_REG_RINVOL,
-		     wm8900_read(codec, WM8900_REG_RINVOL) | 0x100);
-	wm8900_write(codec, WM8900_REG_LOUT1CTL,
-		     wm8900_read(codec, WM8900_REG_LOUT1CTL) | 0x100);
-	wm8900_write(codec, WM8900_REG_ROUT1CTL,
-		     wm8900_read(codec, WM8900_REG_ROUT1CTL) | 0x100);
-	wm8900_write(codec, WM8900_REG_LOUT2CTL,
-		     wm8900_read(codec, WM8900_REG_LOUT2CTL) | 0x100);
-	wm8900_write(codec, WM8900_REG_ROUT2CTL,
-		     wm8900_read(codec, WM8900_REG_ROUT2CTL) | 0x100);
-	wm8900_write(codec, WM8900_REG_LDAC_DV,
-		     wm8900_read(codec, WM8900_REG_LDAC_DV) | 0x100);
-	wm8900_write(codec, WM8900_REG_RDAC_DV,
-		     wm8900_read(codec, WM8900_REG_RDAC_DV) | 0x100);
-	wm8900_write(codec, WM8900_REG_LADC_DV,
-		     wm8900_read(codec, WM8900_REG_LADC_DV) | 0x100);
-	wm8900_write(codec, WM8900_REG_RADC_DV,
-		     wm8900_read(codec, WM8900_REG_RADC_DV) | 0x100);
+	snd_soc_write(codec, WM8900_REG_LINVOL,
+		      snd_soc_read(codec, WM8900_REG_LINVOL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_RINVOL,
+		      snd_soc_read(codec, WM8900_REG_RINVOL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_LOUT1CTL,
+		      snd_soc_read(codec, WM8900_REG_LOUT1CTL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_ROUT1CTL,
+		      snd_soc_read(codec, WM8900_REG_ROUT1CTL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_LOUT2CTL,
+		      snd_soc_read(codec, WM8900_REG_LOUT2CTL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_ROUT2CTL,
+		      snd_soc_read(codec, WM8900_REG_ROUT2CTL) | 0x100);
+	snd_soc_write(codec, WM8900_REG_LDAC_DV,
+		      snd_soc_read(codec, WM8900_REG_LDAC_DV) | 0x100);
+	snd_soc_write(codec, WM8900_REG_RDAC_DV,
+		      snd_soc_read(codec, WM8900_REG_RDAC_DV) | 0x100);
+	snd_soc_write(codec, WM8900_REG_LADC_DV,
+		      snd_soc_read(codec, WM8900_REG_LADC_DV) | 0x100);
+	snd_soc_write(codec, WM8900_REG_RADC_DV,
+		      snd_soc_read(codec, WM8900_REG_RADC_DV) | 0x100);
 
 	/* Set the DAC and mixer output bias */
-	wm8900_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
+	snd_soc_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
 
 	wm8900_dai.dev = &i2c->dev;
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c9baeae..fe1307b 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -225,94 +225,18 @@ struct wm8903_priv {
 	struct snd_pcm_substream *slave_substream;
 };
 
-
-static unsigned int wm8903_read_reg_cache(struct snd_soc_codec *codec,
-						 unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-
-	BUG_ON(reg >= ARRAY_SIZE(wm8903_reg_defaults));
-
-	return cache[reg];
-}
-
-static unsigned int wm8903_hw_read(struct snd_soc_codec *codec, u8 reg)
-{
-	struct i2c_msg xfer[2];
-	u16 data;
-	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		pr_err("i2c_transfer returned %d\n", ret);
-		return 0;
-	}
-
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-
-static unsigned int wm8903_read(struct snd_soc_codec *codec,
-				unsigned int reg)
+static int wm8903_volatile_register(unsigned int reg)
 {
 	switch (reg) {
 	case WM8903_SW_RESET_AND_ID:
 	case WM8903_REVISION_NUMBER:
 	case WM8903_INTERRUPT_STATUS_1:
 	case WM8903_WRITE_SEQUENCER_4:
-		return wm8903_hw_read(codec, reg);
+		return 1;
 
 	default:
-		return wm8903_read_reg_cache(codec, reg);
-	}
-}
-
-static void wm8903_write_reg_cache(struct snd_soc_codec *codec,
-				   u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-
-	BUG_ON(reg >= ARRAY_SIZE(wm8903_reg_defaults));
-
-	switch (reg) {
-	case WM8903_SW_RESET_AND_ID:
-	case WM8903_REVISION_NUMBER:
-		break;
-
-	default:
-		cache[reg] = value;
-		break;
-	}
-}
-
-static int wm8903_write(struct snd_soc_codec *codec, unsigned int reg,
-			unsigned int value)
-{
-	u8 data[3];
-
-	wm8903_write_reg_cache(codec, reg, value);
-
-	/* Data format is 1 byte of address followed by 2 bytes of data */
-	data[0] = reg;
-	data[1] = (value >> 8) & 0xff;
-	data[2] = value & 0xff;
-
-	if (codec->hw_write(codec->control_data, data, 3) == 2)
 		return 0;
-	else
-		return -EIO;
+	}
 }
 
 static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
@@ -323,13 +247,13 @@ static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 	BUG_ON(start > 48);
 
 	/* Enable the sequencer */
-	reg[0] = wm8903_read(codec, WM8903_WRITE_SEQUENCER_0);
+	reg[0] = snd_soc_read(codec, WM8903_WRITE_SEQUENCER_0);
 	reg[0] |= WM8903_WSEQ_ENA;
-	wm8903_write(codec, WM8903_WRITE_SEQUENCER_0, reg[0]);
+	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0, reg[0]);
 
 	dev_dbg(&i2c->dev, "Starting sequence at %d\n", start);
 
-	wm8903_write(codec, WM8903_WRITE_SEQUENCER_3,
+	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_3,
 		     start | WM8903_WSEQ_START);
 
 	/* Wait for it to complete.  If we have the interrupt wired up then
@@ -339,13 +263,13 @@ static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 	do {
 		msleep(10);
 
-		reg[4] = wm8903_read(codec, WM8903_WRITE_SEQUENCER_4);
+		reg[4] = snd_soc_read(codec, WM8903_WRITE_SEQUENCER_4);
 	} while (reg[4] & WM8903_WSEQ_BUSY);
 
 	dev_dbg(&i2c->dev, "Sequence complete\n");
 
 	/* Disable the sequencer again */
-	wm8903_write(codec, WM8903_WRITE_SEQUENCER_0,
+	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0,
 		     reg[0] & ~WM8903_WSEQ_ENA);
 
 	return 0;
@@ -357,12 +281,12 @@ static void wm8903_sync_reg_cache(struct snd_soc_codec *codec, u16 *cache)
 
 	/* There really ought to be something better we can do here :/ */
 	for (i = 0; i < ARRAY_SIZE(wm8903_reg_defaults); i++)
-		cache[i] = wm8903_hw_read(codec, i);
+		cache[i] = codec->hw_read(codec, i);
 }
 
 static void wm8903_reset(struct snd_soc_codec *codec)
 {
-	wm8903_write(codec, WM8903_SW_RESET_AND_ID, 0);
+	snd_soc_write(codec, WM8903_SW_RESET_AND_ID, 0);
 	memcpy(codec->reg_cache, wm8903_reg_defaults,
 	       sizeof(wm8903_reg_defaults));
 }
@@ -423,52 +347,52 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMU) {
-		val = wm8903_read(codec, reg);
+		val = snd_soc_read(codec, reg);
 
 		/* Short the output */
 		val &= ~(WM8903_OUTPUT_SHORT << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 	}
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
-		val = wm8903_read(codec, reg);
+		val = snd_soc_read(codec, reg);
 
 		val |= (WM8903_OUTPUT_IN << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 
 		val |= (WM8903_OUTPUT_INT << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 
 		/* Turn on the output ENA_OUTP */
 		val |= (WM8903_OUTPUT_OUT << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 
 		/* Enable the DC servo */
-		dcs_reg = wm8903_read(codec, WM8903_DC_SERVO_0);
+		dcs_reg = snd_soc_read(codec, WM8903_DC_SERVO_0);
 		dcs_reg |= dcs_bit;
-		wm8903_write(codec, WM8903_DC_SERVO_0, dcs_reg);
+		snd_soc_write(codec, WM8903_DC_SERVO_0, dcs_reg);
 
 		/* Remove the short */
 		val |= (WM8903_OUTPUT_SHORT << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
-		val = wm8903_read(codec, reg);
+		val = snd_soc_read(codec, reg);
 
 		/* Short the output */
 		val &= ~(WM8903_OUTPUT_SHORT << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 
 		/* Disable the DC servo */
-		dcs_reg = wm8903_read(codec, WM8903_DC_SERVO_0);
+		dcs_reg = snd_soc_read(codec, WM8903_DC_SERVO_0);
 		dcs_reg &= ~dcs_bit;
-		wm8903_write(codec, WM8903_DC_SERVO_0, dcs_reg);
+		snd_soc_write(codec, WM8903_DC_SERVO_0, dcs_reg);
 
 		/* Then disable the intermediate and output stages */
 		val &= ~((WM8903_OUTPUT_OUT | WM8903_OUTPUT_INT |
 			  WM8903_OUTPUT_IN) << shift);
-		wm8903_write(codec, reg, val);
+		snd_soc_write(codec, reg, val);
 	}
 
 	return 0;
@@ -492,13 +416,13 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	u16 reg;
 	int ret;
 
-	reg = wm8903_read(codec, WM8903_CLASS_W_0);
+	reg = snd_soc_read(codec, WM8903_CLASS_W_0);
 
 	/* Turn it off if we're about to enable bypass */
 	if (ucontrol->value.integer.value[0]) {
 		if (wm8903->class_w_users == 0) {
 			dev_dbg(&i2c->dev, "Disabling Class W\n");
-			wm8903_write(codec, WM8903_CLASS_W_0, reg &
+			snd_soc_write(codec, WM8903_CLASS_W_0, reg &
 				     ~(WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V));
 		}
 		wm8903->class_w_users++;
@@ -511,7 +435,7 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	if (!ucontrol->value.integer.value[0]) {
 		if (wm8903->class_w_users == 1) {
 			dev_dbg(&i2c->dev, "Enabling Class W\n");
-			wm8903_write(codec, WM8903_CLASS_W_0, reg |
+			snd_soc_write(codec, WM8903_CLASS_W_0, reg |
 				     WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V);
 		}
 		wm8903->class_w_users--;
@@ -1009,55 +933,55 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		reg = wm8903_read(codec, WM8903_VMID_CONTROL_0);
+		reg = snd_soc_read(codec, WM8903_VMID_CONTROL_0);
 		reg &= ~(WM8903_VMID_RES_MASK);
 		reg |= WM8903_VMID_RES_50K;
-		wm8903_write(codec, WM8903_VMID_CONTROL_0, reg);
+		snd_soc_write(codec, WM8903_VMID_CONTROL_0, reg);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
-			wm8903_write(codec, WM8903_CLOCK_RATES_2,
+			snd_soc_write(codec, WM8903_CLOCK_RATES_2,
 				     WM8903_CLK_SYS_ENA);
 
 			/* Change DC servo dither level in startup sequence */
-			wm8903_write(codec, WM8903_WRITE_SEQUENCER_0, 0x11);
-			wm8903_write(codec, WM8903_WRITE_SEQUENCER_1, 0x1257);
-			wm8903_write(codec, WM8903_WRITE_SEQUENCER_2, 0x2);
+			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0, 0x11);
+			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_1, 0x1257);
+			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_2, 0x2);
 
 			wm8903_run_sequence(codec, 0);
 			wm8903_sync_reg_cache(codec, codec->reg_cache);
 
 			/* Enable low impedence charge pump output */
-			reg = wm8903_read(codec,
+			reg = snd_soc_read(codec,
 					  WM8903_CONTROL_INTERFACE_TEST_1);
-			wm8903_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
+			snd_soc_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
 				     reg | WM8903_TEST_KEY);
-			reg2 = wm8903_read(codec, WM8903_CHARGE_PUMP_TEST_1);
-			wm8903_write(codec, WM8903_CHARGE_PUMP_TEST_1,
+			reg2 = snd_soc_read(codec, WM8903_CHARGE_PUMP_TEST_1);
+			snd_soc_write(codec, WM8903_CHARGE_PUMP_TEST_1,
 				     reg2 | WM8903_CP_SW_KELVIN_MODE_MASK);
-			wm8903_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
+			snd_soc_write(codec, WM8903_CONTROL_INTERFACE_TEST_1,
 				     reg);
 
 			/* By default no bypass paths are enabled so
 			 * enable Class W support.
 			 */
 			dev_dbg(&i2c->dev, "Enabling Class W\n");
-			wm8903_write(codec, WM8903_CLASS_W_0, reg |
+			snd_soc_write(codec, WM8903_CLASS_W_0, reg |
 				     WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V);
 		}
 
-		reg = wm8903_read(codec, WM8903_VMID_CONTROL_0);
+		reg = snd_soc_read(codec, WM8903_VMID_CONTROL_0);
 		reg &= ~(WM8903_VMID_RES_MASK);
 		reg |= WM8903_VMID_RES_250K;
-		wm8903_write(codec, WM8903_VMID_CONTROL_0, reg);
+		snd_soc_write(codec, WM8903_VMID_CONTROL_0, reg);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		wm8903_run_sequence(codec, 32);
-		reg = wm8903_read(codec, WM8903_CLOCK_RATES_2);
+		reg = snd_soc_read(codec, WM8903_CLOCK_RATES_2);
 		reg &= ~WM8903_CLK_SYS_ENA;
-		wm8903_write(codec, WM8903_CLOCK_RATES_2, reg);
+		snd_soc_write(codec, WM8903_CLOCK_RATES_2, reg);
 		break;
 	}
 
@@ -1081,7 +1005,7 @@ static int wm8903_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 aif1 = wm8903_read(codec, WM8903_AUDIO_INTERFACE_1);
+	u16 aif1 = snd_soc_read(codec, WM8903_AUDIO_INTERFACE_1);
 
 	aif1 &= ~(WM8903_LRCLK_DIR | WM8903_BCLK_DIR | WM8903_AIF_FMT_MASK |
 		  WM8903_AIF_LRCLK_INV | WM8903_AIF_BCLK_INV);
@@ -1159,7 +1083,7 @@ static int wm8903_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8903_write(codec, WM8903_AUDIO_INTERFACE_1, aif1);
+	snd_soc_write(codec, WM8903_AUDIO_INTERFACE_1, aif1);
 
 	return 0;
 }
@@ -1169,14 +1093,14 @@ static int wm8903_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 reg;
 
-	reg = wm8903_read(codec, WM8903_DAC_DIGITAL_1);
+	reg = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
 
 	if (mute)
 		reg |= WM8903_DAC_MUTE;
 	else
 		reg &= ~WM8903_DAC_MUTE;
 
-	wm8903_write(codec, WM8903_DAC_DIGITAL_1, reg);
+	snd_soc_write(codec, WM8903_DAC_DIGITAL_1, reg);
 
 	return 0;
 }
@@ -1366,12 +1290,12 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	int cur_val;
 	int clk_sys;
 
-	u16 aif1 = wm8903_read(codec, WM8903_AUDIO_INTERFACE_1);
-	u16 aif2 = wm8903_read(codec, WM8903_AUDIO_INTERFACE_2);
-	u16 aif3 = wm8903_read(codec, WM8903_AUDIO_INTERFACE_3);
-	u16 clock0 = wm8903_read(codec, WM8903_CLOCK_RATES_0);
-	u16 clock1 = wm8903_read(codec, WM8903_CLOCK_RATES_1);
-	u16 dac_digital1 = wm8903_read(codec, WM8903_DAC_DIGITAL_1);
+	u16 aif1 = snd_soc_read(codec, WM8903_AUDIO_INTERFACE_1);
+	u16 aif2 = snd_soc_read(codec, WM8903_AUDIO_INTERFACE_2);
+	u16 aif3 = snd_soc_read(codec, WM8903_AUDIO_INTERFACE_3);
+	u16 clock0 = snd_soc_read(codec, WM8903_CLOCK_RATES_0);
+	u16 clock1 = snd_soc_read(codec, WM8903_CLOCK_RATES_1);
+	u16 dac_digital1 = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
 
 	if (substream == wm8903->slave_substream) {
 		dev_dbg(&i2c->dev, "Ignoring hw_params for slave substream\n");
@@ -1503,12 +1427,12 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	aif2 |= bclk_divs[bclk_div].div;
 	aif3 |= bclk / fs;
 
-	wm8903_write(codec, WM8903_CLOCK_RATES_0, clock0);
-	wm8903_write(codec, WM8903_CLOCK_RATES_1, clock1);
-	wm8903_write(codec, WM8903_AUDIO_INTERFACE_1, aif1);
-	wm8903_write(codec, WM8903_AUDIO_INTERFACE_2, aif2);
-	wm8903_write(codec, WM8903_AUDIO_INTERFACE_3, aif3);
-	wm8903_write(codec, WM8903_DAC_DIGITAL_1, dac_digital1);
+	snd_soc_write(codec, WM8903_CLOCK_RATES_0, clock0);
+	snd_soc_write(codec, WM8903_CLOCK_RATES_1, clock1);
+	snd_soc_write(codec, WM8903_AUDIO_INTERFACE_1, aif1);
+	snd_soc_write(codec, WM8903_AUDIO_INTERFACE_2, aif2);
+	snd_soc_write(codec, WM8903_AUDIO_INTERFACE_3, aif3);
+	snd_soc_write(codec, WM8903_DAC_DIGITAL_1, dac_digital1);
 
 	return 0;
 }
@@ -1593,7 +1517,7 @@ static int wm8903_resume(struct platform_device *pdev)
 	if (tmp_cache) {
 		for (i = 2; i < ARRAY_SIZE(wm8903_reg_defaults); i++)
 			if (tmp_cache[i] != reg_cache[i])
-				wm8903_write(codec, i, tmp_cache[i]);
+				snd_soc_write(codec, i, tmp_cache[i]);
 	} else {
 		dev_err(&i2c->dev, "Failed to allocate temporary cache\n");
 	}
@@ -1624,9 +1548,6 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	codec->dev = &i2c->dev;
 	codec->name = "WM8903";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8903_read;
-	codec->write = wm8903_write;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8903_set_bias_level;
 	codec->dai = &wm8903_dai;
@@ -1634,18 +1555,25 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	codec->reg_cache_size = ARRAY_SIZE(wm8903->reg_cache);
 	codec->reg_cache = &wm8903->reg_cache[0];
 	codec->private_data = wm8903;
+	codec->volatile_register = wm8903_volatile_register;
 
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	val = wm8903_hw_read(codec, WM8903_SW_RESET_AND_ID);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	val = snd_soc_read(codec, WM8903_SW_RESET_AND_ID);
 	if (val != wm8903_reg_defaults[WM8903_SW_RESET_AND_ID]) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not a WM8903\n", val);
 		return -ENODEV;
 	}
 
-	val = wm8903_read(codec, WM8903_REVISION_NUMBER);
+	val = snd_soc_read(codec, WM8903_REVISION_NUMBER);
 	dev_info(&i2c->dev, "WM8903 revision %d\n",
 		 val & WM8903_CHIP_REV_MASK);
 
@@ -1655,35 +1583,35 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch volume update bits */
-	val = wm8903_read(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT);
+	val = snd_soc_read(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT);
 	val |= WM8903_ADCVU;
-	wm8903_write(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT, val);
-	wm8903_write(codec, WM8903_ADC_DIGITAL_VOLUME_RIGHT, val);
+	snd_soc_write(codec, WM8903_ADC_DIGITAL_VOLUME_LEFT, val);
+	snd_soc_write(codec, WM8903_ADC_DIGITAL_VOLUME_RIGHT, val);
 
-	val = wm8903_read(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT);
+	val = snd_soc_read(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT);
 	val |= WM8903_DACVU;
-	wm8903_write(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT, val);
-	wm8903_write(codec, WM8903_DAC_DIGITAL_VOLUME_RIGHT, val);
+	snd_soc_write(codec, WM8903_DAC_DIGITAL_VOLUME_LEFT, val);
+	snd_soc_write(codec, WM8903_DAC_DIGITAL_VOLUME_RIGHT, val);
 
-	val = wm8903_read(codec, WM8903_ANALOGUE_OUT1_LEFT);
+	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT1_LEFT);
 	val |= WM8903_HPOUTVU;
-	wm8903_write(codec, WM8903_ANALOGUE_OUT1_LEFT, val);
-	wm8903_write(codec, WM8903_ANALOGUE_OUT1_RIGHT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT1_LEFT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT1_RIGHT, val);
 
-	val = wm8903_read(codec, WM8903_ANALOGUE_OUT2_LEFT);
+	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT2_LEFT);
 	val |= WM8903_LINEOUTVU;
-	wm8903_write(codec, WM8903_ANALOGUE_OUT2_LEFT, val);
-	wm8903_write(codec, WM8903_ANALOGUE_OUT2_RIGHT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT2_LEFT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT2_RIGHT, val);
 
-	val = wm8903_read(codec, WM8903_ANALOGUE_OUT3_LEFT);
+	val = snd_soc_read(codec, WM8903_ANALOGUE_OUT3_LEFT);
 	val |= WM8903_SPKVU;
-	wm8903_write(codec, WM8903_ANALOGUE_OUT3_LEFT, val);
-	wm8903_write(codec, WM8903_ANALOGUE_OUT3_RIGHT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT3_LEFT, val);
+	snd_soc_write(codec, WM8903_ANALOGUE_OUT3_RIGHT, val);
 
 	/* Enable DAC soft mute by default */
-	val = wm8903_read(codec, WM8903_DAC_DIGITAL_1);
+	val = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
 	val |= WM8903_DAC_MUTEMODE;
-	wm8903_write(codec, WM8903_DAC_DIGITAL_1, val);
+	snd_soc_write(codec, WM8903_DAC_DIGITAL_1, val);
 
 	wm8903_dai.dev = &i2c->dev;
 	wm8903_codec = codec;
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index b69210a..da97aae 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -106,50 +106,6 @@ static u16 wm8940_reg_defaults[] = {
 	0x0000, /* Mono Mixer Control */
 };
 
-static inline unsigned int wm8940_read_reg_cache(struct snd_soc_codec *codec,
-						 unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-
-	if (reg >= ARRAY_SIZE(wm8940_reg_defaults))
-		return -1;
-
-	return cache[reg];
-}
-
-static inline int wm8940_write_reg_cache(struct snd_soc_codec *codec,
-					  u16 reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-
-	if (reg >= ARRAY_SIZE(wm8940_reg_defaults))
-		return -1;
-
-	cache[reg] = value;
-
-	return 0;
-}
-
-static int wm8940_write(struct snd_soc_codec *codec, unsigned int reg,
-			unsigned int value)
-{
-	int ret;
-	u8 data[3] = { reg,
-		       (value & 0xff00) >> 8,
-		       (value & 0x00ff)
-	};
-
-	wm8940_write_reg_cache(codec, reg, value);
-
-	ret = codec->hw_write(codec->control_data, data, 3);
-
-	if (ret < 0)
-		return ret;
-	else if (ret != 3)
-		return -EIO;
-	return 0;
-}
-
 static const char *wm8940_companding[] = { "Off", "NC", "u-law", "A-law" };
 static const struct soc_enum wm8940_adc_companding_enum
 = SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 1, 4, wm8940_companding);
@@ -348,14 +304,14 @@ error_ret:
 	return ret;
 }
 
-#define wm8940_reset(c) wm8940_write(c, WM8940_SOFTRESET, 0);
+#define wm8940_reset(c) snd_soc_write(c, WM8940_SOFTRESET, 0);
 
 static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = wm8940_read_reg_cache(codec, WM8940_IFACE) & 0xFE67;
-	u16 clk = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0x1fe;
+	u16 iface = snd_soc_read(codec, WM8940_IFACE) & 0xFE67;
+	u16 clk = snd_soc_read(codec, WM8940_CLOCK) & 0x1fe;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -366,7 +322,7 @@ static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	default:
 		return -EINVAL;
 	}
-	wm8940_write(codec, WM8940_CLOCK, clk);
+	snd_soc_write(codec, WM8940_CLOCK, clk);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -399,7 +355,7 @@ static int wm8940_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	wm8940_write(codec, WM8940_IFACE, iface);
+	snd_soc_write(codec, WM8940_IFACE, iface);
 
 	return 0;
 }
@@ -411,9 +367,9 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 iface = wm8940_read_reg_cache(codec, WM8940_IFACE) & 0xFD9F;
-	u16 addcntrl = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFF1;
-	u16 companding =  wm8940_read_reg_cache(codec,
+	u16 iface = snd_soc_read(codec, WM8940_IFACE) & 0xFD9F;
+	u16 addcntrl = snd_soc_read(codec, WM8940_ADDCNTRL) & 0xFFF1;
+	u16 companding =  snd_soc_read(codec,
 						WM8940_COMPANDINGCTL) & 0xFFDF;
 	int ret;
 
@@ -442,7 +398,7 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_RATE_48000:
 		break;
 	}
-	ret = wm8940_write(codec, WM8940_ADDCNTRL, addcntrl);
+	ret = snd_soc_write(codec, WM8940_ADDCNTRL, addcntrl);
 	if (ret)
 		goto error_ret;
 
@@ -462,10 +418,10 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 		iface |= (3 << 5);
 		break;
 	}
-	ret = wm8940_write(codec, WM8940_COMPANDINGCTL, companding);
+	ret = snd_soc_write(codec, WM8940_COMPANDINGCTL, companding);
 	if (ret)
 		goto error_ret;
-	ret = wm8940_write(codec, WM8940_IFACE, iface);
+	ret = snd_soc_write(codec, WM8940_IFACE, iface);
 
 error_ret:
 	return ret;
@@ -474,19 +430,19 @@ error_ret:
 static int wm8940_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = wm8940_read_reg_cache(codec, WM8940_DAC) & 0xffbf;
+	u16 mute_reg = snd_soc_read(codec, WM8940_DAC) & 0xffbf;
 
 	if (mute)
 		mute_reg |= 0x40;
 
-	return wm8940_write(codec, WM8940_DAC, mute_reg);
+	return snd_soc_write(codec, WM8940_DAC, mute_reg);
 }
 
 static int wm8940_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	u16 val;
-	u16 pwr_reg = wm8940_read_reg_cache(codec, WM8940_POWER1) & 0x1F0;
+	u16 pwr_reg = snd_soc_read(codec, WM8940_POWER1) & 0x1F0;
 	int ret = 0;
 
 	switch (level) {
@@ -494,26 +450,26 @@ static int wm8940_set_bias_level(struct snd_soc_codec *codec,
 		/* ensure bufioen and biasen */
 		pwr_reg |= (1 << 2) | (1 << 3);
 		/* Enable thermal shutdown */
-		val = wm8940_read_reg_cache(codec, WM8940_OUTPUTCTL);
-		ret = wm8940_write(codec, WM8940_OUTPUTCTL, val | 0x2);
+		val = snd_soc_read(codec, WM8940_OUTPUTCTL);
+		ret = snd_soc_write(codec, WM8940_OUTPUTCTL, val | 0x2);
 		if (ret)
 			break;
 		/* set vmid to 75k */
-		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);
+		ret = snd_soc_write(codec, WM8940_POWER1, pwr_reg | 0x1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* ensure bufioen and biasen */
 		pwr_reg |= (1 << 2) | (1 << 3);
-		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);
+		ret = snd_soc_write(codec, WM8940_POWER1, pwr_reg | 0x1);
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* ensure bufioen and biasen */
 		pwr_reg |= (1 << 2) | (1 << 3);
 		/* set vmid to 300k for standby */
-		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x2);
+		ret = snd_soc_write(codec, WM8940_POWER1, pwr_reg | 0x2);
 		break;
 	case SND_SOC_BIAS_OFF:
-		ret = wm8940_write(codec, WM8940_POWER1, pwr_reg);
+		ret = snd_soc_write(codec, WM8940_POWER1, pwr_reg);
 		break;
 	}
 
@@ -587,36 +543,36 @@ static int wm8940_set_dai_pll(struct snd_soc_dai *codec_dai,
 	u16 reg;
 
 	/* Turn off PLL */
-	reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
-	wm8940_write(codec, WM8940_POWER1, reg & 0x1df);
+	reg = snd_soc_read(codec, WM8940_POWER1);
+	snd_soc_write(codec, WM8940_POWER1, reg & 0x1df);
 
 	if (freq_in == 0 || freq_out == 0) {
 		/* Clock CODEC directly from MCLK */
-		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
-		wm8940_write(codec, WM8940_CLOCK, reg & 0x0ff);
+		reg = snd_soc_read(codec, WM8940_CLOCK);
+		snd_soc_write(codec, WM8940_CLOCK, reg & 0x0ff);
 		/* Pll power down */
-		wm8940_write(codec, WM8940_PLLN, (1 << 7));
+		snd_soc_write(codec, WM8940_PLLN, (1 << 7));
 		return 0;
 	}
 
 	/* Pll is followed by a frequency divide by 4 */
 	pll_factors(freq_out*4, freq_in);
 	if (pll_div.k)
-		wm8940_write(codec, WM8940_PLLN,
+		snd_soc_write(codec, WM8940_PLLN,
 			     (pll_div.pre_scale << 4) | pll_div.n | (1 << 6));
 	else /* No factional component */
-		wm8940_write(codec, WM8940_PLLN,
+		snd_soc_write(codec, WM8940_PLLN,
 			     (pll_div.pre_scale << 4) | pll_div.n);
-	wm8940_write(codec, WM8940_PLLK1, pll_div.k >> 18);
-	wm8940_write(codec, WM8940_PLLK2, (pll_div.k >> 9) & 0x1ff);
-	wm8940_write(codec, WM8940_PLLK3, pll_div.k & 0x1ff);
+	snd_soc_write(codec, WM8940_PLLK1, pll_div.k >> 18);
+	snd_soc_write(codec, WM8940_PLLK2, (pll_div.k >> 9) & 0x1ff);
+	snd_soc_write(codec, WM8940_PLLK3, pll_div.k & 0x1ff);
 	/* Enable the PLL */
-	reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
-	wm8940_write(codec, WM8940_POWER1, reg | 0x020);
+	reg = snd_soc_read(codec, WM8940_POWER1);
+	snd_soc_write(codec, WM8940_POWER1, reg | 0x020);
 
 	/* Run CODEC from PLL instead of MCLK */
-	reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
-	wm8940_write(codec, WM8940_CLOCK, reg | 0x100);
+	reg = snd_soc_read(codec, WM8940_CLOCK);
+	snd_soc_write(codec, WM8940_CLOCK, reg | 0x100);
 
 	return 0;
 }
@@ -648,16 +604,16 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8940_BCLKDIV:
-		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFFEF3;
-		ret = wm8940_write(codec, WM8940_CLOCK, reg | (div << 2));
+		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFEF3;
+		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
 		break;
 	case WM8940_MCLKDIV:
-		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK) & 0xFF1F;
-		ret = wm8940_write(codec, WM8940_CLOCK, reg | (div << 5));
+		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFF1F;
+		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 5));
 		break;
 	case WM8940_OPCLKDIV:
-		reg = wm8940_read_reg_cache(codec, WM8940_ADDCNTRL) & 0xFFCF;
-		ret = wm8940_write(codec, WM8940_ADDCNTRL, reg | (div << 4));
+		reg = snd_soc_read(codec, WM8940_ADDCNTRL) & 0xFFCF;
+		ret = snd_soc_write(codec, WM8940_ADDCNTRL, reg | (div << 4));
 		break;
 	}
 	return ret;
@@ -808,7 +764,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8940 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8940);
 
-static int wm8940_register(struct wm8940_priv *wm8940)
+static int wm8940_register(struct wm8940_priv *wm8940,
+			   enum snd_soc_control_type control)
 {
 	struct wm8940_setup_data *pdata = wm8940->codec.dev->platform_data;
 	struct snd_soc_codec *codec = &wm8940->codec;
@@ -825,8 +782,6 @@ static int wm8940_register(struct wm8940_priv *wm8940)
 	codec->private_data = wm8940;
 	codec->name = "WM8940";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8940_read_reg_cache;
-	codec->write = wm8940_write;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8940_set_bias_level;
 	codec->dai = &wm8940_dai;
@@ -834,6 +789,12 @@ static int wm8940_register(struct wm8940_priv *wm8940)
 	codec->reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults);
 	codec->reg_cache = &wm8940->reg_cache;
 
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	if (ret == 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
 	memcpy(codec->reg_cache, wm8940_reg_defaults,
 	       sizeof(wm8940_reg_defaults));
 
@@ -847,15 +808,15 @@ static int wm8940_register(struct wm8940_priv *wm8940)
 
 	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	ret = wm8940_write(codec, WM8940_POWER1, 0x180);
+	ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
 	if (ret < 0)
 		return ret;
 
 	if (!pdata)
 		dev_warn(codec->dev, "No platform data supplied\n");
 	else {
-		reg = wm8940_read_reg_cache(codec, WM8940_OUTPUTCTL);
-		ret = wm8940_write(codec, WM8940_OUTPUTCTL, reg | pdata->vroi);
+		reg = snd_soc_read(codec, WM8940_OUTPUTCTL);
+		ret = snd_soc_write(codec, WM8940_OUTPUTCTL, reg | pdata->vroi);
 		if (ret < 0)
 			return ret;
 	}
@@ -904,7 +865,7 @@ static int wm8940_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 	codec->dev = &i2c->dev;
 
-	return wm8940_register(wm8940);
+	return wm8940_register(wm8940, SND_SOC_I2C);
 }
 
 static int __devexit wm8940_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index bd1af92..5030320 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -292,9 +292,10 @@ struct wm8961_priv {
 	u16 reg_cache[WM8961_MAX_REGISTER];
 };
 
-static int wm8961_reg_is_volatile(int reg)
+static int wm8961_volatile_register(unsigned int reg)
 {
 	switch (reg) {
+	case WM8961_SOFTWARE_RESET:
 	case WM8961_WRITE_SEQUENCER_7:
 	case WM8961_DC_SERVO_1:
 		return 1;
@@ -304,76 +305,9 @@ static int wm8961_reg_is_volatile(int reg)
 	}
 }
 
-static unsigned int wm8961_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > WM8961_MAX_REGISTER);
-	return cache[reg];
-}
-
-static unsigned int wm8961_read_hw(struct snd_soc_codec *codec, u8 reg)
-{
-	struct i2c_msg xfer[2];
-	u16 data;
-	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	BUG_ON(reg > WM8961_MAX_REGISTER);
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
-		return 0;
-	}
-
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-
-static unsigned int wm8961_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	if (wm8961_reg_is_volatile(reg))
-		return wm8961_read_hw(codec, reg);
-	else
-		return wm8961_read_reg_cache(codec, reg);
-}
-
-static int wm8961_write(struct snd_soc_codec *codec, unsigned int reg,
-			unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	u8 data[3];
-
-	BUG_ON(reg > WM8961_MAX_REGISTER);
-
-	if (!wm8961_reg_is_volatile(reg))
-		cache[reg] = value;
-
-	data[0] = reg;
-	data[1] = value >> 8;
-	data[2] = value & 0x00ff;
-
-	if (codec->hw_write(codec->control_data, data, 3) == 3)
-		return 0;
-	else
-		return -EIO;
-}
-
 static int wm8961_reset(struct snd_soc_codec *codec)
 {
-	return wm8961_write(codec, WM8961_SOFTWARE_RESET, 0);
+	return snd_soc_write(codec, WM8961_SOFTWARE_RESET, 0);
 }
 
 /*
@@ -384,33 +318,33 @@ static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u16 hp_reg = wm8961_read(codec, WM8961_ANALOGUE_HP_0);
-	u16 cp_reg = wm8961_read(codec, WM8961_CHARGE_PUMP_1);
-	u16 pwr_reg = wm8961_read(codec, WM8961_PWR_MGMT_2);
-	u16 dcs_reg = wm8961_read(codec, WM8961_DC_SERVO_1);
+	u16 hp_reg = snd_soc_read(codec, WM8961_ANALOGUE_HP_0);
+	u16 cp_reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_1);
+	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
+	u16 dcs_reg = snd_soc_read(codec, WM8961_DC_SERVO_1);
 	int timeout = 500;
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Make sure the output is shorted */
 		hp_reg &= ~(WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT);
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Enable the charge pump */
 		cp_reg |= WM8961_CP_ENA;
-		wm8961_write(codec, WM8961_CHARGE_PUMP_1, cp_reg);
+		snd_soc_write(codec, WM8961_CHARGE_PUMP_1, cp_reg);
 		mdelay(5);
 
 		/* Enable the PGA */
 		pwr_reg |= WM8961_LOUT1_PGA | WM8961_ROUT1_PGA;
-		wm8961_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Enable the amplifier */
 		hp_reg |= WM8961_HPR_ENA | WM8961_HPL_ENA;
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Second stage enable */
 		hp_reg |= WM8961_HPR_ENA_DLY | WM8961_HPL_ENA_DLY;
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Enable the DC servo & trigger startup */
 		dcs_reg |=
@@ -418,10 +352,10 @@ static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 			WM8961_DCS_ENA_CHAN_HPL | WM8961_DCS_TRIG_STARTUP_HPL;
 		dev_dbg(codec->dev, "Enabling DC servo\n");
 
-		wm8961_write(codec, WM8961_DC_SERVO_1, dcs_reg);
+		snd_soc_write(codec, WM8961_DC_SERVO_1, dcs_reg);
 		do {
 			msleep(1);
-			dcs_reg = wm8961_read(codec, WM8961_DC_SERVO_1);
+			dcs_reg = snd_soc_read(codec, WM8961_DC_SERVO_1);
 		} while (--timeout &&
 			 dcs_reg & (WM8961_DCS_TRIG_STARTUP_HPR |
 				WM8961_DCS_TRIG_STARTUP_HPL));
@@ -433,39 +367,39 @@ static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 
 		/* Enable the output stage */
 		hp_reg |= WM8961_HPR_ENA_OUTP | WM8961_HPL_ENA_OUTP;
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Remove the short on the output stage */
 		hp_reg |= WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT;
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
 		/* Short the output */
 		hp_reg &= ~(WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT);
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable the output stage */
 		hp_reg &= ~(WM8961_HPR_ENA_OUTP | WM8961_HPL_ENA_OUTP);
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable DC offset cancellation */
 		dcs_reg &= ~(WM8961_DCS_ENA_CHAN_HPR |
 			     WM8961_DCS_ENA_CHAN_HPL);
-		wm8961_write(codec, WM8961_DC_SERVO_1, dcs_reg);
+		snd_soc_write(codec, WM8961_DC_SERVO_1, dcs_reg);
 
 		/* Finish up */
 		hp_reg &= ~(WM8961_HPR_ENA_DLY | WM8961_HPR_ENA |
 			    WM8961_HPL_ENA_DLY | WM8961_HPL_ENA);
-		wm8961_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable the PGA */
 		pwr_reg &= ~(WM8961_LOUT1_PGA | WM8961_ROUT1_PGA);
-		wm8961_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Disable the charge pump */
 		dev_dbg(codec->dev, "Disabling charge pump\n");
-		wm8961_write(codec, WM8961_CHARGE_PUMP_1,
+		snd_soc_write(codec, WM8961_CHARGE_PUMP_1,
 			     cp_reg & ~WM8961_CP_ENA);
 	}
 
@@ -476,27 +410,27 @@ static int wm8961_spk_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	u16 pwr_reg = wm8961_read(codec, WM8961_PWR_MGMT_2);
-	u16 spk_reg = wm8961_read(codec, WM8961_CLASS_D_CONTROL_1);
+	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
+	u16 spk_reg = snd_soc_read(codec, WM8961_CLASS_D_CONTROL_1);
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Enable the PGA */
 		pwr_reg |= WM8961_SPKL_PGA | WM8961_SPKR_PGA;
-		wm8961_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Enable the amplifier */
 		spk_reg |= WM8961_SPKL_ENA | WM8961_SPKR_ENA;
-		wm8961_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
+		snd_soc_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
 		/* Enable the amplifier */
 		spk_reg &= ~(WM8961_SPKL_ENA | WM8961_SPKR_ENA);
-		wm8961_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
+		snd_soc_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
 
 		/* Enable the PGA */
 		pwr_reg &= ~(WM8961_SPKL_PGA | WM8961_SPKR_PGA);
-		wm8961_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
 	}
 
 	return 0;
@@ -714,10 +648,10 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 		    abs(wm8961_srate[best].rate - fs))
 			best = i;
 	}
-	reg = wm8961_read(codec, WM8961_ADDITIONAL_CONTROL_3);
+	reg = snd_soc_read(codec, WM8961_ADDITIONAL_CONTROL_3);
 	reg &= ~WM8961_SAMPLE_RATE_MASK;
 	reg |= wm8961_srate[best].val;
-	wm8961_write(codec, WM8961_ADDITIONAL_CONTROL_3, reg);
+	snd_soc_write(codec, WM8961_ADDITIONAL_CONTROL_3, reg);
 	dev_dbg(codec->dev, "Selected SRATE %dHz for %dHz\n",
 		wm8961_srate[best].rate, fs);
 
@@ -747,12 +681,12 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 		wm8961_clk_sys_ratio[i].ratio, wm8961->sysclk, fs,
 		wm8961->sysclk / fs);
 
-	reg = wm8961_read(codec, WM8961_CLOCKING_4);
+	reg = snd_soc_read(codec, WM8961_CLOCKING_4);
 	reg &= ~WM8961_CLK_SYS_RATE_MASK;
 	reg |= wm8961_clk_sys_ratio[i].val << WM8961_CLK_SYS_RATE_SHIFT;
-	wm8961_write(codec, WM8961_CLOCKING_4, reg);
+	snd_soc_write(codec, WM8961_CLOCKING_4, reg);
 
-	reg = wm8961_read(codec, WM8961_AUDIO_INTERFACE_0);
+	reg = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_0);
 	reg &= ~WM8961_WL_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -769,15 +703,15 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	wm8961_write(codec, WM8961_AUDIO_INTERFACE_0, reg);
+	snd_soc_write(codec, WM8961_AUDIO_INTERFACE_0, reg);
 
 	/* Sloping stop-band filter is recommended for <= 24kHz */
-	reg = wm8961_read(codec, WM8961_ADC_DAC_CONTROL_2);
+	reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_2);
 	if (fs <= 24000)
 		reg |= WM8961_DACSLOPE;
 	else
 		reg &= WM8961_DACSLOPE;
-	wm8961_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
+	snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
 
 	return 0;
 }
@@ -788,7 +722,7 @@ static int wm8961_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8961_priv *wm8961 = codec->private_data;
-	u16 reg = wm8961_read(codec, WM8961_CLOCKING1);
+	u16 reg = snd_soc_read(codec, WM8961_CLOCKING1);
 
 	if (freq > 33000000) {
 		dev_err(codec->dev, "MCLK must be <33MHz\n");
@@ -804,7 +738,7 @@ static int wm8961_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		reg &= WM8961_MCLKDIV;
 	}
 
-	wm8961_write(codec, WM8961_CLOCKING1, reg);
+	snd_soc_write(codec, WM8961_CLOCKING1, reg);
 
 	wm8961->sysclk = freq;
 
@@ -814,7 +748,7 @@ static int wm8961_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int wm8961_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 aif = wm8961_read(codec, WM8961_AUDIO_INTERFACE_0);
+	u16 aif = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_0);
 
 	aif &= ~(WM8961_BCLKINV | WM8961_LRP |
 		 WM8961_MS | WM8961_FORMAT_MASK);
@@ -874,26 +808,26 @@ static int wm8961_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	return wm8961_write(codec, WM8961_AUDIO_INTERFACE_0, aif);
+	return snd_soc_write(codec, WM8961_AUDIO_INTERFACE_0, aif);
 }
 
 static int wm8961_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = wm8961_read(codec, WM8961_ADDITIONAL_CONTROL_2);
+	u16 reg = snd_soc_read(codec, WM8961_ADDITIONAL_CONTROL_2);
 
 	if (tristate)
 		reg |= WM8961_TRIS;
 	else
 		reg &= ~WM8961_TRIS;
 
-	return wm8961_write(codec, WM8961_ADDITIONAL_CONTROL_2, reg);
+	return snd_soc_write(codec, WM8961_ADDITIONAL_CONTROL_2, reg);
 }
 
 static int wm8961_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = wm8961_read(codec, WM8961_ADC_DAC_CONTROL_1);
+	u16 reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_1);
 
 	if (mute)
 		reg |= WM8961_DACMU;
@@ -902,7 +836,7 @@ static int wm8961_digital_mute(struct snd_soc_dai *dai, int mute)
 
 	msleep(17);
 
-	return wm8961_write(codec, WM8961_ADC_DAC_CONTROL_1, reg);
+	return snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_1, reg);
 }
 
 static int wm8961_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
@@ -912,17 +846,17 @@ static int wm8961_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
 
 	switch (div_id) {
 	case WM8961_BCLK:
-		reg = wm8961_read(codec, WM8961_CLOCKING2);
+		reg = snd_soc_read(codec, WM8961_CLOCKING2);
 		reg &= ~WM8961_BCLKDIV_MASK;
 		reg |= div;
-		wm8961_write(codec, WM8961_CLOCKING2, reg);
+		snd_soc_write(codec, WM8961_CLOCKING2, reg);
 		break;
 
 	case WM8961_LRCLK:
-		reg = wm8961_read(codec, WM8961_AUDIO_INTERFACE_2);
+		reg = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_2);
 		reg &= ~WM8961_LRCLK_RATE_MASK;
 		reg |= div;
-		wm8961_write(codec, WM8961_AUDIO_INTERFACE_2, reg);
+		snd_soc_write(codec, WM8961_AUDIO_INTERFACE_2, reg);
 		break;
 
 	default:
@@ -949,34 +883,34 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		if (codec->bias_level == SND_SOC_BIAS_STANDBY) {
 			/* Enable bias generation */
-			reg = wm8961_read(codec, WM8961_ANTI_POP);
+			reg = snd_soc_read(codec, WM8961_ANTI_POP);
 			reg |= WM8961_BUFIOEN | WM8961_BUFDCOPEN;
-			wm8961_write(codec, WM8961_ANTI_POP, reg);
+			snd_soc_write(codec, WM8961_ANTI_POP, reg);
 
 			/* VMID=2*50k, VREF */
-			reg = wm8961_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VMIDSEL_MASK;
 			reg |= (1 << WM8961_VMIDSEL_SHIFT) | WM8961_VREF;
-			wm8961_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
 		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_PREPARE) {
 			/* VREF off */
-			reg = wm8961_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VREF;
-			wm8961_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
 
 			/* Bias generation off */
-			reg = wm8961_read(codec, WM8961_ANTI_POP);
+			reg = snd_soc_read(codec, WM8961_ANTI_POP);
 			reg &= ~(WM8961_BUFIOEN | WM8961_BUFDCOPEN);
-			wm8961_write(codec, WM8961_ANTI_POP, reg);
+			snd_soc_write(codec, WM8961_ANTI_POP, reg);
 
 			/* VMID off */
-			reg = wm8961_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VMIDSEL_MASK;
-			wm8961_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
 		}
 		break;
 
@@ -1101,7 +1035,7 @@ static int wm8961_resume(struct platform_device *pdev)
 		if (i == WM8961_SOFTWARE_RESET)
 			continue;
 
-		wm8961_write(codec, i, reg_cache[i]);
+		snd_soc_write(codec, i, reg_cache[i]);
 	}
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1140,26 +1074,32 @@ static int wm8961_register(struct wm8961_priv *wm8961)
 	codec->private_data = wm8961;
 	codec->name = "WM8961";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8961_read;
-	codec->write = wm8961_write;
 	codec->dai = &wm8961_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = ARRAY_SIZE(wm8961->reg_cache);
 	codec->reg_cache = &wm8961->reg_cache;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8961_set_bias_level;
+	codec->volatile_register = wm8961_volatile_register;
 
 	memcpy(codec->reg_cache, wm8961_reg_defaults,
 	       sizeof(wm8961_reg_defaults));
 
-	reg = wm8961_read_hw(codec, WM8961_SOFTWARE_RESET);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	reg = snd_soc_read(codec, WM8961_SOFTWARE_RESET);
 	if (reg != 0x1801) {
 		dev_err(codec->dev, "Device is not a WM8961: ID=0x%x\n", reg);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	reg = wm8961_read_hw(codec, WM8961_RIGHT_INPUT_VOLUME);
+	/* This isn't volatile - readback doesn't correspond to write */
+	reg = codec->hw_read(codec, WM8961_RIGHT_INPUT_VOLUME);
 	dev_info(codec->dev, "WM8961 family %d revision %c\n",
 		 (reg & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
 		 ((reg & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
@@ -1172,37 +1112,37 @@ static int wm8961_register(struct wm8961_priv *wm8961)
 	}
 
 	/* Enable class W */
-	reg = wm8961_read(codec, WM8961_CHARGE_PUMP_B);
+	reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_B);
 	reg |= WM8961_CP_DYN_PWR_MASK;
-	wm8961_write(codec, WM8961_CHARGE_PUMP_B, reg);
+	snd_soc_write(codec, WM8961_CHARGE_PUMP_B, reg);
 
 	/* Latch volume update bits (right channel only, we always
 	 * write both out) and default ZC on. */
-	reg = wm8961_read(codec, WM8961_ROUT1_VOLUME);
-	wm8961_write(codec, WM8961_ROUT1_VOLUME,
+	reg = snd_soc_read(codec, WM8961_ROUT1_VOLUME);
+	snd_soc_write(codec, WM8961_ROUT1_VOLUME,
 		     reg | WM8961_LO1ZC | WM8961_OUT1VU);
-	wm8961_write(codec, WM8961_LOUT1_VOLUME, reg | WM8961_LO1ZC);
-	reg = wm8961_read(codec, WM8961_ROUT2_VOLUME);
-	wm8961_write(codec, WM8961_ROUT2_VOLUME,
+	snd_soc_write(codec, WM8961_LOUT1_VOLUME, reg | WM8961_LO1ZC);
+	reg = snd_soc_read(codec, WM8961_ROUT2_VOLUME);
+	snd_soc_write(codec, WM8961_ROUT2_VOLUME,
 		     reg | WM8961_SPKRZC | WM8961_SPKVU);
-	wm8961_write(codec, WM8961_LOUT2_VOLUME, reg | WM8961_SPKLZC);
+	snd_soc_write(codec, WM8961_LOUT2_VOLUME, reg | WM8961_SPKLZC);
 
-	reg = wm8961_read(codec, WM8961_RIGHT_ADC_VOLUME);
-	wm8961_write(codec, WM8961_RIGHT_ADC_VOLUME, reg | WM8961_ADCVU);
-	reg = wm8961_read(codec, WM8961_RIGHT_INPUT_VOLUME);
-	wm8961_write(codec, WM8961_RIGHT_INPUT_VOLUME, reg | WM8961_IPVU);
+	reg = snd_soc_read(codec, WM8961_RIGHT_ADC_VOLUME);
+	snd_soc_write(codec, WM8961_RIGHT_ADC_VOLUME, reg | WM8961_ADCVU);
+	reg = snd_soc_read(codec, WM8961_RIGHT_INPUT_VOLUME);
+	snd_soc_write(codec, WM8961_RIGHT_INPUT_VOLUME, reg | WM8961_IPVU);
 
 	/* Use soft mute by default */
-	reg = wm8961_read(codec, WM8961_ADC_DAC_CONTROL_2);
+	reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_2);
 	reg |= WM8961_DACSMM;
-	wm8961_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
+	snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
 
 	/* Use automatic clocking mode by default; for now this is all
 	 * we support.
 	 */
-	reg = wm8961_read(codec, WM8961_CLOCKING_3);
+	reg = snd_soc_read(codec, WM8961_CLOCKING_3);
 	reg &= ~WM8961_MANUAL_MODE;
-	wm8961_write(codec, WM8961_CLOCKING_3, reg);
+	snd_soc_write(codec, WM8961_CLOCKING_3, reg);
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1250,7 +1190,6 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	codec = &wm8961->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	i2c_set_clientdata(i2c, wm8961);
 	codec->control_data = i2c;
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index d029818..2d702db 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -108,53 +108,7 @@ static const u16 wm8990_reg[] = {
 	0x0000,	    /* R63 - Driver internal */
 };
 
-/*
- * read wm8990 register cache
- */
-static inline unsigned int wm8990_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg >= ARRAY_SIZE(wm8990_reg));
-	return cache[reg];
-}
-
-/*
- * write wm8990 register cache
- */
-static inline void wm8990_write_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-
-	/* Reset register and reserved registers are uncached */
-	if (reg == 0 || reg >= ARRAY_SIZE(wm8990_reg))
-		return;
-
-	cache[reg] = value;
-}
-
-/*
- * write to the wm8990 register space
- */
-static int wm8990_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[3];
-
-	data[0] = reg & 0xFF;
-	data[1] = (value >> 8) & 0xFF;
-	data[2] = value & 0xFF;
-
-	wm8990_write_reg_cache(codec, reg, value);
-
-	if (codec->hw_write(codec->control_data, data, 3) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-#define wm8990_reset(c) wm8990_write(c, WM8990_RESET, 0)
+#define wm8990_reset(c) snd_soc_write(c, WM8990_RESET, 0)
 
 static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
 
@@ -187,8 +141,8 @@ static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	/* now hit the volume update bits (always bit 8) */
-	val = wm8990_read_reg_cache(codec, reg);
-	return wm8990_write(codec, reg, val | 0x0100);
+	val = snd_soc_read(codec, reg);
+	return snd_soc_write(codec, reg, val | 0x0100);
 }
 
 #define SOC_WM899X_OUTPGA_SINGLE_R_TLV(xname, reg, shift, max, invert,\
@@ -427,8 +381,8 @@ static int inmixer_event(struct snd_soc_dapm_widget *w,
 {
 	u16 reg, fakepower;
 
-	reg = wm8990_read_reg_cache(w->codec, WM8990_POWER_MANAGEMENT_2);
-	fakepower = wm8990_read_reg_cache(w->codec, WM8990_INTDRIVBITS);
+	reg = snd_soc_read(w->codec, WM8990_POWER_MANAGEMENT_2);
+	fakepower = snd_soc_read(w->codec, WM8990_INTDRIVBITS);
 
 	if (fakepower & ((1 << WM8990_INMIXL_PWR_BIT) |
 		(1 << WM8990_AINLMUX_PWR_BIT))) {
@@ -443,7 +397,7 @@ static int inmixer_event(struct snd_soc_dapm_widget *w,
 	} else {
 		reg &= ~WM8990_AINL_ENA;
 	}
-	wm8990_write(w->codec, WM8990_POWER_MANAGEMENT_2, reg);
+	snd_soc_write(w->codec, WM8990_POWER_MANAGEMENT_2, reg);
 
 	return 0;
 }
@@ -457,7 +411,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 
 	switch (reg_shift) {
 	case WM8990_SPEAKER_MIXER | (WM8990_LDSPK_BIT << 8) :
-		reg = wm8990_read_reg_cache(w->codec, WM8990_OUTPUT_MIXER1);
+		reg = snd_soc_read(w->codec, WM8990_OUTPUT_MIXER1);
 		if (reg & WM8990_LDLO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 1 LDLO Set\n");
@@ -465,7 +419,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_SPEAKER_MIXER | (WM8990_RDSPK_BIT << 8):
-		reg = wm8990_read_reg_cache(w->codec, WM8990_OUTPUT_MIXER2);
+		reg = snd_soc_read(w->codec, WM8990_OUTPUT_MIXER2);
 		if (reg & WM8990_RDRO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 2 RDRO Set\n");
@@ -473,7 +427,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_OUTPUT_MIXER1 | (WM8990_LDLO_BIT << 8):
-		reg = wm8990_read_reg_cache(w->codec, WM8990_SPEAKER_MIXER);
+		reg = snd_soc_read(w->codec, WM8990_SPEAKER_MIXER);
 		if (reg & WM8990_LDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer LDSPK Set\n");
@@ -481,7 +435,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_OUTPUT_MIXER2 | (WM8990_RDRO_BIT << 8):
-		reg = wm8990_read_reg_cache(w->codec, WM8990_SPEAKER_MIXER);
+		reg = snd_soc_read(w->codec, WM8990_SPEAKER_MIXER);
 		if (reg & WM8990_RDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer RDSPK Set\n");
@@ -1029,24 +983,24 @@ static int wm8990_set_dai_pll(struct snd_soc_dai *codec_dai,
 		pll_factors(&pll_div, freq_out * 4, freq_in);
 
 		/* Turn on PLL */
-		reg = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_2);
+		reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
 		reg |= WM8990_PLL_ENA;
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
 
 		/* sysclk comes from PLL */
-		reg = wm8990_read_reg_cache(codec, WM8990_CLOCKING_2);
-		wm8990_write(codec, WM8990_CLOCKING_2, reg | WM8990_SYSCLK_SRC);
+		reg = snd_soc_read(codec, WM8990_CLOCKING_2);
+		snd_soc_write(codec, WM8990_CLOCKING_2, reg | WM8990_SYSCLK_SRC);
 
 		/* set up N , fractional mode and pre-divisor if neccessary */
-		wm8990_write(codec, WM8990_PLL1, pll_div.n | WM8990_SDM |
+		snd_soc_write(codec, WM8990_PLL1, pll_div.n | WM8990_SDM |
 			(pll_div.div2?WM8990_PRESCALE:0));
-		wm8990_write(codec, WM8990_PLL2, (u8)(pll_div.k>>8));
-		wm8990_write(codec, WM8990_PLL3, (u8)(pll_div.k & 0xFF));
+		snd_soc_write(codec, WM8990_PLL2, (u8)(pll_div.k>>8));
+		snd_soc_write(codec, WM8990_PLL3, (u8)(pll_div.k & 0xFF));
 	} else {
 		/* Turn on PLL */
-		reg = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_2);
+		reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
 		reg &= ~WM8990_PLL_ENA;
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg);
 	}
 	return 0;
 }
@@ -1073,8 +1027,8 @@ static int wm8990_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 audio1, audio3;
 
-	audio1 = wm8990_read_reg_cache(codec, WM8990_AUDIO_INTERFACE_1);
-	audio3 = wm8990_read_reg_cache(codec, WM8990_AUDIO_INTERFACE_3);
+	audio1 = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_1);
+	audio3 = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_3);
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1115,8 +1069,8 @@ static int wm8990_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8990_write(codec, WM8990_AUDIO_INTERFACE_1, audio1);
-	wm8990_write(codec, WM8990_AUDIO_INTERFACE_3, audio3);
+	snd_soc_write(codec, WM8990_AUDIO_INTERFACE_1, audio1);
+	snd_soc_write(codec, WM8990_AUDIO_INTERFACE_3, audio3);
 	return 0;
 }
 
@@ -1128,24 +1082,24 @@ static int wm8990_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8990_MCLK_DIV:
-		reg = wm8990_read_reg_cache(codec, WM8990_CLOCKING_2) &
+		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
 			~WM8990_MCLK_DIV_MASK;
-		wm8990_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
 		break;
 	case WM8990_DACCLK_DIV:
-		reg = wm8990_read_reg_cache(codec, WM8990_CLOCKING_2) &
+		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
 			~WM8990_DAC_CLKDIV_MASK;
-		wm8990_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
 		break;
 	case WM8990_ADCCLK_DIV:
-		reg = wm8990_read_reg_cache(codec, WM8990_CLOCKING_2) &
+		reg = snd_soc_read(codec, WM8990_CLOCKING_2) &
 			~WM8990_ADC_CLKDIV_MASK;
-		wm8990_write(codec, WM8990_CLOCKING_2, reg | div);
+		snd_soc_write(codec, WM8990_CLOCKING_2, reg | div);
 		break;
 	case WM8990_BCLK_DIV:
-		reg = wm8990_read_reg_cache(codec, WM8990_CLOCKING_1) &
+		reg = snd_soc_read(codec, WM8990_CLOCKING_1) &
 			~WM8990_BCLK_DIV_MASK;
-		wm8990_write(codec, WM8990_CLOCKING_1, reg | div);
+		snd_soc_write(codec, WM8990_CLOCKING_1, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -1164,7 +1118,7 @@ static int wm8990_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 audio1 = wm8990_read_reg_cache(codec, WM8990_AUDIO_INTERFACE_1);
+	u16 audio1 = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8990_AIF_WL_MASK;
 	/* bit size */
@@ -1182,7 +1136,7 @@ static int wm8990_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8990_write(codec, WM8990_AUDIO_INTERFACE_1, audio1);
+	snd_soc_write(codec, WM8990_AUDIO_INTERFACE_1, audio1);
 	return 0;
 }
 
@@ -1191,12 +1145,12 @@ static int wm8990_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_codec *codec = dai->codec;
 	u16 val;
 
-	val  = wm8990_read_reg_cache(codec, WM8990_DAC_CTRL) & ~WM8990_DAC_MUTE;
+	val  = snd_soc_read(codec, WM8990_DAC_CTRL) & ~WM8990_DAC_MUTE;
 
 	if (mute)
-		wm8990_write(codec, WM8990_DAC_CTRL, val | WM8990_DAC_MUTE);
+		snd_soc_write(codec, WM8990_DAC_CTRL, val | WM8990_DAC_MUTE);
 	else
-		wm8990_write(codec, WM8990_DAC_CTRL, val);
+		snd_soc_write(codec, WM8990_DAC_CTRL, val);
 
 	return 0;
 }
@@ -1212,21 +1166,21 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*50k */
-		val = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_1) &
+		val = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_1) &
 			~WM8990_VMID_MODE_MASK;
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x2);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x2);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Enable all output discharge bits */
-			wm8990_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
+			snd_soc_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
 				WM8990_DIS_RLINE | WM8990_DIS_OUT3 |
 				WM8990_DIS_OUT4 | WM8990_DIS_LOUT |
 				WM8990_DIS_ROUT);
 
 			/* Enable POBCTRL, SOFT_ST, VMIDTOG and BUFDCOPEN */
-			wm8990_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
+			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
 				     WM8990_BUFDCOPEN | WM8990_POBCTRL |
 				     WM8990_VMIDTOG);
 
@@ -1234,83 +1188,83 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 			msleep(msecs_to_jiffies(300));
 
 			/* Disable VMIDTOG */
-			wm8990_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
+			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
 				     WM8990_BUFDCOPEN | WM8990_POBCTRL);
 
 			/* disable all output discharge bits */
-			wm8990_write(codec, WM8990_ANTIPOP1, 0);
+			snd_soc_write(codec, WM8990_ANTIPOP1, 0);
 
 			/* Enable outputs */
-			wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1b00);
+			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1b00);
 
 			msleep(msecs_to_jiffies(50));
 
 			/* Enable VMID at 2x50k */
-			wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f02);
+			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f02);
 
 			msleep(msecs_to_jiffies(100));
 
 			/* Enable VREF */
-			wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
+			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
 
 			msleep(msecs_to_jiffies(600));
 
 			/* Enable BUFIOEN */
-			wm8990_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
+			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
 				     WM8990_BUFDCOPEN | WM8990_POBCTRL |
 				     WM8990_BUFIOEN);
 
 			/* Disable outputs */
-			wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x3);
+			snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x3);
 
 			/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-			wm8990_write(codec, WM8990_ANTIPOP2, WM8990_BUFIOEN);
+			snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_BUFIOEN);
 
 			/* Enable workaround for ADC clocking issue. */
-			wm8990_write(codec, WM8990_EXT_ACCESS_ENA, 0x2);
-			wm8990_write(codec, WM8990_EXT_CTL1, 0xa003);
-			wm8990_write(codec, WM8990_EXT_ACCESS_ENA, 0);
+			snd_soc_write(codec, WM8990_EXT_ACCESS_ENA, 0x2);
+			snd_soc_write(codec, WM8990_EXT_CTL1, 0xa003);
+			snd_soc_write(codec, WM8990_EXT_ACCESS_ENA, 0);
 		}
 
 		/* VMID=2*250k */
-		val = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_1) &
+		val = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_1) &
 			~WM8990_VMID_MODE_MASK;
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x4);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, val | 0x4);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Enable POBCTRL and SOFT_ST */
-		wm8990_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
+		snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
 			WM8990_POBCTRL | WM8990_BUFIOEN);
 
 		/* Enable POBCTRL, SOFT_ST and BUFDCOPEN */
-		wm8990_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
+		snd_soc_write(codec, WM8990_ANTIPOP2, WM8990_SOFTST |
 			WM8990_BUFDCOPEN | WM8990_POBCTRL |
 			WM8990_BUFIOEN);
 
 		/* mute DAC */
-		val = wm8990_read_reg_cache(codec, WM8990_DAC_CTRL);
-		wm8990_write(codec, WM8990_DAC_CTRL, val | WM8990_DAC_MUTE);
+		val = snd_soc_read(codec, WM8990_DAC_CTRL);
+		snd_soc_write(codec, WM8990_DAC_CTRL, val | WM8990_DAC_MUTE);
 
 		/* Enable any disabled outputs */
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f03);
 
 		/* Disable VMID */
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f01);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x1f01);
 
 		msleep(msecs_to_jiffies(300));
 
 		/* Enable all output discharge bits */
-		wm8990_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
+		snd_soc_write(codec, WM8990_ANTIPOP1, WM8990_DIS_LLINE |
 			WM8990_DIS_RLINE | WM8990_DIS_OUT3 |
 			WM8990_DIS_OUT4 | WM8990_DIS_LOUT |
 			WM8990_DIS_ROUT);
 
 		/* Disable VREF */
-		wm8990_write(codec, WM8990_POWER_MANAGEMENT_1, 0x0);
+		snd_soc_write(codec, WM8990_POWER_MANAGEMENT_1, 0x0);
 
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-		wm8990_write(codec, WM8990_ANTIPOP2, 0x0);
+		snd_soc_write(codec, WM8990_ANTIPOP2, 0x0);
 		break;
 	}
 
@@ -1411,8 +1365,6 @@ static int wm8990_init(struct snd_soc_device *socdev)
 
 	codec->name = "WM8990";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8990_read_reg_cache;
-	codec->write = wm8990_write;
 	codec->set_bias_level = wm8990_set_bias_level;
 	codec->dai = &wm8990_dai;
 	codec->num_dai = 2;
@@ -1422,6 +1374,12 @@ static int wm8990_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8990: failed to set cache I/O: %d\n", ret);
+		goto pcm_err;
+	}
+
 	wm8990_reset(codec);
 
 	/* register pcms */
@@ -1435,18 +1393,18 @@ static int wm8990_init(struct snd_soc_device *socdev)
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	reg = wm8990_read_reg_cache(codec, WM8990_AUDIO_INTERFACE_4);
-	wm8990_write(codec, WM8990_AUDIO_INTERFACE_4, reg | WM8990_ALRCGPIO1);
+	reg = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_4);
+	snd_soc_write(codec, WM8990_AUDIO_INTERFACE_4, reg | WM8990_ALRCGPIO1);
 
-	reg = wm8990_read_reg_cache(codec, WM8990_GPIO1_GPIO2) &
+	reg = snd_soc_read(codec, WM8990_GPIO1_GPIO2) &
 		~WM8990_GPIO1_SEL_MASK;
-	wm8990_write(codec, WM8990_GPIO1_GPIO2, reg | 1);
+	snd_soc_write(codec, WM8990_GPIO1_GPIO2, reg | 1);
 
-	reg = wm8990_read_reg_cache(codec, WM8990_POWER_MANAGEMENT_2);
-	wm8990_write(codec, WM8990_POWER_MANAGEMENT_2, reg | WM8990_OPCLK_ENA);
+	reg = snd_soc_read(codec, WM8990_POWER_MANAGEMENT_2);
+	snd_soc_write(codec, WM8990_POWER_MANAGEMENT_2, reg | WM8990_OPCLK_ENA);
 
-	wm8990_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
-	wm8990_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
+	snd_soc_write(codec, WM8990_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
+	snd_soc_write(codec, WM8990_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
 	snd_soc_add_controls(codec, wm8990_snd_controls,
 				ARRAY_SIZE(wm8990_snd_controls));
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index dbe2059..dc383c2 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -168,84 +168,19 @@ struct wm9081_priv {
 	struct wm9081_retune_mobile_config *retune;
 };
 
-static int wm9081_reg_is_volatile(int reg)
+static int wm9081_volatile_register(unsigned int reg)
 {
 	switch (reg) {
+	case WM9081_SOFTWARE_RESET:
+		return 1;
 	default:
 		return 0;
 	}
 }
 
-static unsigned int wm9081_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > WM9081_MAX_REGISTER);
-	return cache[reg];
-}
-
-static unsigned int wm9081_read_hw(struct snd_soc_codec *codec, u8 reg)
-{
-	struct i2c_msg xfer[2];
-	u16 data;
-	int ret;
-	struct i2c_client *client = codec->control_data;
-
-	BUG_ON(reg > WM9081_MAX_REGISTER);
-
-	/* Write register */
-	xfer[0].addr = client->addr;
-	xfer[0].flags = 0;
-	xfer[0].len = 1;
-	xfer[0].buf = &reg;
-
-	/* Read data */
-	xfer[1].addr = client->addr;
-	xfer[1].flags = I2C_M_RD;
-	xfer[1].len = 2;
-	xfer[1].buf = (u8 *)&data;
-
-	ret = i2c_transfer(client->adapter, xfer, 2);
-	if (ret != 2) {
-		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
-		return 0;
-	}
-
-	return (data >> 8) | ((data & 0xff) << 8);
-}
-
-static unsigned int wm9081_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	if (wm9081_reg_is_volatile(reg))
-		return wm9081_read_hw(codec, reg);
-	else
-		return wm9081_read_reg_cache(codec, reg);
-}
-
-static int wm9081_write(struct snd_soc_codec *codec, unsigned int reg,
-			unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-	u8 data[3];
-
-	BUG_ON(reg > WM9081_MAX_REGISTER);
-
-	if (!wm9081_reg_is_volatile(reg))
-		cache[reg] = value;
-
-	data[0] = reg;
-	data[1] = value >> 8;
-	data[2] = value & 0x00ff;
-
-	if (codec->hw_write(codec->control_data, data, 3) == 3)
-		return 0;
-	else
-		return -EIO;
-}
-
 static int wm9081_reset(struct snd_soc_codec *codec)
 {
-	return wm9081_write(codec, WM9081_SOFTWARE_RESET, 0);
+	return snd_soc_write(codec, WM9081_SOFTWARE_RESET, 0);
 }
 
 static const DECLARE_TLV_DB_SCALE(drc_in_tlv, -4500, 75, 0);
@@ -356,7 +291,7 @@ static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg;
 
-	reg = wm9081_read(codec, WM9081_ANALOGUE_SPEAKER_2);
+	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 	if (reg & WM9081_SPK_MODE)
 		ucontrol->value.integer.value[0] = 1;
 	else
@@ -375,8 +310,8 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int reg_pwr = wm9081_read(codec, WM9081_POWER_MANAGEMENT);
-	unsigned int reg2 = wm9081_read(codec, WM9081_ANALOGUE_SPEAKER_2);
+	unsigned int reg_pwr = snd_soc_read(codec, WM9081_POWER_MANAGEMENT);
+	unsigned int reg2 = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 
 	/* Are we changing anything? */
 	if (ucontrol->value.integer.value[0] ==
@@ -397,7 +332,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 		reg2 &= ~WM9081_SPK_MODE;
 	}
 
-	wm9081_write(codec, WM9081_ANALOGUE_SPEAKER_2, reg2);
+	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_2, reg2);
 
 	return 0;
 }
@@ -456,7 +391,7 @@ static int speaker_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	unsigned int reg = wm9081_read(codec, WM9081_POWER_MANAGEMENT);
+	unsigned int reg = snd_soc_read(codec, WM9081_POWER_MANAGEMENT);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -468,7 +403,7 @@ static int speaker_event(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	wm9081_write(codec, WM9081_POWER_MANAGEMENT, reg);
+	snd_soc_write(codec, WM9081_POWER_MANAGEMENT, reg);
 
 	return 0;
 }
@@ -607,7 +542,7 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 	if (ret != 0)
 		return ret;
 
-	reg5 = wm9081_read(codec, WM9081_FLL_CONTROL_5);
+	reg5 = snd_soc_read(codec, WM9081_FLL_CONTROL_5);
 	reg5 &= ~WM9081_FLL_CLK_SRC_MASK;
 
 	switch (fll_id) {
@@ -621,44 +556,44 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 	}
 
 	/* Disable CLK_SYS while we reconfigure */
-	clk_sys_reg = wm9081_read(codec, WM9081_CLOCK_CONTROL_3);
+	clk_sys_reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_3);
 	if (clk_sys_reg & WM9081_CLK_SYS_ENA)
-		wm9081_write(codec, WM9081_CLOCK_CONTROL_3,
+		snd_soc_write(codec, WM9081_CLOCK_CONTROL_3,
 			     clk_sys_reg & ~WM9081_CLK_SYS_ENA);
 
 	/* Any FLL configuration change requires that the FLL be
 	 * disabled first. */
-	reg1 = wm9081_read(codec, WM9081_FLL_CONTROL_1);
+	reg1 = snd_soc_read(codec, WM9081_FLL_CONTROL_1);
 	reg1 &= ~WM9081_FLL_ENA;
-	wm9081_write(codec, WM9081_FLL_CONTROL_1, reg1);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1);
 
 	/* Apply the configuration */
 	if (fll_div.k)
 		reg1 |= WM9081_FLL_FRAC_MASK;
 	else
 		reg1 &= ~WM9081_FLL_FRAC_MASK;
-	wm9081_write(codec, WM9081_FLL_CONTROL_1, reg1);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1);
 
-	wm9081_write(codec, WM9081_FLL_CONTROL_2,
+	snd_soc_write(codec, WM9081_FLL_CONTROL_2,
 		     (fll_div.fll_outdiv << WM9081_FLL_OUTDIV_SHIFT) |
 		     (fll_div.fll_fratio << WM9081_FLL_FRATIO_SHIFT));
-	wm9081_write(codec, WM9081_FLL_CONTROL_3, fll_div.k);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_3, fll_div.k);
 
-	reg4 = wm9081_read(codec, WM9081_FLL_CONTROL_4);
+	reg4 = snd_soc_read(codec, WM9081_FLL_CONTROL_4);
 	reg4 &= ~WM9081_FLL_N_MASK;
 	reg4 |= fll_div.n << WM9081_FLL_N_SHIFT;
-	wm9081_write(codec, WM9081_FLL_CONTROL_4, reg4);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_4, reg4);
 
 	reg5 &= ~WM9081_FLL_CLK_REF_DIV_MASK;
 	reg5 |= fll_div.fll_clk_ref_div << WM9081_FLL_CLK_REF_DIV_SHIFT;
-	wm9081_write(codec, WM9081_FLL_CONTROL_5, reg5);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_5, reg5);
 
 	/* Enable the FLL */
-	wm9081_write(codec, WM9081_FLL_CONTROL_1, reg1 | WM9081_FLL_ENA);
+	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1 | WM9081_FLL_ENA);
 
 	/* Then bring CLK_SYS up again if it was disabled */
 	if (clk_sys_reg & WM9081_CLK_SYS_ENA)
-		wm9081_write(codec, WM9081_CLOCK_CONTROL_3, clk_sys_reg);
+		snd_soc_write(codec, WM9081_CLOCK_CONTROL_3, clk_sys_reg);
 
 	dev_dbg(codec->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
 
@@ -734,19 +669,19 @@ static int configure_clock(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	reg = wm9081_read(codec, WM9081_CLOCK_CONTROL_1);
+	reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_1);
 	if (mclkdiv)
 		reg |= WM9081_MCLKDIV2;
 	else
 		reg &= ~WM9081_MCLKDIV2;
-	wm9081_write(codec, WM9081_CLOCK_CONTROL_1, reg);
+	snd_soc_write(codec, WM9081_CLOCK_CONTROL_1, reg);
 
-	reg = wm9081_read(codec, WM9081_CLOCK_CONTROL_3);
+	reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_3);
 	if (fll)
 		reg |= WM9081_CLK_SRC_SEL;
 	else
 		reg &= ~WM9081_CLK_SRC_SEL;
-	wm9081_write(codec, WM9081_CLOCK_CONTROL_3, reg);
+	snd_soc_write(codec, WM9081_CLOCK_CONTROL_3, reg);
 
 	dev_dbg(codec->dev, "CLK_SYS is %dHz\n", wm9081->sysclk_rate);
 
@@ -846,76 +781,76 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*40k */
-		reg = wm9081_read(codec, WM9081_VMID_CONTROL);
+		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
 		reg &= ~WM9081_VMID_SEL_MASK;
 		reg |= 0x2;
-		wm9081_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 		/* Normal bias current */
-		reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg &= ~WM9081_STBY_BIAS_ENA;
-		wm9081_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Initial cold start */
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Disable LINEOUT discharge */
-			reg = wm9081_read(codec, WM9081_ANTI_POP_CONTROL);
+			reg = snd_soc_read(codec, WM9081_ANTI_POP_CONTROL);
 			reg &= ~WM9081_LINEOUT_DISCH;
-			wm9081_write(codec, WM9081_ANTI_POP_CONTROL, reg);
+			snd_soc_write(codec, WM9081_ANTI_POP_CONTROL, reg);
 
 			/* Select startup bias source */
-			reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+			reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 			reg |= WM9081_BIAS_SRC | WM9081_BIAS_ENA;
-			wm9081_write(codec, WM9081_BIAS_CONTROL_1, reg);
+			snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 
 			/* VMID 2*4k; Soft VMID ramp enable */
-			reg = wm9081_read(codec, WM9081_VMID_CONTROL);
+			reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
 			reg |= WM9081_VMID_RAMP | 0x6;
-			wm9081_write(codec, WM9081_VMID_CONTROL, reg);
+			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 			mdelay(100);
 
 			/* Normal bias enable & soft start off */
 			reg |= WM9081_BIAS_ENA;
 			reg &= ~WM9081_VMID_RAMP;
-			wm9081_write(codec, WM9081_VMID_CONTROL, reg);
+			snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 			/* Standard bias source */
-			reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+			reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 			reg &= ~WM9081_BIAS_SRC;
-			wm9081_write(codec, WM9081_BIAS_CONTROL_1, reg);
+			snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 		}
 
 		/* VMID 2*240k */
-		reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg &= ~WM9081_VMID_SEL_MASK;
 		reg |= 0x40;
-		wm9081_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 		/* Standby bias current on */
-		reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg |= WM9081_STBY_BIAS_ENA;
-		wm9081_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Startup bias source */
-		reg = wm9081_read(codec, WM9081_BIAS_CONTROL_1);
+		reg = snd_soc_read(codec, WM9081_BIAS_CONTROL_1);
 		reg |= WM9081_BIAS_SRC;
-		wm9081_write(codec, WM9081_BIAS_CONTROL_1, reg);
+		snd_soc_write(codec, WM9081_BIAS_CONTROL_1, reg);
 
 		/* Disable VMID and biases with soft ramping */
-		reg = wm9081_read(codec, WM9081_VMID_CONTROL);
+		reg = snd_soc_read(codec, WM9081_VMID_CONTROL);
 		reg &= ~(WM9081_VMID_SEL_MASK | WM9081_BIAS_ENA);
 		reg |= WM9081_VMID_RAMP;
-		wm9081_write(codec, WM9081_VMID_CONTROL, reg);
+		snd_soc_write(codec, WM9081_VMID_CONTROL, reg);
 
 		/* Actively discharge LINEOUT */
-		reg = wm9081_read(codec, WM9081_ANTI_POP_CONTROL);
+		reg = snd_soc_read(codec, WM9081_ANTI_POP_CONTROL);
 		reg |= WM9081_LINEOUT_DISCH;
-		wm9081_write(codec, WM9081_ANTI_POP_CONTROL, reg);
+		snd_soc_write(codec, WM9081_ANTI_POP_CONTROL, reg);
 		break;
 	}
 
@@ -929,7 +864,7 @@ static int wm9081_set_dai_fmt(struct snd_soc_dai *dai,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm9081_priv *wm9081 = codec->private_data;
-	unsigned int aif2 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_2);
+	unsigned int aif2 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_2);
 
 	aif2 &= ~(WM9081_AIF_BCLK_INV | WM9081_AIF_LRCLK_INV |
 		  WM9081_BCLK_DIR | WM9081_LRCLK_DIR | WM9081_AIF_FMT_MASK);
@@ -1010,7 +945,7 @@ static int wm9081_set_dai_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	wm9081_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
+	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
 
 	return 0;
 }
@@ -1024,18 +959,18 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 	int ret, i, best, best_val, cur_val;
 	unsigned int clk_ctrl2, aif1, aif2, aif3, aif4;
 
-	clk_ctrl2 = wm9081_read(codec, WM9081_CLOCK_CONTROL_2);
+	clk_ctrl2 = snd_soc_read(codec, WM9081_CLOCK_CONTROL_2);
 	clk_ctrl2 &= ~(WM9081_CLK_SYS_RATE_MASK | WM9081_SAMPLE_RATE_MASK);
 
-	aif1 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
+	aif1 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_1);
 
-	aif2 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_2);
+	aif2 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_2);
 	aif2 &= ~WM9081_AIF_WL_MASK;
 
-	aif3 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_3);
+	aif3 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_3);
 	aif3 &= ~WM9081_BCLK_DIV_MASK;
 
-	aif4 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_4);
+	aif4 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_4);
 	aif4 &= ~WM9081_LRCLK_RATE_MASK;
 
 	/* What BCLK do we need? */
@@ -1149,22 +1084,22 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 			s->name, s->rate);
 
 		/* If the EQ is enabled then disable it while we write out */
-		eq1 = wm9081_read(codec, WM9081_EQ_1) & WM9081_EQ_ENA;
+		eq1 = snd_soc_read(codec, WM9081_EQ_1) & WM9081_EQ_ENA;
 		if (eq1 & WM9081_EQ_ENA)
-			wm9081_write(codec, WM9081_EQ_1, 0);
+			snd_soc_write(codec, WM9081_EQ_1, 0);
 
 		/* Write out the other values */
 		for (i = 1; i < ARRAY_SIZE(s->config); i++)
-			wm9081_write(codec, WM9081_EQ_1 + i, s->config[i]);
+			snd_soc_write(codec, WM9081_EQ_1 + i, s->config[i]);
 
 		eq1 |= (s->config[0] & ~WM9081_EQ_ENA);
-		wm9081_write(codec, WM9081_EQ_1, eq1);
+		snd_soc_write(codec, WM9081_EQ_1, eq1);
 	}
 
-	wm9081_write(codec, WM9081_CLOCK_CONTROL_2, clk_ctrl2);
-	wm9081_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
-	wm9081_write(codec, WM9081_AUDIO_INTERFACE_3, aif3);
-	wm9081_write(codec, WM9081_AUDIO_INTERFACE_4, aif4);
+	snd_soc_write(codec, WM9081_CLOCK_CONTROL_2, clk_ctrl2);
+	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
+	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_3, aif3);
+	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_4, aif4);
 
 	return 0;
 }
@@ -1174,14 +1109,14 @@ static int wm9081_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	unsigned int reg;
 
-	reg = wm9081_read(codec, WM9081_DAC_DIGITAL_2);
+	reg = snd_soc_read(codec, WM9081_DAC_DIGITAL_2);
 
 	if (mute)
 		reg |= WM9081_DAC_MUTE;
 	else
 		reg &= ~WM9081_DAC_MUTE;
 
-	wm9081_write(codec, WM9081_DAC_DIGITAL_2, reg);
+	snd_soc_write(codec, WM9081_DAC_DIGITAL_2, reg);
 
 	return 0;
 }
@@ -1210,7 +1145,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 			       unsigned int mask, int slots)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	unsigned int aif1 = wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
+	unsigned int aif1 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_1);
 
 	aif1 &= ~(WM9081_AIFDAC_TDM_SLOT_MASK | WM9081_AIFDAC_TDM_MODE_MASK);
 
@@ -1235,7 +1170,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	wm9081_write(codec, WM9081_AUDIO_INTERFACE_1, aif1);
+	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_1, aif1);
 
 	return 0;
 }
@@ -1357,7 +1292,7 @@ static int wm9081_resume(struct platform_device *pdev)
 		if (i == WM9081_SOFTWARE_RESET)
 			continue;
 
-		wm9081_write(codec, i, reg_cache[i]);
+		snd_soc_write(codec, i, reg_cache[i]);
 	}
 
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1377,7 +1312,8 @@ struct snd_soc_codec_device soc_codec_dev_wm9081 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9081);
 
-static int wm9081_register(struct wm9081_priv *wm9081)
+static int wm9081_register(struct wm9081_priv *wm9081,
+			   enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = &wm9081->codec;
 	int ret;
@@ -1396,19 +1332,24 @@ static int wm9081_register(struct wm9081_priv *wm9081)
 	codec->private_data = wm9081;
 	codec->name = "WM9081";
 	codec->owner = THIS_MODULE;
-	codec->read = wm9081_read;
-	codec->write = wm9081_write;
 	codec->dai = &wm9081_dai;
 	codec->num_dai = 1;
 	codec->reg_cache_size = ARRAY_SIZE(wm9081->reg_cache);
 	codec->reg_cache = &wm9081->reg_cache;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm9081_set_bias_level;
+	codec->volatile_register = wm9081_volatile_register;
 
 	memcpy(codec->reg_cache, wm9081_reg_defaults,
 	       sizeof(wm9081_reg_defaults));
 
-	reg = wm9081_read_hw(codec, WM9081_SOFTWARE_RESET);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	reg = snd_soc_read(codec, WM9081_SOFTWARE_RESET);
 	if (reg != 0x9081) {
 		dev_err(codec->dev, "Device is not a WM9081: ID=0x%x\n", reg);
 		ret = -EINVAL;
@@ -1424,10 +1365,10 @@ static int wm9081_register(struct wm9081_priv *wm9081)
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Enable zero cross by default */
-	reg = wm9081_read(codec, WM9081_ANALOGUE_LINEOUT);
-	wm9081_write(codec, WM9081_ANALOGUE_LINEOUT, reg | WM9081_LINEOUTZC);
-	reg = wm9081_read(codec, WM9081_ANALOGUE_SPEAKER_PGA);
-	wm9081_write(codec, WM9081_ANALOGUE_SPEAKER_PGA,
+	reg = snd_soc_read(codec, WM9081_ANALOGUE_LINEOUT);
+	snd_soc_write(codec, WM9081_ANALOGUE_LINEOUT, reg | WM9081_LINEOUTZC);
+	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_PGA);
+	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_PGA,
 		     reg | WM9081_SPKPGAZC);
 
 	wm9081_dai.dev = codec->dev;
@@ -1482,7 +1423,7 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 
 	codec->dev = &i2c->dev;
 
-	return wm9081_register(wm9081);
+	return wm9081_register(wm9081, SND_SOC_I2C);
 }
 
 static __devexit int wm9081_i2c_remove(struct i2c_client *client)
-- 
1.6.3.3
