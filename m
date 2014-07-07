From: <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5640: add ASRC support
Date: Mon, 7 Jul 2014 19:56:09 +0800
Message-ID: <1404734169-21766-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8D82651AF
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 13:56:32 +0200 (CEST)
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

This patch add ASRC support for rt5640 series codecs.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5640.h |  3 ++
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6bc6efd..494b1b4 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1020,9 +1020,45 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5640_asrc_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(w->codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (rt5640->asrc_en[RT5640_AIF1] ||
+			rt5640->asrc_en[RT5640_AIF2]) {
+			snd_soc_update_bits(w->codec,
+					    RT5640_DUMMY1, 0x70, 0x70);
+			snd_soc_update_bits(w->codec,
+					    RT5640_JD_CTRL, 0x3, 0x3);
+			snd_soc_write(w->codec, RT5640_ASRC_1, 0x9b00);
+			snd_soc_write(w->codec, RT5640_ASRC_2, 0xf800);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_write(w->codec, RT5640_ASRC_1, 0x0);
+		snd_soc_write(w->codec, RT5640_ASRC_2, 0x0);
+		snd_soc_update_bits(w->codec,
+				    RT5640_JD_CTRL, 0x3, 0);
+		snd_soc_update_bits(w->codec,
+				    RT5640_DUMMY1, 0x70, 0);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5640_PWR_ANLG2,
 			RT5640_PWR_PLL_BIT, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("ASRC Function", 1, SND_SOC_NOPM,
+			0, 0, rt5640_asrc_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5640_PWR_ANLG1,
@@ -1276,6 +1312,9 @@ static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
+	{"I2S1", NULL, "ASRC Function"},
+	{"I2S2", NULL, "ASRC Function"},
+
 	{"IN1P", NULL, "LDO2"},
 	{"IN2P", NULL, "LDO2"},
 
@@ -1636,10 +1675,17 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 
 	rt5640->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
-	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
-			rt5640->lrck[dai->id], dai->id);
-		return -EINVAL;
+	if ((rt5640->bclk_ratio[dai->id] != 64 &&
+		rt5640->bclk_ratio[dai->id] != 32) || pre_div < 0) {
+		if (rt5640->sysclk < rt5640->lrck[dai->id] * 384) {
+			dev_err(codec->dev, "Unsupported clock setting");
+			return -EINVAL;
+		}
+		dev_info(codec->dev, "Use ASRC\n");
+		rt5640->asrc_en[dai->id] = true;
+		pre_div = 0;
+	} else {
+		rt5640->asrc_en[dai->id] = false;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
 	if (frame_size < 0) {
@@ -1698,6 +1744,17 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int rt5640_hw_free(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	rt5640->asrc_en[dai->id] = false;
+
+	return 0;
+}
+
 static int rt5640_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -1864,6 +1921,16 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	return 0;
 }
 
+static int rt5640_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	rt5640->bclk_ratio[dai->id] = ratio;
+
+	return 0;
+}
+
 static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
@@ -1995,9 +2062,11 @@ static int rt5640_resume(struct snd_soc_codec *codec)
 
 static const struct snd_soc_dai_ops rt5640_aif_dai_ops = {
 	.hw_params = rt5640_hw_params,
+	.hw_free = rt5640_hw_free,
 	.set_fmt = rt5640_set_dai_fmt,
 	.set_sysclk = rt5640_set_dai_sysclk,
 	.set_pll = rt5640_set_dai_pll,
+	.set_bclk_ratio = rt5640_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver rt5640_dai[] = {
@@ -2214,6 +2283,8 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	}
 
 	rt5640->hp_mute = 1;
+	rt5640->bclk_ratio[RT5640_AIF1] = 64;
+	rt5640->bclk_ratio[RT5640_AIF2] = 64;
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
 				      rt5640_dai, ARRAY_SIZE(rt5640_dai));
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 58ebe96..63b465d 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2095,6 +2095,9 @@ struct rt5640_priv {
 	int pll_out;
 
 	bool hp_mute;
+
+	bool asrc_en[RT5640_AIFS];
+	int bclk_ratio[RT5640_AIFS];
 };
 
 #endif
-- 
1.8.1.1.439.g50a6b54
