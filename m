From: a@opensource.wolfsonmicro.com
Subject: [PATCH 1/2] ASoC: wm8961: Convert to direct regmap API
	usage
Date: Thu, 13 Sep 2012 13:32:45 +0800
Message-ID: <19239.1587108888$1347515508@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16CF3265253
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 07:51:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8961.c |  426 +++++++++++++++++----------------------------
 1 file changed, 161 insertions(+), 265 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 719fb69..4ea64d6e 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -31,277 +32,158 @@
 
 #define WM8961_MAX_REGISTER                     0xFC
 
-static u16 wm8961_reg_defaults[] = {
-	0x009F,     /* R0   - Left Input volume */
-	0x009F,     /* R1   - Right Input volume */
-	0x0000,     /* R2   - LOUT1 volume */
-	0x0000,     /* R3   - ROUT1 volume */
-	0x0020,     /* R4   - Clocking1 */
-	0x0008,     /* R5   - ADC & DAC Control 1 */
-	0x0000,     /* R6   - ADC & DAC Control 2 */
-	0x000A,     /* R7   - Audio Interface 0 */
-	0x01F4,     /* R8   - Clocking2 */
-	0x0000,     /* R9   - Audio Interface 1 */
-	0x00FF,     /* R10  - Left DAC volume */
-	0x00FF,     /* R11  - Right DAC volume */
-	0x0000,     /* R12 */
-	0x0000,     /* R13 */
-	0x0040,     /* R14  - Audio Interface 2 */
-	0x0000,     /* R15  - Software Reset */
-	0x0000,     /* R16 */
-	0x007B,     /* R17  - ALC1 */
-	0x0000,     /* R18  - ALC2 */
-	0x0032,     /* R19  - ALC3 */
-	0x0000,     /* R20  - Noise Gate */
-	0x00C0,     /* R21  - Left ADC volume */
-	0x00C0,     /* R22  - Right ADC volume */
-	0x0120,     /* R23  - Additional control(1) */
-	0x0000,     /* R24  - Additional control(2) */
-	0x0000,     /* R25  - Pwr Mgmt (1) */
-	0x0000,     /* R26  - Pwr Mgmt (2) */
-	0x0000,     /* R27  - Additional Control (3) */
-	0x0000,     /* R28  - Anti-pop */
-	0x0000,     /* R29 */
-	0x005F,     /* R30  - Clocking 3 */
-	0x0000,     /* R31 */
-	0x0000,     /* R32  - ADCL signal path */
-	0x0000,     /* R33  - ADCR signal path */
-	0x0000,     /* R34 */
-	0x0000,     /* R35 */
-	0x0000,     /* R36 */
-	0x0000,     /* R37 */
-	0x0000,     /* R38 */
-	0x0000,     /* R39 */
-	0x0000,     /* R40  - LOUT2 volume */
-	0x0000,     /* R41  - ROUT2 volume */
-	0x0000,     /* R42 */
-	0x0000,     /* R43 */
-	0x0000,     /* R44 */
-	0x0000,     /* R45 */
-	0x0000,     /* R46 */
-	0x0000,     /* R47  - Pwr Mgmt (3) */
-	0x0023,     /* R48  - Additional Control (4) */
-	0x0000,     /* R49  - Class D Control 1 */
-	0x0000,     /* R50 */
-	0x0003,     /* R51  - Class D Control 2 */
-	0x0000,     /* R52 */
-	0x0000,     /* R53 */
-	0x0000,     /* R54 */
-	0x0000,     /* R55 */
-	0x0106,     /* R56  - Clocking 4 */
-	0x0000,     /* R57  - DSP Sidetone 0 */
-	0x0000,     /* R58  - DSP Sidetone 1 */
-	0x0000,     /* R59 */
-	0x0000,     /* R60  - DC Servo 0 */
-	0x0000,     /* R61  - DC Servo 1 */
-	0x0000,     /* R62 */
-	0x015E,     /* R63  - DC Servo 3 */
-	0x0010,     /* R64 */
-	0x0010,     /* R65  - DC Servo 5 */
-	0x0000,     /* R66 */
-	0x0001,     /* R67 */
-	0x0003,     /* R68  - Analogue PGA Bias */
-	0x0000,     /* R69  - Analogue HP 0 */
-	0x0060,     /* R70 */
-	0x01FB,     /* R71  - Analogue HP 2 */
-	0x0000,     /* R72  - Charge Pump 1 */
-	0x0065,     /* R73 */
-	0x005F,     /* R74 */
-	0x0059,     /* R75 */
-	0x006B,     /* R76 */
-	0x0038,     /* R77 */
-	0x000C,     /* R78 */
-	0x000A,     /* R79 */
-	0x006B,     /* R80 */
-	0x0000,     /* R81 */
-	0x0000,     /* R82  - Charge Pump B */
-	0x0087,     /* R83 */
-	0x0000,     /* R84 */
-	0x005C,     /* R85 */
-	0x0000,     /* R86 */
-	0x0000,     /* R87  - Write Sequencer 1 */
-	0x0000,     /* R88  - Write Sequencer 2 */
-	0x0000,     /* R89  - Write Sequencer 3 */
-	0x0000,     /* R90  - Write Sequencer 4 */
-	0x0000,     /* R91  - Write Sequencer 5 */
-	0x0000,     /* R92  - Write Sequencer 6 */
-	0x0000,     /* R93  - Write Sequencer 7 */
-	0x0000,     /* R94 */
-	0x0000,     /* R95 */
-	0x0000,     /* R96 */
-	0x0000,     /* R97 */
-	0x0000,     /* R98 */
-	0x0000,     /* R99 */
-	0x0000,     /* R100 */
-	0x0000,     /* R101 */
-	0x0000,     /* R102 */
-	0x0000,     /* R103 */
-	0x0000,     /* R104 */
-	0x0000,     /* R105 */
-	0x0000,     /* R106 */
-	0x0000,     /* R107 */
-	0x0000,     /* R108 */
-	0x0000,     /* R109 */
-	0x0000,     /* R110 */
-	0x0000,     /* R111 */
-	0x0000,     /* R112 */
-	0x0000,     /* R113 */
-	0x0000,     /* R114 */
-	0x0000,     /* R115 */
-	0x0000,     /* R116 */
-	0x0000,     /* R117 */
-	0x0000,     /* R118 */
-	0x0000,     /* R119 */
-	0x0000,     /* R120 */
-	0x0000,     /* R121 */
-	0x0000,     /* R122 */
-	0x0000,     /* R123 */
-	0x0000,     /* R124 */
-	0x0000,     /* R125 */
-	0x0000,     /* R126 */
-	0x0000,     /* R127 */
-	0x0000,     /* R128 */
-	0x0000,     /* R129 */
-	0x0000,     /* R130 */
-	0x0000,     /* R131 */
-	0x0000,     /* R132 */
-	0x0000,     /* R133 */
-	0x0000,     /* R134 */
-	0x0000,     /* R135 */
-	0x0000,     /* R136 */
-	0x0000,     /* R137 */
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
-	0x0000,     /* R148 */
-	0x0000,     /* R149 */
-	0x0000,     /* R150 */
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
-	0x0000,     /* R164 */
-	0x0000,     /* R165 */
-	0x0000,     /* R166 */
-	0x0000,     /* R167 */
-	0x0000,     /* R168 */
-	0x0000,     /* R169 */
-	0x0000,     /* R170 */
-	0x0000,     /* R171 */
-	0x0000,     /* R172 */
-	0x0000,     /* R173 */
-	0x0000,     /* R174 */
-	0x0000,     /* R175 */
-	0x0000,     /* R176 */
-	0x0000,     /* R177 */
-	0x0000,     /* R178 */
-	0x0000,     /* R179 */
-	0x0000,     /* R180 */
-	0x0000,     /* R181 */
-	0x0000,     /* R182 */
-	0x0000,     /* R183 */
-	0x0000,     /* R184 */
-	0x0000,     /* R185 */
-	0x0000,     /* R186 */
-	0x0000,     /* R187 */
-	0x0000,     /* R188 */
-	0x0000,     /* R189 */
-	0x0000,     /* R190 */
-	0x0000,     /* R191 */
-	0x0000,     /* R192 */
-	0x0000,     /* R193 */
-	0x0000,     /* R194 */
-	0x0000,     /* R195 */
-	0x0030,     /* R196 */
-	0x0006,     /* R197 */
-	0x0000,     /* R198 */
-	0x0060,     /* R199 */
-	0x0000,     /* R200 */
-	0x003F,     /* R201 */
-	0x0000,     /* R202 */
-	0x0000,     /* R203 */
-	0x0000,     /* R204 */
-	0x0001,     /* R205 */
-	0x0000,     /* R206 */
-	0x0181,     /* R207 */
-	0x0005,     /* R208 */
-	0x0008,     /* R209 */
-	0x0008,     /* R210 */
-	0x0000,     /* R211 */
-	0x013B,     /* R212 */
-	0x0000,     /* R213 */
-	0x0000,     /* R214 */
-	0x0000,     /* R215 */
-	0x0000,     /* R216 */
-	0x0070,     /* R217 */
-	0x0000,     /* R218 */
-	0x0000,     /* R219 */
-	0x0000,     /* R220 */
-	0x0000,     /* R221 */
-	0x0000,     /* R222 */
-	0x0003,     /* R223 */
-	0x0000,     /* R224 */
-	0x0000,     /* R225 */
-	0x0001,     /* R226 */
-	0x0008,     /* R227 */
-	0x0000,     /* R228 */
-	0x0000,     /* R229 */
-	0x0000,     /* R230 */
-	0x0000,     /* R231 */
-	0x0004,     /* R232 */
-	0x0000,     /* R233 */
-	0x0000,     /* R234 */
-	0x0000,     /* R235 */
-	0x0000,     /* R236 */
-	0x0000,     /* R237 */
-	0x0080,     /* R238 */
-	0x0000,     /* R239 */
-	0x0000,     /* R240 */
-	0x0000,     /* R241 */
-	0x0000,     /* R242 */
-	0x0000,     /* R243 */
-	0x0000,     /* R244 */
-	0x0052,     /* R245 */
-	0x0110,     /* R246 */
-	0x0040,     /* R247 */
-	0x0000,     /* R248 */
-	0x0030,     /* R249 */
-	0x0000,     /* R250 */
-	0x0000,     /* R251 */
-	0x0001,     /* R252 - General test 1 */
+static const struct reg_default wm8961_reg_defaults[] = {
+	{  0, 0x009F },     /* R0   - Left Input volume */
+	{  1, 0x009F },     /* R1   - Right Input volume */
+	{  2, 0x0000 },     /* R2   - LOUT1 volume */
+	{  3, 0x0000 },     /* R3   - ROUT1 volume */
+	{  4, 0x0020 },     /* R4   - Clocking1 */
+	{  5, 0x0008 },     /* R5   - ADC & DAC Control 1 */
+	{  6, 0x0000 },     /* R6   - ADC & DAC Control 2 */
+	{  7, 0x000A },     /* R7   - Audio Interface 0 */
+	{  8, 0x01F4 },     /* R8   - Clocking2 */
+	{  9, 0x0000 },     /* R9   - Audio Interface 1 */
+	{ 10, 0x00FF },     /* R10  - Left DAC volume */
+	{ 11, 0x00FF },     /* R11  - Right DAC volume */
+
+	{ 14, 0x0040 },     /* R14  - Audio Interface 2 */
+
+	{ 17, 0x007B },     /* R17  - ALC1 */
+	{ 18, 0x0000 },     /* R18  - ALC2 */
+	{ 19, 0x0032 },     /* R19  - ALC3 */
+	{ 20, 0x0000 },     /* R20  - Noise Gate */
+	{ 21, 0x00C0 },     /* R21  - Left ADC volume */
+	{ 22, 0x00C0 },     /* R22  - Right ADC volume */
+	{ 23, 0x0120 },     /* R23  - Additional control(1) */
+	{ 24, 0x0000 },     /* R24  - Additional control(2) */
+	{ 25, 0x0000 },     /* R25  - Pwr Mgmt (1) */
+	{ 26, 0x0000 },     /* R26  - Pwr Mgmt (2) */
+	{ 27, 0x0000 },     /* R27  - Additional Control (3) */
+	{ 28, 0x0000 },     /* R28  - Anti-pop */
+
+	{ 30, 0x005F },     /* R30  - Clocking 3 */
+
+	{ 32, 0x0000 },     /* R32  - ADCL signal path */
+	{ 33, 0x0000 },     /* R33  - ADCR signal path */
+
+	{ 40, 0x0000 },     /* R40  - LOUT2 volume */
+	{ 41, 0x0000 },     /* R41  - ROUT2 volume */
+
+	{ 47, 0x0000 },     /* R47  - Pwr Mgmt (3) */
+	{ 48, 0x0023 },     /* R48  - Additional Control (4) */
+	{ 49, 0x0000 },     /* R49  - Class D Control 1 */
+
+	{ 51, 0x0003 },     /* R51  - Class D Control 2 */
+
+	{ 56, 0x0106 },     /* R56  - Clocking 4 */
+	{ 57, 0x0000 },     /* R57  - DSP Sidetone 0 */
+	{ 58, 0x0000 },     /* R58  - DSP Sidetone 1 */
+
+	{ 60, 0x0000 },     /* R60  - DC Servo 0 */
+	{ 61, 0x0000 },     /* R61  - DC Servo 1 */
+
+	{ 63, 0x015E },     /* R63  - DC Servo 3 */
+
+	{ 65, 0x0010 },     /* R65  - DC Servo 5 */
+
+	{ 68, 0x0003 },     /* R68  - Analogue PGA Bias */
+	{ 69, 0x0000 },     /* R69  - Analogue HP 0 */
+
+	{ 71, 0x01FB },     /* R71  - Analogue HP 2 */
+	{ 72, 0x0000 },     /* R72  - Charge Pump 1 */
+
+	{ 82, 0x0000 },     /* R82  - Charge Pump B */
+
+	{ 87, 0x0000 },     /* R87  - Write Sequencer 1 */
+	{ 88, 0x0000 },     /* R88  - Write Sequencer 2 */
+	{ 89, 0x0000 },     /* R89  - Write Sequencer 3 */
+	{ 90, 0x0000 },     /* R90  - Write Sequencer 4 */
+	{ 91, 0x0000 },     /* R91  - Write Sequencer 5 */
+	{ 92, 0x0000 },     /* R92  - Write Sequencer 6 */
+	{ 93, 0x0000 },     /* R93  - Write Sequencer 7 */
+
+	{ 252, 0x0001 },     /* R252 - General test 1 */
 };
 
 struct wm8961_priv {
-	enum snd_soc_control_type control_type;
+	struct regmap *regmap;
 	int sysclk;
 };
 
-static int wm8961_volatile_register(struct snd_soc_codec *codec, unsigned int reg)
+static bool wm8961_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case WM8961_SOFTWARE_RESET:
 	case WM8961_WRITE_SEQUENCER_7:
 	case WM8961_DC_SERVO_1:
-		return 1;
+		return true;
 
 	default:
-		return 0;
+		return false;
+	}
+}
+
+static bool wm8961_readable(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WM8961_LEFT_INPUT_VOLUME:
+	case WM8961_RIGHT_INPUT_VOLUME:
+	case WM8961_LOUT1_VOLUME:
+	case WM8961_ROUT1_VOLUME:
+	case WM8961_CLOCKING1:
+	case WM8961_ADC_DAC_CONTROL_1:
+	case WM8961_ADC_DAC_CONTROL_2:
+	case WM8961_AUDIO_INTERFACE_0:
+	case WM8961_CLOCKING2:
+	case WM8961_AUDIO_INTERFACE_1:
+	case WM8961_LEFT_DAC_VOLUME:
+	case WM8961_RIGHT_DAC_VOLUME:
+	case WM8961_AUDIO_INTERFACE_2:
+	case WM8961_SOFTWARE_RESET:
+	case WM8961_ALC1:
+	case WM8961_ALC2:
+	case WM8961_ALC3:
+	case WM8961_NOISE_GATE:
+	case WM8961_LEFT_ADC_VOLUME:
+	case WM8961_RIGHT_ADC_VOLUME:
+	case WM8961_ADDITIONAL_CONTROL_1:
+	case WM8961_ADDITIONAL_CONTROL_2:
+	case WM8961_PWR_MGMT_1:
+	case WM8961_PWR_MGMT_2:
+	case WM8961_ADDITIONAL_CONTROL_3:
+	case WM8961_ANTI_POP:
+	case WM8961_CLOCKING_3:
+	case WM8961_ADCL_SIGNAL_PATH:
+	case WM8961_ADCR_SIGNAL_PATH:
+	case WM8961_LOUT2_VOLUME:
+	case WM8961_ROUT2_VOLUME:
+	case WM8961_PWR_MGMT_3:
+	case WM8961_ADDITIONAL_CONTROL_4:
+	case WM8961_CLASS_D_CONTROL_1:
+	case WM8961_CLASS_D_CONTROL_2:
+	case WM8961_CLOCKING_4:
+	case WM8961_DSP_SIDETONE_0:
+	case WM8961_DSP_SIDETONE_1:
+	case WM8961_DC_SERVO_0:
+	case WM8961_DC_SERVO_1:
+	case WM8961_DC_SERVO_3:
+	case WM8961_DC_SERVO_5:
+	case WM8961_ANALOGUE_PGA_BIAS:
+	case WM8961_ANALOGUE_HP_0:
+	case WM8961_ANALOGUE_HP_2:
+	case WM8961_CHARGE_PUMP_1:
+	case WM8961_CHARGE_PUMP_B:
+	case WM8961_WRITE_SEQUENCER_1:
+	case WM8961_WRITE_SEQUENCER_2:
+	case WM8961_WRITE_SEQUENCER_3:
+	case WM8961_WRITE_SEQUENCER_4:
+	case WM8961_WRITE_SEQUENCER_5:
+	case WM8961_WRITE_SEQUENCER_6:
+	case WM8961_WRITE_SEQUENCER_7:
+	case WM8961_GENERAL_TEST_1:
+		return true;
+	default:
+		return false;
 	}
 }
 
