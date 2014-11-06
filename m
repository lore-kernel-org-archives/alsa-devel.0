From: <bardliao@realtek.com>
Subject: [PATCH 3/4] ASoC:rt5670: add rt5672 codec support
Date: Thu, 6 Nov 2014 12:23:53 +0800
Message-ID: <1415247834-14278-3-git-send-email-bardliao@realtek.com>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC1026506E
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 05:24:36 +0100 (CET)
In-Reply-To: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

rt5672 is very similar to rt5670. Therefore we use one codec driver
to support both codecs. The difference between rt5670 and rt5672 is
there is some difference in their dapm routing table.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 71 ++++++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/rt5670.h |  6 ++++
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 7592814..c3914e8 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1635,29 +1635,39 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 	/* PDM */
 	SND_SOC_DAPM_SUPPLY("PDM1 Power", RT5670_PWR_DIG2,
 		RT5670_PWR_PDM1_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("PDM2 Power", RT5670_PWR_DIG2,
-		RT5670_PWR_PDM2_BIT, 0, NULL, 0),
-
 	SND_SOC_DAPM_MUX("PDM1 L Mux", RT5670_PDM_OUT_CTRL,
 			 RT5670_M_PDM1_L_SFT, 1, &rt5670_pdm1_l_mux),
 	SND_SOC_DAPM_MUX("PDM1 R Mux", RT5670_PDM_OUT_CTRL,
 			 RT5670_M_PDM1_R_SFT, 1, &rt5670_pdm1_r_mux),
-	SND_SOC_DAPM_MUX("PDM2 L Mux", RT5670_PDM_OUT_CTRL,
-			 RT5670_M_PDM2_L_SFT, 1, &rt5670_pdm2_l_mux),
-	SND_SOC_DAPM_MUX("PDM2 R Mux", RT5670_PDM_OUT_CTRL,
-			 RT5670_M_PDM2_R_SFT, 1, &rt5670_pdm2_r_mux),
 
 	/* Output Lines */
 	SND_SOC_DAPM_OUTPUT("HPOL"),
 	SND_SOC_DAPM_OUTPUT("HPOR"),
 	SND_SOC_DAPM_OUTPUT("LOUTL"),
 	SND_SOC_DAPM_OUTPUT("LOUTR"),
+};
+
+static const struct snd_soc_dapm_widget rt5670_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("PDM2 Power", RT5670_PWR_DIG2,
+		RT5670_PWR_PDM2_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_MUX("PDM2 L Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM2_L_SFT, 1, &rt5670_pdm2_l_mux),
+	SND_SOC_DAPM_MUX("PDM2 R Mux", RT5670_PDM_OUT_CTRL,
+			 RT5670_M_PDM2_R_SFT, 1, &rt5670_pdm2_r_mux),
 	SND_SOC_DAPM_OUTPUT("PDM1L"),
 	SND_SOC_DAPM_OUTPUT("PDM1R"),
 	SND_SOC_DAPM_OUTPUT("PDM2L"),
 	SND_SOC_DAPM_OUTPUT("PDM2R"),
 };
 
+static const struct snd_soc_dapm_widget rt5672_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_PGA("SPO Amp", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("SPOLP"),
+	SND_SOC_DAPM_OUTPUT("SPOLN"),
+	SND_SOC_DAPM_OUTPUT("SPORP"),
+	SND_SOC_DAPM_OUTPUT("SPORN"),
+};
+
 static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc },
 	{ "ADC Stereo2 Filter", NULL, "ADC STO2 ASRC", is_using_asrc },
@@ -2010,12 +2020,6 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "PDM1 R Mux", "Stereo DAC", "Stereo DAC MIXR" },
 	{ "PDM1 R Mux", "Mono DAC", "Mono DAC MIXR" },
 	{ "PDM1 R Mux", NULL, "PDM1 Power" },
