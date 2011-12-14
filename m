From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: Convert WM9090 to use regmap directly
Date: Wed, 14 Dec 2011 17:00:49 +0800
Message-ID: <1323853254-9020-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D2E6243BC
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 10:01:09 +0100 (CET)
In-Reply-To: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm9090.c |  242 ++++++++++++++++++++++++---------------------
 1 files changed, 128 insertions(+), 114 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 41ebe0d..4be5551 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
@@ -33,116 +34,51 @@
 
 #include "wm9090.h"
 
-static const u16 wm9090_reg_defaults[] = {
-	0x9093,     /* R0   - Software Reset */
-	0x0006,     /* R1   - Power Management (1) */
-	0x6000,     /* R2   - Power Management (2) */
-	0x0000,     /* R3   - Power Management (3) */
-	0x0000,     /* R4 */
-	0x0000,     /* R5 */
-	0x01C0,     /* R6   - Clocking 1 */
-	0x0000,     /* R7 */
-	0x0000,     /* R8 */
-	0x0000,     /* R9 */
-	0x0000,     /* R10 */
-	0x0000,     /* R11 */
-	0x0000,     /* R12 */
-	0x0000,     /* R13 */
-	0x0000,     /* R14 */
-	0x0000,     /* R15 */
-	0x0000,     /* R16 */
-	0x0000,     /* R17 */
-	0x0000,     /* R18 */
-	0x0000,     /* R19 */
-	0x0000,     /* R20 */
-	0x0000,     /* R21 */
-	0x0003,     /* R22  - IN1 Line Control */
-	0x0003,     /* R23  - IN2 Line Control */
-	0x0083,     /* R24  - IN1 Line Input A Volume */
-	0x0083,     /* R25  - IN1  Line Input B Volume */
-	0x0083,     /* R26  - IN2 Line Input A Volume */
-	0x0083,     /* R27  - IN2 Line Input B Volume */
-	0x002D,     /* R28  - Left Output Volume */
-	0x002D,     /* R29  - Right Output Volume */
-	0x0000,     /* R30 */
-	0x0000,     /* R31 */
-	0x0000,     /* R32 */
-	0x0000,     /* R33 */
-	0x0100,     /* R34  - SPKMIXL Attenuation */
-	0x0000,     /* R35 */
-	0x0010,     /* R36  - SPKOUT Mixers */
-	0x0140,     /* R37  - ClassD3 */
-	0x0039,     /* R38  - Speaker Volume Left */
-	0x0000,     /* R39 */
-	0x0000,     /* R40 */
-	0x0000,     /* R41 */
-	0x0000,     /* R42 */
-	0x0000,     /* R43 */
-	0x0000,     /* R44 */
-	0x0000,     /* R45  - Output Mixer1 */
-	0x0000,     /* R46  - Output Mixer2 */
-	0x0100,     /* R47  - Output Mixer3 */
-	0x0100,     /* R48  - Output Mixer4 */
-	0x0000,     /* R49 */
-	0x0000,     /* R50 */
-	0x0000,     /* R51 */
-	0x0000,     /* R52 */
-	0x0000,     /* R53 */
-	0x0000,     /* R54  - Speaker Mixer */
-	0x0000,     /* R55 */
-	0x0000,     /* R56 */
-	0x000D,     /* R57  - AntiPOP2 */
-	0x0000,     /* R58 */
-	0x0000,     /* R59 */
-	0x0000,     /* R60 */
-	0x0000,     /* R61 */
-	0x0000,     /* R62 */
-	0x0000,     /* R63 */
-	0x0000,     /* R64 */
-	0x0000,     /* R65 */
-	0x0000,     /* R66 */
-	0x0000,     /* R67 */
-	0x0000,     /* R68 */
-	0x0000,     /* R69 */
-	0x0000,     /* R70  - Write Sequencer 0 */
-	0x0000,     /* R71  - Write Sequencer 1 */
-	0x0000,     /* R72  - Write Sequencer 2 */
-	0x0000,     /* R73  - Write Sequencer 3 */
-	0x0000,     /* R74  - Write Sequencer 4 */
-	0x0000,     /* R75  - Write Sequencer 5 */
-	0x1F25,     /* R76  - Charge Pump 1 */
-	0x0000,     /* R77 */
-	0x0000,     /* R78 */
-	0x0000,     /* R79 */
-	0x0000,     /* R80 */
-	0x0000,     /* R81 */
-	0x0000,     /* R82 */
-	0x0000,     /* R83 */
-	0x0000,     /* R84  - DC Servo 0 */
-	0x054A,     /* R85  - DC Servo 1 */
-	0x0000,     /* R86 */
-	0x0000,     /* R87  - DC Servo 3 */
-	0x0000,     /* R88  - DC Servo Readback 0 */
-	0x0000,     /* R89  - DC Servo Readback 1 */
-	0x0000,     /* R90  - DC Servo Readback 2 */
-	0x0000,     /* R91 */
-	0x0000,     /* R92 */
-	0x0000,     /* R93 */
-	0x0000,     /* R94 */
-	0x0000,     /* R95 */
-	0x0100,     /* R96  - Analogue HP 0 */
-	0x0000,     /* R97 */
-	0x8640,     /* R98  - AGC Control 0 */
-	0xC000,     /* R99  - AGC Control 1 */
-	0x0200,     /* R100 - AGC Control 2 */
+static const struct reg_default wm9090_reg_defaults[] = {
+	{ 1,  0x0006 },     /* R1   - Power Management (1) */
+	{ 2,  0x6000 },     /* R2   - Power Management (2) */
+	{ 3,  0x0000 },     /* R3   - Power Management (3) */
+	{ 6,  0x01C0 },     /* R6   - Clocking 1 */
+	{ 22, 0x0003 },     /* R22  - IN1 Line Control */
+	{ 23, 0x0003 },     /* R23  - IN2 Line Control */
+	{ 24, 0x0083 },     /* R24  - IN1 Line Input A Volume */
+	{ 25, 0x0083 },     /* R25  - IN1  Line Input B Volume */
+	{ 26, 0x0083 },     /* R26  - IN2 Line Input A Volume */
+	{ 27, 0x0083 },     /* R27  - IN2 Line Input B Volume */
+	{ 28, 0x002D },     /* R28  - Left Output Volume */
+	{ 29, 0x002D },     /* R29  - Right Output Volume */
+	{ 34, 0x0100 },     /* R34  - SPKMIXL Attenuation */
+	{ 35, 0x0010 },     /* R36  - SPKOUT Mixers */
+	{ 37, 0x0140 },     /* R37  - ClassD3 */
+	{ 38, 0x0039 },     /* R38  - Speaker Volume Left */
+	{ 45, 0x0000 },     /* R45  - Output Mixer1 */
+	{ 46, 0x0000 },     /* R46  - Output Mixer2 */
+	{ 47, 0x0100 },     /* R47  - Output Mixer3 */
+	{ 48, 0x0100 },     /* R48  - Output Mixer4 */
+	{ 54, 0x0000 },     /* R54  - Speaker Mixer */
+	{ 57, 0x000D },     /* R57  - AntiPOP2 */
+	{ 70, 0x0000 },     /* R70  - Write Sequencer 0 */
+	{ 71, 0x0000 },     /* R71  - Write Sequencer 1 */
+	{ 72, 0x0000 },     /* R72  - Write Sequencer 2 */
+	{ 73, 0x0000 },     /* R73  - Write Sequencer 3 */
+	{ 74, 0x0000 },     /* R74  - Write Sequencer 4 */
+	{ 75, 0x0000 },     /* R75  - Write Sequencer 5 */
+	{ 76, 0x1F25 },     /* R76  - Charge Pump 1 */
+	{ 85, 0x054A },     /* R85  - DC Servo 1 */
+	{ 87, 0x0000 },     /* R87  - DC Servo 3 */
+	{ 96, 0x0100 },     /* R96  - Analogue HP 0 */
+	{ 98, 0x8640 },     /* R98  - AGC Control 0 */
+	{ 99, 0xC000 },     /* R99  - AGC Control 1 */
+	{ 100, 0x0200 },     /* R100 - AGC Control 2 */
 };
 
 /* This struct is used to save the context */
 struct wm9090_priv {
 	struct wm9090_platform_data pdata;
+	struct regmap *regmap;
 };
 
-static int wm9090_volatile(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm9090_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM9090_SOFTWARE_RESET:
@@ -150,10 +86,60 @@ static int wm9090_volatile(struct snd_soc_codec *codec, unsigned int reg)
 	case WM9090_DC_SERVO_READBACK_0:
 	case WM9090_DC_SERVO_READBACK_1:
 	case WM9090_DC_SERVO_READBACK_2:
-		return 1;
+		return true;
 
 	default:
-		return 0;
+		return false;
+	}
+}
+
+static bool wm9090_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM9090_SOFTWARE_RESET:
+	case WM9090_POWER_MANAGEMENT_1:
+	case WM9090_POWER_MANAGEMENT_2:
+	case WM9090_POWER_MANAGEMENT_3:
+	case WM9090_CLOCKING_1:
+	case WM9090_IN1_LINE_CONTROL:
+	case WM9090_IN2_LINE_CONTROL:
+	case WM9090_IN1_LINE_INPUT_A_VOLUME:
+	case WM9090_IN1_LINE_INPUT_B_VOLUME:
+	case WM9090_IN2_LINE_INPUT_A_VOLUME:
+	case WM9090_IN2_LINE_INPUT_B_VOLUME:
+	case WM9090_LEFT_OUTPUT_VOLUME:
+	case WM9090_RIGHT_OUTPUT_VOLUME:
+	case WM9090_SPKMIXL_ATTENUATION:
+	case WM9090_SPKOUT_MIXERS:
+	case WM9090_CLASSD3:
+	case WM9090_SPEAKER_VOLUME_LEFT:
+	case WM9090_OUTPUT_MIXER1:
+	case WM9090_OUTPUT_MIXER2:
+	case WM9090_OUTPUT_MIXER3:
+	case WM9090_OUTPUT_MIXER4:
+	case WM9090_SPEAKER_MIXER:
+	case WM9090_ANTIPOP2:
+	case WM9090_WRITE_SEQUENCER_0:
+	case WM9090_WRITE_SEQUENCER_1:
+	case WM9090_WRITE_SEQUENCER_2:
+	case WM9090_WRITE_SEQUENCER_3:
+	case WM9090_WRITE_SEQUENCER_4:
+	case WM9090_WRITE_SEQUENCER_5:
+	case WM9090_CHARGE_PUMP_1:
+	case WM9090_DC_SERVO_0:
+	case WM9090_DC_SERVO_1:
+	case WM9090_DC_SERVO_3:
+	case WM9090_DC_SERVO_READBACK_0:
+	case WM9090_DC_SERVO_READBACK_1:
+	case WM9090_DC_SERVO_READBACK_2:
+	case WM9090_ANALOGUE_HP_0:
+	case WM9090_AGC_CONTROL_0:
+	case WM9090_AGC_CONTROL_1:
+	case WM9090_AGC_CONTROL_2:
+		return true;
+
+	default:
+		return false;
 	}
 }
 
