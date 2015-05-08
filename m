From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add DMIC ASRC detect function
Date: Fri, 8 May 2015 13:24:02 +0800
Message-ID: <1431062642-26986-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C996261563
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 07:24:12 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds DMIC ASRC detect function to dominate whether the DMIC ASRC
enable or not.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 81 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 685e268..8bb7be8 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1230,6 +1230,75 @@ int rt5677_sel_asrc_clk_src(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(rt5677_sel_asrc_clk_src);
 
+static int rt5677_dmic_use_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int asrc_setting;
+
+	switch (source->shift) {
+	case 11:
+		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_STO1_CLK_SEL_MASK) >>
+				RT5677_AD_STO1_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	case 10:
+		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_STO2_CLK_SEL_MASK) >>
+				RT5677_AD_STO2_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	case 9:
+		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_STO3_CLK_SEL_MASK) >>
+				RT5677_AD_STO3_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	case 8:
+		regmap_read(rt5677->regmap, RT5677_ASRC_5, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_STO4_CLK_SEL_MASK) >>
+			RT5677_AD_STO4_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	case 7:
+		regmap_read(rt5677->regmap, RT5677_ASRC_6, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_MONOL_CLK_SEL_MASK) >>
+			RT5677_AD_MONOL_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	case 6:
+		regmap_read(rt5677->regmap, RT5677_ASRC_6, &asrc_setting);
+		asrc_setting = (asrc_setting & RT5677_AD_MONOR_CLK_SEL_MASK) >>
+			RT5677_AD_MONOR_CLK_SEL_SFT;
+		if (asrc_setting >= RT5677_CLK_SEL_I2S1_ASRC &&
+			asrc_setting <= RT5677_CLK_SEL_I2S6_ASRC)
+			return 1;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5677_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5677_STO1_ADC_MIXER,
@@ -3087,12 +3156,12 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
-	{ "Stereo1 DMIC Mux", NULL, "DMIC STO1 ASRC", can_use_asrc },
-	{ "Stereo2 DMIC Mux", NULL, "DMIC STO2 ASRC", can_use_asrc },
-	{ "Stereo3 DMIC Mux", NULL, "DMIC STO3 ASRC", can_use_asrc },
-	{ "Stereo4 DMIC Mux", NULL, "DMIC STO4 ASRC", can_use_asrc },
-	{ "Mono DMIC L Mux", NULL, "DMIC MONO L ASRC", can_use_asrc },
-	{ "Mono DMIC R Mux", NULL, "DMIC MONO R ASRC", can_use_asrc },
+	{ "Stereo1 DMIC Mux", NULL, "DMIC STO1 ASRC", rt5677_dmic_use_asrc },
+	{ "Stereo2 DMIC Mux", NULL, "DMIC STO2 ASRC", rt5677_dmic_use_asrc },
+	{ "Stereo3 DMIC Mux", NULL, "DMIC STO3 ASRC", rt5677_dmic_use_asrc },
+	{ "Stereo4 DMIC Mux", NULL, "DMIC STO4 ASRC", rt5677_dmic_use_asrc },
+	{ "Mono DMIC L Mux", NULL, "DMIC MONO L ASRC", rt5677_dmic_use_asrc },
+	{ "Mono DMIC R Mux", NULL, "DMIC MONO R ASRC", rt5677_dmic_use_asrc },
 	{ "I2S1", NULL, "I2S1 ASRC", can_use_asrc},
 	{ "I2S2", NULL, "I2S2 ASRC", can_use_asrc},
 	{ "I2S3", NULL, "I2S3 ASRC", can_use_asrc},
-- 
1.8.1.1.439.g50a6b54
