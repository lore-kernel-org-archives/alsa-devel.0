From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Add the function of impedance
	sensing
Date: Mon, 11 Sep 2017 14:52:48 +0800
Message-ID: <1505112768-27727-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 450CF266C6D
 for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2017 08:52:58 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Support the function of impedance sensing. It could be set the range number
and the related parameters in the DTS.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5663.txt |   4 +
 include/sound/rt5663.h                             |   3 +
 sound/soc/codecs/rt5663.c                          | 218 ++++++++++++++++++++-
 3 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index ff38171..4dcd181 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -19,6 +19,10 @@ Optional properties:
   Based on the different PCB layout, add the manual offset value to
   compensate the DC offset for each L and R channel, and they are different
   between headphone and headset.
+- "realtek,impedance_sensing_num"
+  The range number of impedance sensing.
+- "realtek,impedance_sensing_table"
+  The parameters table of impedance sensing.
 
 Pins on the device (for linking into audio routes) for RT5663:
 
diff --git a/include/sound/rt5663.h b/include/sound/rt5663.h
index 7d00e58..7b90a8f 100644
--- a/include/sound/rt5663.h
+++ b/include/sound/rt5663.h
@@ -16,6 +16,9 @@ struct rt5663_platform_data {
 	unsigned int dc_offset_r_manual;
 	unsigned int dc_offset_l_manual_mic;
 	unsigned int dc_offset_r_manual_mic;
+
+	unsigned int impedance_sensing_num;
+	unsigned int *impedance_sensing_table;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ab9e0eb..767f219 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -38,6 +38,16 @@ enum {
 	CODEC_VER_0,
 };
 
+struct impedance_mapping_table {
+	unsigned int imp_min;
+	unsigned int imp_max;
+	unsigned int vol;
+	unsigned int dc_offset_l_manual;
+	unsigned int dc_offset_r_manual;
+	unsigned int dc_offset_l_manual_mic;
+	unsigned int dc_offset_r_manual_mic;
+};
+
 struct rt5663_priv {
 	struct snd_soc_codec *codec;
 	struct rt5663_platform_data pdata;
@@ -45,6 +55,7 @@ struct rt5663_priv {
 	struct delayed_work jack_detect_work;
 	struct snd_soc_jack *hs_jack;
 	struct timer_list btn_check_timer;
+	struct impedance_mapping_table *imp_table;
 
 	int codec_ver;
 	int sysclk;
@@ -1575,6 +1586,9 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			rt5663->jack_type = SND_JACK_HEADSET;
 			rt5663_enable_push_button_irq(codec, true);
 
+			if (rt5663->pdata.impedance_sensing_num)
+				break;
+
 			if (rt5663->pdata.dc_offset_l_manual_mic) {
 				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
 					rt5663->pdata.dc_offset_l_manual_mic >>
@@ -1596,6 +1610,9 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		default:
 			rt5663->jack_type = SND_JACK_HEADPHONE;
 
+			if (rt5663->pdata.impedance_sensing_num)
+				break;
+
 			if (rt5663->pdata.dc_offset_l_manual) {
 				regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
 					rt5663->pdata.dc_offset_l_manual >> 16);
@@ -1623,6 +1640,177 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5663->jack_type;
 }
 
+static int rt5663_impedance_sensing(struct snd_soc_codec *codec)
+{
+	struct rt5663_priv *rt5663 = snd_soc_codec_get_drvdata(codec);
+	unsigned int value, i, reg84, reg26, reg2fa, reg91, reg10, reg80;
+
+	for (i = 0; i < rt5663->pdata.impedance_sensing_num; i++) {
+		if (rt5663->imp_table[i].vol == 7)
+			break;
+	}
+
+	if (rt5663->jack_type == SND_JACK_HEADSET) {
+		snd_soc_write(codec, RT5663_MIC_DECRO_2,
+			rt5663->imp_table[i].dc_offset_l_manual_mic >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_3,
+			rt5663->imp_table[i].dc_offset_l_manual_mic & 0xffff);
+		snd_soc_write(codec, RT5663_MIC_DECRO_5,
+			rt5663->imp_table[i].dc_offset_r_manual_mic >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_6,
+			rt5663->imp_table[i].dc_offset_r_manual_mic & 0xffff);
+	} else {
+		snd_soc_write(codec, RT5663_MIC_DECRO_2,
+			rt5663->imp_table[i].dc_offset_l_manual >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_3,
+			rt5663->imp_table[i].dc_offset_l_manual & 0xffff);
+		snd_soc_write(codec, RT5663_MIC_DECRO_5,
+			rt5663->imp_table[i].dc_offset_r_manual >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_6,
+			rt5663->imp_table[i].dc_offset_r_manual & 0xffff);
+	}
+
+	reg84 = snd_soc_read(codec, RT5663_ASRC_2);
+	reg26 = snd_soc_read(codec, RT5663_STO1_ADC_MIXER);
+	reg2fa = snd_soc_read(codec, RT5663_DUMMY_1);
+	reg91 = snd_soc_read(codec, RT5663_HP_CHARGE_PUMP_1);
+	reg10 = snd_soc_read(codec, RT5663_RECMIX);
+	reg80 = snd_soc_read(codec, RT5663_GLB_CLK);
+
+	snd_soc_update_bits(codec, RT5663_STO_DRE_1, 0x8000, 0);
+	snd_soc_write(codec, RT5663_ASRC_2, 0);
+	snd_soc_write(codec, RT5663_STO1_ADC_MIXER, 0x4040);
+	snd_soc_update_bits(codec, RT5663_PWR_ANLG_1,
+		RT5663_PWR_VREF1_MASK | RT5663_PWR_VREF2_MASK |
+		RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK,
+		RT5663_PWR_VREF1 | RT5663_PWR_VREF2);
+	usleep_range(10000, 10005);
+	snd_soc_update_bits(codec, RT5663_PWR_ANLG_1,
+		RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK,
+		RT5663_PWR_FV1 | RT5663_PWR_FV2);
+	snd_soc_update_bits(codec, RT5663_GLB_CLK, RT5663_SCLK_SRC_MASK,
+		RT5663_SCLK_SRC_RCCLK);
+	snd_soc_update_bits(codec, RT5663_RC_CLK, RT5663_DIG_25M_CLK_MASK,
+		RT5663_DIG_25M_CLK_EN);
+	snd_soc_update_bits(codec, RT5663_ADDA_CLK_1, RT5663_I2S_PD1_MASK, 0);
+	snd_soc_write(codec, RT5663_PRE_DIV_GATING_1, 0xff00);
+	snd_soc_write(codec, RT5663_PRE_DIV_GATING_2, 0xfffc);
+	snd_soc_write(codec, RT5663_HP_CHARGE_PUMP_1, 0x1232);
+	snd_soc_write(codec, RT5663_HP_LOGIC_2, 0x0005);
+	snd_soc_write(codec, RT5663_DEPOP_2, 0x3003);
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030, 0x0030);
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0003, 0x0003);
+	snd_soc_update_bits(codec, RT5663_PWR_DIG_2,
+		RT5663_PWR_ADC_S1F | RT5663_PWR_DAC_S1F,
+		RT5663_PWR_ADC_S1F | RT5663_PWR_DAC_S1F);
+	snd_soc_update_bits(codec, RT5663_PWR_DIG_1,
+		RT5663_PWR_DAC_L1 | RT5663_PWR_DAC_R1 |
+		RT5663_PWR_LDO_DACREF_MASK | RT5663_PWR_ADC_L1 |
+		RT5663_PWR_ADC_R1,
+		RT5663_PWR_DAC_L1 | RT5663_PWR_DAC_R1 |
+		RT5663_PWR_LDO_DACREF_ON | RT5663_PWR_ADC_L1 |
+		RT5663_PWR_ADC_R1);
+	msleep(40);
+	snd_soc_update_bits(codec, RT5663_PWR_ANLG_2,
+		RT5663_PWR_RECMIX1 | RT5663_PWR_RECMIX2,
+		RT5663_PWR_RECMIX1 | RT5663_PWR_RECMIX2);
+	msleep(30);
+	snd_soc_write(codec, RT5663_HP_CHARGE_PUMP_2, 0x1371);
+	snd_soc_write(codec, RT5663_STO_DAC_MIXER, 0);
+	snd_soc_write(codec, RT5663_BYPASS_STO_DAC, 0x000c);
+	snd_soc_write(codec, RT5663_HP_BIAS, 0xafaa);
+	snd_soc_write(codec, RT5663_CHARGE_PUMP_1, 0x2224);
+	snd_soc_write(codec, RT5663_HP_OUT_EN, 0x8088);
+	snd_soc_write(codec, RT5663_CHOP_ADC, 0x3000);
+	snd_soc_write(codec, RT5663_ADDA_RST, 0xc000);
+	snd_soc_write(codec, RT5663_STO1_HPF_ADJ1, 0x3320);
+	snd_soc_write(codec, RT5663_HP_CALIB_2, 0x00c9);
+	snd_soc_write(codec, RT5663_DUMMY_1, 0x004c);
+	snd_soc_write(codec, RT5663_ANA_BIAS_CUR_1, 0x7733);
+	snd_soc_write(codec, RT5663_CHARGE_PUMP_2, 0x7777);
+	snd_soc_write(codec, RT5663_STO_DRE_9, 0x0007);
+	snd_soc_write(codec, RT5663_STO_DRE_10, 0x0007);
+	snd_soc_write(codec, RT5663_DUMMY_2, 0x02a4);
+	snd_soc_write(codec, RT5663_RECMIX, 0x0005);
+	snd_soc_write(codec, RT5663_HP_IMP_SEN_1, 0x4334);
+	snd_soc_update_bits(codec, RT5663_IRQ_3, 0x0004, 0x0004);
+	snd_soc_write(codec, RT5663_HP_LOGIC_1, 0x2200);
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x3000, 0x3000);
+	snd_soc_write(codec, RT5663_HP_LOGIC_1, 0x6200);
+
+	for (i = 0; i < 100; i++) {
+		msleep(20);
+		if (snd_soc_read(codec, RT5663_INT_ST_1) & 0x2)
+			break;
+	}
+
+	value = snd_soc_read(codec, RT5663_HP_IMP_SEN_4);
+
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x3000, 0);
+	snd_soc_write(codec, RT5663_INT_ST_1, 0);
+	snd_soc_write(codec, RT5663_HP_LOGIC_1, 0);
+	snd_soc_update_bits(codec, RT5663_RC_CLK, RT5663_DIG_25M_CLK_MASK,
+		RT5663_DIG_25M_CLK_DIS);
+	snd_soc_write(codec, RT5663_GLB_CLK, reg80);
+	snd_soc_write(codec, RT5663_RECMIX, reg10);
+	snd_soc_write(codec, RT5663_DUMMY_2, 0x00a4);
+	snd_soc_write(codec, RT5663_DUMMY_1, reg2fa);
+	snd_soc_write(codec, RT5663_HP_CALIB_2, 0x00c8);
+	snd_soc_write(codec, RT5663_STO1_HPF_ADJ1, 0xb320);
+	snd_soc_write(codec, RT5663_ADDA_RST, 0xe400);
+	snd_soc_write(codec, RT5663_CHOP_ADC, 0x2000);
+	snd_soc_write(codec, RT5663_HP_OUT_EN, 0x0008);
+	snd_soc_update_bits(codec, RT5663_PWR_ANLG_2,
+		RT5663_PWR_RECMIX1 | RT5663_PWR_RECMIX2, 0);
+	snd_soc_update_bits(codec, RT5663_PWR_DIG_1,
+		RT5663_PWR_DAC_L1 | RT5663_PWR_DAC_R1 |
+		RT5663_PWR_LDO_DACREF_MASK | RT5663_PWR_ADC_L1 |
+		RT5663_PWR_ADC_R1, 0);
+	snd_soc_update_bits(codec, RT5663_PWR_DIG_2,
+		RT5663_PWR_ADC_S1F | RT5663_PWR_DAC_S1F, 0);
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0003, 0);
+	snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030, 0);
+	snd_soc_write(codec, RT5663_HP_LOGIC_2, 0);
+	snd_soc_write(codec, RT5663_HP_CHARGE_PUMP_1, reg91);
+	snd_soc_update_bits(codec, RT5663_PWR_ANLG_1,
+		RT5663_PWR_VREF1_MASK | RT5663_PWR_VREF2_MASK, 0);
+	snd_soc_write(codec, RT5663_STO1_ADC_MIXER, reg26);
+	snd_soc_write(codec, RT5663_ASRC_2, reg84);
+
+	for (i = 0; i < rt5663->pdata.impedance_sensing_num; i++) {
+		if (value >= rt5663->imp_table[i].imp_min &&
+			value <= rt5663->imp_table[i].imp_max)
+			break;
+	}
+
+	snd_soc_update_bits(codec, RT5663_STO_DRE_9, RT5663_DRE_GAIN_HP_MASK,
+		rt5663->imp_table[i].vol);
+	snd_soc_update_bits(codec, RT5663_STO_DRE_10, RT5663_DRE_GAIN_HP_MASK,
+		rt5663->imp_table[i].vol);
+
+	if (rt5663->jack_type == SND_JACK_HEADSET) {
+		snd_soc_write(codec, RT5663_MIC_DECRO_2,
+			rt5663->imp_table[i].dc_offset_l_manual_mic >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_3,
+			rt5663->imp_table[i].dc_offset_l_manual_mic & 0xffff);
+		snd_soc_write(codec, RT5663_MIC_DECRO_5,
+			rt5663->imp_table[i].dc_offset_r_manual_mic >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_6,
+			rt5663->imp_table[i].dc_offset_r_manual_mic & 0xffff);
+	} else {
+		snd_soc_write(codec, RT5663_MIC_DECRO_2,
+			rt5663->imp_table[i].dc_offset_l_manual >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_3,
+			rt5663->imp_table[i].dc_offset_l_manual & 0xffff);
+		snd_soc_write(codec, RT5663_MIC_DECRO_5,
+			rt5663->imp_table[i].dc_offset_r_manual >> 16);
+		snd_soc_write(codec, RT5663_MIC_DECRO_6,
+			rt5663->imp_table[i].dc_offset_r_manual & 0xffff);
+	}
+
+	return 0;
+}
+
 static int rt5663_button_detect(struct snd_soc_codec *codec)
 {
 	int btn_type, val;
@@ -1701,6 +1889,8 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 				break;
 			case CODEC_VER_0:
 				report = rt5663_jack_detect(rt5663->codec, 1);
+				if (rt5663->pdata.impedance_sensing_num)
+					rt5663_impedance_sensing(rt5663->codec);
 				break;
 			default:
 				dev_err(codec->dev, "Unknown CODEC Version\n");
@@ -1796,10 +1986,6 @@ static const struct snd_kcontrol_new rt5663_v2_specific_controls[] = {
 };
 
 static const struct snd_kcontrol_new rt5663_specific_controls[] = {
-	/* Headphone Output Volume */
-	SOC_DOUBLE_R_TLV("Headphone Playback Volume", RT5663_STO_DRE_9,
-		RT5663_STO_DRE_10, RT5663_DRE_GAIN_HP_SHIFT, 23, 1,
-		rt5663_hp_vol_tlv),
 	/* Mic Boost Volume*/
 	SOC_SINGLE_TLV("IN1 Capture Volume", RT5663_CBJ_2,
 		RT5663_GAIN_BST1_SHIFT, 8, 0, in_bst_tlv),
@@ -1807,6 +1993,13 @@ static const struct snd_kcontrol_new rt5663_specific_controls[] = {
 	SOC_ENUM("IF1 ADC Data Swap", rt5663_if1_adc_enum),
 };
 
+static const struct snd_kcontrol_new rt5663_hpvol_controls[] = {
+	/* Headphone Output Volume */
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume", RT5663_STO_DRE_9,
+		RT5663_STO_DRE_10, RT5663_DRE_GAIN_HP_SHIFT, 23, 1,
+		rt5663_hp_vol_tlv),
+};
+
 static int rt5663_is_sys_clk_from_pll(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_widget *sink)
 {
@@ -2889,6 +3082,10 @@ static int rt5663_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(rt5663_specific_dapm_routes));
 		snd_soc_add_codec_controls(codec, rt5663_specific_controls,
 			ARRAY_SIZE(rt5663_specific_controls));
+
+		if (!rt5663->imp_table)
+			snd_soc_add_codec_controls(codec, rt5663_hpvol_controls,
+				ARRAY_SIZE(rt5663_hpvol_controls));
 		break;
 	}
 
@@ -3177,6 +3374,8 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 
 static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 {
+	int table_size;
+
 	device_property_read_u32(dev, "realtek,dc_offset_l_manual",
 		&rt5663->pdata.dc_offset_l_manual);
 	device_property_read_u32(dev, "realtek,dc_offset_r_manual",
@@ -3185,6 +3384,17 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		&rt5663->pdata.dc_offset_l_manual_mic);
 	device_property_read_u32(dev, "realtek,dc_offset_r_manual_mic",
 		&rt5663->pdata.dc_offset_r_manual_mic);
+	device_property_read_u32(dev, "realtek,impedance_sensing_num",
+		&rt5663->pdata.impedance_sensing_num);
+
+	if (rt5663->pdata.impedance_sensing_num) {
+		table_size = sizeof(struct impedance_mapping_table) *
+			rt5663->pdata.impedance_sensing_num;
+		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
+		device_property_read_u32_array(dev,
+			"realtek,impedance_sensing_table",
+			(u32 *)rt5663->imp_table, table_size);
+	}
 
 	return 0;
 }
-- 
2.7.4
