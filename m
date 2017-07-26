From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5670: merge ADC L/R Mux
Date: Wed, 26 Jul 2017 20:00:19 +0800
Message-ID: <1501070420-17773-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id ED2D826740A
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 14:00:33 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Some ADC L/R Muxes share the some control bit. So, merge them.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0ec7985..2866f9b 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1151,20 +1151,15 @@ static const char * const rt5670_stereo_adc1_src[] = {
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc1_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
-static const struct snd_kcontrol_new rt5670_sto_adc_l1_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC L1 source", rt5670_stereo1_adc1_enum);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_r1_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC R1 source", rt5670_stereo1_adc1_enum);
+static const struct snd_kcontrol_new rt5670_sto_adc_1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC 1 Mux", rt5670_stereo1_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc1_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_l1_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC L1 source", rt5670_stereo2_adc1_enum);
+static const struct snd_kcontrol_new rt5670_sto2_adc_1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC 1 Mux", rt5670_stereo2_adc1_enum);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_r1_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC R1 source", rt5670_stereo2_adc1_enum);
 
 /* MX-27 MX-26 [11] */
 static const char * const rt5670_stereo_adc2_src[] = {
@@ -1174,20 +1169,15 @@ static const char * const rt5670_stereo_adc2_src[] = {
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc2_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
-static const struct snd_kcontrol_new rt5670_sto_adc_l2_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC L2 source", rt5670_stereo1_adc2_enum);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_r2_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC R2 source", rt5670_stereo1_adc2_enum);
+static const struct snd_kcontrol_new rt5670_sto_adc_2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC 2 Mux", rt5670_stereo1_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_l2_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC L2 source", rt5670_stereo2_adc2_enum);
+static const struct snd_kcontrol_new rt5670_sto2_adc_2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC 2 Mux", rt5670_stereo2_adc2_enum);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_r2_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC R2 source", rt5670_stereo2_adc2_enum);
 
 /* MX-27 MX26 [10] */
 static const char * const rt5670_stereo_adc_src[] = {
@@ -1642,23 +1632,23 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Stereo1 DMIC Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto1_dmic_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_l2_mux),
+			 &rt5670_sto_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_r2_mux),
+			 &rt5670_sto_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_l1_mux),
+			 &rt5670_sto_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_r1_mux),
+			 &rt5670_sto_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 DMIC Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto2_dmic_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_l2_mux),
+			 &rt5670_sto2_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_r2_mux),
+			 &rt5670_sto2_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_l1_mux),
+			 &rt5670_sto2_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_r1_mux),
+			 &rt5670_sto2_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC LR Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto2_adc_lr_mux),
 	SND_SOC_DAPM_MUX("Mono DMIC L Mux", SND_SOC_NOPM, 0, 0,
-- 
2.7.4
