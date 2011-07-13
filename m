From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
Date: Wed, 13 Jul 2011 12:19:02 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110713115711.GG1928@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Wednesday, July 13, 2011 7:57 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; linux-arm-
> kernel@lists.infradead.org; u.kleine-koenig@pengutronix.de
> Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
> 
> Which version of the codec do you have? I have:
Yes, it is revision 17.

> [    0.370000] sgtl5000 0-000a: sgtl5000 revision 17
> [    0.370000] sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-
> 000a: -22
> [    0.380000] asoc: failed to instantiate card mxs_sgtl5000: -22
> 
> The failure is because CONFIG_REGULATOR is not set and it thus fails in
> the
> codec-driver:
> 
> #else /* CONFIG_REGULATOR */
> static int ldo_regulator_register(struct snd_soc_codec *codec,
> 				struct regulator_init_data *init_data,
> 				int voltage)
> {
> 	return -EINVAL;
> }
> 
> (I can patch it to load properly, but well...)
> 
> Proper regulator support for mxs is not in mainline yet. Is that planned?
> How do you do it?

Yes, it's not in mainline yet.
Fixed regulator may be a method.
However currently I just removed VDDIO and VDDA checking in sgtl5000 driver.
Additionally, it seems sgtl5000 driver still needs another fix to get it running.
I copy the patch as below for your info(Just for test).
I'm going to do that in my following work.

Regards
Dong Aisheng

>From 0596a396a31b5a50fdf0af94a2243812bc8bbe67 Mon Sep 17 00:00:00 2001
From: Dong Aisheng <b29396@freescale.com>
Date: Mon, 11 Jul 2011 16:09:31 +0800
Subject: [PATCH 1/1] sgtl5000: fix i2c r/w issue add neglect VDDIO and VDDIO

This is caused by sgtl5000 using register address step is 2,
and snd-soc-core can't handle this as we expect, so we have to
fill the register cache by reading register out when initialization
instead of providing a default value array.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |  159 ++++++++++++++-----------------------------
 1 files changed, 52 insertions(+), 107 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ff29380..c29f153 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -33,87 +33,18 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
 
