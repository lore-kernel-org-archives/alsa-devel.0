From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 4/8] ASoC: rt5640: add ASRC support
Date: Mon,  4 Jan 2016 17:20:26 -0600
Message-ID: <1451949630-3475-5-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 51A7D2606B7
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 00:21:04 +0100 (CET)
In-Reply-To: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jack Yu <jack.yu@realtek.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jack Yu <jack.yu@realtek.com>

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5640.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5640.h |  17 ++++++++
 2 files changed, 119 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index f2beb1a..18f2d3b 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -488,6 +488,18 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
+static int is_using_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	if (!rt5640->asrc_en)
+		return 0;
+
+	return 1;
+}
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5640_sto_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5640_STO_ADC_MIXER,
@@ -1059,6 +1071,20 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5640_PWR_ANLG2,
 			RT5640_PWR_PLL_BIT, 0, NULL, 0),
+
+	/* ASRC */
+	SND_SOC_DAPM_SUPPLY_S("Stereo Filter ASRC", 1, RT5640_ASRC_1,
+			 15, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 Filter ASRC", 1, RT5640_ASRC_1,
+			 12, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5640_ASRC_1,
+			 11, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC1 ASRC", 1, RT5640_ASRC_1,
+			 9, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC2 ASRC", 1, RT5640_ASRC_1,
+			 8, 0, NULL, 0),
+
+
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5640_PWR_ANLG1,
@@ -1319,6 +1345,12 @@ static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
+	{ "I2S1", NULL, "Stereo Filter ASRC", is_using_asrc },
+	{ "I2S2", NULL, "I2S2 ASRC", is_using_asrc },
+	{ "I2S2", NULL, "I2S2 Filter ASRC", is_using_asrc },
+	{ "DMIC1", NULL, "DMIC1 ASRC", is_using_asrc },
+	{ "DMIC2", NULL, "DMIC2 ASRC", is_using_asrc },
+
 	{"IN1P", NULL, "LDO2"},
 	{"IN2P", NULL, "LDO2"},
 	{"IN3P", NULL, "LDO2"},
@@ -1981,6 +2013,76 @@ int rt5640_dmic_enable(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(rt5640_dmic_enable);
 
+int rt5640_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	unsigned int asrc2_mask = 0;
+	unsigned int asrc2_value = 0;
+
+	switch (clk_src) {
+	case RT5640_CLK_SEL_SYS:
+	case RT5640_CLK_SEL_ASRC:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!filter_mask)
+		return -EINVAL;
+
+	if (filter_mask & RT5640_DA_STEREO_FILTER) {
+		asrc2_mask |= RT5640_STO_DAC_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_STO_DAC_M_MASK)
+			| (clk_src << RT5640_STO_DAC_M_SFT);
+	}
+
+	if (filter_mask & RT5640_DA_MONO_L_FILTER) {
+		asrc2_mask |= RT5640_MDA_L_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_MDA_L_M_MASK)
+			| (clk_src << RT5640_MDA_L_M_SFT);
+	}
+
+	if (filter_mask & RT5640_DA_MONO_R_FILTER) {
+		asrc2_mask |= RT5640_MDA_R_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_MDA_R_M_MASK)
+			| (clk_src << RT5640_MDA_R_M_SFT);
+	}
+
+	if (filter_mask & RT5640_AD_STEREO_FILTER) {
+		asrc2_mask |= RT5640_ADC_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_ADC_M_MASK)
+			| (clk_src << RT5640_ADC_M_SFT);
+	}
+
+	if (filter_mask & RT5640_AD_MONO_L_FILTER) {
+		asrc2_mask |= RT5640_MAD_L_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_MAD_L_M_MASK)
+			| (clk_src << RT5640_MAD_L_M_SFT);
+	}
+
+	if (filter_mask & RT5640_AD_MONO_R_FILTER)  {
+		asrc2_mask |= RT5640_MAD_R_M_MASK;
+		asrc2_value = (asrc2_value & ~RT5640_MAD_R_M_MASK)
+			| (clk_src << RT5640_MAD_R_M_SFT);
+	}
+
+	snd_soc_update_bits(codec, RT5640_ASRC_2,
+		asrc2_mask, asrc2_value);
+
+	if (snd_soc_read(codec, RT5640_ASRC_2)) {
+		rt5640->asrc_en = true;
+		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x3);
+	} else {
+		rt5640->asrc_en = false;
+		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5640_sel_asrc_clk_src);
+
 static int rt5640_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 3deb8ba..83a7150 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -1033,6 +1033,10 @@
 #define RT5640_DMIC_2_M_NOR			(0x0 << 8)
 #define RT5640_DMIC_2_M_ASYN			(0x1 << 8)
 
+/* ASRC clock source selection (0x84) */
+#define RT5640_CLK_SEL_SYS			(0x0)
+#define RT5640_CLK_SEL_ASRC			(0x1)
+
 /* ASRC Control 2 (0x84) */
 #define RT5640_MDA_L_M_MASK			(0x1 << 15)
 #define RT5640_MDA_L_M_SFT			15
@@ -2079,6 +2083,16 @@ enum {
 	RT5640_DMIC2,
 };
 
+/* filter mask */
+enum {
+	RT5640_DA_STEREO_FILTER = 0x1,
+	RT5640_DA_MONO_L_FILTER = (0x1 << 1),
+	RT5640_DA_MONO_R_FILTER = (0x1 << 2),
+	RT5640_AD_STEREO_FILTER = (0x1 << 3),
+	RT5640_AD_MONO_L_FILTER = (0x1 << 4),
+	RT5640_AD_MONO_R_FILTER = (0x1 << 5),
+};
+
 struct rt5640_priv {
 	struct snd_soc_codec *codec;
 	struct rt5640_platform_data pdata;
@@ -2095,9 +2109,12 @@ struct rt5640_priv {
 	int pll_out;
 
 	bool hp_mute;
+	bool asrc_en;
 };
 
 int rt5640_dmic_enable(struct snd_soc_codec *codec,
 		       bool dmic1_data_pin, bool dmic2_data_pin);
+int rt5640_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src);
 
 #endif
-- 
1.9.1
