From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 4/6] ASoC: alc5632: Remove unrelevant registers
	and name the relevant
Date: Wed, 16 Nov 2011 12:07:01 +0200
Message-ID: <1321438023-29660-5-git-send-email-leon@leon.nu>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9291E24468
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:32 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 10so213890eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 02:07:32 -0800 (PST)
In-Reply-To: <1321438023-29660-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |  177 ++++++++++++++------------------------------
 1 files changed, 57 insertions(+), 120 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 902f178..ea40f02 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -36,118 +36,55 @@
  * ALC5632 register cache
  */
 static struct reg_default  alc5632_reg_defaults[] = {
-	{   0, 0x59B4 },
-	{   1, 0x0000 }, 
-	{   2, 0x8080 }, 
-	{   3, 0x0000 }, 
-	{   4, 0x8080 }, 
-	{   5, 0x0000 }, 
-	{   6, 0x8080 }, 
-	{   7, 0x0000 }, 
-	{   8, 0xC800 }, 
-	{   9, 0x0000 }, 
-	{  10, 0xE808 }, 
-	{  11, 0x0000 },
-	{  12, 0x1010 }, 
-	{  13, 0x0000 }, 
-	{  14, 0x0808 }, 
-	{  15, 0x0000 },
-	{  16, 0xEE0F }, 
-	{  17, 0x0000 }, 
-	{  18, 0xCBCB }, 
-	{  19, 0x0000 },
-	{  20, 0x7F7F }, 
-	{  21, 0x0000 }, 
-	{  22, 0x0000 }, 
-	{  23, 0x0000 },
-	{  24, 0xE010 }, 
-	{  25, 0x0000 }, 
-	{  26, 0x0000 }, 
-	{  27, 0x0000 },
-	{  28, 0x8008 }, 
-	{  29, 0x0000 }, 
-	{  30, 0x0000 }, 
-	{  31, 0x0000 },
-	{  32, 0x0000 }, 
-	{  33, 0x0000 }, 
-	{  34, 0x0000 }, 
-	{  35, 0x0000 },
-	{  36, 0x00C0 }, 
-	{  37, 0x0000 }, 
-	{  38, 0xEF00 }, 
-	{  39, 0x0000 },
-	{  40, 0x0000 }, 
-	{  41, 0x0000 },
-	{  42, 0x0000 }, 
-	{  43, 0x0000 },
-	{  44, 0x0000 }, 
-	{  45, 0x0000 }, 
-	{  46, 0x0000 },
-	{  47, 0x0000 },
-	{  48, 0x0000 }, 
-	{  49, 0x0000 }, 
-	{  50, 0x0000 }, 
-	{  51, 0x0000 },
-	{  52, 0x8000 }, 
-	{  53, 0x0000 }, 
-	{  54, 0x0000 }, 
-	{  55, 0x0000 },
-	{  56, 0x0000 }, 
-	{  57, 0x0000 }, 
-	{  58, 0x0000 }, 
-	{  59, 0x0000 },
-	{  60, 0x0000 }, 
-	{  61, 0x0000 }, 
-	{  62, 0x8000 }, 
-	{  63, 0x0000 },
-	{  64, 0x0C0A }, 
-	{  65, 0x0000 }, 
-	{  66, 0x0000 }, 
-	{  67, 0x0000 },
-	{  68, 0x0000 }, 
-	{  69, 0x0000 }, 
-	{  70, 0x0000 }, 
-	{  71, 0x0000 },
-	{  72, 0x0000 }, 
-	{  73, 0x0000 }, 
-	{  74, 0x0000 }, 
-	{  75, 0x0000 },
-	{  76, 0xBE3E }, 
-	{  77, 0x0000 }, 
-	{  78, 0xBE3E }, 
-	{  79, 0x0000 },
-	{  80, 0x0000 }, 
-	{  81, 0x0000 }, 
-	{  82, 0x0000 }, 
-	{  83, 0x0000 },
-	{  84, 0x803A }, 
-	{  85, 0x0000 }, 
-	{  86, 0x0000 }, 
-	{  87, 0x0000 },
-	{  88, 0x0000 }, 
-	{  89, 0x0000 }, 
-	{  90, 0x0009 }, 
-	{  91, 0x0000 },
-	{  92, 0x0000 }, 
-	{  93, 0x0000 }, 
-	{  94, 0x3000 }, 
-	{  95, 0x0000 },
-	{  96, 0x3075 }, 
-	{  97, 0x0000 }, 
-	{  98, 0x1010 }, 
-	{  99, 0x0000 },
-	{ 100, 0x3110 }, 
-	{ 101, 0x0000 }, 
-	{ 102, 0x0000 }, 
-	{ 103, 0x0000 },
-	{ 104, 0x0553 }, 
-	{ 105, 0x0000 }, 
-	{ 106, 0x0000 }, 
-	{ 107, 0x0000 },
-	{ 108, 0x0000 }, 
-	{ 109, 0x0000 }, 
-	{ 110, 0x0000 }, 
-	{ 111, 0x0000 },
+	{   0, 0x59B4 },	/* R0   - Reset */
+	{   2, 0x8080 },	/* R2   - Speaker Output Volume */
+	{   4, 0x8080 },	/* R4   - Headphone Output Volume */
+	{   6, 0x8080 },	/* R6   - AUXOUT Volume */
+	{   8, 0xC800 },	/* R8   - Phone Input */
+	{  10, 0xE808 },	/* R10  - LINE_IN Volume */
+	{  12, 0x1010 },	/* R12  - STEREO DAC Input Volume */
+	{  14, 0x0808 },	/* R14  - MIC Input Volume */
+	{  16, 0xEE0F },	/* R16  - Stereo DAC and MIC Routing Control */
+	{  18, 0xCBCB },	/* R18  - ADC Record Gain */
+	{  20, 0x7F7F },	/* R20  - ADC Record Mixer Control */
+	{  24, 0xE010 },	/* R24  - Voice DAC Volume */
+	{  28, 0x8008 },	/* R28  - Output Mixer Control */
+	{  34, 0x0000 },	/* R34  - Microphone Control */
+	{  36, 0x00C0 },    /* R36  - Codec Digital MIC/Digital Boost
+						   Control */
+	{  38, 0xEF00 },	/* R38  - Power Down Control/Status */
+	{  46, 0x0000 },	/* R46  - Stereo DAC/Voice DAC/Stereo ADC
+						   Function Select */
+	{  52, 0x8000 },	/* R52  - Main Serial Data Port Control
+						   (Stereo I2S) */
+	{  54, 0x0000 },	/* R54  - Extend Serial Data Port Control
+						   (VoDAC_I2S/PCM) */
+	{  58, 0x0000 },	/* R58  - Power Management Addition 1 */
+	{  60, 0x0000 },	/* R60  - Power Management Addition 2 */
+	{  62, 0x8000 },	/* R62  - Power Management Addition 3 */
+	{  64, 0x0C0A },	/* R64  - General Purpose Control Register 1 */
+	{  66, 0x0000 },	/* R66  - General Purpose Control Register 2 */
+	{  68, 0x0000 },	/* R68  - PLL1 Control */
+	{  70, 0x0000 },	/* R70  - PLL2 Control */
+	{  76, 0xBE3E },	/* R76  - GPIO Pin Configuration */
+	{  78, 0xBE3E },	/* R78  - GPIO Pin Polarity */
+	{  80, 0x0000 },	/* R80  - GPIO Pin Sticky */
+	{  82, 0x0000 },	/* R82  - GPIO Pin Wake Up */
+	{  84, 0x803A },	/* R84  - GPIO Pin Status */
+	{  86, 0x0000 },	/* R86  - Pin Sharing */
+	{  88, 0x0000 },	/* R88  - Over-Temp/Current Status */
+	{  90, 0x0009 },	/* R90  - Soft Volume Control Setting */
+	{  92, 0x0000 },	/* R92  - GPIO_Output Pin Control */
+	{  94, 0x3000 },	/* R94  - MISC Control */
+	{  96, 0x3075 },	/* R96  - Stereo DAC Clock Control_1 */
+	{  98, 0x1010 },	/* R98  - Stereo DAC Clock Control_2 */
+	{ 100, 0x3110 },	/* R100 - VoDAC_PCM Clock Control_1 */
+	{ 104, 0x0553 },	/* R104 - Pseudo Stereo and Spatial Effect
+						   Block Control */
+	{ 106, 0x0000 },	/* R106 - Private Register Address */
+	{ 108, 0x0000 },	/* R108 - Private Register Data */
+	{ 110, 0x0000 },	/* R110 - EQ Control and Status/ADC
+							HPF Control */
 };
 
 /* codec private data */
