From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Convert to use regmap directly
Date: Sat,  4 May 2013 15:39:34 -0300
Message-ID: <1367692780-23550-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f171.google.com (mail-gg0-f171.google.com
 [209.85.161.171])
 by alsa0.perex.cz (Postfix) with ESMTP id DAB95261605
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2013 20:40:30 +0200 (CEST)
Received: by mail-gg0-f171.google.com with SMTP id r4so411031ggn.2
 for <alsa-devel@alsa-project.org>; Sat, 04 May 2013 11:40:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |  145 +++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 92bbfec..96b65b1 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/clk.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
@@ -34,30 +35,30 @@
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
 /* default value of sgtl5000 registers */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
-	[SGTL5000_CHIP_CLK_CTRL] = 0x0008,
-	[SGTL5000_CHIP_I2S_CTRL] = 0x0010,
-	[SGTL5000_CHIP_SSS_CTRL] = 0x0008,
-	[SGTL5000_CHIP_DAC_VOL] = 0x3c3c,
-	[SGTL5000_CHIP_PAD_STRENGTH] = 0x015f,
-	[SGTL5000_CHIP_ANA_HP_CTRL] = 0x1818,
-	[SGTL5000_CHIP_ANA_CTRL] = 0x0111,
-	[SGTL5000_CHIP_LINE_OUT_VOL] = 0x0404,
-	[SGTL5000_CHIP_ANA_POWER] = 0x7060,
-	[SGTL5000_CHIP_PLL_CTRL] = 0x5000,
-	[SGTL5000_DAP_BASS_ENHANCE] = 0x0040,
-	[SGTL5000_DAP_BASS_ENHANCE_CTRL] = 0x051f,
-	[SGTL5000_DAP_SURROUND] = 0x0040,
-	[SGTL5000_DAP_EQ_BASS_BAND0] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND1] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND2] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND3] = 0x002f,
-	[SGTL5000_DAP_EQ_BASS_BAND4] = 0x002f,
-	[SGTL5000_DAP_MAIN_CHAN] = 0x8000,
-	[SGTL5000_DAP_AVC_CTRL] = 0x0510,
-	[SGTL5000_DAP_AVC_THRESHOLD] = 0x1473,
-	[SGTL5000_DAP_AVC_ATTACK] = 0x0028,
-	[SGTL5000_DAP_AVC_DECAY] = 0x0050,
+static const struct reg_default sgtl5000_reg_defaults[] = {
+	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
+	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
+	{ SGTL5000_CHIP_SSS_CTRL,		0x0008 },
+	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
+	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
+	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
+	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
+	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
+	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
+	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
+	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
+	{ SGTL5000_DAP_BASS_ENHANCE_CTRL,	0x051f },
+	{ SGTL5000_DAP_SURROUND,		0x0040 },
+	{ SGTL5000_DAP_EQ_BASS_BAND0,		0x002f },
+	{ SGTL5000_DAP_EQ_BASS_BAND1,		0x002f },
+	{ SGTL5000_DAP_EQ_BASS_BAND2,		0x002f },
+	{ SGTL5000_DAP_EQ_BASS_BAND3,		0x002f },
+	{ SGTL5000_DAP_EQ_BASS_BAND4,		0x002f },
+	{ SGTL5000_DAP_MAIN_CHAN,		0x8000 },
+	{ SGTL5000_DAP_AVC_CTRL,		0x0510 },
+	{ SGTL5000_DAP_AVC_THRESHOLD,		0x1473 },
+	{ SGTL5000_DAP_AVC_ATTACK,		0x0028 },
+	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
 };
 
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
@@ -112,6 +113,7 @@ struct sgtl5000_priv {
 	int fmt;	/* i2s data format */
 	struct regulator_bulk_data supplies[SGTL5000_SUPPLY_NUM];
 	struct ldo_regulator *ldo;
+	struct regmap *regmap;
 };
 
 /*
@@ -958,17 +960,76 @@ static struct snd_soc_dai_driver sgtl5000_dai = {
 	.symmetric_rates = 1,
 };
 
-static int sgtl5000_volatile_register(struct snd_soc_codec *codec,
-					unsigned int reg)
+static bool sgtl5000_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SGTL5000_CHIP_ID:
 	case SGTL5000_CHIP_ADCDAC_CTRL:
 	case SGTL5000_CHIP_ANA_STATUS:
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
+}
+
+static bool sgtl5000_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SGTL5000_CHIP_ID:
+	case SGTL5000_CHIP_DIG_POWER:
+	case SGTL5000_CHIP_CLK_CTRL:
+	case SGTL5000_CHIP_I2S_CTRL:
+	case SGTL5000_CHIP_SSS_CTRL:
+	case SGTL5000_CHIP_ADCDAC_CTRL:
+	case SGTL5000_CHIP_DAC_VOL:
+	case SGTL5000_CHIP_PAD_STRENGTH:
+	case SGTL5000_CHIP_ANA_ADC_CTRL:
+	case SGTL5000_CHIP_ANA_HP_CTRL:
+	case SGTL5000_CHIP_ANA_CTRL:
+	case SGTL5000_CHIP_LINREG_CTRL:
+	case SGTL5000_CHIP_REF_CTRL:
+	case SGTL5000_CHIP_MIC_CTRL:
+	case SGTL5000_CHIP_LINE_OUT_CTRL:
+	case SGTL5000_CHIP_LINE_OUT_VOL:
+	case SGTL5000_CHIP_ANA_POWER:
+	case SGTL5000_CHIP_PLL_CTRL:
+	case SGTL5000_CHIP_CLK_TOP_CTRL:
+	case SGTL5000_CHIP_ANA_STATUS:
+	case SGTL5000_CHIP_SHORT_CTRL:
+	case SGTL5000_CHIP_ANA_TEST2:
+	case SGTL5000_DAP_CTRL:
+	case SGTL5000_DAP_PEQ:
+	case SGTL5000_DAP_BASS_ENHANCE:
+	case SGTL5000_DAP_BASS_ENHANCE_CTRL:
+	case SGTL5000_DAP_AUDIO_EQ:
+	case SGTL5000_DAP_SURROUND:
+	case SGTL5000_DAP_FLT_COEF_ACCESS:
+	case SGTL5000_DAP_COEF_WR_B0_MSB:
+	case SGTL5000_DAP_COEF_WR_B0_LSB:
+	case SGTL5000_DAP_EQ_BASS_BAND0:
+	case SGTL5000_DAP_EQ_BASS_BAND1:
+	case SGTL5000_DAP_EQ_BASS_BAND2:
+	case SGTL5000_DAP_EQ_BASS_BAND3:
+	case SGTL5000_DAP_EQ_BASS_BAND4:
+	case SGTL5000_DAP_MAIN_CHAN:
+	case SGTL5000_DAP_MIX_CHAN:
+	case SGTL5000_DAP_AVC_CTRL:
+	case SGTL5000_DAP_AVC_THRESHOLD:
+	case SGTL5000_DAP_AVC_ATTACK:
+	case SGTL5000_DAP_AVC_DECAY:
+	case SGTL5000_DAP_COEF_WR_B1_MSB:
+	case SGTL5000_DAP_COEF_WR_B1_LSB:
+	case SGTL5000_DAP_COEF_WR_B2_MSB:
+	case SGTL5000_DAP_COEF_WR_B2_LSB:
+	case SGTL5000_DAP_COEF_WR_A1_MSB:
+	case SGTL5000_DAP_COEF_WR_A1_LSB:
+	case SGTL5000_DAP_COEF_WR_A2_MSB:
+	case SGTL5000_DAP_COEF_WR_A2_LSB:
+		return true;
+
+	default:
+		return false;
+	}
 }
 
 #ifdef CONFIG_SUSPEND
@@ -1300,7 +1361,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
 	/* setup i2c data ops */
