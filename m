From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: add clock source selection
	controls
Date: Thu, 17 Jul 2014 17:09:23 +0800
Message-ID: <1405588163-31631-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C8B2654D9
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 11:09:44 +0200 (CEST)
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

We can select the clock source of some digital widgets in rt5645.
This patch adds the controls of those selections.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a7762d0..e8e30b7 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -440,6 +440,89 @@ static SOC_ENUM_SINGLE_DECL(rt5645_tdm_adc_sel_enum,
 				RT5645_TDM_CTRL_1, 8,
 				rt5645_tdm_adc_data_select);
 
+static const char * const rt5645_asrc_clk_source[] = {
+	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
+	"clk_i2s3_track", "clk_i2s4_track", "clk_sys2", "clk_sys3",
+	"clk_sys4", "clk_sys5"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_da_sto_asrc_enum, RT5645_ASRC_2,
+				12, rt5645_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_da_monol_asrc_enum, RT5645_ASRC_2,
+				8, rt5645_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_da_monor_asrc_enum, RT5645_ASRC_2,
+				4, rt5645_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_ad_sto1_asrc_enum, RT5645_ASRC_2,
+				0, rt5645_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_ad_monol_asrc_enum, RT5645_ASRC_3,
+				4, rt5645_asrc_clk_source);
+
+static const SOC_ENUM_SINGLE_DECL(rt5645_ad_monor_asrc_enum, RT5645_ASRC_3,
+				0, rt5645_asrc_clk_source);
+
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
@@ -511,6 +594,20 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_SINGLE("TDM IF1_DAC1_R Sel", RT5645_TDM_CTRL_3, 8, 7, 0),
 	SOC_SINGLE("TDM IF1_DAC2_L Sel", RT5645_TDM_CTRL_3, 4, 7, 0),
 	SOC_SINGLE("TDM IF1_DAC2_R Sel", RT5645_TDM_CTRL_3, 0, 7, 0),
+
+	/* Clock Source Selection*/
+	SOC_ENUM_EXT("DA STO Clk Sel", rt5645_da_sto_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
+	SOC_ENUM_EXT("DA MONOL Clk Sel", rt5645_da_monol_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
+	SOC_ENUM_EXT("DA MONOR Clk Sel", rt5645_da_monor_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
+	SOC_ENUM_EXT("AD STO1 Clk Sel", rt5645_ad_sto1_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
+	SOC_ENUM_EXT("AD MONOL Clk Sel", rt5645_ad_monol_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
+	SOC_ENUM_EXT("AD MONOR Clk Sel", rt5645_ad_monor_asrc_enum,
+		     snd_soc_get_enum_double, rt5645_clk_sel_put),
 };
 
 /**
-- 
1.8.1.1.439.g50a6b54
