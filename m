From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: Convert WM8903 to direct regmap API
	usage
Date: Fri,  2 Dec 2011 19:28:14 +0000
Message-ID: <1322854095-14437-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F20C424617
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:28:20 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Converting to an rbtree cache as regcache doesn't have a flat cache.
Since the top of the register map is fairly sparse this should be an
overall win.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |  382 +++++++++++++++++++++++---------------------
 1 files changed, 200 insertions(+), 182 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 2f18c51..004db57 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -37,184 +38,84 @@
 #include "wm8903.h"
 
 /* Register defaults at reset */
-static u16 wm8903_reg_defaults[] = {
-	0x8903,     /* R0   - SW Reset and ID */
-	0x0000,     /* R1   - Revision Number */
-	0x0000,     /* R2 */
-	0x0000,     /* R3 */
-	0x0018,     /* R4   - Bias Control 0 */
-	0x0000,     /* R5   - VMID Control 0 */
-	0x0000,     /* R6   - Mic Bias Control 0 */
-	0x0000,     /* R7 */
-	0x0001,     /* R8   - Analogue DAC 0 */
-	0x0000,     /* R9 */
-	0x0001,     /* R10  - Analogue ADC 0 */
-	0x0000,     /* R11 */
-	0x0000,     /* R12  - Power Management 0 */
-	0x0000,     /* R13  - Power Management 1 */
-	0x0000,     /* R14  - Power Management 2 */
-	0x0000,     /* R15  - Power Management 3 */
-	0x0000,     /* R16  - Power Management 4 */
-	0x0000,     /* R17  - Power Management 5 */
-	0x0000,     /* R18  - Power Management 6 */
-	0x0000,     /* R19 */
-	0x0400,     /* R20  - Clock Rates 0 */
-	0x0D07,     /* R21  - Clock Rates 1 */
-	0x0000,     /* R22  - Clock Rates 2 */
-	0x0000,     /* R23 */
-	0x0050,     /* R24  - Audio Interface 0 */
-	0x0242,     /* R25  - Audio Interface 1 */
-	0x0008,     /* R26  - Audio Interface 2 */
-	0x0022,     /* R27  - Audio Interface 3 */
-	0x0000,     /* R28 */
-	0x0000,     /* R29 */
-	0x00C0,     /* R30  - DAC Digital Volume Left */
-	0x00C0,     /* R31  - DAC Digital Volume Right */
-	0x0000,     /* R32  - DAC Digital 0 */
-	0x0000,     /* R33  - DAC Digital 1 */
-	0x0000,     /* R34 */
-	0x0000,     /* R35 */
-	0x00C0,     /* R36  - ADC Digital Volume Left */
-	0x00C0,     /* R37  - ADC Digital Volume Right */
-	0x0000,     /* R38  - ADC Digital 0 */
-	0x0073,     /* R39  - Digital Microphone 0 */
-	0x09BF,     /* R40  - DRC 0 */
-	0x3241,     /* R41  - DRC 1 */
-	0x0020,     /* R42  - DRC 2 */
-	0x0000,     /* R43  - DRC 3 */
-	0x0085,     /* R44  - Analogue Left Input 0 */
-	0x0085,     /* R45  - Analogue Right Input 0 */
-	0x0044,     /* R46  - Analogue Left Input 1 */
-	0x0044,     /* R47  - Analogue Right Input 1 */
-	0x0000,     /* R48 */
-	0x0000,     /* R49 */
-	0x0008,     /* R50  - Analogue Left Mix 0 */
-	0x0004,     /* R51  - Analogue Right Mix 0 */
-	0x0000,     /* R52  - Analogue Spk Mix Left 0 */
-	0x0000,     /* R53  - Analogue Spk Mix Left 1 */
-	0x0000,     /* R54  - Analogue Spk Mix Right 0 */
-	0x0000,     /* R55  - Analogue Spk Mix Right 1 */
-	0x0000,     /* R56 */
-	0x002D,     /* R57  - Analogue OUT1 Left */
-	0x002D,     /* R58  - Analogue OUT1 Right */
-	0x0039,     /* R59  - Analogue OUT2 Left */
-	0x0039,     /* R60  - Analogue OUT2 Right */
-	0x0100,     /* R61 */
-	0x0139,     /* R62  - Analogue OUT3 Left */
-	0x0139,     /* R63  - Analogue OUT3 Right */
-	0x0000,     /* R64 */
-	0x0000,     /* R65  - Analogue SPK Output Control 0 */
-	0x0000,     /* R66 */
-	0x0010,     /* R67  - DC Servo 0 */
-	0x0100,     /* R68 */
-	0x00A4,     /* R69  - DC Servo 2 */
-	0x0807,     /* R70 */
-	0x0000,     /* R71 */
-	0x0000,     /* R72 */
-	0x0000,     /* R73 */
-	0x0000,     /* R74 */
-	0x0000,     /* R75 */
-	0x0000,     /* R76 */
-	0x0000,     /* R77 */
-	0x0000,     /* R78 */
-	0x000E,     /* R79 */
-	0x0000,     /* R80 */
-	0x0000,     /* R81 */
-	0x0000,     /* R82 */
-	0x0000,     /* R83 */
-	0x0000,     /* R84 */
-	0x0000,     /* R85 */
-	0x0000,     /* R86 */
-	0x0006,     /* R87 */
-	0x0000,     /* R88 */
-	0x0000,     /* R89 */
-	0x0000,     /* R90  - Analogue HP 0 */
-	0x0060,     /* R91 */
-	0x0000,     /* R92 */
-	0x0000,     /* R93 */
-	0x0000,     /* R94  - Analogue Lineout 0 */
-	0x0060,     /* R95 */
-	0x0000,     /* R96 */
-	0x0000,     /* R97 */
-	0x0000,     /* R98  - Charge Pump 0 */
-	0x1F25,     /* R99 */
-	0x2B19,     /* R100 */
-	0x01C0,     /* R101 */
-	0x01EF,     /* R102 */
-	0x2B00,     /* R103 */
-	0x0000,     /* R104 - Class W 0 */
-	0x01C0,     /* R105 */
-	0x1C10,     /* R106 */
-	0x0000,     /* R107 */
-	0x0000,     /* R108 - Write Sequencer 0 */
-	0x0000,     /* R109 - Write Sequencer 1 */
-	0x0000,     /* R110 - Write Sequencer 2 */
-	0x0000,     /* R111 - Write Sequencer 3 */
-	0x0000,     /* R112 - Write Sequencer 4 */
-	0x0000,     /* R113 */
-	0x0000,     /* R114 - Control Interface */
-	0x0000,     /* R115 */
-	0x00A8,     /* R116 - GPIO Control 1 */
-	0x00A8,     /* R117 - GPIO Control 2 */
-	0x00A8,     /* R118 - GPIO Control 3 */
-	0x0220,     /* R119 - GPIO Control 4 */
-	0x01A0,     /* R120 - GPIO Control 5 */
-	0x0000,     /* R121 - Interrupt Status 1 */
-	0xFFFF,     /* R122 - Interrupt Status 1 Mask */
-	0x0000,     /* R123 - Interrupt Polarity 1 */
-	0x0000,     /* R124 */
-	0x0003,     /* R125 */
-	0x0000,     /* R126 - Interrupt Control */
-	0x0000,     /* R127 */
-	0x0005,     /* R128 */
-	0x0000,     /* R129 - Control Interface Test 1 */
-	0x0000,     /* R130 */
-	0x0000,     /* R131 */
-	0x0000,     /* R132 */
-	0x0000,     /* R133 */
-	0x0000,     /* R134 */
-	0x03FF,     /* R135 */
-	0x0007,     /* R136 */
-	0x0040,     /* R137 */
-	0x0000,     /* R138 */
-	0x0000,     /* R139 */
-	0x0000,     /* R140 */
-	0x0000,     /* R141 */
-	0x0000,     /* R142 */
-	0x0000,     /* R143 */
-	0x0000,     /* R144 */
-	0x0000,     /* R145 */
-	0x0000,     /* R146 */
-	0x0000,     /* R147 */
-	0x4000,     /* R148 */
-	0x6810,     /* R149 - Charge Pump Test 1 */
-	0x0004,     /* R150 */
-	0x0000,     /* R151 */
-	0x0000,     /* R152 */
-	0x0000,     /* R153 */
-	0x0000,     /* R154 */
-	0x0000,     /* R155 */
-	0x0000,     /* R156 */
-	0x0000,     /* R157 */
-	0x0000,     /* R158 */
-	0x0000,     /* R159 */
-	0x0000,     /* R160 */
-	0x0000,     /* R161 */
-	0x0000,     /* R162 */
-	0x0000,     /* R163 */
-	0x0028,     /* R164 - Clock Rate Test 4 */
-	0x0004,     /* R165 */
-	0x0000,     /* R166 */
-	0x0060,     /* R167 */
-	0x0000,     /* R168 */
-	0x0000,     /* R169 */
-	0x0000,     /* R170 */
-	0x0000,     /* R171 */
-	0x0000,     /* R172 - Analogue Output Bias 0 */
+static const struct reg_default wm8903_reg_defaults[] = {
+	{ 4,  0x0018 },     /* R4   - Bias Control 0 */
+	{ 5,  0x0000 },     /* R5   - VMID Control 0 */
+	{ 6,  0x0000 },     /* R6   - Mic Bias Control 0 */
+	{ 8,  0x0001 },     /* R8   - Analogue DAC 0 */
+	{ 10, 0x0001 },     /* R10  - Analogue ADC 0 */
+	{ 12, 0x0000 },     /* R12  - Power Management 0 */
+	{ 13, 0x0000 },     /* R13  - Power Management 1 */
+	{ 14, 0x0000 },     /* R14  - Power Management 2 */
+	{ 15, 0x0000 },     /* R15  - Power Management 3 */
+	{ 16, 0x0000 },     /* R16  - Power Management 4 */
+	{ 17, 0x0000 },     /* R17  - Power Management 5 */
+	{ 18, 0x0000 },     /* R18  - Power Management 6 */
+	{ 20, 0x0400 },     /* R20  - Clock Rates 0 */
+	{ 21, 0x0D07 },     /* R21  - Clock Rates 1 */
+	{ 22, 0x0000 },     /* R22  - Clock Rates 2 */
+	{ 24, 0x0050 },     /* R24  - Audio Interface 0 */
+	{ 25, 0x0242 },     /* R25  - Audio Interface 1 */
+	{ 26, 0x0008 },     /* R26  - Audio Interface 2 */
+	{ 27, 0x0022 },     /* R27  - Audio Interface 3 */
+	{ 30, 0x00C0 },     /* R30  - DAC Digital Volume Left */
+	{ 31, 0x00C0 },     /* R31  - DAC Digital Volume Right */
+	{ 32, 0x0000 },     /* R32  - DAC Digital 0 */
+	{ 33, 0x0000 },     /* R33  - DAC Digital 1 */
+	{ 36, 0x00C0 },     /* R36  - ADC Digital Volume Left */
+	{ 37, 0x00C0 },     /* R37  - ADC Digital Volume Right */
+	{ 38, 0x0000 },     /* R38  - ADC Digital 0 */
+	{ 39, 0x0073 },     /* R39  - Digital Microphone 0 */
+	{ 40, 0x09BF },     /* R40  - DRC 0 */
+	{ 41, 0x3241 },     /* R41  - DRC 1 */
+	{ 42, 0x0020 },     /* R42  - DRC 2 */
+	{ 43, 0x0000 },     /* R43  - DRC 3 */
+	{ 44, 0x0085 },     /* R44  - Analogue Left Input 0 */
+	{ 45, 0x0085 },     /* R45  - Analogue Right Input 0 */
+	{ 46, 0x0044 },     /* R46  - Analogue Left Input 1 */
+	{ 47, 0x0044 },     /* R47  - Analogue Right Input 1 */
+	{ 50, 0x0008 },     /* R50  - Analogue Left Mix 0 */
+	{ 51, 0x0004 },     /* R51  - Analogue Right Mix 0 */
+	{ 52, 0x0000 },     /* R52  - Analogue Spk Mix Left 0 */
+	{ 53, 0x0000 },     /* R53  - Analogue Spk Mix Left 1 */
+	{ 54, 0x0000 },     /* R54  - Analogue Spk Mix Right 0 */
+	{ 55, 0x0000 },     /* R55  - Analogue Spk Mix Right 1 */
+	{ 57, 0x002D },     /* R57  - Analogue OUT1 Left */
+	{ 58, 0x002D },     /* R58  - Analogue OUT1 Right */
+	{ 59, 0x0039 },     /* R59  - Analogue OUT2 Left */
+	{ 60, 0x0039 },     /* R60  - Analogue OUT2 Right */
+	{ 62, 0x0139 },     /* R62  - Analogue OUT3 Left */
+	{ 63, 0x0139 },     /* R63  - Analogue OUT3 Right */
+	{ 64, 0x0000 },     /* R65  - Analogue SPK Output Control 0 */
+	{ 67, 0x0010 },     /* R67  - DC Servo 0 */
+	{ 69, 0x00A4 },     /* R69  - DC Servo 2 */
+	{ 90, 0x0000 },     /* R90  - Analogue HP 0 */
+	{ 94, 0x0000 },     /* R94  - Analogue Lineout 0 */
+	{ 98, 0x0000 },     /* R98  - Charge Pump 0 */
+	{ 104, 0x0000 },    /* R104 - Class W 0 */
+	{ 108, 0x0000 },    /* R108 - Write Sequencer 0 */
+	{ 109, 0x0000 },    /* R109 - Write Sequencer 1 */
+	{ 110, 0x0000 },    /* R110 - Write Sequencer 2 */
+	{ 111, 0x0000 },    /* R111 - Write Sequencer 3 */
+	{ 112, 0x0000 },    /* R112 - Write Sequencer 4 */
+	{ 114, 0x0000 },    /* R114 - Control Interface */
+	{ 116, 0x00A8 },    /* R116 - GPIO Control 1 */
+	{ 117, 0x00A8 },    /* R117 - GPIO Control 2 */
+	{ 118, 0x00A8 },    /* R118 - GPIO Control 3 */
+	{ 119, 0x0220 },    /* R119 - GPIO Control 4 */
+	{ 120, 0x01A0 },    /* R120 - GPIO Control 5 */
+	{ 122, 0xFFFF },    /* R122 - Interrupt Status 1 Mask */
+	{ 123, 0x0000 },    /* R123 - Interrupt Polarity 1 */
+	{ 126, 0x0000 },    /* R126 - Interrupt Control */
+	{ 129, 0x0000 },    /* R129 - Control Interface Test 1 */
+	{ 149, 0x6810 },    /* R149 - Charge Pump Test 1 */
+	{ 164, 0x0028 },    /* R164 - Clock Rate Test 4 */
+	{ 172, 0x0000 },    /* R172 - Analogue Output Bias 0 */
 };
 
 struct wm8903_priv {
 	struct snd_soc_codec *codec;
+	struct regmap *regmap;
 
 	int sysclk;
 	int irq;
@@ -239,7 +140,97 @@ struct wm8903_priv {
 #endif
 };
 
-static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8903_readable_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8903_SW_RESET_AND_ID:
+	case WM8903_REVISION_NUMBER:
+	case WM8903_BIAS_CONTROL_0:
+	case WM8903_VMID_CONTROL_0:
+	case WM8903_MIC_BIAS_CONTROL_0:
+	case WM8903_ANALOGUE_DAC_0:
+	case WM8903_ANALOGUE_ADC_0:
+	case WM8903_POWER_MANAGEMENT_0:
+	case WM8903_POWER_MANAGEMENT_1:
+	case WM8903_POWER_MANAGEMENT_2:
+	case WM8903_POWER_MANAGEMENT_3:
+	case WM8903_POWER_MANAGEMENT_4:
+	case WM8903_POWER_MANAGEMENT_5:
+	case WM8903_POWER_MANAGEMENT_6:
+	case WM8903_CLOCK_RATES_0:
+	case WM8903_CLOCK_RATES_1:
+	case WM8903_CLOCK_RATES_2:
+	case WM8903_AUDIO_INTERFACE_0:
+	case WM8903_AUDIO_INTERFACE_1:
+	case WM8903_AUDIO_INTERFACE_2:
+	case WM8903_AUDIO_INTERFACE_3:
+	case WM8903_DAC_DIGITAL_VOLUME_LEFT:
+	case WM8903_DAC_DIGITAL_VOLUME_RIGHT:
+	case WM8903_DAC_DIGITAL_0:
+	case WM8903_DAC_DIGITAL_1:
+	case WM8903_ADC_DIGITAL_VOLUME_LEFT:
+	case WM8903_ADC_DIGITAL_VOLUME_RIGHT:
+	case WM8903_ADC_DIGITAL_0:
+	case WM8903_DIGITAL_MICROPHONE_0:
+	case WM8903_DRC_0:
+	case WM8903_DRC_1:
+	case WM8903_DRC_2:
+	case WM8903_DRC_3:
+	case WM8903_ANALOGUE_LEFT_INPUT_0:
+	case WM8903_ANALOGUE_RIGHT_INPUT_0:
+	case WM8903_ANALOGUE_LEFT_INPUT_1:
+	case WM8903_ANALOGUE_RIGHT_INPUT_1:
+	case WM8903_ANALOGUE_LEFT_MIX_0:
+	case WM8903_ANALOGUE_RIGHT_MIX_0:
+	case WM8903_ANALOGUE_SPK_MIX_LEFT_0:
+	case WM8903_ANALOGUE_SPK_MIX_LEFT_1:
+	case WM8903_ANALOGUE_SPK_MIX_RIGHT_0:
+	case WM8903_ANALOGUE_SPK_MIX_RIGHT_1:
+	case WM8903_ANALOGUE_OUT1_LEFT:
+	case WM8903_ANALOGUE_OUT1_RIGHT:
+	case WM8903_ANALOGUE_OUT2_LEFT:
+	case WM8903_ANALOGUE_OUT2_RIGHT:
+	case WM8903_ANALOGUE_OUT3_LEFT:
+	case WM8903_ANALOGUE_OUT3_RIGHT:
+	case WM8903_ANALOGUE_SPK_OUTPUT_CONTROL_0:
+	case WM8903_DC_SERVO_0:
+	case WM8903_DC_SERVO_2:
+	case WM8903_DC_SERVO_READBACK_1:
+	case WM8903_DC_SERVO_READBACK_2:
+	case WM8903_DC_SERVO_READBACK_3:
+	case WM8903_DC_SERVO_READBACK_4:
+	case WM8903_ANALOGUE_HP_0:
+	case WM8903_ANALOGUE_LINEOUT_0:
+	case WM8903_CHARGE_PUMP_0:
+	case WM8903_CLASS_W_0:
+	case WM8903_WRITE_SEQUENCER_0:
+	case WM8903_WRITE_SEQUENCER_1:
+	case WM8903_WRITE_SEQUENCER_2:
+	case WM8903_WRITE_SEQUENCER_3:
+	case WM8903_WRITE_SEQUENCER_4:
+	case WM8903_CONTROL_INTERFACE:
+	case WM8903_GPIO_CONTROL_1:
+	case WM8903_GPIO_CONTROL_2:
+	case WM8903_GPIO_CONTROL_3:
+	case WM8903_GPIO_CONTROL_4:
+	case WM8903_GPIO_CONTROL_5:
+	case WM8903_INTERRUPT_STATUS_1:
+	case WM8903_INTERRUPT_STATUS_1_MASK:
+	case WM8903_INTERRUPT_POLARITY_1:
+	case WM8903_INTERRUPT_CONTROL:
+	case WM8903_FLL_CONTROL_1:
+	case WM8903_FLL_CONTROL_2:
+	case WM8903_FLL_CONTROL_3:
+	case WM8903_FLL_CONTROL_4:
+	case WM8903_CLOCK_RATE_TEST_4:
+	case WM8903_ANALOGUE_OUTPUT_BIAS_0:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool wm8903_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8903_SW_RESET_AND_ID:
@@ -1767,7 +1758,7 @@ static int wm8903_resume(struct snd_soc_codec *codec)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_cache_sync(codec);
+	regcache_sync(wm8903->regmap);
 
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1897,15 +1888,16 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	u16 val;
 
 	wm8903->codec = codec;
+	codec->control_data = wm8903->regmap;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
 	val = snd_soc_read(codec, WM8903_SW_RESET_AND_ID);
-	if (val != wm8903_reg_defaults[WM8903_SW_RESET_AND_ID]) {
+	if (val != 0x8903) {
 		dev_err(codec->dev,
 			"Device with ID register %x is not a WM8903\n", val);
 		return -ENODEV;
@@ -2044,10 +2036,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.suspend =	wm8903_suspend,
 	.resume =	wm8903_resume,
 	.set_bias_level = wm8903_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8903_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8903_reg_defaults,
-	.volatile_register = wm8903_volatile_register,
 	.seq_notifier = wm8903_seq_notifier,
 	.controls = wm8903_snd_controls,
 	.num_controls = ARRAY_SIZE(wm8903_snd_controls),
@@ -2057,6 +2045,19 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8903_intercon),
 };
 
+static const struct regmap_config wm8903_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM8903_MAX_REGISTER,
+	.volatile_reg = wm8903_volatile_register,
+	.readable_reg = wm8903_readable_register,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8903_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8903_reg_defaults),
+};
+
 static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
@@ -2068,18 +2069,35 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	if (wm8903 == NULL)
 		return -ENOMEM;
 
+	wm8903->regmap = regmap_init_i2c(i2c, &wm8903_regmap);
+	if (IS_ERR(wm8903->regmap)) {
+		ret = PTR_ERR(wm8903->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8903);
 	wm8903->irq = i2c->irq;
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
+	if (ret != 0)
+		goto err;
 
+	return 0;
+err:
+	regmap_exit(wm8903->regmap);
 	return ret;
 }
 
 static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 {
+	struct wm8903_priv *wm8903 = i2c_get_clientdata(client);
+
+	regmap_exit(wm8903->regmap);
 	snd_soc_unregister_codec(&client->dev);
+
 	return 0;
 }
 
-- 
1.7.7.3
