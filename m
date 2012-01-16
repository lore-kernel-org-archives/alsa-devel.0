From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Optimise performance of WM8904 ADC 128fs
	OSR mode
Date: Mon, 16 Jan 2012 18:49:35 +0000
Message-ID: <1326739775-11609-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 896BF103851
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 19:49:39 +0100 (CET)
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
 sound/soc/codecs/wm8904.c |   31 ++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8904.h |   11 +++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index f2a740d..14afc11 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -304,6 +304,7 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	case WM8904_EQ23:
 	case WM8904_EQ24:
 	case WM8904_CONTROL_INTERFACE_TEST_1:
+	case WM8904_ADC_TEST_0:
 	case WM8904_ANALOGUE_OUTPUT_BIAS_0:
 	case WM8904_FLL_NCO_TEST_0:
 	case WM8904_FLL_NCO_TEST_1:
@@ -569,6 +570,29 @@ static const char *hpf_mode_text[] = {
 static const struct soc_enum hpf_mode =
 	SOC_ENUM_SINGLE(WM8904_ADC_DIGITAL_0, 5, 4, hpf_mode_text);
 
+static int wm8904_adc_osr_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	int ret;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	if (ucontrol->value.integer.value[0])
+		val = 0;
+	else
+		val = WM8904_ADC_128_OSR_TST_MODE | WM8904_ADC_BIASX1P5;
+
+	snd_soc_update_bits(codec, WM8904_ADC_TEST_0,
+			    WM8904_ADC_128_OSR_TST_MODE | WM8904_ADC_BIASX1P5,
+			    val);
+
+	return ret;
+}
+
 static const struct snd_kcontrol_new wm8904_adc_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Digital Capture Volume", WM8904_ADC_DIGITAL_VOLUME_LEFT,
 		 WM8904_ADC_DIGITAL_VOLUME_RIGHT, 1, 119, 0, digital_tlv),
@@ -585,7 +609,12 @@ SOC_DOUBLE_R("Capture Switch", WM8904_ANALOGUE_LEFT_INPUT_0,
 SOC_SINGLE("High Pass Filter Switch", WM8904_ADC_DIGITAL_0, 4, 1, 0),
 SOC_ENUM("High Pass Filter Mode", hpf_mode),
 
-SOC_SINGLE("ADC 128x OSR Switch", WM8904_ANALOGUE_ADC_0, 0, 1, 0),
+{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ADC 128x OSR Switch",
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,
+	.put = wm8904_adc_osr_put,
+	.private_value = SOC_SINGLE_VALUE(WM8904_ANALOGUE_ADC_0, 0, 1, 0),
+},
 };
 
 static const char *drc_path_text[] = {
diff --git a/sound/soc/codecs/wm8904.h b/sound/soc/codecs/wm8904.h
index 9e8c841..c29a0e8 100644
--- a/sound/soc/codecs/wm8904.h
+++ b/sound/soc/codecs/wm8904.h
@@ -123,6 +123,7 @@
 #define WM8904_EQ23                             0x9C
 #define WM8904_EQ24                             0x9D
 #define WM8904_CONTROL_INTERFACE_TEST_1         0xA1
+#define WM8904_ADC_TEST_0			0xC6
 #define WM8904_ANALOGUE_OUTPUT_BIAS_0           0xCC
 #define WM8904_FLL_NCO_TEST_0                   0xF7
 #define WM8904_FLL_NCO_TEST_1                   0xF8
@@ -1557,6 +1558,16 @@
 #define WM8904_USER_KEY_WIDTH                        1  /* USER_KEY */
 
 /*
+ * R198 (0xC6) - ADC Test 0
+ */
+#define WM8904_ADC_128_OSR_TST_MODE             0x0004  /* ADC_128_OSR_TST_MODE */
+#define WM8904_ADC_128_OSR_TST_MODE_SHIFT            2  /* ADC_128_OSR_TST_MODE */
+#define WM8904_ADC_128_OSR_TST_MODE_WIDTH            1  /* ADC_128_OSR_TST_MODE */
+#define WM8904_ADC_BIASX1P5                     0x0001  /* ADC_BIASX1P5 */
+#define WM8904_ADC_BIASX1P5_SHIFT                    0  /* ADC_BIASX1P5 */
+#define WM8904_ADC_BIASX1P5_WIDTH                    1  /* ADC_BIASX1P5 */
+
+/*
  * R204 (0xCC) - Analogue Output Bias 0
  */
 #define WM8904_PGA_BIAS_MASK                    0x0070  /* PGA_BIAS - [6:4] */
-- 
1.7.7.3
