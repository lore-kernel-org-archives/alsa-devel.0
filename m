From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [alsa-devel] [PATCH] ASoC: codecs: da9055: Minor improvements
Date: Wed, 10 Oct 2012 17:24:53 +0530
Message-ID: <1349870093.13275.16.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: David Dajun Chen <david.chen@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch includes two minor improvements for da9055 codec driver

(1) Adding support for DSP mode of AIF
(2) Muting Mic PGAs during ALC calibration process

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
---
 sound/soc/codecs/da9055.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 185d8dd..abf3e43 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -173,11 +173,18 @@
 #define DA9055_AIF_FORMAT_I2S_MODE	(0 << 0)
 #define DA9055_AIF_FORMAT_LEFT_J	(1 << 0)
 #define DA9055_AIF_FORMAT_RIGHT_J	(2 << 0)
+#define DA9055_AIF_FORMAT_DSP		(3 << 0)
 #define DA9055_AIF_WORD_S16_LE		(0 << 2)
 #define DA9055_AIF_WORD_S20_3LE		(1 << 2)
 #define DA9055_AIF_WORD_S24_LE		(2 << 2)
 #define DA9055_AIF_WORD_S32_LE		(3 << 2)
 
+/* MIC_L_CTRL bit fields */
+#define DA9055_MIC_L_MUTE_EN		(1 << 6)
+
+/* MIC_R_CTRL bit fields */
+#define DA9055_MIC_R_MUTE_EN		(1 << 6)
+
 /* MIXIN_L_CTRL bit fields */
 #define DA9055_MIXIN_L_MIX_EN		(1 << 3)
 
@@ -476,7 +483,7 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	u8 reg_val, adc_left, adc_right;
+	u8 reg_val, adc_left, adc_right, mic_left, mic_right;
 	int avg_left_data, avg_right_data, offset_l, offset_r;
 
 	if (ucontrol->value.integer.value[0]) {
@@ -485,6 +492,16 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 		 * offsets must be done first
 		 */
 
+		/* Save current values from Mic control registers */
+		mic_left = snd_soc_read(codec, DA9055_MIC_L_CTRL);
+		mic_right = snd_soc_read(codec, DA9055_MIC_R_CTRL);
+
+		/* Mute Mic PGA Left and Right */
+		snd_soc_update_bits(codec, DA9055_MIC_L_CTRL,
+				    DA9055_MIC_L_MUTE_EN, DA9055_MIC_L_MUTE_EN);
+		snd_soc_update_bits(codec, DA9055_MIC_R_CTRL,
+				    DA9055_MIC_R_MUTE_EN, DA9055_MIC_R_MUTE_EN);
+
 		/* Save current values from ADC control registers */
 		adc_left = snd_soc_read(codec, DA9055_ADC_L_CTRL);
 		adc_right = snd_soc_read(codec, DA9055_ADC_R_CTRL);
@@ -520,6 +537,10 @@ static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 		/* Restore original values of ADC control registers */
 		snd_soc_write(codec, DA9055_ADC_L_CTRL, adc_left);
 		snd_soc_write(codec, DA9055_ADC_R_CTRL, adc_right);
+
+		/* Restore original values of Mic control registers */
+		snd_soc_write(codec, DA9055_MIC_L_CTRL, mic_left);
+		snd_soc_write(codec, DA9055_MIC_R_CTRL, mic_right);
 	}
 
 	return snd_soc_put_volsw(kcontrol, ucontrol);
@@ -1155,6 +1176,9 @@ static int da9055_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_RIGHT_J:
 		aif_ctrl = DA9055_AIF_FORMAT_RIGHT_J;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		aif_ctrl = DA9055_AIF_FORMAT_DSP;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.1
