From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Convert wm8993 to direct regmap API
	usage
Date: Wed, 14 Dec 2011 17:00:53 +0800
Message-ID: <1323853254-9020-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323853254-9020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64BA52459E
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
 sound/soc/codecs/wm8993.c |  422 +++++++++++++++++++++++++++++----------------
 1 files changed, 272 insertions(+), 150 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 2835e7d..daf8296 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -40,134 +41,112 @@ static const char *wm8993_supply_names[WM8993_NUM_SUPPLIES] = {
 	"SPKVDD",
 };
 
-static u16 wm8993_reg_defaults[WM8993_REGISTER_COUNT] = {
-	0x8993,     /* R0   - Software Reset */
-	0x0000,     /* R1   - Power Management (1) */
-	0x6000,     /* R2   - Power Management (2) */
-	0x0000,     /* R3   - Power Management (3) */
-	0x4050,     /* R4   - Audio Interface (1) */
-	0x4000,     /* R5   - Audio Interface (2) */
-	0x01C8,     /* R6   - Clocking 1 */
-	0x0000,     /* R7   - Clocking 2 */
-	0x0000,     /* R8   - Audio Interface (3) */
-	0x0040,     /* R9   - Audio Interface (4) */
-	0x0004,     /* R10  - DAC CTRL */
-	0x00C0,     /* R11  - Left DAC Digital Volume */
-	0x00C0,     /* R12  - Right DAC Digital Volume */
-	0x0000,     /* R13  - Digital Side Tone */
-	0x0300,     /* R14  - ADC CTRL */
-	0x00C0,     /* R15  - Left ADC Digital Volume */
-	0x00C0,     /* R16  - Right ADC Digital Volume */
-	0x0000,     /* R17 */
-	0x0000,     /* R18  - GPIO CTRL 1 */
-	0x0010,     /* R19  - GPIO1 */
-	0x0000,     /* R20  - IRQ_DEBOUNCE */
-	0x0000,     /* R21 */
-	0x8000,     /* R22  - GPIOCTRL 2 */
-	0x0800,     /* R23  - GPIO_POL */
-	0x008B,     /* R24  - Left Line Input 1&2 Volume */
-	0x008B,     /* R25  - Left Line Input 3&4 Volume */
-	0x008B,     /* R26  - Right Line Input 1&2 Volume */
-	0x008B,     /* R27  - Right Line Input 3&4 Volume */
-	0x006D,     /* R28  - Left Output Volume */
-	0x006D,     /* R29  - Right Output Volume */
-	0x0066,     /* R30  - Line Outputs Volume */
-	0x0020,     /* R31  - HPOUT2 Volume */
-	0x0079,     /* R32  - Left OPGA Volume */
-	0x0079,     /* R33  - Right OPGA Volume */
-	0x0003,     /* R34  - SPKMIXL Attenuation */
-	0x0003,     /* R35  - SPKMIXR Attenuation */
-	0x0011,     /* R36  - SPKOUT Mixers */
-	0x0100,     /* R37  - SPKOUT Boost */
-	0x0079,     /* R38  - Speaker Volume Left */
-	0x0079,     /* R39  - Speaker Volume Right */
-	0x0000,     /* R40  - Input Mixer2 */
-	0x0000,     /* R41  - Input Mixer3 */
-	0x0000,     /* R42  - Input Mixer4 */
-	0x0000,     /* R43  - Input Mixer5 */
-	0x0000,     /* R44  - Input Mixer6 */
-	0x0000,     /* R45  - Output Mixer1 */
-	0x0000,     /* R46  - Output Mixer2 */
-	0x0000,     /* R47  - Output Mixer3 */
-	0x0000,     /* R48  - Output Mixer4 */
-	0x0000,     /* R49  - Output Mixer5 */
-	0x0000,     /* R50  - Output Mixer6 */
-	0x0000,     /* R51  - HPOUT2 Mixer */
-	0x0000,     /* R52  - Line Mixer1 */
-	0x0000,     /* R53  - Line Mixer2 */
-	0x0000,     /* R54  - Speaker Mixer */
-	0x0000,     /* R55  - Additional Control */
-	0x0000,     /* R56  - AntiPOP1 */
-	0x0000,     /* R57  - AntiPOP2 */
-	0x0000,     /* R58  - MICBIAS */
-	0x0000,     /* R59 */
-	0x0000,     /* R60  - FLL Control 1 */
-	0x0000,     /* R61  - FLL Control 2 */
-	0x0000,     /* R62  - FLL Control 3 */
-	0x2EE0,     /* R63  - FLL Control 4 */
-	0x0002,     /* R64  - FLL Control 5 */
-	0x2287,     /* R65  - Clocking 3 */
-	0x025F,     /* R66  - Clocking 4 */
-	0x0000,     /* R67  - MW Slave Control */
-	0x0000,     /* R68 */
-	0x0002,     /* R69  - Bus Control 1 */
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
-	0x0000,     /* R81  - Class W 0 */
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
-	0x0000,     /* R98  - EQ1 */
-	0x000C,     /* R99  - EQ2 */
-	0x000C,     /* R100 - EQ3 */
-	0x000C,     /* R101 - EQ4 */
-	0x000C,     /* R102 - EQ5 */
-	0x000C,     /* R103 - EQ6 */
-	0x0FCA,     /* R104 - EQ7 */
-	0x0400,     /* R105 - EQ8 */
-	0x00D8,     /* R106 - EQ9 */
-	0x1EB5,     /* R107 - EQ10 */
-	0xF145,     /* R108 - EQ11 */
-	0x0B75,     /* R109 - EQ12 */
-	0x01C5,     /* R110 - EQ13 */
-	0x1C58,     /* R111 - EQ14 */
-	0xF373,     /* R112 - EQ15 */
-	0x0A54,     /* R113 - EQ16 */
-	0x0558,     /* R114 - EQ17 */
-	0x168E,     /* R115 - EQ18 */
-	0xF829,     /* R116 - EQ19 */
-	0x07AD,     /* R117 - EQ20 */
-	0x1103,     /* R118 - EQ21 */
-	0x0564,     /* R119 - EQ22 */
-	0x0559,     /* R120 - EQ23 */
-	0x4000,     /* R121 - EQ24 */
-	0x0000,     /* R122 - Digital Pulls */
-	0x0F08,     /* R123 - DRC Control 1 */
-	0x0000,     /* R124 - DRC Control 2 */
-	0x0080,     /* R125 - DRC Control 3 */
-	0x0000,     /* R126 - DRC Control 4 */
+static struct reg_default wm8993_reg_defaults[] = {
+	{ 1,   0x0000 },     /* R1   - Power Management (1) */
+	{ 2,   0x6000 },     /* R2   - Power Management (2) */
+	{ 3,   0x0000 },     /* R3   - Power Management (3) */
+	{ 4,   0x4050 },     /* R4   - Audio Interface (1) */
+	{ 5,   0x4000 },     /* R5   - Audio Interface (2) */
+	{ 6,   0x01C8 },     /* R6   - Clocking 1 */
+	{ 7,   0x0000 },     /* R7   - Clocking 2 */
+	{ 8,   0x0000 },     /* R8   - Audio Interface (3) */
+	{ 9,   0x0040 },     /* R9   - Audio Interface (4) */
+	{ 10,  0x0004 },     /* R10  - DAC CTRL */
+	{ 11,  0x00C0 },     /* R11  - Left DAC Digital Volume */
+	{ 12,  0x00C0 },     /* R12  - Right DAC Digital Volume */
+	{ 13,  0x0000 },     /* R13  - Digital Side Tone */
+	{ 14,  0x0300 },     /* R14  - ADC CTRL */
+	{ 15,  0x00C0 },     /* R15  - Left ADC Digital Volume */
+	{ 16,  0x00C0 },     /* R16  - Right ADC Digital Volume */
+	{ 18,  0x0000 },     /* R18  - GPIO CTRL 1 */
+	{ 19,  0x0010 },     /* R19  - GPIO1 */
+	{ 20,  0x0000 },     /* R20  - IRQ_DEBOUNCE */
+	{ 21,  0x8000 },     /* R22  - GPIOCTRL 2 */
+	{ 22,  0x0800 },     /* R23  - GPIO_POL */
+	{ 24,  0x008B },     /* R24  - Left Line Input 1&2 Volume */
+	{ 25,  0x008B },     /* R25  - Left Line Input 3&4 Volume */
+	{ 26,  0x008B },     /* R26  - Right Line Input 1&2 Volume */
+	{ 27,  0x008B },     /* R27  - Right Line Input 3&4 Volume */
+	{ 28,  0x006D },     /* R28  - Left Output Volume */
+	{ 29,  0x006D },     /* R29  - Right Output Volume */
+	{ 30,  0x0066 },     /* R30  - Line Outputs Volume */
+	{ 31,  0x0020 },     /* R31  - HPOUT2 Volume */
+	{ 32,  0x0079 },     /* R32  - Left OPGA Volume */
+	{ 33,  0x0079 },     /* R33  - Right OPGA Volume */
+	{ 34,  0x0003 },     /* R34  - SPKMIXL Attenuation */
+	{ 35,  0x0003 },     /* R35  - SPKMIXR Attenuation */
+	{ 36,  0x0011 },     /* R36  - SPKOUT Mixers */
+	{ 37,  0x0100 },     /* R37  - SPKOUT Boost */
+	{ 38,  0x0079 },     /* R38  - Speaker Volume Left */
+	{ 39,  0x0079 },     /* R39  - Speaker Volume Right */
+	{ 40,  0x0000 },     /* R40  - Input Mixer2 */
+	{ 41,  0x0000 },     /* R41  - Input Mixer3 */
+	{ 42,  0x0000 },     /* R42  - Input Mixer4 */
+	{ 43,  0x0000 },     /* R43  - Input Mixer5 */
+	{ 44,  0x0000 },     /* R44  - Input Mixer6 */
+	{ 45,  0x0000 },     /* R45  - Output Mixer1 */
+	{ 46,  0x0000 },     /* R46  - Output Mixer2 */
+	{ 47,  0x0000 },     /* R47  - Output Mixer3 */
+	{ 48,  0x0000 },     /* R48  - Output Mixer4 */
+	{ 49,  0x0000 },     /* R49  - Output Mixer5 */
+	{ 50,  0x0000 },     /* R50  - Output Mixer6 */
+	{ 51,  0x0000 },     /* R51  - HPOUT2 Mixer */
+	{ 52,  0x0000 },     /* R52  - Line Mixer1 */
+	{ 53,  0x0000 },     /* R53  - Line Mixer2 */
+	{ 54,  0x0000 },     /* R54  - Speaker Mixer */
+	{ 55,  0x0000 },     /* R55  - Additional Control */
+	{ 56,  0x0000 },     /* R56  - AntiPOP1 */
+	{ 57,  0x0000 },     /* R57  - AntiPOP2 */
+	{ 58,  0x0000 },     /* R58  - MICBIAS */
+	{ 60,  0x0000 },     /* R60  - FLL Control 1 */
+	{ 61,  0x0000 },     /* R61  - FLL Control 2 */
+	{ 62,  0x0000 },     /* R62  - FLL Control 3 */
+	{ 63,  0x2EE0 },     /* R63  - FLL Control 4 */
+	{ 64,  0x0002 },     /* R64  - FLL Control 5 */
+	{ 65,  0x2287 },     /* R65  - Clocking 3 */
+	{ 66,  0x025F },     /* R66  - Clocking 4 */
+	{ 67,  0x0000 },     /* R67  - MW Slave Control */
+	{ 69,  0x0002 },     /* R69  - Bus Control 1 */
+	{ 70,  0x0000 },     /* R70  - Write Sequencer 0 */
+	{ 71,  0x0000 },     /* R71  - Write Sequencer 1 */
+	{ 72,  0x0000 },     /* R72  - Write Sequencer 2 */
+	{ 73,  0x0000 },     /* R73  - Write Sequencer 3 */
+	{ 74,  0x0000 },     /* R74  - Write Sequencer 4 */
+	{ 75,  0x0000 },     /* R75  - Write Sequencer 5 */
+	{ 76,  0x1F25 },     /* R76  - Charge Pump 1 */
+	{ 81,  0x0000 },     /* R81  - Class W 0 */
+	{ 85,  0x054A },     /* R85  - DC Servo 1 */
+	{ 87,  0x0000 },     /* R87  - DC Servo 3 */
+	{ 96,  0x0100 },     /* R96  - Analogue HP 0 */
+	{ 98,  0x0000 },     /* R98  - EQ1 */
+	{ 99,  0x000C },     /* R99  - EQ2 */
+	{ 100, 0x000C },     /* R100 - EQ3 */
+	{ 101, 0x000C },     /* R101 - EQ4 */
+	{ 102, 0x000C },     /* R102 - EQ5 */
+	{ 103, 0x000C },     /* R103 - EQ6 */
+	{ 104, 0x0FCA },     /* R104 - EQ7 */
+	{ 105, 0x0400 },     /* R105 - EQ8 */
+	{ 106, 0x00D8 },     /* R106 - EQ9 */
+	{ 107, 0x1EB5 },     /* R107 - EQ10 */
+	{ 108, 0xF145 },     /* R108 - EQ11 */
+	{ 109, 0x0B75 },     /* R109 - EQ12 */
+	{ 110, 0x01C5 },     /* R110 - EQ13 */
+	{ 111, 0x1C58 },     /* R111 - EQ14 */
+	{ 112, 0xF373 },     /* R112 - EQ15 */
+	{ 113, 0x0A54 },     /* R113 - EQ16 */
+	{ 114, 0x0558 },     /* R114 - EQ17 */
+	{ 115, 0x168E },     /* R115 - EQ18 */
+	{ 116, 0xF829 },     /* R116 - EQ19 */
+	{ 117, 0x07AD },     /* R117 - EQ20 */
+	{ 118, 0x1103 },     /* R118 - EQ21 */
+	{ 119, 0x0564 },     /* R119 - EQ22 */
+	{ 120, 0x0559 },     /* R120 - EQ23 */
+	{ 121, 0x4000 },     /* R121 - EQ24 */
+	{ 122, 0x0000 },     /* R122 - Digital Pulls */
+	{ 123, 0x0F08 },     /* R123 - DRC Control 1 */
+	{ 124, 0x0000 },     /* R124 - DRC Control 2 */
+	{ 125, 0x0080 },     /* R125 - DRC Control 3 */
+	{ 126, 0x0000 },     /* R126 - DRC Control 4 */
 };
 
 static struct {
@@ -225,9 +204,9 @@ static struct {
 
 struct wm8993_priv {
 	struct wm_hubs_data hubs_data;
+	struct regmap *regmap;
 	struct regulator_bulk_data supplies[WM8993_NUM_SUPPLIES];
 	struct wm8993_platform_data pdata;
-	enum snd_soc_control_type control_type;
 	int master;
 	int sysclk_source;
 	int tdm_slots;
@@ -242,7 +221,7 @@ struct wm8993_priv {
 	int fll_src;
 };
 
-static int wm8993_volatile(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8993_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8993_SOFTWARE_RESET:
@@ -250,9 +229,128 @@ static int wm8993_volatile(struct snd_soc_codec *codec, unsigned int reg)
 	case WM8993_DC_SERVO_READBACK_0:
 	case WM8993_DC_SERVO_READBACK_1:
 	case WM8993_DC_SERVO_READBACK_2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
+	}
+}
+
+static bool wm8993_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8993_SOFTWARE_RESET:
+	case WM8993_POWER_MANAGEMENT_1:
+	case WM8993_POWER_MANAGEMENT_2:
+	case WM8993_POWER_MANAGEMENT_3:
+	case WM8993_AUDIO_INTERFACE_1:
+	case WM8993_AUDIO_INTERFACE_2:
+	case WM8993_CLOCKING_1:
+	case WM8993_CLOCKING_2:
+	case WM8993_AUDIO_INTERFACE_3:
+	case WM8993_AUDIO_INTERFACE_4:
+	case WM8993_DAC_CTRL:
+	case WM8993_LEFT_DAC_DIGITAL_VOLUME:
+	case WM8993_RIGHT_DAC_DIGITAL_VOLUME:
+	case WM8993_DIGITAL_SIDE_TONE:
+	case WM8993_ADC_CTRL:
+	case WM8993_LEFT_ADC_DIGITAL_VOLUME:
+	case WM8993_RIGHT_ADC_DIGITAL_VOLUME:
+	case WM8993_GPIO_CTRL_1:
+	case WM8993_GPIO1:
+	case WM8993_IRQ_DEBOUNCE:
+	case WM8993_GPIOCTRL_2:
+	case WM8993_GPIO_POL:
+	case WM8993_LEFT_LINE_INPUT_1_2_VOLUME:
+	case WM8993_LEFT_LINE_INPUT_3_4_VOLUME:
+	case WM8993_RIGHT_LINE_INPUT_1_2_VOLUME:
+	case WM8993_RIGHT_LINE_INPUT_3_4_VOLUME:
+	case WM8993_LEFT_OUTPUT_VOLUME:
+	case WM8993_RIGHT_OUTPUT_VOLUME:
+	case WM8993_LINE_OUTPUTS_VOLUME:
+	case WM8993_HPOUT2_VOLUME:
+	case WM8993_LEFT_OPGA_VOLUME:
+	case WM8993_RIGHT_OPGA_VOLUME:
+	case WM8993_SPKMIXL_ATTENUATION:
+	case WM8993_SPKMIXR_ATTENUATION:
+	case WM8993_SPKOUT_MIXERS:
+	case WM8993_SPKOUT_BOOST:
+	case WM8993_SPEAKER_VOLUME_LEFT:
+	case WM8993_SPEAKER_VOLUME_RIGHT:
+	case WM8993_INPUT_MIXER2:
+	case WM8993_INPUT_MIXER3:
+	case WM8993_INPUT_MIXER4:
+	case WM8993_INPUT_MIXER5:
+	case WM8993_INPUT_MIXER6:
+	case WM8993_OUTPUT_MIXER1:
+	case WM8993_OUTPUT_MIXER2:
+	case WM8993_OUTPUT_MIXER3:
+	case WM8993_OUTPUT_MIXER4:
+	case WM8993_OUTPUT_MIXER5:
+	case WM8993_OUTPUT_MIXER6:
+	case WM8993_HPOUT2_MIXER:
+	case WM8993_LINE_MIXER1:
+	case WM8993_LINE_MIXER2:
+	case WM8993_SPEAKER_MIXER:
+	case WM8993_ADDITIONAL_CONTROL:
+	case WM8993_ANTIPOP1:
+	case WM8993_ANTIPOP2:
+	case WM8993_MICBIAS:
+	case WM8993_FLL_CONTROL_1:
+	case WM8993_FLL_CONTROL_2:
+	case WM8993_FLL_CONTROL_3:
+	case WM8993_FLL_CONTROL_4:
+	case WM8993_FLL_CONTROL_5:
+	case WM8993_CLOCKING_3:
+	case WM8993_CLOCKING_4:
+	case WM8993_MW_SLAVE_CONTROL:
+	case WM8993_BUS_CONTROL_1:
+	case WM8993_WRITE_SEQUENCER_0:
+	case WM8993_WRITE_SEQUENCER_1:
+	case WM8993_WRITE_SEQUENCER_2:
+	case WM8993_WRITE_SEQUENCER_3:
+	case WM8993_WRITE_SEQUENCER_4:
+	case WM8993_WRITE_SEQUENCER_5:
+	case WM8993_CHARGE_PUMP_1:
+	case WM8993_CLASS_W_0:
+	case WM8993_DC_SERVO_0:
+	case WM8993_DC_SERVO_1:
+	case WM8993_DC_SERVO_3:
+	case WM8993_DC_SERVO_READBACK_0:
+	case WM8993_DC_SERVO_READBACK_1:
+	case WM8993_DC_SERVO_READBACK_2:
+	case WM8993_ANALOGUE_HP_0:
+	case WM8993_EQ1:
+	case WM8993_EQ2:
+	case WM8993_EQ3:
+	case WM8993_EQ4:
+	case WM8993_EQ5:
+	case WM8993_EQ6:
+	case WM8993_EQ7:
+	case WM8993_EQ8:
+	case WM8993_EQ9:
+	case WM8993_EQ10:
+	case WM8993_EQ11:
+	case WM8993_EQ12:
+	case WM8993_EQ13:
+	case WM8993_EQ14:
+	case WM8993_EQ15:
+	case WM8993_EQ16:
+	case WM8993_EQ17:
+	case WM8993_EQ18:
+	case WM8993_EQ19:
+	case WM8993_EQ20:
+	case WM8993_EQ21:
+	case WM8993_EQ22:
+	case WM8993_EQ23:
+	case WM8993_EQ24:
+	case WM8993_DIGITAL_PULLS:
+	case WM8993_DRC_CONTROL_1:
+	case WM8993_DRC_CONTROL_2:
+	case WM8993_DRC_CONTROL_3:
+	case WM8993_DRC_CONTROL_4:
+		return true;
+	default:
+		return false;
 	}
 }
 
@@ -957,7 +1055,8 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			if (ret != 0)
 				return ret;
 
-			snd_soc_cache_sync(codec);
+			regcache_cache_only(wm8993->regmap, false);
+			regcache_sync(wm8993->regmap);
 
 			/* Tune DC servo configuration */
 			snd_soc_write(codec, 0x44, 3);
@@ -1018,14 +1117,8 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 				    WM8993_VMID_RAMP_MASK |
 				    WM8993_BIAS_SRC, 0);
 
