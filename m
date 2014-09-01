From: <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5670: add clock source selection
	controls
Date: Mon, 1 Sep 2014 13:37:58 +0800
Message-ID: <1409549878-27304-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E3AFE265134
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 07:38:27 +0200 (CEST)
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

We can select the clock source of some digital widgets in rt5670.
This patch adds the controls of those selections.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
Mark,

I write the changelog at the beginning of rt5670.c. But I am not
sure if it is a regular way to make a changelog.
---
 sound/soc/codecs/rt5670.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index ba9d9b4..87131a1 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -7,6 +7,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * Changelog:
+ *
+ * - Add clock source selections for some digital widgets.
  */
 
 #include <linux/module.h>
@@ -430,6 +434,105 @@ static SOC_ENUM_SINGLE_DECL(rt5670_if2_dac_enum, RT5670_DIG_INF1_DATA,
 static SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_enum, RT5670_DIG_INF1_DATA,
 				RT5670_IF2_ADC_SEL_SFT, rt5670_data_select);
 
+static const char * const rt5670_asrc_clk_source[] = {
+	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
+	"clk_i2s3_track", "clk_i2s4_track", "clk_sys2", "clk_sys3",
+	"clk_sys4", "clk_sys5"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_da_sto_asrc_enum, RT5670_ASRC_2,
+				12, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_da_monol_asrc_enum, RT5670_ASRC_2,
+				8, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_da_monor_asrc_enum, RT5670_ASRC_2,
+				4, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_ad_sto1_asrc_enum, RT5670_ASRC_2,
+				0, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_up_filter_asrc_enum, RT5670_ASRC_3,
+				12, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_down_filter_asrc_enum, RT5670_ASRC_3,
+				8, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_ad_monol_asrc_enum, RT5670_ASRC_3,
+				4, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_ad_monor_asrc_enum, RT5670_ASRC_3,
+				0, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_ad_sto2_asrc_enum, RT5670_ASRC_5,
+				12, rt5670_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5670_dsp_asrc_enum, RT5670_DSP_CLK,
+				0, rt5670_asrc_clk_source);
+
+static int rt5670_clk_sel_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	unsigned int u_bit = 0, p_bit = 0;
+	struct soc_enum *em =
+		(struct soc_enum *)kcontrol->private_value;
+
+	switch (em->reg) {
+	case RT5670_ASRC_2:
+		switch (em->shift_l) {
+		case 0:
+			u_bit = 0x8;
+			p_bit = RT5670_PWR_ADC_S1F;
+			break;
+		case 4:
+			u_bit = 0x100;
+			p_bit = RT5670_PWR_DAC_MF_R;
+			break;
+		case 8:
+			u_bit = 0x200;
+			p_bit = RT5670_PWR_DAC_MF_L;
+			break;
+		case 12:
+			u_bit = 0x400;
+			p_bit = RT5670_PWR_DAC_S1F;
+			break;
+		}
+		break;
+	case RT5670_ASRC_3:
+		switch (em->shift_l) {
+		case 0:
+			u_bit = 0x1;
+			p_bit = RT5670_PWR_ADC_MF_R;
+			break;
+		case 4:
+			u_bit = 0x2;
+			p_bit = RT5670_PWR_ADC_MF_L;
+			break;
+		}
+		break;
+	case RT5670_ASRC_5:
+		u_bit = 0x4;
+		p_bit = RT5670_PWR_ADC_S2F;
+		break;
+	}
+
+	if (u_bit || p_bit) {
+		switch (ucontrol->value.integer.value[0]) {
+		case 1 ... 4: /*enable*/
+			if (snd_soc_read(codec, RT5670_PWR_DIG2) & p_bit)
+				snd_soc_update_bits(codec,
+					RT5670_ASRC_1, u_bit, u_bit);
+			break;
+		default: /*disable*/
+			snd_soc_update_bits(codec, RT5670_ASRC_1, u_bit, 0);
+			break;
+		}
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
 static const struct snd_kcontrol_new rt5670_snd_controls[] = {
 	/* Headphone Output Volume */
 	SOC_DOUBLE("HP Playback Switch", RT5670_HP_VOL,
@@ -482,6 +585,24 @@ static const struct snd_kcontrol_new rt5670_snd_controls[] = {
 
 	SOC_ENUM("ADC IF2 Data Switch", rt5670_if2_adc_enum),
 	SOC_ENUM("DAC IF2 Data Switch", rt5670_if2_dac_enum),
+
+	SOC_ENUM_EXT("DA STO Clk Sel", rt5670_da_sto_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM_EXT("DA MONOL Clk Sel", rt5670_da_monol_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM_EXT("DA MONOR Clk Sel", rt5670_da_monor_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM_EXT("AD STO1 Clk Sel", rt5670_ad_sto1_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM_EXT("AD MONOL Clk Sel", rt5670_ad_monol_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM_EXT("AD MONOR Clk Sel", rt5670_ad_monor_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM("UP Clk Sel", rt5670_up_filter_asrc_enum),
+	SOC_ENUM("DOWN Clk Sel", rt5670_down_filter_asrc_enum),
+	SOC_ENUM_EXT("AD STO2 Clk Sel", rt5670_ad_sto2_asrc_enum,
+		     snd_soc_get_enum_double, rt5670_clk_sel_put),
+	SOC_ENUM("DSP Clk Sel", rt5670_dsp_asrc_enum),
 };
 
 /**
-- 
1.8.1.1.439.g50a6b54