-	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
+	codec->control_data = sgtl5000->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1391,11 +1453,6 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.suspend = sgtl5000_suspend,
 	.resume = sgtl5000_resume,
 	.set_bias_level = sgtl5000_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = sgtl5000_regs,
-	.volatile_register = sgtl5000_volatile_register,
 	.controls = sgtl5000_snd_controls,
 	.num_controls = ARRAY_SIZE(sgtl5000_snd_controls),
 	.dapm_widgets = sgtl5000_dapm_widgets,
@@ -1404,6 +1461,19 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.num_dapm_routes = ARRAY_SIZE(sgtl5000_dapm_routes),
 };
 
+static const struct regmap_config sgtl5000_regmap = {
+	.reg_bits = 16,
+	.val_bits = 16,
+
+	.max_register = SGTL5000_MAX_REG_OFFSET,
+	.volatile_reg = sgtl5000_volatile,
+	.readable_reg = sgtl5000_readable,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = sgtl5000_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
+};
+
 static int sgtl5000_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
@@ -1415,6 +1485,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (!sgtl5000)
 		return -ENOMEM;
 
+	sgtl5000->regmap = devm_regmap_init_i2c(client, &sgtl5000_regmap);
+	if (IS_ERR(sgtl5000->regmap)) {
+		ret = PTR_ERR(sgtl5000->regmap);
+		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(client, sgtl5000);
 
 	ret = snd_soc_register_codec(&client->dev,
-- 
1.7.9.5
