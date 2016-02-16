From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 8/9] ASoC: msm8x16: add dapm widgets
Date: Tue, 16 Feb 2016 17:33:38 +0000
Message-ID: <1455644018-1959-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds all the dapm widgets in digital and analog die of the
codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8x16-wcd.c | 1278 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1278 insertions(+)

diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
index 4bf3b81..f1ae55d 100644
--- a/sound/soc/codecs/msm8x16-wcd.c
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -24,10 +24,19 @@
 #define MSM8X16_WCD_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 		SNDRV_PCM_FMTBIT_S24_LE)
 
+/* cut off freq of  3DB 150HZ */
+#define  CF_MIN_3DB_150HZ		0x2
+
 /* Cap mode for micbias */
 #define MICBIAS_EXT_BYP_CAP 0x00
 #define MICBIAS_NO_EXT_BYP_CAP 0x01
 
+/* Internal status on mute_mask to track mute on different sinks */
+#define MUTE_MASK_HPHL_PA_DISABLE					BIT(1)
+#define MUTE_MASK_HPHR_PA_DISABLE					BIT(2)
+#define MUTE_MASK_EAR_PA_DISABLE					BIT(3)
+#define MUTE_MASK_SPKR_PA_DISABLE					BIT(4)
+
 struct msm8x16_wcd_chip {
 	struct regmap	*analog_map;
 	struct regmap	*digital_map;
@@ -58,6 +67,38 @@ static const char * const cf_text[] = {
 	"MIN_3DB_4Hz", "MIN_3DB_75Hz", "MIN_3DB_150Hz"
 };
 
+static const char * const rx_mix1_text[] = {
+	"ZERO", "IIR1", "IIR2", "RX1", "RX2", "RX3"
+};
+
+static const char * const rx_mix2_text[] = {
+	"ZERO", "IIR1", "IIR2"
+};
+
+static const char * const dec_mux_text[] = {
+	"ZERO", "ADC1", "ADC2", "ADC3", "DMIC1", "DMIC2"
+};
+
+static const char * const adc2_mux_text[] = {
+	"ZERO", "INP2", "INP3"
+};
+
+static const char * const rdac2_mux_text[] = {
+	"ZERO", "RX2", "RX1"
+};
+
+static const char * const iir_inp1_text[] = {
+	"ZERO", "DEC1", "DEC2", "RX1", "RX2", "RX3"
+};
+
+static const char * const iir1_inp1_text[] = {
+	"ZERO", "DEC1", "DEC2", "RX1", "RX2", "RX3"
+};
+
+static const char * const hph_text[] = {
+	"ZERO", "Switch",
+};
+
 static const struct soc_enum msm8x16_wcd_spk_boost_ctl_enum[] = {
 		SOC_ENUM_SINGLE_EXT(2, msm8x16_wcd_spk_boost_ctrl_text),
 };
@@ -70,9 +111,164 @@ static const struct soc_enum cf_rxmix2_enum =
 static const struct soc_enum cf_rxmix3_enum =
 	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_RX3_B4_CTL, 0, 3, cf_text);
 
