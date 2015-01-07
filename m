From: mengdong.lin@intel.com
Subject: [PATCH v2 2/3] ASoC: rt5670: add API to select ASRC
	clock source
Date: Wed,  7 Jan 2015 10:19:12 +0800
Message-ID: <1420597152-4144-1-git-send-email-mengdong.lin@intel.com>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B7D17261558
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 03:11:25 +0100 (CET)
In-Reply-To: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, bardliao@realtek.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

When codec is in slave mode, ASRC can suppress noise for asynchronous
MCLK and LRCLK or special I2S format. This patch defines an API to select
the clock source for specified filters.  And the codec driver will turn on ASRC
for these filters if ASRC is selected as their clock source.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
Bard reviewed the patch and adds clarification for ASRC.

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index da210fd..498dda2 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -728,6 +728,89 @@ static int can_use_asrc(struct snd_soc_dapm_widget *source,
 	return 0;
 }
 
+
+/**
+ * rt5670_sel_asrc_clk_src - select ASRC clock source for a set of filters
+ * @codec: SoC audio codec device.
+ * @filter_mask: mask of filters.
+ * @clk_src: clock source
+ *
+ * The ASRC function is for asynchronous MCLK and LRCK. Also, since RT5670 can
+ * only support standard 32fs or 64fs i2s format, ASRC should be enabled to
+ * support special i2s clock format such as Intel's 100fs(100 * sampling rate).
+ * ASRC function will track i2s clock and generate a corresponding system clock
+ * for codec. This function provides an API to select the clock source for a
+ * set of filters specified by the mask. And the codec driver will turn on ASRC
+ * for these filters if ASRC is selected as their clock source.
+ */
+int rt5670_sel_asrc_clk_src(struct snd_soc_codec *codec,
+			    unsigned int filter_mask, unsigned int clk_src)
+{
+	unsigned int asrc2_mask = 0, asrc2_value = 0;
+	unsigned int asrc3_mask = 0, asrc3_value = 0;
+
+	if (clk_src > RT5670_CLK_SEL_SYS3)
+		return -EINVAL;
+
+	if (filter_mask & RT5670_DA_STEREO_FILTER) {
+		asrc2_mask |= RT5670_DA_STO_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5670_DA_STO_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_DA_STO_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_DA_MONO_L_FILTER) {
+		asrc2_mask |= RT5670_DA_MONOL_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5670_DA_MONOL_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_DA_MONOL_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_DA_MONO_R_FILTER) {
+		asrc2_mask |= RT5670_DA_MONOR_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5670_DA_MONOR_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_DA_MONOR_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_AD_STEREO_FILTER) {
+		asrc2_mask |= RT5670_AD_STO1_CLK_SEL_MASK;
+		asrc2_value = (asrc2_value & ~RT5670_AD_STO1_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_AD_STO1_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_AD_MONO_L_FILTER) {
+		asrc3_mask |= RT5670_AD_MONOL_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5670_AD_MONOL_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_AD_MONOL_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_AD_MONO_R_FILTER)  {
+		asrc3_mask |= RT5670_AD_MONOR_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5670_AD_MONOR_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_AD_MONOR_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_UP_RATE_FILTER) {
+		asrc3_mask |= RT5670_UP_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5670_UP_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_UP_CLK_SEL_SFT);
+	}
+
+	if (filter_mask & RT5670_DOWN_RATE_FILTER) {
+		asrc3_mask |= RT5670_DOWN_CLK_SEL_MASK;
+		asrc3_value = (asrc3_value & ~RT5670_DOWN_CLK_SEL_MASK)
+				| (clk_src <<  RT5670_DOWN_CLK_SEL_SFT);
+	}
+
+	if (asrc2_mask)
+		snd_soc_update_bits(codec, RT5670_ASRC_2,
+				    asrc2_mask, asrc2_value);
+
+	if (asrc3_mask)
+		snd_soc_update_bits(codec, RT5670_ASRC_3,
+				    asrc3_mask, asrc3_value);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5670_sel_asrc_clk_src);
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5670_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO1_ADC_MIXER,
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 7c37b00..991314f 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1966,6 +1966,21 @@ enum {
 	RT5670_DMIC_DATA_GPIO5,
 };
 
+/* filter mask */
+enum {
+	RT5670_DA_STEREO_FILTER = 0x1,
+	RT5670_DA_MONO_L_FILTER = (0x1 << 1),
+	RT5670_DA_MONO_R_FILTER = (0x1 << 2),
+	RT5670_AD_STEREO_FILTER = (0x1 << 3),
+	RT5670_AD_MONO_L_FILTER = (0x1 << 4),
+	RT5670_AD_MONO_R_FILTER = (0x1 << 5),
+	RT5670_UP_RATE_FILTER   = (0x1 << 6),
+	RT5670_DOWN_RATE_FILTER = (0x1 << 7),
+};
+
+int rt5670_sel_asrc_clk_src(struct snd_soc_codec *codec,
+			    unsigned int filter_mask, unsigned int clk_src);
+
 struct rt5670_priv {
 	struct snd_soc_codec *codec;
 	struct rt5670_platform_data pdata;
-- 
1.9.1
