From: <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: Add ASRC support
Date: Fri, 31 Oct 2014 15:37:55 +0800
Message-ID: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CCCB2654E5
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 08:38:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch add ASRC support for rt5645 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bc442f4..3131e91 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -443,6 +443,65 @@ static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
 				RT5645_TDM_CTRL_1, 8,
 				rt5645_tdm_adc_data_select);
 
+static int rt5645_clk_sel_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	unsigned int u_bit = 0, p_bit = 0;
+	struct soc_enum *em =
+		(struct soc_enum *)kcontrol->private_value;
+
+	switch (em->reg) {
+	case RT5645_ASRC_2:
+		switch (em->shift_l) {
+		case 0:
+			u_bit = 0x8;
+			p_bit = RT5645_PWR_ADC_S1F;
+			break;
+		case 4:
+			u_bit = 0x100;
+			p_bit = RT5645_PWR_DAC_MF_R;
+			break;
+		case 8:
+			u_bit = 0x200;
+			p_bit = RT5645_PWR_DAC_MF_L;
+			break;
+		case 12:
+			u_bit = 0x400;
+			p_bit = RT5645_PWR_DAC_S1F;
+			break;
+		}
+		break;
+	case RT5645_ASRC_3:
+		switch (em->shift_l) {
+		case 0:
+			u_bit = 0x1;
+			p_bit = RT5645_PWR_ADC_MF_R;
+			break;
+		case 4:
+			u_bit = 0x2;
+			p_bit = RT5645_PWR_ADC_MF_L;
+			break;
+		}
+		break;
+	}
+
+	if (u_bit || p_bit) {
+		switch (ucontrol->value.integer.value[0]) {
+		case 1 ... 4: /*enable*/
+			if (snd_soc_read(codec, RT5645_PWR_DIG2) & p_bit)
+				snd_soc_update_bits(codec,
+					RT5645_ASRC_1, u_bit, u_bit);
+			break;
+		default: /*disable*/
+			snd_soc_update_bits(codec, RT5645_ASRC_1, u_bit, 0);
+			break;
+		}
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -554,6 +613,53 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
+static int is_using_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int reg, shift, val;
+
+	switch (source->shift) {
+	case 0:
+		reg = RT5645_ASRC_3;
+		shift = 0;
+		break;
+	case 1:
+		reg = RT5645_ASRC_3;
+		shift = 4;
+		break;
+	case 3:
+		reg = RT5645_ASRC_2;
+		shift = 0;
+		break;
+	case 8:
+		reg = RT5645_ASRC_2;
+		shift = 4;
+		break;
+	case 9:
+		reg = RT5645_ASRC_2;
+		shift = 8;
+		break;
+	case 10:
+		reg = RT5645_ASRC_2;
+		shift = 12;
+		break;
+	default:
+		return 0;
+	}
+
+	val = (snd_soc_read(source->codec, reg) >> shift) & 0xf;
+	switch (val) {
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		return 1;
+	default:
+		return 0;
+	}
+
+}
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5645_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5645_STO1_ADC_MIXER,
@@ -1246,6 +1352,30 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5645_PWR_VOL,
 		RT5645_PWR_MIC_DET_BIT, 0, NULL, 0),
 
+	/* ASRC */
+	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5645_ASRC_1,
+			      11, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5645_ASRC_1,
+			      12, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5645_ASRC_1,
+			      10, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO L ASRC", 1, RT5645_ASRC_1,
+			      9, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO R ASRC", 1, RT5645_ASRC_1,
+			      8, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO1 ASRC", 1, RT5645_ASRC_1,
+			      7, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO L ASRC", 1, RT5645_ASRC_1,
+			      5, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO R ASRC", 1, RT5645_ASRC_1,
+			      4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5645_ASRC_1,
+			      3, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO L ASRC", 1, RT5645_ASRC_1,
+			      1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO R ASRC", 1, RT5645_ASRC_1,
+			      0, 0, NULL, 0),
+
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
@@ -1504,6 +1634,17 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
+	{ "adc stereo1 filter", NULL, "ADC STO1 ASRC", is_using_asrc },
+	{ "adc stereo2 filter", NULL, "ADC STO2 ASRC", is_using_asrc },
+	{ "adc mono left filter", NULL, "ADC MONO L ASRC", is_using_asrc },
+	{ "adc mono right filter", NULL, "ADC MONO R ASRC", is_using_asrc },
+	{ "dac mono left filter", NULL, "DAC MONO L ASRC", is_using_asrc },
+	{ "dac mono right filter", NULL, "DAC MONO R ASRC", is_using_asrc },
+	{ "dac stereo1 filter", NULL, "DAC STO ASRC", is_using_asrc },
+
+	{ "I2S1", NULL, "I2S1 ASRC" },
+	{ "I2S2", NULL, "I2S2 ASRC" },
+
 	{ "IN1P", NULL, "LDO2" },
 	{ "IN2P", NULL, "LDO2" },
 
@@ -1550,12 +1691,15 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 
 	{ "Stereo1 DMIC Mux", "DMIC1", "DMIC1" },
 	{ "Stereo1 DMIC Mux", "DMIC2", "DMIC2" },
+	{ "Stereo1 DMIC Mux", NULL, "DMIC STO1 ASRC" },
 
 	{ "Mono DMIC L Mux", "DMIC1", "DMIC L1" },
 	{ "Mono DMIC L Mux", "DMIC2", "DMIC L2" },
+	{ "Mono DMIC L Mux", NULL, "DMIC MONO L ASRC" },
 
 	{ "Mono DMIC R Mux", "DMIC1", "DMIC R1" },
 	{ "Mono DMIC R Mux", "DMIC2", "DMIC R2" },
+	{ "Mono DMIC R Mux", NULL, "DMIC MONO R ASRC" },
 
 	{ "Stereo1 ADC L2 Mux", "DMIC", "Stereo1 DMIC Mux" },
 	{ "Stereo1 ADC L2 Mux", "DAC MIX", "DAC MIXL" },
-- 
1.8.1.1.439.g50a6b54
