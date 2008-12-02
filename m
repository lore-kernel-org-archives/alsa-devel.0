From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: TWL4030: Add input selection and gain
	controls
Date: Tue,  2 Dec 2008 20:48:58 +0200
Message-ID: <1228243738-9561-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 6755C1037EB
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 19:49:12 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id i36so659839gve.24
	for <alsa-devel@alsa-project.org>; Tue, 02 Dec 2008 10:49:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

The TWL4030 codec device has two ADCs. Both of them can have
several inputs routed to them, but TRM says that only one source
can be selected for every ADC, even though every source has a
dedicated bit in the registers.

This patch adds input source controls. It modifies default register
values to have no inputs selected and ADCs disabled. When some
input is selected, control handlers enable apropriate input
amplifier and ADC. If a microphone is selected, bias power is
automatically enabled. When some input is deselected, unused
chip parts are disabled.

Microphone and line input recording tested on OMAP3 pandora board.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
Compared to my previous patch, I've changed "Microphone Boost" name
to "Input Boost Volume", as it affects line inputs too.
I thought that hiding this control for line-in was not a good idea,
as it might still be useful for weak sources. "Capture" was
also changed to "Input", as inputs can be also routed to outputs,
not only recorded.

 sound/soc/codecs/twl4030.c |  177 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/twl4030.h |   16 ++++
 2 files changed, 190 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ffd5120..3c9fdf2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -46,9 +46,9 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0xc3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
-	0x24, /* REG_ANAMICL		(0x5)	*/
-	0x04, /* REG_ANAMICR		(0x6)	*/
-	0x0a, /* REG_AVADC_CTL		(0x7)	*/
+	0x20, /* REG_ANAMICL		(0x5)	*/
+	0x00, /* REG_ANAMICR		(0x6)	*/
+	0x00, /* REG_AVADC_CTL		(0x7)	*/
 	0x00, /* REG_ADCMICSEL		(0x8)	*/
 	0x00, /* REG_DIGMIXING		(0x9)	*/
 	0x0c, /* REG_ATXL1PGA		(0xA)	*/
@@ -347,6 +347,162 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 	return err;
 }
 
+static int twl4030_get_left_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	int result = 0;
+
+	/* one bit must be set a time */
+	reg &= TWL4030_CKMIC_EN | TWL4030_AUXL_EN | TWL4030_HSMIC_EN
+			| TWL4030_MAINMIC_EN;
+	if (reg != 0) {
+		result++;
+		while ((reg & 1) == 0) {
+			result++;
+			reg >>= 1;
+		}
+	}
+
+	ucontrol->value.integer.value[0] = result;
+	return 0;
+}
+
+static int twl4030_put_left_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	int value = ucontrol->value.integer.value[0];
+	u8 anamicl, micbias, avadc_ctl;
+
+	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	anamicl &= ~(TWL4030_CKMIC_EN | TWL4030_AUXL_EN | TWL4030_HSMIC_EN
+			| TWL4030_MAINMIC_EN);
+	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
+	micbias &= ~(TWL4030_HSMICBIAS_EN | TWL4030_MICBIAS1_EN);
+	avadc_ctl = twl4030_read_reg_cache(codec, TWL4030_REG_AVADC_CTL);
+
+	switch (value) {
+	case 1:
+		anamicl |= TWL4030_MAINMIC_EN;
+		micbias |= TWL4030_MICBIAS1_EN;
+		break;
+	case 2:
+		anamicl |= TWL4030_HSMIC_EN;
+		micbias |= TWL4030_HSMICBIAS_EN;
+		break;
+	case 3:
+		anamicl |= TWL4030_AUXL_EN;
+		break;
+	case 4:
+		anamicl |= TWL4030_CKMIC_EN;
+		break;
+	default:
+		break;
+	}
+
+	/* If some input is selected, enable amp and ADC */
+	if (value != 0) {
+		anamicl |= TWL4030_MICAMPL_EN;
+		avadc_ctl |= TWL4030_ADCL_EN;
+	} else {
+		anamicl &= ~TWL4030_MICAMPL_EN;
+		avadc_ctl &= ~TWL4030_ADCL_EN;
+	}
+
+	twl4030_write(codec, TWL4030_REG_ANAMICL, anamicl);
+	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
+	twl4030_write(codec, TWL4030_REG_AVADC_CTL, avadc_ctl);
+
+	return 1;
+}
+
+static int twl4030_get_right_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
+	int value = 0;
+
+	reg &= TWL4030_SUBMIC_EN|TWL4030_AUXR_EN;
+	switch (reg) {
+	case TWL4030_SUBMIC_EN:
+		value = 1;
+		break;
+	case TWL4030_AUXR_EN:
+		value = 2;
+		break;
+	default:
+		break;
+	}
+
+	ucontrol->value.integer.value[0] = value;
+	return 0;
+}
+
+static int twl4030_put_right_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	int value = ucontrol->value.integer.value[0];
+	u8 anamicr, micbias, avadc_ctl;
+
+	anamicr = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
+	anamicr &= ~(TWL4030_SUBMIC_EN|TWL4030_AUXR_EN);
+	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
+	micbias &= ~TWL4030_MICBIAS2_EN;
+	avadc_ctl = twl4030_read_reg_cache(codec, TWL4030_REG_AVADC_CTL);
+
+	switch (value) {
+	case 1:
+		anamicr |= TWL4030_SUBMIC_EN;
+		micbias |= TWL4030_MICBIAS2_EN;
+		break;
+	case 2:
+		anamicr |= TWL4030_AUXR_EN;
+		break;
+	default:
+		break;
+	}
+
+	if (value != 0) {
+		anamicr |= TWL4030_MICAMPR_EN;
+		avadc_ctl |= TWL4030_ADCR_EN;
+	} else {
+		anamicr &= ~TWL4030_MICAMPR_EN;
+		avadc_ctl &= ~TWL4030_ADCR_EN;
+	}
+
+	twl4030_write(codec, TWL4030_REG_ANAMICR, anamicr);
+	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
+	twl4030_write(codec, TWL4030_REG_AVADC_CTL, avadc_ctl);
+
+	return 1;
+}
+
+static const char *twl4030_left_in_sel[] = {
+	"None",
+	"Main Mic",
+	"Headset Mic",
+	"Line In",
+	"Carkit Mic",
+};
+
+static const char *twl4030_right_in_sel[] = {
+	"None",
+	"Sub Mic",
+	"Line In",
+};
+
+static const struct soc_enum twl4030_left_input_mux =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl4030_left_in_sel),
+		twl4030_left_in_sel);
+
+static const struct soc_enum twl4030_right_input_mux =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(twl4030_right_in_sel),
+		twl4030_right_in_sel);
+
 /*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
@@ -378,6 +534,12 @@ static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
  */
 static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
 