-#ifdef CONFIG_REGULATOR
-               /* Post 2.6.34 we will be able to get a callback when
-                * the regulators are disabled which we can use but
-		* for now just assume that the power will be cut if
-		* the regulator API is in use.
-		*/
-		codec->cache_sync = 1;
-#endif
+		regcache_cache_only(wm8993->regmap, true);
+		regcache_mark_dirty(wm8993->regmap);
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies),
 				       wm8993->supplies);
@@ -1419,7 +1512,8 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	wm8993->hubs_data.dcs_codes_r = -2;
 	wm8993->hubs_data.series_startup = 1;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	codec->control_data = wm8993->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1443,7 +1537,7 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	}
 
 	val = snd_soc_read(codec, WM8993_SOFTWARE_RESET);
-	if (val != wm8993_reg_defaults[WM8993_SOFTWARE_RESET]) {
+	if (val != 0x8993) {
 		dev_err(codec->dev, "Invalid ID register value %x\n", val);
 		ret = -EINVAL;
 		goto err_enable;
@@ -1453,7 +1547,7 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		goto err_enable;
 
-	codec->cache_only = 1;
+	regcache_cache_only(wm8993->regmap, true);
 
 	/* By default we're using the output mixers */
 	wm8993->class_w_users = 2;
@@ -1572,16 +1666,25 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 #define wm8993_resume NULL
 #endif
 
+static const struct regmap_config wm8993_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.max_register = WM8993_MAX_REGISTER,
+	.volatile_reg = wm8993_volatile,
+	.readable_reg = wm8993_readable,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = wm8993_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8993_reg_defaults),
+};
+
 static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.probe = 	wm8993_probe,
 	.remove = 	wm8993_remove,
 	.suspend =	wm8993_suspend,
 	.resume =	wm8993_resume,
 	.set_bias_level = wm8993_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8993_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8993_reg_defaults,
-	.volatile_register = wm8993_volatile,
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
@@ -1591,22 +1694,41 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	struct wm8993_priv *wm8993;
 	int ret;
 
-	wm8993 = devm_kzalloc(&i2c-dev, sizeof(struct wm8993_priv),
+	wm8993 = devm_kzalloc(&i2c->dev, sizeof(struct wm8993_priv),
 			      GFP_KERNEL);
 	if (wm8993 == NULL)
 		return -ENOMEM;
 
+	wm8993->regmap = regmap_init_i2c(i2c, &wm8993_regmap);
+	if (IS_ERR(wm8993->regmap)) {
+		ret = PTR_ERR(wm8993->regmap);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	i2c_set_clientdata(i2c, wm8993);
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8993, &wm8993_dai, 1);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		goto err;
+	}
+
+	return ret;
+
+err:
+	regmap_exit(wm8993->regmap);
 	return ret;
 }
 
 static __devexit int wm8993_i2c_remove(struct i2c_client *client)
 {
+	struct wm8993_priv *wm8993 = i2c_get_clientdata(client);
+
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+	regmap_exit(wm8993->regmap);
+
 	return 0;
 }
 
-- 
1.7.7.3
