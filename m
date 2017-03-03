From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 04/10] Modified indentation
Date: Fri, 3 Mar 2017 23:52:42 +0900
Message-ID: <1488552768-14901-5-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0117.outbound.protection.outlook.com [104.47.34.117])
 by alsa0.perex.cz (Postfix) with ESMTP id A4363266AFE
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:02 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Modified indentation problem.

 sound/soc/codecs/max98927.c | 80 ++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 5627279c..efc761b 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -141,22 +141,21 @@ static struct reg_default max98927_reg[] = {
 };
 
 static int max98927_reg_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
-		unsigned int mask, unsigned int shift)
+	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
+	unsigned int mask, unsigned int shift)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	int data;
 
 	regmap_read(max98927->regmap, reg, &data);
-	ucontrol->value.integer.value[0] =
-		(data & mask) >> shift;
+	ucontrol->value.integer.value[0] = (data & mask) >> shift;
 	return 0;
 }
 
 static int max98927_reg_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol, unsigned int reg,
-		unsigned int mask, unsigned int shift)
+	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
+	unsigned int mask, unsigned int shift)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -164,18 +163,18 @@ static int max98927_reg_put(struct snd_kcontrol *kcontrol,
 
 	regmap_update_bits(max98927->regmap, reg, mask, sel << shift);
 	dev_dbg(codec->dev, "%s: register 0x%02X, value 0x%02X\n",
-				__func__, reg, sel);
+		__func__, reg, sel);
 	return 0;
 }
 
-static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
-	unsigned int fmt)
+static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int invert = 0;
 
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		regmap_update_bits(max98927->regmap,
@@ -218,13 +217,13 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			max98927->iface, max98927->iface);
-	break;
+		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0020_PCM_MODE_CFG,
 			max98927->iface, max98927->iface);
-	break;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -292,8 +291,7 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(max98927->regmap,
-		reg, mask, value);
+	regmap_update_bits(max98927->regmap, reg, mask, value);
 	return 0;
 }
 
@@ -388,7 +386,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static int max98927_dai_set_sysclk(struct snd_soc_dai *dai,
-				   int clk_id, unsigned int freq, int dir)
+	int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -458,7 +456,7 @@ static DECLARE_TLV_DB_SCALE(max98927_spk_tlv, 300, 300, 0);
 static DECLARE_TLV_DB_SCALE(max98927_digital_tlv, -1600, 25, 0);
 
 static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -470,7 +468,7 @@ static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -486,7 +484,7 @@ static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -498,7 +496,7 @@ static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
@@ -514,7 +512,7 @@ static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0040_BOOST_CTRL0,
@@ -522,7 +520,7 @@ static int max98927_boost_voltage_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_boost_voltage_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0040_BOOST_CTRL0,
@@ -530,7 +528,7 @@ static int max98927_boost_voltage_put(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_amp_vol_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0036_AMP_VOL_CTRL,
@@ -539,7 +537,7 @@ static int max98927_amp_vol_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_amp_dsp_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0052_BROWNOUT_EN,
@@ -548,7 +546,7 @@ static int max98927_amp_dsp_put(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_amp_dsp_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0052_BROWNOUT_EN,
@@ -557,7 +555,7 @@ static int max98927_amp_dsp_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_ramp_switch_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0037_AMP_DSP_CFG,
@@ -565,7 +563,7 @@ static int max98927_ramp_switch_put(struct snd_kcontrol *kcontrol,
 		MAX98927_AMP_DSP_CFG_RMP_SHIFT);
 }
 static int max98927_ramp_switch_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0037_AMP_DSP_CFG,
@@ -574,21 +572,21 @@ static int max98927_ramp_switch_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_dre_en_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0039_DRE_CTRL,
 		MAX98927_DRE_CTRL_DRE_EN, 0);
 }
 static int max98927_dre_en_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0039_DRE_CTRL,
 		MAX98927_DRE_CTRL_DRE_EN, 0);
 }
 static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0036_AMP_VOL_CTRL,
@@ -596,7 +594,7 @@ static int max98927_amp_vol_put(struct snd_kcontrol *kcontrol,
 		7);
 }
 static int max98927_spk_src_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R003B_SPK_SRC_SEL,
@@ -604,7 +602,7 @@ static int max98927_spk_src_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_spk_src_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R003B_SPK_SRC_SEL,
@@ -612,7 +610,7 @@ static int max98927_spk_src_put(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_mono_out_get(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_get(kcontrol, ucontrol,
 		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
@@ -621,7 +619,7 @@ static int max98927_mono_out_get(struct snd_kcontrol *kcontrol,
 }
 
 static int max98927_mono_out_put(struct snd_kcontrol *kcontrol,
-		struct snd_ctl_elem_value *ucontrol)
+	struct snd_ctl_elem_value *ucontrol)
 {
 	return max98927_reg_put(kcontrol, ucontrol,
 		MAX98927_R0025_PCM_TO_SPK_MONOMIX_A,
@@ -646,9 +644,10 @@ static bool max98927_readable_register(struct device *dev, unsigned int reg)
 	case MAX98927_R0100_SOFT_RESET:
 	case MAX98927_R01FF_REV_ID:
 		return true;
+	default:
+		return false;
 	}
-	return false;
-};
+}
 
 static const char * const max98927_boost_voltage_text[] = {
 	"6.5V", "6.625V", "6.75V", "6.875V", "7V", "7.125V", "7.25V", "7.375V",
@@ -701,13 +700,12 @@ static const struct snd_kcontrol_new max98927_snd_controls[] = {
 		MAX98927_R0036_AMP_VOL_CTRL,
 		MAX98927_AMP_VOL_SEL_SHIFT, 1, 0,
 		max98927_amp_vol_get, max98927_amp_vol_put),
-
 	SOC_ENUM_EXT("Boost Output Voltage", max98927_enum[2],
-	max98927_boost_voltage_get, max98927_boost_voltage_put),
+		max98927_boost_voltage_get, max98927_boost_voltage_put),
 	SOC_ENUM_EXT("Speaker Source", max98927_enum[1],
-	max98927_spk_src_get, max98927_spk_src_put),
+		max98927_spk_src_get, max98927_spk_src_put),
 	SOC_ENUM_EXT("Monomix Output", max98927_enum[0],
-	max98927_mono_out_get, max98927_mono_out_put),
+		max98927_mono_out_get, max98927_mono_out_put),
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
@@ -762,9 +760,9 @@ static int max98927_probe(struct snd_soc_codec *codec)
 	if (max98927->regmap)
 		regmap_write(max98927->regmap,
 			MAX98927_R001E_PCM_TX_CH_SRC_A,
-			(max98927->i_l_slot
-				<<MAX98927_PCM_TX_CH_SRC_A_I_SHIFT|
-				max98927->v_l_slot)&0xFF);
+			((max98927->i_l_slot <<
+			MAX98927_PCM_TX_CH_SRC_A_I_SHIFT)
+			| max98927->v_l_slot) & 0xFF);
 
 	/* Set interleave mode */
 	if (max98927->interleave_mode)
-- 
2.7.4