+/*
+ * Gain control for input amplifiers
+ * 0 dB to 30 dB in 6 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(input_gain_tlv, 0, 600, 0);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
@@ -420,6 +582,15 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Capture Volume",
 		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0, digital_capture_tlv),
+
+	SOC_DOUBLE_TLV("Input Boost Volume", TWL4030_REG_ANAMIC_GAIN,
+		0, 3, 5, 0, input_gain_tlv),
+
+	/* Input source controls */
+	SOC_ENUM_EXT("Left Input Source", twl4030_left_input_mux,
+		twl4030_get_left_input, twl4030_put_left_input),
+	SOC_ENUM_EXT("Right Input Source", twl4030_right_input_mux,
+		twl4030_get_right_input, twl4030_put_right_input),
 };
 
 /* add non dapm controls */
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 09865d9..a2065d4 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -113,7 +113,16 @@
 #define TWL4030_CODECPDZ		0x02
 #define TWL4030_OPT_MODE		0x01
 
+/* TWL4030_REG_MICBIAS_CTL (0x04) Fields */
+
+#define TWL4030_MICBIAS2_CTL		0x40
+#define TWL4030_MICBIAS1_CTL		0x20
+#define TWL4030_HSMICBIAS_EN		0x04
+#define TWL4030_MICBIAS2_EN		0x02
+#define TWL4030_MICBIAS1_EN		0x01
+
 /* ANAMICL (0x05) Fields */
+
 #define TWL4030_CNCL_OFFSET_START	0x80
 #define TWL4030_OFFSET_CNCL_SEL		0x60
 #define TWL4030_OFFSET_CNCL_SEL_ARX1	0x00
@@ -127,10 +136,17 @@
 #define TWL4030_MAINMIC_EN		0x01
 
 /* ANAMICR (0x06) Fields */
+
 #define TWL4030_MICAMPR_EN		0x10
 #define TWL4030_AUXR_EN			0x04
 #define TWL4030_SUBMIC_EN		0x01
 
+/* AVADC_CTL (0x07) Fields */
+
+#define TWL4030_ADCL_EN			0x08
+#define TWL4030_AVADC_CLK_PRIORITY	0x04
+#define TWL4030_ADCR_EN			0x02
+
 /* AUDIO_IF (0x0E) Fields */
 
 #define TWL4030_AIF_SLAVE_EN		0x80
-- 
1.5.4.3
