From: Michele Curti <michele.curti@gmail.com>
Subject: [PATCH] ASoc: rt5645: move RT5650 muxes to
	rt5650_specific_dapm_widgets
Date: Fri, 12 Jun 2015 11:59:37 +0200
Message-ID: <1434103177-1093-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id B8BA526688A
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:00:25 +0200 (CEST)
Received: by wiga1 with SMTP id a1so12159547wig.0
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 03:00:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, tiwai@suse.de, alsa-devel@alsa-project.org, Michele Curti <michele.curti@gmail.com>
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
---
 sound/soc/codecs/rt5645.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 46dc795..e92e734 100644
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
2.4.2
