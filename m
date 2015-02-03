From: yang.a.fang@intel.com
Subject: [PATCH v2 1/2] ASoC: rt5645: add API to select ASRC
	clock source
Date: Tue,  3 Feb 2015 11:25:50 -0800
Message-ID: <1422991551-28544-1-git-send-email-yang.a.fang@intel.com>
References: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C422D260415
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 20:26:13 +0100 (CET)
In-Reply-To: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, kevin.strasser@intel.com, vinod.koul@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, mengdong.lin@intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch defines an API to select the clock source for specified filters.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5645.c |   74 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5645.h |   72 +++++++++++++++++++------------------------
 2 files changed, 105 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 27141e2..eb8aea3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -601,6 +601,80 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+/**
+ * rt5645_sel_asrc_clk_src - select ASRC clock source for a set of filters
+ * @codec: SoC audio codec device.
+ * @filter_mask: mask of filters.
+ * @clk_src: clock source
+ *
+ * The ASRC function is for asynchronous MCLK and LRCK. Also, since RT5645 can
+ * only support standard 32fs or 64fs i2s format, ASRC should be enabled to
+ * support special i2s clock format such as Intel's 100fs(100 * sampling rate).
+ * ASRC function will track i2s clock and generate a corresponding system clock
+ * for codec. This function provides an API to select the clock source for a
+ * set of filters specified by the mask. And the codec driver will turn on ASRC
+ * for these filters if ASRC is selected as their clock source.
+ */
+int rt5645_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src)
+{
+	unsigned int asrc2_mask = 0, asrc2_value = 0;
+	unsigned int asrc3_mask = 0, asrc3_value = 0;
+
+	if ((clk_src != RT5645_CLK_SEL_SYS) &&
+	    (clk_src != RT5645_CLK_SEL_I2S1_ASRC) &&
+	    (clk_src != RT5645_CLK_SEL_I2S2_ASRC) &&
+	    (clk_src != RT5645_CLK_SEL_SYS2))
+			return -EINVAL;
+
+	if (filter_mask & RT5645_DA_STEREO_FILTER) {
+		asrc2_mask |= RT5645_DA_STO_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5645_DA_STO_CLK_SEL_MASK)
+			| (clk_src << RT5645_DA_STO_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5645_DA_MONO_L_FILTER) {
+		asrc2_mask |= RT5645_DA_MONOL_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5645_DA_MONOL_CLK_SEL_MASK)
+			| (clk_src <<  RT5645_DA_MONOL_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5645_DA_MONO_R_FILTER) {
+		asrc2_mask |= RT5645_DA_MONOR_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5645_DA_MONOR_CLK_SEL_MASK)
+			| (clk_src <<  RT5645_DA_MONOR_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5645_AD_STEREO_FILTER) {
+		asrc2_mask |= RT5645_AD_STO1_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5645_AD_STO1_CLK_SEL_MASK)
+			| (clk_src <<  RT5645_AD_STO1_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5645_AD_MONO_L_FILTER) {
+		asrc3_mask |= RT5645_AD_MONOL_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5645_AD_MONOL_CLK_SEL_MASK)
+			| (clk_src <<  RT5645_AD_MONOL_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5645_AD_MONO_R_FILTER)  {
+		asrc3_mask |= RT5645_AD_MONOR_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5645_AD_MONOR_CLK_SEL_MASK)
+		| (clk_src <<  RT5645_AD_MONOR_CLK_SEL_SFT);
+	}
+
+	if (asrc2_mask)
+		snd_soc_update_bits(codec, RT5645_ASRC_2,
+			asrc2_mask, asrc2_value);
+
+	if (asrc3_mask)
+		snd_soc_update_bits(codec, RT5645_ASRC_3,
+			asrc3_mask, asrc3_value);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5645_sel_asrc_clk_src);
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5645_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5645_STO1_ADC_MIXER,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index a815e36..dbafa93 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1111,50 +1111,27 @@
 #define RT5645_DMIC_2_M_NOR			(0x0 << 8)
 #define RT5645_DMIC_2_M_ASYN			(0x1 << 8)
 
+/* ASRC clock source selection (0x84, 0x85) */
+#define RT5645_CLK_SEL_SYS			(0x0)
+#define RT5645_CLK_SEL_I2S1_ASRC		(0x1)
+#define RT5645_CLK_SEL_I2S2_ASRC		(0x2)
+#define RT5645_CLK_SEL_SYS2			(0x5)
+
 /* ASRC Control 2 (0x84) */
