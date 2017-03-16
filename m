From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5665: set i2s pin share
	configuration
Date: Thu, 16 Mar 2017 13:58:41 +0800
Message-ID: <1489643921-29900-2-git-send-email-bardliao@realtek.com>
References: <1489643921-29900-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C7A12670EE
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 06:59:11 +0100 (CET)
In-Reply-To: <1489643921-29900-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

I2S2 and I2S3 are share pins. We need to configure it when i2s is
active and disable it when i2s is inactive. To disable i2s pins
means to set them as gpio.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 1d00c60..5545d08 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2604,6 +2604,55 @@ static int rt5655_set_verf(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5665_i2s_pin_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	unsigned int val1, val2, mask1, mask2 = 0;
+
+	switch (w->shift) {
+	case RT5665_PWR_I2S2_1_BIT:
+		mask1 = RT5665_GP2_PIN_MASK | RT5665_GP3_PIN_MASK |
+			RT5665_GP4_PIN_MASK | RT5665_GP5_PIN_MASK;
+		val1 = RT5665_GP2_PIN_BCLK2 | RT5665_GP3_PIN_LRCK2 |
+			RT5665_GP4_PIN_DACDAT2_1 | RT5665_GP5_PIN_ADCDAT2_1;
+		break;
+	case RT5665_PWR_I2S2_2_BIT:
+		mask1 = RT5665_GP2_PIN_MASK | RT5665_GP3_PIN_MASK |
+			RT5665_GP8_PIN_MASK;
+		val1 = RT5665_GP2_PIN_BCLK2 | RT5665_GP3_PIN_LRCK2 |
+			RT5665_GP8_PIN_DACDAT2_2;
+		mask2 = RT5665_GP9_PIN_MASK;
+		val2 = RT5665_GP9_PIN_ADCDAT2_2;
+		break;
+	case RT5665_PWR_I2S3_BIT:
+		mask1 = RT5665_GP6_PIN_MASK | RT5665_GP7_PIN_MASK |
+			RT5665_GP8_PIN_MASK;
+		val1 = RT5665_GP6_PIN_BCLK3 | RT5665_GP7_PIN_LRCK3 |
+			RT5665_GP8_PIN_DACDAT3;
+		mask2 = RT5665_GP9_PIN_MASK;
+		val2 = RT5665_GP9_PIN_ADCDAT3;
+		break;
+	}
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1, mask1, val1);
+		if (mask2)
+			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_2,
+					    mask2, val2);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, RT5665_GPIO_CTRL_1, mask1, 0);
+		if (mask2)
+			snd_soc_update_bits(codec, RT5665_GPIO_CTRL_2,
+					    mask2, 0);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
 
 static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5665_PWR_ANLG_3, RT5665_PWR_LDO2_BIT, 0,
@@ -2856,11 +2905,14 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("I2S1_2", RT5665_PWR_DIG_1, RT5665_PWR_I2S1_2_BIT,
 		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("I2S2_1", RT5665_PWR_DIG_1, RT5665_PWR_I2S2_1_BIT,
-		0, NULL, 0),
+		0, rt5665_i2s_pin_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("I2S2_2", RT5665_PWR_DIG_1, RT5665_PWR_I2S2_2_BIT,
-		0, NULL, 0),
+		0, rt5665_i2s_pin_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("I2S3", RT5665_PWR_DIG_1, RT5665_PWR_I2S3_BIT,
-		0, NULL, 0),
+		0, rt5665_i2s_pin_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA("IF1 DAC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1 DAC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-- 
2.7.4
