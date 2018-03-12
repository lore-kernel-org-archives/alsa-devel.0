From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5659: Separate adc 1/2 clock
	control
Date: Mon, 12 Mar 2018 19:50:09 +0800
Message-ID: <1520855409-28862-3-git-send-email-bardliao@realtek.com>
References: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 41CFC266F0F
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 12:50:22 +0100 (CET)
In-Reply-To: <1520855409-28862-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The control bits of ADC 1 and 2 clock are different. We have to
separate it.

Signed-off-by: Zhong An <zhongan@pinecone.net>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5659.c | 38 ++++++++++++++++++++++++++++++++------
 sound/soc/codecs/rt5659.h | 12 ++++++++----
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index a81e248..1c1a521 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1622,7 +1622,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	return idx;
 }
 
-static int set_adc_clk(struct snd_soc_dapm_widget *w,
+static int set_adc1_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
@@ -1630,13 +1630,39 @@ static int set_adc_clk(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
-			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK,
-			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK);
+			RT5659_CKXEN_ADC1_MASK | RT5659_CKGEN_ADC1_MASK,
+			RT5659_CKXEN_ADC1_MASK | RT5659_CKGEN_ADC1_MASK);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
-			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK, 0);
+			RT5659_CKXEN_ADC1_MASK | RT5659_CKGEN_ADC1_MASK, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+
+}
+
+static int set_adc2_clk(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
+			RT5659_CKXEN_ADC2_MASK | RT5659_CKGEN_ADC2_MASK,
+			RT5659_CKXEN_ADC2_MASK | RT5659_CKGEN_ADC2_MASK);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
+			RT5659_CKXEN_ADC2_MASK | RT5659_CKGEN_ADC2_MASK, 0);
 		break;
 
 	default:
@@ -2559,9 +2585,9 @@ static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
 		RT5659_PWR_ADC_L2_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC2 R Power", RT5659_PWR_DIG_1,
 		RT5659_PWR_ADC_R2_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC1 clock", SND_SOC_NOPM, 0, 0, set_adc_clk,
+	SND_SOC_DAPM_SUPPLY("ADC1 clock", SND_SOC_NOPM, 0, 0, set_adc1_clk,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_SUPPLY("ADC2 clock", SND_SOC_NOPM, 0, 0, set_adc_clk,
+	SND_SOC_DAPM_SUPPLY("ADC2 clock", SND_SOC_NOPM, 0, 0, set_adc2_clk,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 	/* ADC Mux */
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index 3b51c8a..8b576d7 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1743,10 +1743,14 @@
 #define RT5659_CKGEN_DAC2_SFT			4
 
 /* Chopper and Clock control for ADC (0x013b)*/
-#define RT5659_CKXEN_ADCC_MASK			(0x1 << 13)
-#define RT5659_CKXEN_ADCC_SFT			13
-#define RT5659_CKGEN_ADCC_MASK			(0x1 << 12)
-#define RT5659_CKGEN_ADCC_SFT			12
+#define RT5659_CKXEN_ADC1_MASK			(0x1 << 13)
+#define RT5659_CKXEN_ADC1_SFT			13
+#define RT5659_CKGEN_ADC1_MASK			(0x1 << 12)
+#define RT5659_CKGEN_ADC1_SFT			12
+#define RT5659_CKXEN_ADC2_MASK			(0x1 << 5)
+#define RT5659_CKXEN_ADC2_SFT			5
+#define RT5659_CKGEN_ADC2_MASK			(0x1 << 4)
+#define RT5659_CKGEN_ADC2_SFT			4
 
 /* Test Mode Control 1 (0x0145) */
 #define RT5659_AD2DA_LB_MASK			(0x1 << 9)
-- 
2.7.4