-/* default value of sgtl5000 registers except DAP */
-static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
-	0xa011, /* 0x0000, CHIP_ID. 11 stand for revison 17 */
-	0x0000, /* 0x0002, CHIP_DIG_POWER. */
-	0x0008, /* 0x0004, CHIP_CKL_CTRL */
-	0x0010, /* 0x0006, CHIP_I2S_CTRL */
-	0x0000, /* 0x0008, reserved */
-	0x0008, /* 0x000A, CHIP_SSS_CTRL */
-	0x0000, /* 0x000C, reserved */
-	0x020c, /* 0x000E, CHIP_ADCDAC_CTRL */
-	0x3c3c, /* 0x0010, CHIP_DAC_VOL */
-	0x0000, /* 0x0012, reserved */
-	0x015f, /* 0x0014, CHIP_PAD_STRENGTH */
-	0x0000, /* 0x0016, reserved */
-	0x0000, /* 0x0018, reserved */
-	0x0000, /* 0x001A, reserved */
-	0x0000, /* 0x001E, reserved */
-	0x0000, /* 0x0020, CHIP_ANA_ADC_CTRL */
-	0x1818, /* 0x0022, CHIP_ANA_HP_CTRL */
-	0x0111, /* 0x0024, CHIP_ANN_CTRL */
-	0x0000, /* 0x0026, CHIP_LINREG_CTRL */
-	0x0000, /* 0x0028, CHIP_REF_CTRL */
-	0x0000, /* 0x002A, CHIP_MIC_CTRL */
-	0x0000, /* 0x002C, CHIP_LINE_OUT_CTRL */
-	0x0404, /* 0x002E, CHIP_LINE_OUT_VOL */
-	0x7060, /* 0x0030, CHIP_ANA_POWER */
-	0x5000, /* 0x0032, CHIP_PLL_CTRL */
-	0x0000, /* 0x0034, CHIP_CLK_TOP_CTRL */
-	0x0000, /* 0x0036, CHIP_ANA_STATUS */
-	0x0000, /* 0x0038, reserved */
-	0x0000, /* 0x003A, CHIP_ANA_TEST2 */
-	0x0000, /* 0x003C, CHIP_SHORT_CTRL */
-	0x0000, /* reserved */
-};
-
-/* default value of dap registers */
-static const u16 sgtl5000_dap_regs[] = {
-	0x0000, /* 0x0100, DAP_CONTROL */
-	0x0000, /* 0x0102, DAP_PEQ */
-	0x0040, /* 0x0104, DAP_BASS_ENHANCE */
-	0x051f, /* 0x0106, DAP_BASS_ENHANCE_CTRL */
-	0x0000, /* 0x0108, DAP_AUDIO_EQ */
-	0x0040, /* 0x010A, DAP_SGTL_SURROUND */
-	0x0000, /* 0x010C, DAP_FILTER_COEF_ACCESS */
-	0x0000, /* 0x010E, DAP_COEF_WR_B0_MSB */
-	0x0000, /* 0x0110, DAP_COEF_WR_B0_LSB */
-	0x0000, /* 0x0112, reserved */
-	0x0000, /* 0x0114, reserved */
-	0x002f, /* 0x0116, DAP_AUDIO_EQ_BASS_BAND0 */
-	0x002f, /* 0x0118, DAP_AUDIO_EQ_BAND0 */
-	0x002f, /* 0x011A, DAP_AUDIO_EQ_BAND2 */
-	0x002f, /* 0x011C, DAP_AUDIO_EQ_BAND3 */
-	0x002f, /* 0x011E, DAP_AUDIO_EQ_TREBLE_BAND4 */
-	0x8000, /* 0x0120, DAP_MAIN_CHAN */
-	0x0000, /* 0x0122, DAP_MIX_CHAN */
-	0x0510, /* 0x0124, DAP_AVC_CTRL */
-	0x1473, /* 0x0126, DAP_AVC_THRESHOLD */
-	0x0028, /* 0x0128, DAP_AVC_ATTACK */
-	0x0050, /* 0x012A, DAP_AVC_DECAY */
-	0x0000, /* 0x012C, DAP_COEF_WR_B1_MSB */
-	0x0000, /* 0x012E, DAP_COEF_WR_B1_LSB */
-	0x0000, /* 0x0130, DAP_COEF_WR_B2_MSB */
-	0x0000, /* 0x0132, DAP_COEF_WR_B2_LSB */
-	0x0000, /* 0x0134, DAP_COEF_WR_A1_MSB */
-	0x0000, /* 0x0136, DAP_COEF_WR_A1_LSB */
-	0x0000, /* 0x0138, DAP_COEF_WR_A2_MSB */
-	0x0000, /* 0x013A, DAP_COEF_WR_A2_LSB */
-};
-
 /* regulator supplies for sgtl5000, VDDD is an optional external supply */
 enum sgtl5000_regulator_supplies {
-	VDDA,
-	VDDIO,
+//	VDDA,
+//	VDDIO,
 	VDDD,
 	SGTL5000_SUPPLY_NUM
 };
 
 /* vddd is optional supply */
 static const char *supply_names[SGTL5000_SUPPLY_NUM] = {
-	"VDDA",
-	"VDDIO",
+//	"VDDA",
+//	"VDDIO",
 	"VDDD"
 };
 
@@ -780,6 +711,11 @@ static int ldo_regulator_is_enabled(struct regulator_dev *dev)
 	return ldo->enabled;
 }
 
+/*
+ * enable internal VDDD power supply. Since register
+ * cache not fill yet, we have to use hw_read and write
+ * instead of snd_soc_read and snd_soc_write.
+ */
 static int ldo_regulator_enable(struct regulator_dev *dev)
 {
 	struct ldo_regulator *ldo = rdev_get_drvdata(dev);
@@ -797,17 +733,17 @@ static int ldo_regulator_enable(struct regulator_dev *dev)
 	ldo->voltage = (1600 - reg * 50) * 1000;
 
 	/* set voltage to register */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
-				(0x1 << 4) - 1, reg);
+	codec->write(codec, SGTL5000_CHIP_LINREG_CTRL, reg);
 
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINEREG_D_POWERUP,
-				SGTL5000_LINEREG_D_POWERUP);
+	reg = codec->hw_read(codec, SGTL5000_CHIP_ANA_POWER);
+	reg |= SGTL5000_LINEREG_D_POWERUP;
+	codec->write(codec, SGTL5000_CHIP_ANA_POWER, reg);
 
+	reg &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
 	/* when internal ldo enabled, simple digital power can be disabled */