+/* RX1 MIX1 */
+static const struct soc_enum rx_mix1_inp1_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX1_B1_CTL,
+		0, 6, rx_mix1_text);
+
+static const struct soc_enum rx_mix1_inp2_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX1_B1_CTL,
+		3, 6, rx_mix1_text);
+
+static const struct soc_enum rx_mix1_inp3_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX1_B2_CTL,
+		0, 6, rx_mix1_text);
+/* RX1 MIX2 */
+static const struct soc_enum rx_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX1_B3_CTL,
+		0, 3, rx_mix2_text);
+
+/* RX2 MIX1 */
+static const struct soc_enum rx2_mix1_inp1_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX2_B1_CTL,
+		0, 6, rx_mix1_text);
+
+static const struct soc_enum rx2_mix1_inp2_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX2_B1_CTL,
+		3, 6, rx_mix1_text);
+
+static const struct soc_enum rx2_mix1_inp3_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX2_B1_CTL,
+		0, 6, rx_mix1_text);
+
+/* RX2 MIX2 */
+static const struct soc_enum rx2_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX2_B3_CTL,
+		0, 3, rx_mix2_text);
+
+/* RX3 MIX1 */
+static const struct soc_enum rx3_mix1_inp1_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX3_B1_CTL,
+		0, 6, rx_mix1_text);
+
+static const struct soc_enum rx3_mix1_inp2_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX3_B1_CTL,
+		3, 6, rx_mix1_text);
+
+static const struct soc_enum rx3_mix1_inp3_chain_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_RX3_B1_CTL,
+		0, 6, rx_mix1_text);
+
+/* DEC */
+static const struct soc_enum dec1_mux_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_TX_B1_CTL,
+		0, 6, dec_mux_text);
+
+static const struct soc_enum dec2_mux_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_TX_B1_CTL,
+		3, 6, dec_mux_text);
+
+static const struct soc_enum rdac2_mux_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_DIGITAL_CDC_CONN_HPHR_DAC_CTL,
+		0, 3, rdac2_mux_text);
+
+static const struct soc_enum iir1_inp1_mux_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_EQ1_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct soc_enum iir2_inp1_mux_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_CONN_EQ2_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct soc_enum adc2_enum =
+	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(adc2_mux_text), adc2_mux_text);
+
+static const struct soc_enum hph_enum =
+	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(hph_text), hph_text);
+
+static const struct snd_kcontrol_new ear_pa_switch[] = {
+	SOC_DAPM_SINGLE("Switch",
+		MSM8X16_WCD_A_ANALOG_RX_EAR_CTL, 5, 1, 0)
+};
+
+static const struct snd_kcontrol_new spkr_switch[] = {
+	SOC_DAPM_SINGLE("Switch",
+		MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 7, 1, 0)
+};
+
+static const struct snd_kcontrol_new dec1_mux =
+	SOC_DAPM_ENUM("DEC1 MUX Mux", dec1_mux_enum);
+
+static const struct snd_kcontrol_new dec2_mux =
+	SOC_DAPM_ENUM("DEC2 MUX Mux", dec2_mux_enum);
+
+static const struct snd_kcontrol_new rdac2_mux =
+	SOC_DAPM_ENUM("RDAC2 MUX Mux", rdac2_mux_enum);
+
+static const struct snd_kcontrol_new iir1_inp1_mux =
+	SOC_DAPM_ENUM("IIR1 INP1 Mux", iir1_inp1_mux_enum);
+
+static const struct snd_kcontrol_new iir2_inp1_mux =
+	SOC_DAPM_ENUM("IIR2 INP1 Mux", iir2_inp1_mux_enum);
+
+static const struct snd_kcontrol_new tx_adc2_mux =
+	SOC_DAPM_ENUM("ADC2 MUX Mux", adc2_enum);
+
+static const struct snd_kcontrol_new rx_mix1_inp1_mux =
+	SOC_DAPM_ENUM("RX1 MIX1 INP1 Mux", rx_mix1_inp1_chain_enum);
+
+static const struct snd_kcontrol_new rx_mix1_inp2_mux =
+	SOC_DAPM_ENUM("RX1 MIX1 INP2 Mux", rx_mix1_inp2_chain_enum);
+
+static const struct snd_kcontrol_new rx_mix1_inp3_mux =
+	SOC_DAPM_ENUM("RX1 MIX1 INP3 Mux", rx_mix1_inp3_chain_enum);
+
+static const struct snd_kcontrol_new rx2_mix1_inp1_mux =
+	SOC_DAPM_ENUM("RX2 MIX1 INP1 Mux", rx2_mix1_inp1_chain_enum);
+
+static const struct snd_kcontrol_new rx2_mix1_inp2_mux =
+	SOC_DAPM_ENUM("RX2 MIX1 INP2 Mux", rx2_mix1_inp2_chain_enum);
+
+static const struct snd_kcontrol_new rx2_mix1_inp3_mux =
+	SOC_DAPM_ENUM("RX2 MIX1 INP3 Mux", rx2_mix1_inp3_chain_enum);
+
+static const struct snd_kcontrol_new rx3_mix1_inp1_mux =
+	SOC_DAPM_ENUM("RX3 MIX1 INP1 Mux", rx3_mix1_inp1_chain_enum);
+
+static const struct snd_kcontrol_new rx3_mix1_inp2_mux =
+	SOC_DAPM_ENUM("RX3 MIX1 INP2 Mux", rx3_mix1_inp2_chain_enum);
+
+static const struct snd_kcontrol_new rx3_mix1_inp3_mux =
+	SOC_DAPM_ENUM("RX3 MIX1 INP3 Mux", rx3_mix1_inp3_chain_enum);
+
+static const struct snd_kcontrol_new rx1_mix2_inp1_mux =
+	SOC_DAPM_ENUM("RX1 MIX2 INP1 Mux", rx_mix2_inp1_chain_enum);
+
+static const struct snd_kcontrol_new rx2_mix2_inp1_mux =
+	SOC_DAPM_ENUM("RX2 MIX2 INP1 Mux", rx2_mix2_inp1_chain_enum);
+
+static const struct snd_kcontrol_new hphl_mux[] = {
+	SOC_DAPM_ENUM("HPHL", hph_enum)
+};
+
+static const struct snd_kcontrol_new hphr_mux[] = {
+	SOC_DAPM_ENUM("HPHR", hph_enum)
+};
+
 static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
 static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
 
+static unsigned long rx_digital_gain_reg[] = {
+	MSM8X16_WCD_A_CDC_RX1_VOL_CTL_B2_CTL,
+	MSM8X16_WCD_A_CDC_RX2_VOL_CTL_B2_CTL,
+	MSM8X16_WCD_A_CDC_RX3_VOL_CTL_B2_CTL,
+};
+
+static unsigned long tx_digital_gain_reg[] = {
+	MSM8X16_WCD_A_CDC_TX1_VOL_CTL_GAIN,
+	MSM8X16_WCD_A_CDC_TX2_VOL_CTL_GAIN,
+};
+
 static int msm8x16_wcd_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	return msm8x16_wcd_reg_readonly[reg];
@@ -260,6 +456,1086 @@ static const struct snd_kcontrol_new msm8x16_wcd_snd_controls[] = {
 	SOC_ENUM("RX3 HPF cut off", cf_rxmix3_enum),
 };
 