@@ -1023,7 +960,7 @@ static struct snd_soc_dai_driver alc5632_dai = {
 	.symmetric_rates = 1,
 };
 
-#ifdef CONFIG_PM 
+#ifdef CONFIG_PM
 static int alc5632_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 {
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -1035,7 +972,7 @@ static int alc5632_resume(struct snd_soc_codec *codec)
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 
 	regcache_sync(alc5632->regmap);
-	
+
 	alc5632_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
@@ -1097,7 +1034,7 @@ static struct regmap_config alc5632_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
 
-	.max_register = ALC5632_MAX_REGISTER, 
+	.max_register = ALC5632_MAX_REGISTER,
 	.reg_defaults = alc5632_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(alc5632_reg_defaults),
 	.volatile_reg = alc5632_volatile_register,
@@ -1165,14 +1102,14 @@ static __devinit int alc5632_i2c_probe(struct i2c_client *client,
 		dev_err(&client->dev, "regmap_init() failed: %d\n", ret);
 		return ret;
 	}
-	
+
 	ret = alc5632_reset(alc5632->regmap);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to issue reset\n");
 		regmap_exit(alc5632->regmap);
 		return ret;
 	}
-	
+
 	ret =  snd_soc_register_codec(&client->dev,
 		&soc_codec_device_alc5632, &alc5632_dai, 1);
 
@@ -1209,7 +1146,7 @@ static struct i2c_driver alc5632_i2c_driver = {
 	.remove =  __devexit_p(alc5632_i2c_remove),
 	.id_table = alc5632_i2c_table,
 };
-#endif 
+#endif
 
 static int __init alc5632_modinit(void)
 {
@@ -1227,9 +1164,9 @@ module_init(alc5632_modinit);
 
 static void __exit alc5632_modexit(void)
 {
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)	
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&alc5632_i2c_driver);
-#endif	
+#endif
 }
 module_exit(alc5632_modexit);
 
-- 
1.7.3.4