-	{ "PDM2 L Mux", "Stereo DAC", "Stereo DAC MIXL" },
-	{ "PDM2 L Mux", "Mono DAC", "Mono DAC MIXL" },
-	{ "PDM2 L Mux", NULL, "PDM2 Power" },
-	{ "PDM2 R Mux", "Stereo DAC", "Stereo DAC MIXR" },
-	{ "PDM2 R Mux", "Mono DAC", "Mono DAC MIXR" },
-	{ "PDM2 R Mux", NULL, "PDM2 Power" },
 
 	{ "HP Amp", NULL, "HPO MIX" },
 	{ "HP Amp", NULL, "Mic Det Power" },
@@ -2033,13 +2037,30 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "LOUTR", NULL, "LOUT R Playback" },
 	{ "LOUTL", NULL, "Improve HP Amp Drv" },
 	{ "LOUTR", NULL, "Improve HP Amp Drv" },
+};
 
+static const struct snd_soc_dapm_route rt5670_specific_dapm_routes[] = {
+	{ "PDM2 L Mux", "Stereo DAC", "Stereo DAC MIXL" },
+	{ "PDM2 L Mux", "Mono DAC", "Mono DAC MIXL" },
+	{ "PDM2 L Mux", NULL, "PDM2 Power" },
+	{ "PDM2 R Mux", "Stereo DAC", "Stereo DAC MIXR" },
+	{ "PDM2 R Mux", "Mono DAC", "Mono DAC MIXR" },
+	{ "PDM2 R Mux", NULL, "PDM2 Power" },
 	{ "PDM1L", NULL, "PDM1 L Mux" },
 	{ "PDM1R", NULL, "PDM1 R Mux" },
 	{ "PDM2L", NULL, "PDM2 L Mux" },
 	{ "PDM2R", NULL, "PDM2 R Mux" },
 };
 
+static const struct snd_soc_dapm_route rt5672_specific_dapm_routes[] = {
+	{ "SPO Amp", NULL, "PDM1 L Mux" },
+	{ "SPO Amp", NULL, "PDM1 R Mux" },
+	{ "SPOLP", NULL, "SPO Amp" },
+	{ "SPOLN", NULL, "SPO Amp" },
+	{ "SPORP", NULL, "SPO Amp" },
+	{ "SPORN", NULL, "SPO Amp" },
+};
+
 static int rt5670_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -2371,6 +2392,29 @@ static int rt5670_probe(struct snd_soc_codec *codec)
 {
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
+	switch (snd_soc_read(codec, RT5670_RESET) & RT5670_ID_MASK) {
+	case RT5670_ID_5670:
+	case RT5670_ID_5671:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5670_specific_dapm_widgets,
+			ARRAY_SIZE(rt5670_specific_dapm_widgets));
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5670_specific_dapm_routes,
+			ARRAY_SIZE(rt5670_specific_dapm_routes));
+		break;
+	case RT5670_ID_5672:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5672_specific_dapm_widgets,
+			ARRAY_SIZE(rt5672_specific_dapm_widgets));
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5672_specific_dapm_routes,
+			ARRAY_SIZE(rt5672_specific_dapm_routes));
+		break;
+	default:
+		dev_err(codec->dev,
+			"The driver is for RT5670 RT5671 or RT5672 only\n");
+		return -ENODEV;
+	}
 	rt5670->codec = codec;
 	rt5670_dsp_probe(codec);
 
@@ -2493,6 +2537,7 @@ static const struct regmap_config rt5670_regmap = {
 
 static const struct i2c_device_id rt5670_i2c_id[] = {
 	{ "rt5670", 0 },
+	{ "rt5672", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5670_i2c_id);
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 70285c9..8b2ab69 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -228,6 +228,12 @@
 #define RT5670_R_VOL_MASK			(0x3f)
 #define RT5670_R_VOL_SFT			0
 
+/* SW Reset & Device ID (0x00) */
+#define RT5670_ID_MASK				(0x3 << 1)
+#define RT5670_ID_5670				(0x0 << 1)
+#define RT5670_ID_5672				(0x1 << 1)
+#define RT5670_ID_5671				(0x2 << 1)
+
 /* Combo Jack Control 1 (0x0a) */
 #define RT5670_CBJ_BST1_MASK			(0xf << 12)
 #define RT5670_CBJ_BST1_SFT			(12)
-- 
1.8.1.1.439.g50a6b54
