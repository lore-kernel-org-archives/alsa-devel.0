From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: move RT5645 muxes to
	rt5645_specific_dapm_widgets
Date: Mon, 29 Jun 2015 14:20:50 +0800
Message-ID: <1435558850-2040-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 234DE265192
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 08:21:18 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This is a similar patch to "move RT5650 muxes to rt5650_specific_
dapm_widgets" patch. The purpose is to silence the "has no paths"
warnings.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d0750be..8c8a2b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1697,15 +1697,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* IF1 2 Mux */
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc1_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc2_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc3_in_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
-		0, 0, &rt5645_if1_adc_in_mux),
-
 	SND_SOC_DAPM_MUX("IF2 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if2_adc_in_mux),
 
@@ -1716,14 +1707,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1 DAC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac0_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac1_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac2_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5645_if1_dac3_tdm_sel_mux),
 	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1856,6 +1839,25 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPOR"),
 };
 
+static const struct snd_soc_dapm_widget rt5645_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5645_if1_dac3_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc1_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("RT5645 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5645_if1_adc3_in_mux),
+};
+
 static const struct snd_soc_dapm_widget rt5650_specific_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("A DAC1 L Mux", SND_SOC_NOPM,
 		0, 0, &rt5650_a_dac1_l_mux),
@@ -3050,6 +3052,9 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 
 	switch (rt5645->codec_type) {
 	case CODEC_TYPE_RT5645:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5645_specific_dapm_widgets,
+			ARRAY_SIZE(rt5645_specific_dapm_widgets));
 		snd_soc_dapm_add_routes(&codec->dapm,
 			rt5645_specific_dapm_routes,
 			ARRAY_SIZE(rt5645_specific_dapm_routes));
-- 
1.8.1.1.439.g50a6b54