-	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_LINREG_SIMPLE_POWERUP,
-				0);
+	codec->write(codec, SGTL5000_CHIP_ANA_POWER, reg);
+
+	udelay(10);
 
 	ldo->enabled = 1;
 	return 0;
@@ -1022,13 +958,11 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 {
 	u16 *cache = codec->reg_cache;
-	int i;
-	int regular_regs = SGTL5000_CHIP_SHORT_CTRL >> 1;
+	int reg;
+	int step = codec->driver->reg_cache_step;
 
 	/* restore regular registers */
-	for (i = 0; i < regular_regs; i++) {
-		int reg = i << 1;
-
+	for (reg = 0; reg < SGTL5000_CHIP_SHORT_CTRL; reg += step) {
 		/* this regs depends on the others */
 		if (reg == SGTL5000_CHIP_ANA_POWER ||
 			reg == SGTL5000_CHIP_CLK_CTRL ||
@@ -1037,35 +971,32 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 			reg == SGTL5000_CHIP_CLK_CTRL)
 			continue;
 
-		snd_soc_write(codec, reg, cache[i]);
+		snd_soc_write(codec, reg, cache[reg]);
 	}
 
 	/* restore dap registers */
-	for (i = SGTL5000_DAP_REG_OFFSET >> 1;
-			i < SGTL5000_MAX_REG_OFFSET >> 1; i++) {
-		int reg = i << 1;
-
-		snd_soc_write(codec, reg, cache[i]);
-	}
+	for (reg = SGTL5000_DAP_REG_OFFSET;
+			reg < SGTL5000_MAX_REG_OFFSET; reg += step)
+		snd_soc_write(codec, reg, cache[reg]);
 
 	/*
 	 * restore power and other regs according
 	 * to set_power() and set_clock()
 	 */
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-			cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINREG_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-			cache[SGTL5000_CHIP_ANA_POWER >> 1]);
+			cache[SGTL5000_CHIP_ANA_POWER]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-			cache[SGTL5000_CHIP_CLK_CTRL >> 1]);
+			cache[SGTL5000_CHIP_CLK_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-			cache[SGTL5000_CHIP_REF_CTRL >> 1]);
+			cache[SGTL5000_CHIP_REF_CTRL]);
 
 	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-			cache[SGTL5000_CHIP_LINE_OUT_CTRL >> 1]);
+			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
 	return 0;
 }
 
@@ -1105,12 +1036,12 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 	int vag;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
-	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
-	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
+//	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
+//	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
 	vddd  = regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
 
-	vdda  = vdda / 1000;
-	vddio = vddio / 1000;
+	vdda  = 3300;
+	vddio = 3300;
 	vddd  = vddd / 1000;
 
 	if (vdda <= 0 || vddio <= 0 || vddd < 0) {
@@ -1335,6 +1266,22 @@ err_regulator_free:
 
 }
 
+static int sgtl5000_fill_reg_cache(struct snd_soc_codec *codec)
+{
+	int reg;
+	int step = codec->driver->reg_cache_step;
+	u16 *cache = codec->reg_cache;
+
+	for (reg = SGTL5000_DAP_REG_OFFSET;
+		reg <= SGTL5000_MAX_REG_OFFSET; reg += step)
+		cache[reg] = codec->hw_read(codec, reg);
+
+	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += step)
+		cache[reg] = codec->hw_read(codec, reg);
+
+	return 0;
+}
+
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
 	int ret;
@@ -1351,6 +1298,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
+	sgtl5000_fill_reg_cache(codec);
+
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(codec);
 	if (ret)
@@ -1443,10 +1392,9 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.suspend = sgtl5000_suspend,
 	.resume = sgtl5000_resume,
 	.set_bias_level = sgtl5000_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),
+	.reg_cache_size = SGTL5000_MAX_REG_OFFSET,
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
-	.reg_cache_default = sgtl5000_regs,
 	.volatile_register = sgtl5000_volatile_register,
 };
 
@@ -1466,9 +1414,6 @@ static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
 	 * at init phase makes life easy.
 	 * FIXME: should we drop 'const' of sgtl5000_regs?
 	 */
-	memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET >> 1)),
-			sgtl5000_dap_regs,
-			SGTL5000_MAX_REG_OFFSET - SGTL5000_DAP_REG_OFFSET);
 
 	i2c_set_clientdata(client, sgtl5000);
 
-- 
1.7.0.4
