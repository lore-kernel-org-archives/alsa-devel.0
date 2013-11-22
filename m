From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: wm8990: Convert to direct regmap API
	usage
Date: Fri, 22 Nov 2013 14:39:52 +0000
Message-ID: <1385131192-28693-5-git-send-email-broonie@kernel.org>
References: <1385131192-28693-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 187182650C4
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:40:06 +0100 (CET)
In-Reply-To: <1385131192-28693-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, patches@opensouce.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8990.c | 156 ++++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 2261fe1b68ce..0ccd4d8d043b 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -30,13 +31,12 @@
 
 /* codec private data */
 struct wm8990_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	unsigned int sysclk;
 	unsigned int pcmclk;
 };
 
-static int wm8990_volatile_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
+static bool wm8990_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8990_RESET:
@@ -46,71 +46,69 @@ static int wm8990_volatile_register(struct snd_soc_codec *codec,
 	}
 }
 
-static const u16 wm8990_reg[] = {
-	0x8990,     /* R0  - Reset */
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
-	0x0079,     /* R38 - ClassD4 */
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
-	0x0000,	    /* R63 - Driver internal */
+static const struct reg_default wm8990_reg_defaults[] = {
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
+	{ 38, 0x0079 },     /* R38 - ClassD4 */
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
 
 #define wm8990_reset(c) snd_soc_write(c, WM8990_RESET, 0)
@@ -1114,6 +1112,7 @@ static int wm8990_mute(struct snd_soc_dai *dai, int mute)
 static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct wm8990_priv *wm8990 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	switch (level) {
@@ -1128,7 +1127,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			ret = snd_soc_cache_sync(codec);
+			ret = regcache_sync(wm8990->regmap);
 			if (ret < 0) {
 				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
 				return ret;
@@ -1226,7 +1225,7 @@ static int wm8990_set_bias_level(struct snd_soc_codec *codec,
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
 		snd_soc_write(codec, WM8990_ANTIPOP2, 0x0);
 
-		codec->cache_sync = 1;
+		regcache_mark_dirty(wm8990->regmap);
 		break;
 	}
 
@@ -1295,7 +1294,7 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8990: failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1334,10 +1333,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.suspend =	wm8990_suspend,
 	.resume =	wm8990_resume,
 	.set_bias_level = wm8990_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8990_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8990_reg,
-	.volatile_register = wm8990_volatile_register,
 	.controls =	wm8990_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8990_snd_controls),
 	.dapm_widgets = wm8990_dapm_widgets,
@@ -1346,6 +1341,17 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8990_dapm_routes),
 };
 
+static const struct regmap_config wm8990_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM8990_PLL3,
+	.volatile_reg = wm8990_volatile_register,
+	.reg_defaults = wm8990_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8990_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int wm8990_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-- 
1.8.4.4
