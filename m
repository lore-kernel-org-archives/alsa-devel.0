From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: add ASRC support
Date: Fri, 27 Jun 2014 18:58:11 +0800
Message-ID: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AEB3265211
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 12:58:46 +0200 (CEST)
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
 sound/soc/codecs/rt5640.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5640.h |  2 ++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 6bc6efd..3245ec4 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -341,6 +341,43 @@ static bool rt5640_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static const char * const rt5640_asrc_mode[] = {
+	"disable", "enable"
+};
+
+static const SOC_ENUM_SINGLE_DECL(rt5640_asrc_enum, SND_SOC_NOPM,
+				0, rt5640_asrc_mode);
+
+static int rt5640_asrc_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	rt5640->asrc_en = ucontrol->value.integer.value[0];
+
+	if (rt5640->asrc_en) {
+		snd_soc_update_bits(codec, RT5640_DUMMY1, 0x70, 0x70);
+		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x3);
+	} else {
+		snd_soc_update_bits(codec, RT5640_DUMMY1, 0x70, 0x0);
+		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x0);
+	}
+
+	return 0;
+}
+
+static int rt5640_asrc_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = rt5640->asrc_en;
+
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
@@ -436,6 +473,10 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	SOC_ENUM("DAC IF1 Data Switch", rt5640_if1_dac_enum),
 	SOC_ENUM("ADC IF2 Data Switch", rt5640_if2_adc_enum),
 	SOC_ENUM("DAC IF2 Data Switch", rt5640_if2_dac_enum),
+
+	/* ASRC */
+	SOC_ENUM_EXT("ASRC Switch", rt5640_asrc_enum,
+		rt5640_asrc_get, rt5640_asrc_put),
 };
 
 static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
@@ -1020,9 +1061,37 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5640_asrc_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(w->codec);
+
+	if (!rt5640->asrc_en)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_write(w->codec, RT5640_ASRC_1, 0x9b00);
+		snd_soc_write(w->codec, RT5640_ASRC_2, 0xf800);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_write(w->codec, RT5640_ASRC_1, 0x0);
+		snd_soc_write(w->codec, RT5640_ASRC_2, 0x0);
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
@@ -1276,6 +1345,9 @@ static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
+	{"I2S1", NULL, "ASRC Function"},
+	{"I2S2", NULL, "ASRC Function"},
+
 	{"IN1P", NULL, "LDO2"},
 	{"IN2P", NULL, "LDO2"},
 
@@ -1635,7 +1707,12 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	int dai_sel, pre_div, bclk_ms, frame_size;
 
 	rt5640->lrck[dai->id] = params_rate(params);
-	pre_div = rl6231_get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
+	if (rt5640->asrc_en)
+		pre_div = 0;
+	else
+		pre_div = rl6231_get_clk_info(rt5640->sysclk,
+						rt5640->lrck[dai->id]);
+
 	if (pre_div < 0) {
 		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
 			rt5640->lrck[dai->id], dai->id);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 58ebe96..0b39178 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2095,6 +2095,8 @@ struct rt5640_priv {
 	int pll_out;
 
 	bool hp_mute;
+
+	int asrc_en;
 };
 
 #endif
-- 
1.8.1.1.439.g50a6b54