-#define RT5645_MDA_L_M_MASK			(0x1 << 15)
-#define RT5645_MDA_L_M_SFT			15
-#define RT5645_MDA_L_M_NOR			(0x0 << 15)
-#define RT5645_MDA_L_M_ASYN			(0x1 << 15)
-#define RT5645_MDA_R_M_MASK			(0x1 << 14)
-#define RT5645_MDA_R_M_SFT			14
-#define RT5645_MDA_R_M_NOR			(0x0 << 14)
-#define RT5645_MDA_R_M_ASYN			(0x1 << 14)
-#define RT5645_MAD_L_M_MASK			(0x1 << 13)
-#define RT5645_MAD_L_M_SFT			13
-#define RT5645_MAD_L_M_NOR			(0x0 << 13)
-#define RT5645_MAD_L_M_ASYN			(0x1 << 13)
-#define RT5645_MAD_R_M_MASK			(0x1 << 12)
-#define RT5645_MAD_R_M_SFT			12
-#define RT5645_MAD_R_M_NOR			(0x0 << 12)
-#define RT5645_MAD_R_M_ASYN			(0x1 << 12)
-#define RT5645_ADC_M_MASK			(0x1 << 11)
-#define RT5645_ADC_M_SFT			11
-#define RT5645_ADC_M_NOR			(0x0 << 11)
-#define RT5645_ADC_M_ASYN			(0x1 << 11)
-#define RT5645_STO_DAC_M_MASK			(0x1 << 5)
-#define RT5645_STO_DAC_M_SFT			5
-#define RT5645_STO_DAC_M_NOR			(0x0 << 5)
-#define RT5645_STO_DAC_M_ASYN			(0x1 << 5)
-#define RT5645_I2S1_R_D_MASK			(0x1 << 4)
-#define RT5645_I2S1_R_D_SFT			4
-#define RT5645_I2S1_R_D_DIS			(0x0 << 4)
-#define RT5645_I2S1_R_D_EN			(0x1 << 4)
-#define RT5645_I2S2_R_D_MASK			(0x1 << 3)
-#define RT5645_I2S2_R_D_SFT			3
-#define RT5645_I2S2_R_D_DIS			(0x0 << 3)
-#define RT5645_I2S2_R_D_EN			(0x1 << 3)
-#define RT5645_PRE_SCLK_MASK			(0x3)
-#define RT5645_PRE_SCLK_SFT			0
-#define RT5645_PRE_SCLK_512			(0x0)
-#define RT5645_PRE_SCLK_1024			(0x1)
-#define RT5645_PRE_SCLK_2048			(0x2)
+#define RT5645_DA_STO_CLK_SEL_MASK		(0xf << 12)
+#define RT5645_DA_STO_CLK_SEL_SFT		12
+#define RT5645_DA_MONOL_CLK_SEL_MASK		(0xf << 8)
+#define RT5645_DA_MONOL_CLK_SEL_SFT		8
+#define RT5645_DA_MONOR_CLK_SEL_MASK		(0xf << 4)
+#define RT5645_DA_MONOR_CLK_SEL_SFT		4
+#define RT5645_AD_STO1_CLK_SEL_MASK		(0xf << 0)
+#define RT5645_AD_STO1_CLK_SEL_SFT		0
 
 /* ASRC Control 3 (0x85) */
-#define RT5645_I2S1_RATE_MASK			(0xf << 12)
-#define RT5645_I2S1_RATE_SFT			12
-#define RT5645_I2S2_RATE_MASK			(0xf << 8)
-#define RT5645_I2S2_RATE_SFT			8
+#define RT5645_AD_MONOL_CLK_SEL_MASK		(0xf << 4)
+#define RT5645_AD_MONOL_CLK_SEL_SFT		4
+#define RT5645_AD_MONOR_CLK_SEL_MASK		(0xf << 0)
+#define RT5645_AD_MONOR_CLK_SEL_SFT		0
 
 /* ASRC Control 4 (0x89) */
 #define RT5645_I2S1_PD_MASK			(0x7 << 12)
@@ -2175,6 +2152,19 @@ enum {
 	RT5645_DMIC_DATA_GPIO11,
 };
 
+/* filter mask */
+enum {
+	RT5645_DA_STEREO_FILTER = 0x1,
+	RT5645_DA_MONO_L_FILTER = (0x1 << 1),
+	RT5645_DA_MONO_R_FILTER = (0x1 << 2),
+	RT5645_AD_STEREO_FILTER = (0x1 << 3),
+	RT5645_AD_MONO_L_FILTER = (0x1 << 4),
+	RT5645_AD_MONO_R_FILTER = (0x1 << 5),
+};
+
+int rt5645_sel_asrc_clk_src(struct snd_soc_codec *codec,
+		unsigned int filter_mask, unsigned int clk_src);
+
 struct rt5645_priv {
 	struct snd_soc_codec *codec;
 	struct rt5645_platform_data pdata;
-- 
1.7.9.5
