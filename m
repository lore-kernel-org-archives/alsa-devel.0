From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5677: Add the ASRC support
Date: Fri, 19 Dec 2014 14:11:00 +0800
Message-ID: <1418969461-22494-2-git-send-email-oder_chiou@realtek.com>
References: <1418969461-22494-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA582605B5
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 07:11:11 +0100 (CET)
In-Reply-To: <1418969461-22494-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the ASRC support

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index a15e39d..66abfa3 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -921,6 +921,97 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
+static int is_using_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	unsigned int reg, shift, val;
+
+	if (source->reg == RT5677_ASRC_1) {
+		switch (source->shift) {
+		case 12:
+			reg = RT5677_ASRC_4;
+			shift = 0;
+			break;
+		case 13:
+			reg = RT5677_ASRC_4;
+			shift = 4;
+			break;
+		case 14:
+			reg = RT5677_ASRC_4;
+			shift = 8;
+			break;
+		case 15:
+			reg = RT5677_ASRC_4;
+			shift = 12;
+			break;
+		default:
+			return 0;
+		}
+	} else {
+		switch (source->shift) {
+		case 0:
+			reg = RT5677_ASRC_6;
+			shift = 8;
+			break;
+		case 1:
+			reg = RT5677_ASRC_6;
+			shift = 12;
+			break;
+		case 2:
+			reg = RT5677_ASRC_5;
+			shift = 0;
+			break;
+		case 3:
+			reg = RT5677_ASRC_5;
+			shift = 4;
+			break;
+		case 4:
+			reg = RT5677_ASRC_5;
+			shift = 8;
+			break;
+		case 5:
+			reg = RT5677_ASRC_5;
+			shift = 12;
+			break;
+		case 12:
+			reg = RT5677_ASRC_3;
+			shift = 0;
+			break;
+		case 13:
+			reg = RT5677_ASRC_3;
+			shift = 4;
+			break;
+		case 14:
+			reg = RT5677_ASRC_3;
+			shift = 12;
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	val = (snd_soc_read(source->codec, reg) >> shift) & 0xf;
+	switch (val) {
+	case 1 ... 6:
+		return 1;
+	default:
+		return 0;
+	}
+
+}
+
+static int can_use_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	if (rt5677->sysclk > rt5677->lrck[RT5677_AIF1] * 384)
+		return 1;
+
+	return 0;
+}
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5677_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5677_STO1_ADC_MIXER,
@@ -2215,6 +2306,45 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL2", RT5677_PWR_ANLG2, RT5677_PWR_PLL2_BIT,
 		0, rt5677_set_pll2_event, SND_SOC_DAPM_POST_PMU),
 
+	/* ASRC */
+	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5677_ASRC_1, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5677_ASRC_1, 1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S3 ASRC", 1, RT5677_ASRC_1, 2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S4 ASRC", 1, RT5677_ASRC_1, 3, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5677_ASRC_2, 14, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO2 L ASRC", 1, RT5677_ASRC_2, 13, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO2 R ASRC", 1, RT5677_ASRC_2, 12, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO3 L ASRC", 1, RT5677_ASRC_1, 15, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO3 R ASRC", 1, RT5677_ASRC_1, 14, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO4 L ASRC", 1, RT5677_ASRC_1, 13, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DAC MONO4 R ASRC", 1, RT5677_ASRC_1, 12, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO1 ASRC", 1, RT5677_ASRC_2, 11, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO2 ASRC", 1, RT5677_ASRC_2, 10, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO3 ASRC", 1, RT5677_ASRC_2, 9, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO4 ASRC", 1, RT5677_ASRC_2, 8, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO L ASRC", 1, RT5677_ASRC_2, 7, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO R ASRC", 1, RT5677_ASRC_2, 6, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5677_ASRC_2, 5, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5677_ASRC_2, 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO3 ASRC", 1, RT5677_ASRC_2, 3, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO4 ASRC", 1, RT5677_ASRC_2, 2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO L ASRC", 1, RT5677_ASRC_2, 1, 0, NULL,
+		0),
+	SND_SOC_DAPM_SUPPLY_S("ADC MONO R ASRC", 1, RT5677_ASRC_2, 0, 0, NULL,
+		0),
+
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5677_PWR_ANLG2, RT5677_PWR_MB1_BIT,
@@ -2729,6 +2859,31 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
+	{ "Stereo1 DMIC Mux", NULL, "DMIC STO1 ASRC", can_use_asrc },
+	{ "Stereo2 DMIC Mux", NULL, "DMIC STO2 ASRC", can_use_asrc },
+	{ "Stereo3 DMIC Mux", NULL, "DMIC STO3 ASRC", can_use_asrc },
+	{ "Stereo4 DMIC Mux", NULL, "DMIC STO4 ASRC", can_use_asrc },
+	{ "Mono DMIC L Mux", NULL, "DMIC MONO L ASRC", can_use_asrc },
+	{ "Mono DMIC R Mux", NULL, "DMIC MONO R ASRC", can_use_asrc },
+	{ "I2S1", NULL, "I2S1 ASRC", can_use_asrc},
+	{ "I2S2", NULL, "I2S2 ASRC", can_use_asrc},
+	{ "I2S3", NULL, "I2S3 ASRC", can_use_asrc},
+	{ "I2S4", NULL, "I2S4 ASRC", can_use_asrc},
+
+	{ "dac stereo1 filter", NULL, "DAC STO ASRC", is_using_asrc },
+	{ "dac mono2 left filter", NULL, "DAC MONO2 L ASRC", is_using_asrc },
+	{ "dac mono2 right filter", NULL, "DAC MONO2 R ASRC", is_using_asrc },
+	{ "dac mono3 left filter", NULL, "DAC MONO3 L ASRC", is_using_asrc },
+	{ "dac mono3 right filter", NULL, "DAC MONO3 R ASRC", is_using_asrc },
+	{ "dac mono4 left filter", NULL, "DAC MONO4 L ASRC", is_using_asrc },
+	{ "dac mono4 right filter", NULL, "DAC MONO4 R ASRC", is_using_asrc },
+	{ "adc stereo1 filter", NULL, "ADC STO1 ASRC", is_using_asrc },
+	{ "adc stereo2 filter", NULL, "ADC STO2 ASRC", is_using_asrc },
+	{ "adc stereo3 filter", NULL, "ADC STO3 ASRC", is_using_asrc },
+	{ "adc stereo4 filter", NULL, "ADC STO4 ASRC", is_using_asrc },
+	{ "adc mono left filter", NULL, "ADC MONO L ASRC", is_using_asrc },
+	{ "adc mono right filter", NULL, "ADC MONO R ASRC", is_using_asrc },
+
 	{ "DMIC1", NULL, "DMIC L1" },
 	{ "DMIC1", NULL, "DMIC R1" },
 	{ "DMIC2", NULL, "DMIC L2" },
-- 
1.8.1.1.439.g50a6b54