@@ -958,11 +840,12 @@ static struct snd_soc_dai_driver wm8961_dai = {
 
 static int wm8961_probe(struct snd_soc_codec *codec)
 {
+	struct wm8961_priv *wm8961 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret = 0;
 	u16 reg;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -975,9 +858,9 @@ static int wm8961_probe(struct snd_soc_codec *codec)
 	}
 
 	/* This isn't volatile - readback doesn't correspond to write */
-	codec->cache_bypass = 1;
+	regcache_cache_bypass(wm8961->regmap, true);
 	reg = snd_soc_read(codec, WM8961_RIGHT_INPUT_VOLUME);
-	codec->cache_bypass = 0;
+	regcache_cache_bypass(wm8961->regmap, false);
 	dev_info(codec->dev, "WM8961 family %d revision %c\n",
 		 (reg & WM8961_DEVICE_ID_MASK) >> WM8961_DEVICE_ID_SHIFT,
 		 ((reg & WM8961_CHIP_REV_MASK) >> WM8961_CHIP_REV_SHIFT)
@@ -1066,10 +949,19 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.suspend =	wm8961_suspend,
 	.resume =	wm8961_resume,
 	.set_bias_level = wm8961_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm8961_reg_defaults),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = wm8961_reg_defaults,
-	.volatile_register = wm8961_volatile_register,
+};
+
+static const struct regmap_config wm8961_regmap = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = WM8961_MAX_REGISTER,
+
+	.reg_defaults = wm8961_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm8961_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm8961_volatile,
+	.readable_reg = wm8961_readable,
 };
 
 static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
@@ -1083,6 +975,10 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 	if (wm8961 == NULL)
 		return -ENOMEM;
 
+	wm8961->regmap = devm_regmap_init_i2c(i2c, &wm8961_regmap);
+	if (IS_ERR(wm8961->regmap))
+		return PTR_ERR(wm8961->regmap);
+
 	i2c_set_clientdata(i2c, wm8961);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.10.4