+static int msm8x16_wcd_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_RX_EAR_CTL,
+			    0x80, 0x80);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_RX_EAR_CTL,
+			    0x40, 0x40);
+		usleep_range(7000, 7100);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x00);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x01);
+		msleep(20);
+		msm8x16_wcd->mute_mask |= MUTE_MASK_EAR_PA_DISABLE;
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_RX_EAR_CTL,
+			    0x40, 0x00);
+		usleep_range(7000, 7100);
+		/*
+		 * Reset pa select bit from ear to hph after ear pa
+		 * is disabled to reduce ear turn off pop
+		 */
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_RX_EAR_CTL,
+			    0x80, 0x00);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_hph_pa_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (w->shift == 5) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_HPH_L_TEST, 0x04, 0x04);
+		} else if (w->shift == 4) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_HPH_R_TEST, 0x04, 0x04);
+		}
+		snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_NCP_FBCTRL, 0x20, 0x20);
+		break;
+
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(4000, 4100);
+		if (w->shift == 5)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x00);
+		else if (w->shift == 4)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX2_B6_CTL, 0x01, 0x00);
+		usleep_range(10000, 10100);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		if (w->shift == 5) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x01);
+			msleep(20);
+			msm8x16_wcd->mute_mask |= MUTE_MASK_HPHL_PA_DISABLE;
+		} else if (w->shift == 4) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX2_B6_CTL, 0x01, 0x01);
+			msleep(20);
+			msm8x16_wcd->mute_mask |= MUTE_MASK_HPHR_PA_DISABLE;
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (w->shift == 5) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_HPH_L_TEST, 0x04, 0x00);
+
+		} else if (w->shift == 4) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_HPH_R_TEST, 0x04, 0x00);
+		}
+		usleep_range(4000, 4100);
+
+		usleep_range(1000, 1100);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL, 0x40, 0x40);
+		usleep_range(10000, 10100);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_hphl_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_RX_HPH_L_PA_DAC_CTL, 0x02, 0x02);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL, 0x01, 0x01);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x02, 0x02);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_RX_HPH_L_PA_DAC_CTL, 0x02, 0x00);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x02, 0x00);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL, 0x01, 0x00);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_spk_pa(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x10, 0x10);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_SPKR_PWRSTG_CTL, 0x01, 0x01);
+		if (!msm8x16_wcd->spk_boost_set)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 0x10, 0x10);
+		usleep_range(1000, 1100);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_SPKR_PWRSTG_CTL, 0xE0, 0xE0);
+		if (!TOMBAK_IS_1_0(msm8x16_wcd->pmic_rev))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_EAR_CTL, 0x01, 0x01);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(1000, 1100);
+		if (msm8x16_wcd->spk_boost_set)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_SPKR_DRV_CTL, 0xEF, 0xEF);
+		else
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 0x10, 0x00);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_RX3_B6_CTL, 0x01, 0x00);
+		snd_soc_update_bits(codec, w->reg, 0x80, 0x80);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_RX3_B6_CTL, 0x01, 0x01);
+		msleep(20);
+		msm8x16_wcd->mute_mask |= MUTE_MASK_SPKR_PA_DISABLE;
+		snd_soc_update_bits(codec, w->reg, 0x80, 0x00);
+		if (msm8x16_wcd->spk_boost_set)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_SPKR_DRV_CTL, 0xEF, 0x00);
+		else
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 0x10, 0x00);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_SPKR_PWRSTG_CTL, 0xE0, 0x00);
+		if (!TOMBAK_IS_1_0(msm8x16_wcd->pmic_rev))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_RX_EAR_CTL, 0x01, 0x00);
+		usleep_range(1000, 1100);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_SPKR_PWRSTG_CTL, 0x01, 0x00);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x10, 0x00);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_dig_clk(struct snd_soc_dapm_widget *w,
+				     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (w->shift == 2)
+			snd_soc_update_bits(codec, w->reg, 0x80, 0x80);
+		if (msm8x16_wcd->spk_boost_set) {
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_SEC_ACCESS,
+					0xA5, 0xA5);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_PERPH_RESET_CTL3,
+					0x0F, 0x0F);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_CURRENT_LIMIT,
+					0x82, 0x82);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x20, 0x20);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BOOST_EN_CTL,
+					0xDF, 0xDF);
+			usleep_range(1000, 1100);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_CURRENT_LIMIT,
+					0x83, 0x83);
+		} else if (msm8x16_wcd->ear_pa_boost_set) {
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_SEC_ACCESS,
+					0xA5, 0xA5);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_PERPH_RESET_CTL3,
+					0x07, 0x07);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x40, 0x40);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x80, 0x80);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x02, 0x02);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BOOST_EN_CTL,
+					0xDF, 0xDF);
+		} else {
+			snd_soc_update_bits(codec, w->reg, 1<<w->shift,
+					1<<w->shift);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (msm8x16_wcd->spk_boost_set) {
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BOOST_EN_CTL,
+					0xDF, 0x5F);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x20, 0x00);
+		} else if (msm8x16_wcd->ear_pa_boost_set) {
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BOOST_EN_CTL,
+					0x80, 0x00);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x80, 0x00);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x02, 0x00);
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_BYPASS_MODE,
+					0x40, 0x00);
+		} else {
+			snd_soc_update_bits(codec, w->reg, 1<<w->shift, 0x00);
+		}
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_rx_chain(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+				0x80, 0x80);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+				0x80, 0x00);
+		snd_soc_update_bits(codec, w->reg,
+			    1 << w->shift, 0x00);
+		msleep(20);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_on_demand_supply(
+		struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	int ret = 0;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regulator_enable(msm8x16_wcd->vdd_micbias);
+		if (ret)
+		dev_err(codec->dev, "%s: Failed to enable vdd micbias\n",
+			__func__);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = regulator_disable(msm8x16_wcd->vdd_micbias);
+		if (ret)
+			dev_err(codec->dev, "%s: Failed to disable vdd-micbias\n",
+				__func__);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int msm8x16_wcd_codec_enable_charge_pump(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (!(strcmp(w->name, "EAR CP")))
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x80, 0x80);
+		else
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0xC0, 0xC0);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(1000, 1100);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		usleep_range(1000, 1100);
+		if (!(strcmp(w->name, "EAR CP")))
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x80, 0x00);
+		else {
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x40, 0x00);
+			if (msm8x16_wcd->rx_bias_count == 0)
+				snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+					0x80, 0x00);
+		}
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_rx_bias(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		msm8x16_wcd->rx_bias_count++;
+		if (msm8x16_wcd->rx_bias_count == 1)
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_RX_COM_BIAS_DAC,
+					0x81, 0x81);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		msm8x16_wcd->rx_bias_count--;
+		if (msm8x16_wcd->rx_bias_count == 0)
+			snd_soc_update_bits(codec,
+					MSM8X16_WCD_A_ANALOG_RX_COM_BIAS_DAC,
+					0x81, 0x00);
+		break;
+	}
+
+	return 0;
+}
+
+static void msm8x16_wcd_micbias2_enable(struct snd_soc_codec *codec, bool on)
+{
+	if (on) {
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_MICB_1_CTL,
+					0x60, 0x60);
+		snd_soc_write(codec, MSM8X16_WCD_A_ANALOG_MICB_1_VAL,
+					0xC0);
+		/*
+		 * Special headset needs MICBIAS as 2.7V so wait for
+		 * 50 msec for the MICBIAS to reach 2.7 volts.
+		 */
+		msleep(50);
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_MICB_1_CTL,
+				0x60, 0x00);
+	}
+}
+
+static int msm8x16_wcd_codec_enable_micbias(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+	u16 micb_int_reg;
+	char *internal1_text = "Internal1";
+	char *internal2_text = "Internal2";
+	char *internal3_text = "Internal3";
+	char *external2_text = "External2";
+	char *external_text = "External";
+	bool micbias2;
+
+	switch (w->reg) {
+	case MSM8X16_WCD_A_ANALOG_MICB_1_EN:
+	case MSM8X16_WCD_A_ANALOG_MICB_2_EN:
+		micb_int_reg = MSM8X16_WCD_A_ANALOG_MICB_1_INT_RBIAS;
+		break;
+	default:
+		dev_err(codec->dev,
+			"%s: Error, invalid micbias register 0x%x\n",
+			__func__, w->reg);
+		return -EINVAL;
+	}
+
+	micbias2 = (snd_soc_read(codec, MSM8X16_WCD_A_ANALOG_MICB_2_EN) & 0x80);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x80, 0x80);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x10, 0x10);
+			snd_soc_update_bits(codec, w->reg, 0x60, 0x00);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x2, 0x2);
+		}
+		if (!strnstr(w->name, external_text, 30))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_MICB_1_EN, 0x05, 0x04);
+		if (w->reg == MSM8X16_WCD_A_ANALOG_MICB_1_EN)
+			msm8x16_wcd_configure_cap(codec, true, micbias2);
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(20000, 20100);
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x40, 0x40);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x08, 0x08);
+			msm8x16_wcd_micbias2_enable(codec, true);
+			msm8x16_wcd_configure_cap(codec, false, true);
+			regmap_write(msm8x16_wcd->analog_map, 0xf144, 0x95);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x01, 0x01);
+		}  else if (strnstr(w->name, external2_text, 30)) {
+			msm8x16_wcd_micbias2_enable(codec, true);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (strnstr(w->name, internal1_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0xC0, 0x40);
+		} else if (strnstr(w->name, internal2_text, 30)) {
+			msm8x16_wcd_micbias2_enable(codec, false);
+		} else if (strnstr(w->name, internal3_text, 30)) {
+			snd_soc_update_bits(codec, micb_int_reg, 0x2, 0x0);
+		} else if (strnstr(w->name, external2_text, 30)) {
+			msm8x16_wcd_micbias2_enable(codec, false);
+			break;
+		}
+		if (w->reg == MSM8X16_WCD_A_ANALOG_MICB_1_EN)
+			msm8x16_wcd_configure_cap(codec, false, micbias2);
+		break;
+	}
+
+	return 0;
+}
+
+static void msm8x16_wcd_codec_enable_adc_block(struct snd_soc_codec *codec,
+					 int enable)
+{
+
+	if (enable) {
+		snd_soc_update_bits(codec,
+				    MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL,
+				    0x20, 0x20);
+		snd_soc_update_bits(codec,
+				    MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+				    0x10, 0x10);
+	} else {
+		snd_soc_update_bits(codec,
+			    MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+			    0x10, 0x00);
+		snd_soc_update_bits(codec,
+			    MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL,
+				    0x20, 0x0);
+	}
+}
+
+static int msm8x16_wcd_codec_enable_adc(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	u16 adc_reg;
+	u8 init_bit_shift;
+
+	adc_reg = MSM8X16_WCD_A_ANALOG_TX_1_2_TEST_CTL_2;
+
+	if (w->reg == MSM8X16_WCD_A_ANALOG_TX_1_EN)
+		init_bit_shift = 5;
+	else if ((w->reg == MSM8X16_WCD_A_ANALOG_TX_2_EN) ||
+		 (w->reg == MSM8X16_WCD_A_ANALOG_TX_3_EN))
+		init_bit_shift = 4;
+	else {
+		dev_err(codec->dev, "%s: Error, invalid adc register\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		msm8x16_wcd_codec_enable_adc_block(codec, 1);
+		if (w->reg == MSM8X16_WCD_A_ANALOG_TX_2_EN)
+			snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_MICB_1_CTL, 0x02, 0x02);
+		/*
+		 * Add delay of 10 ms to give sufficient time for the voltage
+		 * to shoot up and settle so that the txfe init does not
+		 * happen when the input voltage is changing too much.
+		 */
+		usleep_range(10000, 10010);
+		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift,
+				1 << init_bit_shift);
+		if (w->reg == MSM8X16_WCD_A_ANALOG_TX_1_EN)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_CONN_TX1_CTL,
+				0x03, 0x00);
+		else if ((w->reg == MSM8X16_WCD_A_ANALOG_TX_2_EN) ||
+			(w->reg == MSM8X16_WCD_A_ANALOG_TX_3_EN))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_CONN_TX2_CTL,
+				0x03, 0x00);
+		usleep_range(1000, 1100);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 * Add delay of 12 ms before deasserting the init
+		 * to reduce the tx pop
+		 */
+	usleep_range(12000, 12010);
+		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift, 0x00);
+		usleep_range(1000, 1100);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		msm8x16_wcd_codec_enable_adc_block(codec, 0);
+		if (w->reg == MSM8X16_WCD_A_ANALOG_TX_2_EN)
+			snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_MICB_1_CTL, 0x02, 0x00);
+		if (w->reg == MSM8X16_WCD_A_ANALOG_TX_1_EN)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_CONN_TX1_CTL,
+				0x03, 0x02);
+		else if ((w->reg == MSM8X16_WCD_A_ANALOG_TX_2_EN) ||
+			(w->reg == MSM8X16_WCD_A_ANALOG_TX_3_EN))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_DIGITAL_CDC_CONN_TX2_CTL,
+				0x03, 0x02);
+
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_hphr_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_RX_HPH_R_PA_DAC_CTL, 0x02, 0x02);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL, 0x02, 0x02);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x01, 0x01);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_RX_HPH_R_PA_DAC_CTL, 0x02, 0x00);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_ANA_CLK_CTL, 0x01, 0x00);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL, 0x02, 0x00);
+		break;
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
+						 struct snd_kcontrol *kcontrol,
+						 int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* apply the digital gain after the interpolator is enabled*/
+		if ((w->shift) < ARRAY_SIZE(rx_digital_gain_reg))
+			snd_soc_write(codec,
+				  rx_digital_gain_reg[w->shift],
+				  snd_soc_read(codec,
+				  rx_digital_gain_reg[w->shift])
+				  );
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_CLK_RX_RESET_CTL,
+			1 << w->shift, 1 << w->shift);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_CLK_RX_RESET_CTL,
+			1 << w->shift, 0x0);
+		/*
+		 * disable the mute enabled during the PMD of this device
+		 */
+		if (msm8x16_wcd->mute_mask & MUTE_MASK_HPHL_PA_DISABLE) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x00);
+			msm8x16_wcd->mute_mask &= ~(MUTE_MASK_HPHL_PA_DISABLE);
+		}
+		if (msm8x16_wcd->mute_mask & MUTE_MASK_HPHR_PA_DISABLE) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX2_B6_CTL, 0x01, 0x00);
+			msm8x16_wcd->mute_mask &= ~(MUTE_MASK_HPHR_PA_DISABLE);
+		}
+		if (msm8x16_wcd->mute_mask & MUTE_MASK_SPKR_PA_DISABLE) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX3_B6_CTL, 0x01, 0x00);
+			msm8x16_wcd->mute_mask &= ~(MUTE_MASK_SPKR_PA_DISABLE);
+		}
+		if (msm8x16_wcd->mute_mask & MUTE_MASK_EAR_PA_DISABLE) {
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0x01, 0x00);
+			msm8x16_wcd->mute_mask &= ~(MUTE_MASK_EAR_PA_DISABLE);
+		}
+	}
+	return 0;
+}
+
+static int msm8x16_wcd_codec_enable_dec(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	unsigned int decimator;
+	char *dec_name = NULL;
+	char *widget_name = NULL;
+	char *temp;
+	int ret = 0;
+	u16 dec_reset_reg, tx_vol_ctl_reg, tx_mux_ctl_reg;
+	u8 dec_hpf_cut_of_freq;
+	int offset;
+	char *dec_num;
+
+	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	if (!widget_name)
+		return -ENOMEM;
+	temp = widget_name;
+
+	dec_name = strsep(&widget_name, " ");
+	widget_name = temp;
+	if (!dec_name) {
+		dev_err(codec->dev,
+			"%s: Invalid decimator = %s\n", __func__, w->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dec_num = strpbrk(dec_name, "12");
+	if (dec_num == NULL) {
+		dev_err(codec->dev, "%s: Invalid Decimator\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = kstrtouint(dec_num, 10, &decimator);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"%s: Invalid decimator = %s\n", __func__, dec_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev_err(codec->dev,
+		"%s(): widget = %s dec_name = %s decimator = %u\n", __func__,
+		w->name, dec_name, decimator);
+
+	if (w->reg == MSM8X16_WCD_A_CDC_CLK_TX_CLK_EN_B1_CTL) {
+		dec_reset_reg = MSM8X16_WCD_A_CDC_CLK_TX_RESET_B1_CTL;
+		offset = 0;
+	} else {
+		dev_err(codec->dev, "%s: Error, incorrect dec\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tx_vol_ctl_reg = MSM8X16_WCD_A_CDC_TX1_VOL_CTL_CFG +
+			 32 * (decimator - 1);
+	tx_mux_ctl_reg = MSM8X16_WCD_A_CDC_TX1_MUX_CTL +
+			  32 * (decimator - 1);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enableable TX digital mute */
+		snd_soc_update_bits(codec, tx_vol_ctl_reg, 0x01, 0x01);
+		dec_hpf_cut_of_freq = snd_soc_read(codec, tx_mux_ctl_reg);
+		dec_hpf_cut_of_freq = (dec_hpf_cut_of_freq & 0x30) >> 4;
+		if (dec_hpf_cut_of_freq != CF_MIN_3DB_150HZ) {
+			/* set cut of freq to CF_MIN_3DB_150HZ (0x1) */
+			snd_soc_update_bits(codec, tx_mux_ctl_reg, 0x30,
+					    CF_MIN_3DB_150HZ << 4);
+		}
+		snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_TX_1_2_TXFE_CLKDIV,
+				0xFF, 0x42);
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* enable HPF */
+		snd_soc_update_bits(codec, tx_mux_ctl_reg, 0x08, 0x00);
+		/* apply the digital gain after the decimator is enabled*/
+		if ((w->shift) < ARRAY_SIZE(tx_digital_gain_reg))
+			snd_soc_write(codec,
+				  tx_digital_gain_reg[w->shift + offset],
+				  snd_soc_read(codec,
+				  tx_digital_gain_reg[w->shift + offset])
+				  );
+		snd_soc_update_bits(codec, tx_vol_ctl_reg, 0x01, 0x00);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, tx_vol_ctl_reg, 0x01, 0x01);
+		msleep(20);
+		snd_soc_update_bits(codec, tx_mux_ctl_reg, 0x08, 0x08);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift,
+			1 << w->shift);
+		snd_soc_update_bits(codec, dec_reset_reg, 1 << w->shift, 0x0);
+		snd_soc_update_bits(codec, tx_mux_ctl_reg, 0x08, 0x08);
+		snd_soc_update_bits(codec, tx_vol_ctl_reg, 0x01, 0x00);
+		break;
+	}
+
+out:
+	kfree(widget_name);
+	return ret;
+}
+
+static s32 g_dmic_clk_cnt;
+static int msm8x16_wcd_codec_enable_dmic(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	u8  dmic_clk_en;
+	u16 dmic_clk_reg;
+	s32 *dmic_clk_cnt;
+	unsigned int dmic;
+	int ret;
+	char *dec_num = strpbrk(w->name, "12");
+
+	if (dec_num == NULL) {
+		dev_err(codec->dev, "%s: Invalid DMIC\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = kstrtouint(dec_num, 10, &dmic);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"%s: Invalid DMIC line on the codec\n", __func__);
+		return -EINVAL;
+	}
+
+	switch (dmic) {
+	case 1:
+	case 2:
+		dmic_clk_en = 0x01;
+		dmic_clk_cnt = &g_dmic_clk_cnt;
+		dmic_clk_reg = MSM8X16_WCD_A_CDC_CLK_DMIC_B1_CTL;
+		break;
+	default:
+		dev_err(codec->dev, "%s: Invalid DMIC Selection\n", __func__);
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		(*dmic_clk_cnt)++;
+		if (*dmic_clk_cnt == 1) {
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					0x0E, 0x02);
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					dmic_clk_en, dmic_clk_en);
+		}
+		if (dmic == 1)
+			snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_TX1_DMIC_CTL, 0x07, 0x01);
+		if (dmic == 2)
+			snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_TX2_DMIC_CTL, 0x07, 0x01);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		(*dmic_clk_cnt)--;
+		if (*dmic_clk_cnt  == 0)
+			snd_soc_update_bits(codec, dmic_clk_reg,
+					dmic_clk_en, 0);
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget msm8x16_wcd_dapm_widgets[] = {
+	/*RX stuff */
+	SND_SOC_DAPM_OUTPUT("EAR"),
+
+	SND_SOC_DAPM_PGA_E("EAR PA", SND_SOC_NOPM,
+			0, 0, NULL, 0, msm8x16_wcd_codec_enable_ear_pa,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("EAR_S", SND_SOC_NOPM, 0, 0,
+		ear_pa_switch, ARRAY_SIZE(ear_pa_switch)),
+
+	SND_SOC_DAPM_AIF_IN("I2S RX1", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_AIF_IN("I2S RX2", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_AIF_IN("I2S RX3", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_SUPPLY("INT_LDO_H", SND_SOC_NOPM, 1, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("HEADPHONE"),
+	SND_SOC_DAPM_PGA_E("HPHL PA", MSM8X16_WCD_A_ANALOG_RX_HPH_CNP_EN,
+		5, 0, NULL, 0,
+		msm8x16_wcd_hph_pa_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("HPHL", SND_SOC_NOPM, 0, 0, hphl_mux),
+
+	SND_SOC_DAPM_MIXER_E("HPHL DAC",
+		MSM8X16_WCD_A_ANALOG_RX_HPH_L_PA_DAC_CTL, 3, 0, NULL,
+		0, msm8x16_wcd_hphl_dac_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_PGA_E("HPHR PA", MSM8X16_WCD_A_ANALOG_RX_HPH_CNP_EN,
+		4, 0, NULL, 0,
+		msm8x16_wcd_hph_pa_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("HPHR", SND_SOC_NOPM, 0, 0, hphr_mux),
+
+	SND_SOC_DAPM_MIXER_E("HPHR DAC",
+		MSM8X16_WCD_A_ANALOG_RX_HPH_R_PA_DAC_CTL, 3, 0, NULL,
+		0, msm8x16_wcd_hphr_dac_event,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER("SPK DAC", SND_SOC_NOPM, 0, 0,
+		spkr_switch, ARRAY_SIZE(spkr_switch)),
+
+	/* Speaker */
+	SND_SOC_DAPM_OUTPUT("SPK_OUT"),
+
+	SND_SOC_DAPM_PGA_E("SPK PA", MSM8X16_WCD_A_ANALOG_SPKR_DRV_CTL,
+			6, 0, NULL, 0, msm8x16_wcd_codec_enable_spk_pa,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("RX1 MIX1",
+			MSM8X16_WCD_A_CDC_CLK_RX_B1_CTL, 0, 0, NULL, 0,
+			msm8x16_wcd_codec_enable_interpolator,
+		SND_SOC_DAPM_PRE_REG|
+			SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD|
+			SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("RX2 MIX1",
+			MSM8X16_WCD_A_CDC_CLK_RX_B1_CTL, 1, 0, NULL, 0,
+			msm8x16_wcd_codec_enable_interpolator,
+		SND_SOC_DAPM_PRE_REG|
+			SND_SOC_DAPM_POST_PMU |
+			SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER_E("RX1 MIX2",
+		MSM8X16_WCD_A_CDC_CLK_RX_B1_CTL, 0, 0, NULL,
+		0, msm8x16_wcd_codec_enable_interpolator,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX2 MIX2",
+		MSM8X16_WCD_A_CDC_CLK_RX_B1_CTL, 1, 0, NULL,
+		0, msm8x16_wcd_codec_enable_interpolator,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX3 MIX1",
+		MSM8X16_WCD_A_CDC_CLK_RX_B1_CTL, 2, 0, NULL,
+		0, msm8x16_wcd_codec_enable_interpolator,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("RX1 CLK", MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+		0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RX2 CLK", MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+		1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RX3 CLK", MSM8X16_WCD_A_DIGITAL_CDC_DIG_CLK_CTL,
+		2, 0, msm8x16_wcd_codec_enable_dig_clk, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX1 CHAIN", MSM8X16_WCD_A_CDC_RX1_B6_CTL, 0, 0,
+		NULL, 0,
+		msm8x16_wcd_codec_enable_rx_chain,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX2 CHAIN", MSM8X16_WCD_A_CDC_RX2_B6_CTL, 0, 0,
+		NULL, 0,
+		msm8x16_wcd_codec_enable_rx_chain,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER_E("RX3 CHAIN", MSM8X16_WCD_A_CDC_RX3_B6_CTL, 0, 0,
+		NULL, 0,
+		msm8x16_wcd_codec_enable_rx_chain,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+		&rx_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+		&rx_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+		&rx_mix1_inp3_mux),
+
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+		&rx2_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+		&rx2_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+		&rx2_mix1_inp3_mux),
+
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP1", SND_SOC_NOPM, 0, 0,
+		&rx3_mix1_inp1_mux),
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP2", SND_SOC_NOPM, 0, 0,
+		&rx3_mix1_inp2_mux),
+	SND_SOC_DAPM_MUX("RX3 MIX1 INP3", SND_SOC_NOPM, 0, 0,
+		&rx3_mix1_inp3_mux),
+
+	SND_SOC_DAPM_MUX("RX1 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+		&rx1_mix2_inp1_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+		&rx2_mix2_inp1_mux),
+
+	SND_SOC_DAPM_SUPPLY("MICBIAS_REGULATOR", SND_SOC_NOPM,
+		0, 0,
+		msm8x16_wcd_codec_enable_on_demand_supply,
+		SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("CP", MSM8X16_WCD_A_ANALOG_NCP_EN, 0, 0,
+		msm8x16_wcd_codec_enable_charge_pump, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU |	SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("EAR CP", MSM8X16_WCD_A_ANALOG_NCP_EN, 4, 0,
+		msm8x16_wcd_codec_enable_charge_pump, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("RX_BIAS", SND_SOC_NOPM,
+		0, 0, msm8x16_wcd_codec_enable_rx_bias,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("SPK_RX_BIAS", SND_SOC_NOPM, 0, 0,
+		msm8x16_wcd_codec_enable_rx_bias, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	/* TX */
+	SND_SOC_DAPM_SUPPLY_S("CDC_CONN", -2, MSM8X16_WCD_A_CDC_CLK_OTHR_CTL,
+		2, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("AMIC1"),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1",
+		MSM8X16_WCD_A_ANALOG_MICB_1_EN, 7, 0,
+		msm8x16_wcd_codec_enable_micbias, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2",
+		MSM8X16_WCD_A_ANALOG_MICB_2_EN, 7, 0,
+		msm8x16_wcd_codec_enable_micbias, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal3",
+		MSM8X16_WCD_A_ANALOG_MICB_1_EN, 7, 0,
+		msm8x16_wcd_codec_enable_micbias, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC1", NULL, MSM8X16_WCD_A_ANALOG_TX_1_EN, 7, 0,
+		msm8x16_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2_INP2",
+		NULL, MSM8X16_WCD_A_ANALOG_TX_2_EN, 7, 0,
+		msm8x16_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2_INP3",
+		NULL, MSM8X16_WCD_A_ANALOG_TX_3_EN, 7, 0,
+		msm8x16_wcd_codec_enable_adc, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER("ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("ADC2 MUX", SND_SOC_NOPM, 0, 0,
+		&tx_adc2_mux),
+
+	SND_SOC_DAPM_SUPPLY("MIC BIAS External",
+		MSM8X16_WCD_A_ANALOG_MICB_1_EN, 7, 0,
+		msm8x16_wcd_codec_enable_micbias, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY("MIC BIAS External2",
+		MSM8X16_WCD_A_ANALOG_MICB_2_EN, 7, 0,
+		msm8x16_wcd_codec_enable_micbias, SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_INPUT("AMIC3"),
+
+	SND_SOC_DAPM_MUX_E("DEC1 MUX",
+		MSM8X16_WCD_A_CDC_CLK_TX_CLK_EN_B1_CTL, 0, 0,
+		&dec1_mux, msm8x16_wcd_codec_enable_dec,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX_E("DEC2 MUX",
+		MSM8X16_WCD_A_CDC_CLK_TX_CLK_EN_B1_CTL, 1, 0,
+		&dec2_mux, msm8x16_wcd_codec_enable_dec,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MUX("RDAC2 MUX", SND_SOC_NOPM, 0, 0, &rdac2_mux),
+
+	SND_SOC_DAPM_INPUT("AMIC2"),
+
+	SND_SOC_DAPM_AIF_OUT("I2S TX1", "AIF1 Capture", 0, SND_SOC_NOPM,
+		0, 0),
+	SND_SOC_DAPM_AIF_OUT("I2S TX2", "AIF1 Capture", 0, SND_SOC_NOPM,
+		0, 0),
+	SND_SOC_DAPM_AIF_OUT("I2S TX3", "AIF1 Capture", 0, SND_SOC_NOPM,
+		0, 0),
+
+	/* Digital Mic Inputs */
+	SND_SOC_DAPM_ADC_E("DMIC1", NULL, SND_SOC_NOPM, 0, 0,
+		msm8x16_wcd_codec_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_ADC_E("DMIC2", NULL, SND_SOC_NOPM, 0, 0,
+		msm8x16_wcd_codec_enable_dmic, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
+	/* Sidetone */
+	SND_SOC_DAPM_MUX("IIR1 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir1_inp1_mux),
+	SND_SOC_DAPM_PGA("IIR1",
+		MSM8X16_WCD_A_CDC_CLK_SD_CTL, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("IIR2 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir2_inp1_mux),
+	SND_SOC_DAPM_PGA("IIR2",
+		MSM8X16_WCD_A_CDC_CLK_SD_CTL, 1, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("RX_I2S_CLK",
+		MSM8X16_WCD_A_CDC_CLK_RX_I2S_CTL,	4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("TX_I2S_CLK",
+		MSM8X16_WCD_A_CDC_CLK_TX_I2S_CTL, 4, 0,
+		NULL, 0),
+};
 
 static int msm8x16_wcd_codec_parse_dt(struct platform_device *pdev,
 				      struct msm8x16_wcd_chip *chip)
@@ -650,6 +1926,8 @@ static struct snd_soc_codec_driver msm8x16_wcd_codec = {
 	.reg_word_size = 1,
 	.controls = msm8x16_wcd_snd_controls,
 	.num_controls = ARRAY_SIZE(msm8x16_wcd_snd_controls),
+	.dapm_widgets = msm8x16_wcd_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(msm8x16_wcd_dapm_widgets),
 };
 
 static int msm8x16_wcd_probe(struct platform_device *pdev)
-- 
1.9.1
