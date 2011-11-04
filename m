From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert WM9081 to direct regmap API usage
Date: Fri,  4 Nov 2011 21:42:04 +0000
Message-ID: <1320442924-12182-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9947110384A
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 22:42:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |  280 +++++++++++++++++++++++++++++----------------
 1 files changed, 182 insertions(+), 98 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 4e0489f..09d6da0 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -30,69 +31,63 @@
 #include <sound/wm9081.h>
 #include "wm9081.h"
 
-static u16 wm9081_reg_defaults[] = {
-	0x0000,     /* R0  - Software Reset */
-	0x0000,     /* R1 */
-	0x00B9,     /* R2  - Analogue Lineout */
-	0x00B9,     /* R3  - Analogue Speaker PGA */
-	0x0001,     /* R4  - VMID Control */
-	0x0068,     /* R5  - Bias Control 1 */
-	0x0000,     /* R6 */
-	0x0000,     /* R7  - Analogue Mixer */
-	0x0000,     /* R8  - Anti Pop Control */
-	0x01DB,     /* R9  - Analogue Speaker 1 */
-	0x0018,     /* R10 - Analogue Speaker 2 */
-	0x0180,     /* R11 - Power Management */
-	0x0000,     /* R12 - Clock Control 1 */
-	0x0038,     /* R13 - Clock Control 2 */
-	0x4000,     /* R14 - Clock Control 3 */
-	0x0000,     /* R15 */
-	0x0000,     /* R16 - FLL Control 1 */
-	0x0200,     /* R17 - FLL Control 2 */
-	0x0000,     /* R18 - FLL Control 3 */
-	0x0204,     /* R19 - FLL Control 4 */
-	0x0000,     /* R20 - FLL Control 5 */
-	0x0000,     /* R21 */
-	0x0000,     /* R22 - Audio Interface 1 */
-	0x0002,     /* R23 - Audio Interface 2 */
-	0x0008,     /* R24 - Audio Interface 3 */
-	0x0022,     /* R25 - Audio Interface 4 */
-	0x0000,     /* R26 - Interrupt Status */
-	0x0006,     /* R27 - Interrupt Status Mask */
-	0x0000,     /* R28 - Interrupt Polarity */
-	0x0000,     /* R29 - Interrupt Control */
-	0x00C0,     /* R30 - DAC Digital 1 */
-	0x0008,     /* R31 - DAC Digital 2 */
-	0x09AF,     /* R32 - DRC 1 */
-	0x4201,     /* R33 - DRC 2 */
-	0x0000,     /* R34 - DRC 3 */
-	0x0000,     /* R35 - DRC 4 */
-	0x0000,     /* R36 */
-	0x0000,     /* R37 */
-	0x0000,     /* R38 - Write Sequencer 1 */
-	0x0000,     /* R39 - Write Sequencer 2 */
-	0x0002,     /* R40 - MW Slave 1 */
-	0x0000,     /* R41 */
-	0x0000,     /* R42 - EQ 1 */
-	0x0000,     /* R43 - EQ 2 */
-	0x0FCA,     /* R44 - EQ 3 */
-	0x0400,     /* R45 - EQ 4 */
-	0x00B8,     /* R46 - EQ 5 */
-	0x1EB5,     /* R47 - EQ 6 */
-	0xF145,     /* R48 - EQ 7 */
-	0x0B75,     /* R49 - EQ 8 */
-	0x01C5,     /* R50 - EQ 9 */
-	0x169E,     /* R51 - EQ 10 */
-	0xF829,     /* R52 - EQ 11 */
-	0x07AD,     /* R53 - EQ 12 */
-	0x1103,     /* R54 - EQ 13 */
-	0x1C58,     /* R55 - EQ 14 */
-	0xF373,     /* R56 - EQ 15 */
-	0x0A54,     /* R57 - EQ 16 */
-	0x0558,     /* R58 - EQ 17 */
-	0x0564,     /* R59 - EQ 18 */
-	0x0559,     /* R60 - EQ 19 */
-	0x4000,     /* R61 - EQ 20 */
+static struct reg_default wm9081_reg[] = {
+	{  0, 0x9081 },     /* R0  - Software Reset */
+	{  1, 0x0000 },     /* R1 */
+	{  2, 0x00B9 },     /* R2  - Analogue Lineout */
+	{  3, 0x00B9 },     /* R3  - Analogue Speaker PGA */
+	{  4, 0x0001 },     /* R4  - VMID Control */
+	{  5, 0x0068 },     /* R5  - Bias Control 1 */
+	{  6, 0x0000 },     /* R6 */
+	{  7, 0x0000 },     /* R7  - Analogue Mixer */
+	{  8, 0x0000 },     /* R8  - Anti Pop Control */
+	{  9, 0x01DB },     /* R9  - Analogue Speaker 1 */
+	{ 10, 0x0018 },     /* R10 - Analogue Speaker 2 */
+	{ 11, 0x0180 },     /* R11 - Power Management */
+	{ 12, 0x0000 },     /* R12 - Clock Control 1 */
+	{ 13, 0x0038 },     /* R13 - Clock Control 2 */
+	{ 14, 0x4000 },     /* R14 - Clock Control 3 */
+	{ 16, 0x0000 },     /* R16 - FLL Control 1 */
+	{ 17, 0x0200 },     /* R17 - FLL Control 2 */
+	{ 18, 0x0000 },     /* R18 - FLL Control 3 */
+	{ 19, 0x0204 },     /* R19 - FLL Control 4 */
+	{ 20, 0x0000 },     /* R20 - FLL Control 5 */
+	{ 22, 0x0000 },     /* R22 - Audio Interface 1 */
+	{ 23, 0x0002 },     /* R23 - Audio Interface 2 */
+	{ 24, 0x0008 },     /* R24 - Audio Interface 3 */
+	{ 25, 0x0022 },     /* R25 - Audio Interface 4 */
+	{ 27, 0x0006 },     /* R27 - Interrupt Status Mask */
+	{ 28, 0x0000 },     /* R28 - Interrupt Polarity */
+	{ 29, 0x0000 },     /* R29 - Interrupt Control */
+	{ 30, 0x00C0 },     /* R30 - DAC Digital 1 */
+	{ 31, 0x0008 },     /* R31 - DAC Digital 2 */
+	{ 32, 0x09AF },     /* R32 - DRC 1 */
+	{ 33, 0x4201 },     /* R33 - DRC 2 */
+	{ 34, 0x0000 },     /* R34 - DRC 3 */
+	{ 35, 0x0000 },     /* R35 - DRC 4 */
+	{ 38, 0x0000 },     /* R38 - Write Sequencer 1 */
+	{ 39, 0x0000 },     /* R39 - Write Sequencer 2 */
+	{ 40, 0x0002 },     /* R40 - MW Slave 1 */
+	{ 42, 0x0000 },     /* R42 - EQ 1 */
+	{ 43, 0x0000 },     /* R43 - EQ 2 */
+	{ 44, 0x0FCA },     /* R44 - EQ 3 */
+	{ 45, 0x0400 },     /* R45 - EQ 4 */
+	{ 46, 0x00B8 },     /* R46 - EQ 5 */
+	{ 47, 0x1EB5 },     /* R47 - EQ 6 */
+	{ 48, 0xF145 },     /* R48 - EQ 7 */
+	{ 49, 0x0B75 },     /* R49 - EQ 8 */
+	{ 50, 0x01C5 },     /* R50 - EQ 9 */
+	{ 51, 0x169E },     /* R51 - EQ 10 */
+	{ 52, 0xF829 },     /* R52 - EQ 11 */
+	{ 53, 0x07AD },     /* R53 - EQ 12 */
+	{ 54, 0x1103 },     /* R54 - EQ 13 */
+	{ 55, 0x1C58 },     /* R55 - EQ 14 */
+	{ 56, 0xF373 },     /* R56 - EQ 15 */
+	{ 57, 0x0A54 },     /* R57 - EQ 16 */
+	{ 58, 0x0558 },     /* R58 - EQ 17 */
+	{ 59, 0x0564 },     /* R59 - EQ 18 */
+	{ 60, 0x0559 },     /* R60 - EQ 19 */
+	{ 61, 0x4000 },     /* R61 - EQ 20 */
 };
 
 static struct {
@@ -156,7 +151,7 @@ static struct {
 };
 
 struct wm9081_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int sysclk_source;
 	int mclk_rate;
 	int sysclk_rate;
@@ -169,20 +164,84 @@ struct wm9081_priv {
 	struct wm9081_pdata pdata;
 };
 
-static int wm9081_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm9081_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM9081_SOFTWARE_RESET:
 	case WM9081_INTERRUPT_STATUS:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-static int wm9081_reset(struct snd_soc_codec *codec)
+static bool wm9081_readable_register(struct device *dev, unsigned int reg)
 {
-	return snd_soc_write(codec, WM9081_SOFTWARE_RESET, 0);
+	switch (reg) {
+	case WM9081_SOFTWARE_RESET:
+	case WM9081_ANALOGUE_LINEOUT:
+	case WM9081_ANALOGUE_SPEAKER_PGA:
+	case WM9081_VMID_CONTROL:
+	case WM9081_BIAS_CONTROL_1:
+	case WM9081_ANALOGUE_MIXER:
+	case WM9081_ANTI_POP_CONTROL:
+	case WM9081_ANALOGUE_SPEAKER_1:
+	case WM9081_ANALOGUE_SPEAKER_2:
+	case WM9081_POWER_MANAGEMENT:
+	case WM9081_CLOCK_CONTROL_1:
+	case WM9081_CLOCK_CONTROL_2:
+	case WM9081_CLOCK_CONTROL_3:
+	case WM9081_FLL_CONTROL_1:
+	case WM9081_FLL_CONTROL_2:
+	case WM9081_FLL_CONTROL_3:
+	case WM9081_FLL_CONTROL_4:
+	case WM9081_FLL_CONTROL_5:
+	case WM9081_AUDIO_INTERFACE_1:
+	case WM9081_AUDIO_INTERFACE_2:
+	case WM9081_AUDIO_INTERFACE_3:
+	case WM9081_AUDIO_INTERFACE_4:
+	case WM9081_INTERRUPT_STATUS:
+	case WM9081_INTERRUPT_STATUS_MASK:
+	case WM9081_INTERRUPT_POLARITY:
+	case WM9081_INTERRUPT_CONTROL:
+	case WM9081_DAC_DIGITAL_1:
+	case WM9081_DAC_DIGITAL_2:
+	case WM9081_DRC_1:
+	case WM9081_DRC_2:
+	case WM9081_DRC_3:
+	case WM9081_DRC_4:
+	case WM9081_WRITE_SEQUENCER_1:
+	case WM9081_WRITE_SEQUENCER_2:
+	case WM9081_MW_SLAVE_1:
+	case WM9081_EQ_1:
+	case WM9081_EQ_2:
+	case WM9081_EQ_3:
+	case WM9081_EQ_4:
+	case WM9081_EQ_5:
+	case WM9081_EQ_6:
+	case WM9081_EQ_7:
+	case WM9081_EQ_8:
+	case WM9081_EQ_9:
+	case WM9081_EQ_10:
+	case WM9081_EQ_11:
+	case WM9081_EQ_12:
+	case WM9081_EQ_13:
+	case WM9081_EQ_14:
+	case WM9081_EQ_15:
+	case WM9081_EQ_16:
+	case WM9081_EQ_17:
+	case WM9081_EQ_18:
+	case WM9081_EQ_19:
+	case WM9081_EQ_20:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int wm9081_reset(struct regmap *map)
+{
+	return regmap_write(map, WM9081_SOFTWARE_RESET, 0x9081);
 }
 
 static const DECLARE_TLV_DB_SCALE(drc_in_tlv, -4500, 75, 0);
@@ -1202,25 +1261,14 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 	int ret;
 	u16 reg;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm9081->control_type);
+	codec->control_data = wm9081->regmap;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
-	reg = snd_soc_read(codec, WM9081_SOFTWARE_RESET);
-	if (reg != 0x9081) {
-		dev_err(codec->dev, "Device is not a WM9081: ID=0x%x\n", reg);
-		ret = -EINVAL;
-		return ret;
-	}
-
-	ret = wm9081_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
 	reg = 0;
 	if (wm9081->pdata.irq_high)
 		reg |= WM9081_IRQ_POL;
@@ -1263,15 +1311,9 @@ static int wm9081_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm9081_resume(struct snd_soc_codec *codec)
 {
-	u16 *reg_cache = codec->reg_cache;
-	int i;
-
-	for (i = 0; i < codec->driver->reg_cache_size; i++) {
-		if (i == WM9081_SOFTWARE_RESET)
-			continue;
+	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
 
-		snd_soc_write(codec, i, reg_cache[i]);
-	}
+	regcache_sync(wm9081->regmap);
 
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1291,11 +1333,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.set_sysclk = wm9081_set_sysclk,
 	.set_bias_level = wm9081_set_bias_level,
 
-	.reg_cache_size = ARRAY_SIZE(wm9081_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm9081_reg_defaults,
-	.volatile_register = wm9081_volatile_register,
-
 	.controls         = wm9081_snd_controls,
 	.num_controls     = ARRAY_SIZE(wm9081_snd_controls),
 	.dapm_widgets	  = wm9081_dapm_widgets,
@@ -1304,11 +1341,24 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.num_dapm_routes = ARRAY_SIZE(wm9081_audio_paths),
 };
 
+static const struct regmap_config wm9081_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM9081_MAX_REGISTER,
+	.reg_defaults = wm9081_reg,
+	.num_reg_defaults = ARRAY_SIZE(wm9081_reg),
+	.volatile_reg = wm9081_volatile_register,
+	.readable_reg = wm9081_readable_register,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm9081_priv *wm9081;
+	unsigned int reg;
 	int ret;
 
 	wm9081 = kzalloc(sizeof(struct wm9081_priv), GFP_KERNEL);
@@ -1316,7 +1366,30 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, wm9081);
-	wm9081->control_type = SND_SOC_I2C;
+
+	wm9081->regmap = regmap_init_i2c(i2c, &wm9081_regmap);
+	if (IS_ERR(wm9081->regmap)) {
+		ret = PTR_ERR(wm9081->regmap);
+		dev_err(&i2c->dev, "regmap_init() failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = regmap_read(wm9081->regmap, WM9081_SOFTWARE_RESET, &reg);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
+		goto err_regmap;
+	}
+	if (reg != 0x9081) {
+		dev_err(&i2c->dev, "Device is not a WM9081: ID=0x%x\n", reg);
+		ret = -EINVAL;
+		goto err_regmap;
+	}
+
+	ret = wm9081_reset(wm9081->regmap);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to issue reset\n");
+		goto err_regmap;
+	}
 
 	if (dev_get_platdata(&i2c->dev))
 		memcpy(&wm9081->pdata, dev_get_platdata(&i2c->dev),
@@ -1325,13 +1398,24 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9081, &wm9081_dai, 1);
 	if (ret < 0)
-		kfree(wm9081);
+		goto err_regmap;
+
+	return 0;
+
+err_regmap:
+	regmap_exit(wm9081->regmap);
+err:
+	kfree(wm9081);
+
 	return ret;
 }
 
 static __devexit int wm9081_i2c_remove(struct i2c_client *client)
 {
+	struct wm9081_priv *wm9081 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
+	regmap_exit(wm9081->regmap);
 	kfree(i2c_get_clientdata(client));
 	return 0;
 }
-- 
1.7.7.1
