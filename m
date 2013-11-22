From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: wm8991: Convert to direct regmap API
	usage
Date: Fri, 22 Nov 2013 13:39:14 +0000
Message-ID: <1385127556-1661-2-git-send-email-broonie@kernel.org>
References: <1385127556-1661-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 34843262607
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:39:25 +0100 (CET)
In-Reply-To: <1385127556-1661-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8991.c | 166 ++++++++++++++++++++++++++--------------------
 1 file changed, 94 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 86aa33fd11de..7006f9732af6 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -31,76 +32,85 @@
 #include "wm8991.h"
 
 struct wm8991_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	unsigned int pcmclk;
 };
 
-static const u16 wm8991_reg_defs[] = {
-	0x8991,     /* R0  - Reset */
-	0x0000,     /* R1  - Power Management (1) */
-	0x6000,     /* R2  - Power Management (2) */
-	0x0000,     /* R3  - Power Management (3) */
-	0x4050,     /* R4  - Audio Interface (1) */
-	0x4000,     /* R5  - Audio Interface (2) */
-	0x01C8,     /* R6  - Clocking (1) */
-	0x0000,     /* R7  - Clocking (2) */
-	0x0040,     /* R8  - Audio Interface (3) */
-	0x0040,     /* R9  - Audio Interface (4) */
-	0x0004,     /* R10 - DAC CTRL */
-	0x00C0,     /* R11 - Left DAC Digital Volume */
-	0x00C0,     /* R12 - Right DAC Digital Volume */
-	0x0000,     /* R13 - Digital Side Tone */
-	0x0100,     /* R14 - ADC CTRL */
-	0x00C0,     /* R15 - Left ADC Digital Volume */
-	0x00C0,     /* R16 - Right ADC Digital Volume */
-	0x0000,     /* R17 */
-	0x0000,     /* R18 - GPIO CTRL 1 */
-	0x1000,     /* R19 - GPIO1 & GPIO2 */
-	0x1010,     /* R20 - GPIO3 & GPIO4 */
-	0x1010,     /* R21 - GPIO5 & GPIO6 */
-	0x8000,     /* R22 - GPIOCTRL 2 */
-	0x0800,     /* R23 - GPIO_POL */
-	0x008B,     /* R24 - Left Line Input 1&2 Volume */
-	0x008B,     /* R25 - Left Line Input 3&4 Volume */
-	0x008B,     /* R26 - Right Line Input 1&2 Volume */
-	0x008B,     /* R27 - Right Line Input 3&4 Volume */
-	0x0000,     /* R28 - Left Output Volume */
-	0x0000,     /* R29 - Right Output Volume */
-	0x0066,     /* R30 - Line Outputs Volume */
-	0x0022,     /* R31 - Out3/4 Volume */
-	0x0079,     /* R32 - Left OPGA Volume */
-	0x0079,     /* R33 - Right OPGA Volume */
-	0x0003,     /* R34 - Speaker Volume */
-	0x0003,     /* R35 - ClassD1 */
-	0x0000,     /* R36 */
-	0x0100,     /* R37 - ClassD3 */
-	0x0000,     /* R38 */
-	0x0000,     /* R39 - Input Mixer1 */
-	0x0000,     /* R40 - Input Mixer2 */
-	0x0000,     /* R41 - Input Mixer3 */
-	0x0000,     /* R42 - Input Mixer4 */
-	0x0000,     /* R43 - Input Mixer5 */
-	0x0000,     /* R44 - Input Mixer6 */
-	0x0000,     /* R45 - Output Mixer1 */
-	0x0000,     /* R46 - Output Mixer2 */
-	0x0000,     /* R47 - Output Mixer3 */
-	0x0000,     /* R48 - Output Mixer4 */
-	0x0000,     /* R49 - Output Mixer5 */
-	0x0000,     /* R50 - Output Mixer6 */
-	0x0180,     /* R51 - Out3/4 Mixer */
-	0x0000,     /* R52 - Line Mixer1 */
-	0x0000,     /* R53 - Line Mixer2 */
-	0x0000,     /* R54 - Speaker Mixer */
-	0x0000,     /* R55 - Additional Control */
-	0x0000,     /* R56 - AntiPOP1 */
-	0x0000,     /* R57 - AntiPOP2 */
-	0x0000,     /* R58 - MICBIAS */
-	0x0000,     /* R59 */
-	0x0008,     /* R60 - PLL1 */
-	0x0031,     /* R61 - PLL2 */
-	0x0026,     /* R62 - PLL3 */
+static const struct reg_default wm8991_reg_defaults[] = {
+	{  1, 0x0000 },     /* R1  - Power Management (1) */
+	{  2, 0x6000 },     /* R2  - Power Management (2) */
+	{  3, 0x0000 },     /* R3  - Power Management (3) */
+	{  4, 0x4050 },     /* R4  - Audio Interface (1) */
+	{  5, 0x4000 },     /* R5  - Audio Interface (2) */
+	{  6, 0x01C8 },     /* R6  - Clocking (1) */
+	{  7, 0x0000 },     /* R7  - Clocking (2) */
+	{  8, 0x0040 },     /* R8  - Audio Interface (3) */
+	{  9, 0x0040 },     /* R9  - Audio Interface (4) */
+	{ 10, 0x0004 },     /* R10 - DAC CTRL */
+	{ 11, 0x00C0 },     /* R11 - Left DAC Digital Volume */
+	{ 12, 0x00C0 },     /* R12 - Right DAC Digital Volume */
+	{ 13, 0x0000 },     /* R13 - Digital Side Tone */
+	{ 14, 0x0100 },     /* R14 - ADC CTRL */
+	{ 15, 0x00C0 },     /* R15 - Left ADC Digital Volume */
+	{ 16, 0x00C0 },     /* R16 - Right ADC Digital Volume */
+
+	{ 18, 0x0000 },     /* R18 - GPIO CTRL 1 */
+	{ 19, 0x1000 },     /* R19 - GPIO1 & GPIO2 */
+	{ 20, 0x1010 },     /* R20 - GPIO3 & GPIO4 */
+	{ 21, 0x1010 },     /* R21 - GPIO5 & GPIO6 */
+	{ 22, 0x8000 },     /* R22 - GPIOCTRL 2 */
+	{ 23, 0x0800 },     /* R23 - GPIO_POL */
+	{ 24, 0x008B },     /* R24 - Left Line Input 1&2 Volume */
+	{ 25, 0x008B },     /* R25 - Left Line Input 3&4 Volume */
+	{ 26, 0x008B },     /* R26 - Right Line Input 1&2 Volume */
+	{ 27, 0x008B },     /* R27 - Right Line Input 3&4 Volume */
+	{ 28, 0x0000 },     /* R28 - Left Output Volume */
+	{ 29, 0x0000 },     /* R29 - Right Output Volume */
+	{ 30, 0x0066 },     /* R30 - Line Outputs Volume */
+	{ 31, 0x0022 },     /* R31 - Out3/4 Volume */
+	{ 32, 0x0079 },     /* R32 - Left OPGA Volume */
+	{ 33, 0x0079 },     /* R33 - Right OPGA Volume */
+	{ 34, 0x0003 },     /* R34 - Speaker Volume */
+	{ 35, 0x0003 },     /* R35 - ClassD1 */
+
+	{ 37, 0x0100 },     /* R37 - ClassD3 */
+
+	{ 39, 0x0000 },     /* R39 - Input Mixer1 */
+	{ 40, 0x0000 },     /* R40 - Input Mixer2 */
+	{ 41, 0x0000 },     /* R41 - Input Mixer3 */
+	{ 42, 0x0000 },     /* R42 - Input Mixer4 */
+	{ 43, 0x0000 },     /* R43 - Input Mixer5 */
+	{ 44, 0x0000 },     /* R44 - Input Mixer6 */
+	{ 45, 0x0000 },     /* R45 - Output Mixer1 */
+	{ 46, 0x0000 },     /* R46 - Output Mixer2 */
+	{ 47, 0x0000 },     /* R47 - Output Mixer3 */
+	{ 48, 0x0000 },     /* R48 - Output Mixer4 */
+	{ 49, 0x0000 },     /* R49 - Output Mixer5 */
+	{ 50, 0x0000 },     /* R50 - Output Mixer6 */
+	{ 51, 0x0180 },     /* R51 - Out3/4 Mixer */
+	{ 52, 0x0000 },     /* R52 - Line Mixer1 */
+	{ 53, 0x0000 },     /* R53 - Line Mixer2 */
+	{ 54, 0x0000 },     /* R54 - Speaker Mixer */
+	{ 55, 0x0000 },     /* R55 - Additional Control */
+	{ 56, 0x0000 },     /* R56 - AntiPOP1 */
+	{ 57, 0x0000 },     /* R57 - AntiPOP2 */
+	{ 58, 0x0000 },     /* R58 - MICBIAS */
+
+	{ 60, 0x0008 },     /* R60 - PLL1 */
+	{ 61, 0x0031 },     /* R61 - PLL2 */
+	{ 62, 0x0026 },     /* R62 - PLL3 */
 };
 
+static bool wm8991_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8991_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #define wm8991_reset(c) snd_soc_write(c, WM8991_RESET, 0)
 
 static const unsigned int rec_mix_tlv[] = {
@@ -1110,6 +1120,7 @@ static int wm8991_mute(struct snd_soc_dai *dai, int mute)
 static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8991_priv *wm8991 = snd_soc_codec_get_drvdata(codec);
 	u16 val;
 
 	switch (level) {
@@ -1125,7 +1136,7 @@ static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+			regcache_sync(wm8991->regmap);
 			/* Enable all output discharge bits */
 			snd_soc_write(codec, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
 				      WM8991_DIS_RLINE | WM8991_DIS_OUT3 |
@@ -1213,7 +1224,7 @@ static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
 		snd_soc_write(codec, WM8991_ANTIPOP2, 0x0);
-		codec->cache_sync = 1;
+		regcache_mark_dirty(wm8991->regmap);
 		break;
 	}
 
@@ -1247,7 +1258,7 @@ static int wm8991_probe(struct snd_soc_codec *codec)
 
 	wm8991 = snd_soc_codec_get_drvdata(codec);
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8991->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache i/o: %d\n", ret);
 		return ret;
@@ -1332,9 +1343,17 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8991_dapm_widgets),
 	.dapm_routes = wm8991_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(wm8991_dapm_routes),
-	.reg_cache_size = WM8991_MAX_REGISTER + 1,
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8991_reg_defs
+};
+
+static const struct regmap_config wm8991_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM8991_PLL3,
+	.volatile_reg = wm8991_volatile,
+	.reg_defaults = wm8991_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8991_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int wm8991_i2c_probe(struct i2c_client *i2c,
@@ -1347,7 +1366,10 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 	if (!wm8991)
 		return -ENOMEM;
 
-	wm8991->control_type = SND_SOC_I2C;
+	wm8991->regmap = devm_regmap_init_i2c(i2c, &wm8991_regmap);
+	if (IS_ERR(wm8991->regmap))
+		return PTR_ERR(wm8991->regmap);
+
 	i2c_set_clientdata(i2c, wm8991);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.8.4.4
