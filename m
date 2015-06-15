From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: move RT5650 muxes to
	rt5650_specific_dapm_widgets
Date: Mon, 15 Jun 2015 10:44:11 +0800
Message-ID: <1434336251-21807-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DA1AA260676
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 04:44:28 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Michele Curti <michele.curti@gmail.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Developing a driver for an Asus X205TA laptop I get these dmesg
errors:

 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC1 Swap Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC2 Swap Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC3 Swap Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 L Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 R Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 L Mux has no paths
 rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 R Mux has no paths

so, move these muxes to the rt5650_specific_dapm_widgets[] list.

Signed-off-by: Michele Curti <michele.curti@gmail.com>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4344043..9ce311e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1706,15 +1706,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("RT5645 IF1 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if1_adc_in_mux),
 
-	SND_SOC_DAPM_MUX("RT5650 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5650_if1_adc1_in_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5650_if1_adc2_in_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
-		0, 0, &rt5650_if1_adc3_in_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 ADC Mux", SND_SOC_NOPM,
-		0, 0, &rt5650_if1_adc_in_mux),
-
 	SND_SOC_DAPM_MUX("IF2 ADC Mux", SND_SOC_NOPM,
 		0, 0, &rt5645_if2_adc_in_mux),
 
@@ -1733,14 +1724,6 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 		&rt5645_if1_dac2_tdm_sel_mux),
 	SND_SOC_DAPM_MUX("RT5645 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
 		&rt5645_if1_dac3_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5650_if1_dac0_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5650_if1_dac1_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
-		&rt5650_if1_dac2_tdm_sel_mux),
-	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
-		&rt5650_if1_dac3_tdm_sel_mux),
 	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC L", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 ADC R", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1882,6 +1865,24 @@ static const struct snd_soc_dapm_widget rt5650_specific_dapm_widgets[] = {
 		0, 0, &rt5650_a_dac2_l_mux),
 	SND_SOC_DAPM_MUX("A DAC2 R Mux", SND_SOC_NOPM,
 		0, 0, &rt5650_a_dac2_r_mux),
+
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC1 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc1_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC2 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc2_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC3 Swap Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc3_in_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 ADC Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_if1_adc_in_mux),
+
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac0_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC1 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac1_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 L Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac2_tdm_sel_mux),
+	SND_SOC_DAPM_MUX("RT5650 IF1 DAC2 R Mux", SND_SOC_NOPM, 0, 0,
+		&rt5650_if1_dac3_tdm_sel_mux),
 };
 
 static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
-- 
1.8.1.1.439.g50a6b54