@@ -492,8 +478,7 @@ static int wm9090_add_controls(struct snd_soc_codec *codec)
 static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 *reg_cache = codec->reg_cache;
-	int i, ret;
+	struct wm9090_priv *wm9090 = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -513,7 +498,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Restore the register cache */
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm9090->regmap);
 		}
 
 		/* We keep VMID off during standby since the combination of
@@ -537,9 +522,11 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9090_probe(struct snd_soc_codec *codec)
 {
+	struct wm9090_priv *wm9090 = dev_get_drvdata(codec->dev);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	codec->control_data = wm9090->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -548,7 +535,7 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 	ret = snd_soc_read(codec, WM9090_SOFTWARE_RESET);
 	if (ret < 0)
 		return ret;
-	if (ret != wm9090_reg_defaults[WM9090_SOFTWARE_RESET]) {
+	if (ret != 0x9093) {
 		dev_err(codec->dev, "Device is not a WM9090, ID=%x\n", ret);
 		return -EINVAL;
 	}
@@ -624,12 +611,22 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9090 = {
 	.suspend = 	wm9090_suspend,
 	.resume =	wm9090_resume,
 	.set_bias_level = wm9090_set_bias_level,
-	.reg_cache_size = (WM9090_MAX_REGISTER + 1),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm9090_reg_defaults,
-	.volatile_register = wm9090_volatile,
 };
 
+static const struct regmap_config wm9090_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM9090_MAX_REGISTER,
+	.volatile_reg = wm9090_volatile,
+	.readable_reg = wm9090_readable,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm9090_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9090_reg_defaults),
+};
+
+
 static int wm9090_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -642,6 +639,13 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
+	wm9090->regmap = regmap_init_i2c(i2c, &wm9090_regmap);
+	if (IS_ERR(wm9090->regmap)) {
+		ret = PTR_ERR(wm9090->regmap);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	if (i2c->dev.platform_data)
 		memcpy(&wm9090->pdata, i2c->dev.platform_data,
 		       sizeof(wm9090->pdata));
@@ -650,6 +654,15 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9090,  NULL, 0);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	regmap_exit(wm9090->regmap);
 	return ret;
 }
 
@@ -658,6 +671,7 @@ static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
 	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
 
 	snd_soc_unregister_codec(&i2c->dev);
+	regmap_exit(wm9090->regmap);
 
 	return 0;
 }
-- 
1.7.7.3
