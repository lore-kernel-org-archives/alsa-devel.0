From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: Add function "rl6231_get_pre_div" to
	correct the dmic clock calculation
Date: Wed, 5 Aug 2015 10:03:18 +0800
Message-ID: <1438740198-2248-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB40265A58
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 04:03:28 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rl6231.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rl6231.h |  1 +
 sound/soc/codecs/rt5640.c |  7 ++++---
 sound/soc/codecs/rt5645.c |  7 ++++---
 sound/soc/codecs/rt5651.c |  7 ++++---
 sound/soc/codecs/rt5670.c |  7 ++++---
 sound/soc/codecs/rt5677.c |  5 ++++-
 7 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 96f3e90..57e51c1 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -11,10 +11,57 @@
  */
 
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include "rl6231.h"
 
 /**
+ * rl6231_get_pre_div - Return the value of pre divider.
+ *
+ * @map: map for setting.
+ * @reg: register.
+ * @sft: shift.
+ *
+ * Return the value of pre divider from given register value.
+ * Return negative error code for unexpected register value.
+ */
+int rl6231_get_pre_div(struct regmap *map, unsigned int reg, int sft)
+{
+	int pd, val;
+
+	regmap_read(map, reg, &val);
+
+	val = (val >> sft) & 0x7;
+
+	switch (val) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		pd = val + 1;
+		break;
+	case 4:
+		pd = 6;
+		break;
+	case 5:
+		pd = 8;
+		break;
+	case 6:
+		pd = 12;
+		break;
+	case 7:
+		pd = 16;
+		break;
+	default:
+		pd = -EINVAL;
+		break;
+	}
+
+	return pd;
+}
+EXPORT_SYMBOL_GPL(rl6231_get_pre_div);
+
+/**
  * rl6231_calc_dmic_clk - Calculate the parameter of dmic.
  *
  * @rate: base clock rate.
diff --git a/sound/soc/codecs/rl6231.h b/sound/soc/codecs/rl6231.h
index 0f7b057..4c77b44 100644
--- a/sound/soc/codecs/rl6231.h
+++ b/sound/soc/codecs/rl6231.h
@@ -30,5 +30,6 @@ int rl6231_calc_dmic_clk(int rate);
 int rl6231_pll_calc(const unsigned int freq_in,
 	const unsigned int freq_out, struct rl6231_pll_code *pll_code);
 int rl6231_get_clk_info(int sclk, int rate);
+int rl6231_get_pre_div(struct regmap *map, unsigned int reg, int sft);
 
 #endif /* __RL6231_H__ */
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 119eca7..c557192 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -459,10 +459,11 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-	int idx = -EINVAL;
-
-	idx = rl6231_calc_dmic_clk(rt5640->sysclk);
+	int idx, rate;
 
+	rate = rt5640->sysclk / rl6231_get_pre_div(rt5640->regmap,
+		RT5640_ADDA_CLK1, RT5640_I2S_PD1_SFT);
+	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9d54b34..4b01b63 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -543,10 +543,11 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	int idx = -EINVAL;
-
-	idx = rl6231_calc_dmic_clk(rt5645->sysclk);
+	int idx, rate;
 
+	rate = rt5645->sysclk / rl6231_get_pre_div(rt5645->regmap,
+		RT5645_ADDA_CLK1, RT5645_I2S_PD1_SFT);
+	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 96295cc..8f7159b 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -378,10 +378,11 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
-	int idx = -EINVAL;
-
-	idx = rl6231_calc_dmic_clk(rt5651->sysclk);
+	int idx, rate;
 
+	rate = rt5651->sysclk / rl6231_get_pre_div(rt5651->regmap,
+		RT5651_ADDA_CLK1, RT5651_I2S_PD1_SFT);
+	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index fd6ffd2..177748a 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -683,10 +683,11 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
-	int idx = -EINVAL;
-
-	idx = rl6231_calc_dmic_clk(rt5670->sysclk);
+	int idx, rate;
 
+	rate = rt5670->sysclk / rl6231_get_pre_div(rt5670->regmap,
+		RT5670_ADDA_CLK1, RT5670_I2S_PD1_SFT);
+	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8d70911..3316700 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -916,8 +916,11 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
-	int idx = rl6231_calc_dmic_clk(rt5677->lrck[RT5677_AIF1] << 8);
+	int idx, rate;
 
+	rate = rt5677->sysclk / rl6231_get_pre_div(rt5677->regmap,
+		RT5677_CLK_TREE_CTRL1, RT5677_I2S_PD1_SFT);
+	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
-- 
1.8.1.1.439.g50a6b54
