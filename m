From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: TWL4030: Add capture source selection
	and mic gain control
Date: Tue,  2 Dec 2008 01:07:28 +0200
Message-ID: <1228172848-5221-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AC941037E3
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 00:07:40 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id i36so541141gve.24
	for <alsa-devel@alsa-project.org>; Mon, 01 Dec 2008 15:07:39 -0800 (PST)
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

This patch adds controls for capture source controls. When a microphone
is selected, handlers automatically enable bias power (disable when
deselected). The patch also adds microphone gain control. Microphone
and line input recording tested on OMAP3 pandora board.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/codecs/twl4030.c |  139 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl4030.h |    7 ++
 2 files changed, 146 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ffd5120..755a872 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -347,6 +347,130 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
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
+	u8 anamicl, micbias;
+
+	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	anamicl &= ~(TWL4030_CKMIC_EN | TWL4030_AUXL_EN | TWL4030_HSMIC_EN
+			| TWL4030_MAINMIC_EN);
+	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
+	micbias &= ~(TWL4030_HSMICBIAS_EN | TWL4030_MICBIAS1_EN);
+
+	switch (value) {
+	case 0:
+		anamicl |= TWL4030_MAINMIC_EN;
+		micbias |= TWL4030_MICBIAS1_EN;
+		break;
+	case 1:
+		anamicl |= TWL4030_HSMIC_EN;
+		micbias |= TWL4030_HSMICBIAS_EN;
+		break;
+	case 2:
+		anamicl |= TWL4030_AUXL_EN;
+		break;
+	case 3:
+		anamicl |= TWL4030_CKMIC_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	twl4030_write(codec, TWL4030_REG_ANAMICL, anamicl);
+	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
+
+	return 1;
+}
+
+static int twl4030_get_right_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
+
+	reg &= TWL4030_SUBMIC_EN|TWL4030_AUXR_EN;
+	if (reg == TWL4030_SUBMIC_EN)
+		ucontrol->value.integer.value[0] = 0;
+	else if (reg == TWL4030_AUXR_EN)
+		ucontrol->value.integer.value[0] = 1;
+
+	return 0;
+}
+
+static int twl4030_put_right_input(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = kcontrol->private_data;
+	int value = ucontrol->value.integer.value[0];
+	u8 anamicr, micbias;
+
+	anamicr = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
+	anamicr &= ~(TWL4030_SUBMIC_EN|TWL4030_AUXR_EN);
+	micbias = twl4030_read_reg_cache(codec, TWL4030_REG_MICBIAS_CTL);
+	micbias &= ~TWL4030_MICBIAS2_EN;
+
+	switch (value) {
+	case 0:
+		anamicr |= TWL4030_SUBMIC_EN;
+		micbias |= TWL4030_MICBIAS2_EN;
+		break;
+	case 1:
+		anamicr |= TWL4030_AUXR_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	twl4030_write(codec, TWL4030_REG_ANAMICR, anamicr);
+	twl4030_write(codec, TWL4030_REG_MICBIAS_CTL, micbias);
+
+	return 1;
+}
+
+static const char *twl4030_left_in_sel[] = {
+	"Main Mic",
+	"Headset Mic",
+	"Line In",
+	"Carkit Mic",
+};
+
+static const char *twl4030_right_in_sel[] = {
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
@@ -378,6 +502,12 @@ static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
  */
 static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
 
+/*
+ * Gain control for microphone amplifier
+ * 0 dB to 30 dB in 6 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(microphone_gain_tlv, 0, 600, 0);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
@@ -420,6 +550,15 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Capture Volume",
 		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0, digital_capture_tlv),
+
+	SOC_DOUBLE_TLV("Microphone Boost", TWL4030_REG_ANAMIC_GAIN,
+		0, 3, 5, 0, microphone_gain_tlv),
+
+	/* Capture source controls */
+	SOC_ENUM_EXT("Left Capture Source", twl4030_left_input_mux,
+		twl4030_get_left_input, twl4030_put_left_input),
+	SOC_ENUM_EXT("Right Capture Source", twl4030_right_input_mux,
+		twl4030_get_right_input, twl4030_put_right_input),
 };
 
 /* add non dapm controls */
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 09865d9..8dae844 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -113,6 +113,13 @@
 #define TWL4030_CODECPDZ		0x02
 #define TWL4030_OPT_MODE		0x01
 
+/* TWL4030_REG_MICBIAS_CTL (0x04) Fields */
+#define TWL4030_MICBIAS2_CTL		0x40
+#define TWL4030_MICBIAS1_CTL		0x20
+#define TWL4030_HSMICBIAS_EN		0x04
+#define TWL4030_MICBIAS2_EN		0x02
+#define TWL4030_MICBIAS1_EN		0x01
+
 /* ANAMICL (0x05) Fields */
 #define TWL4030_CNCL_OFFSET_START	0x80
 #define TWL4030_OFFSET_CNCL_SEL		0x60
-- 
1.5.4.3
