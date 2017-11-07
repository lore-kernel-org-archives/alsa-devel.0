From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 3/3] ASoC: nau8540: fix the record pop noise
Date: Tue, 7 Nov 2017 15:23:19 +0800
Message-ID: <1510039399-12807-3-git-send-email-KCHSU0@nuvoton.com>
References: <1510039399-12807-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A44267328
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 08:23:24 +0100 (CET)
In-Reply-To: <1510039399-12807-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

When the record starts, the driver turns on MICBIAS and the voltage is
pulled up for an instant. If the receiver starts to capture the signal
between the instant, there is an pop noise in the stream beginning.
To avoid the pop noise, the driver makes a delay in the sequence.
After MICBIAS powered up, the driver waits 300 ms for the voltage
going down. Then turns on the ADC output, and sends signal to receiver.
The pop noise can be erased.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8540.c | 47 ++++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/nau8540.h |  2 ++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 572bea2..fd40c61 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -233,6 +233,28 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new digital_ch1_mux =
 	SOC_DAPM_ENUM("Digital CH1 Select", digital_ch1_enum);
 
+static int adc_power_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		msleep(300);
+		/* DO12 and DO34 pad output enable */
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+			NAU8540_I2S_DO12_TRI, 0);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+			NAU8540_I2S_DO34_TRI, 0);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+			NAU8540_I2S_DO12_TRI, NAU8540_I2S_DO12_TRI);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+			NAU8540_I2S_DO34_TRI, NAU8540_I2S_DO34_TRI);
+	}
+	return 0;
+}
+
 static int aiftx_power_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
@@ -260,14 +282,18 @@ static const struct snd_soc_dapm_widget nau8540_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Frontend PGA3", NAU8540_REG_PWR, 14, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Frontend PGA4", NAU8540_REG_PWR, 15, 0, NULL, 0),
 
-	SND_SOC_DAPM_ADC("ADC1", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 0, 0),
-	SND_SOC_DAPM_ADC("ADC2", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 1, 0),
-	SND_SOC_DAPM_ADC("ADC3", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 2, 0),
-	SND_SOC_DAPM_ADC("ADC4", NULL,
-		NAU8540_REG_POWER_MANAGEMENT, 3, 0),
+	SND_SOC_DAPM_ADC_E("ADC1", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 0, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC2", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 1, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC3", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 2, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_ADC_E("ADC4", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 3, 0, adc_power_control,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 	SND_SOC_DAPM_PGA("ADC CH1", NAU8540_REG_ANALOG_PWR, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("ADC CH2", NAU8540_REG_ANALOG_PWR, 1, 0, NULL, 0),
@@ -744,6 +770,11 @@ static void nau8540_init_regs(struct nau8540 *nau8540)
 	regmap_update_bits(regmap, NAU8540_REG_FEPGA2,
 		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT,
 		NAU8540_FEPGA2_MODCH4_SHT | NAU8540_FEPGA2_MODCH3_SHT);
+	/* DO12 and DO34 pad output disable */
+	regmap_update_bits(regmap, NAU8540_REG_PCM_CTRL1,
+		NAU8540_I2S_DO12_TRI, NAU8540_I2S_DO12_TRI);
+	regmap_update_bits(regmap, NAU8540_REG_PCM_CTRL2,
+		NAU8540_I2S_DO34_TRI, NAU8540_I2S_DO34_TRI);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index 9595663..732b490 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -151,6 +151,7 @@
 #define NAU8540_I2S_DF_PCM_AB		0x3
 
 /* PCM_CTRL1 (0x11) */
+#define NAU8540_I2S_DO12_TRI		(0x1 << 15)
 #define NAU8540_I2S_LRC_DIV_SFT	12
 #define NAU8540_I2S_LRC_DIV_MASK	(0x3 << NAU8540_I2S_LRC_DIV_SFT)
 #define NAU8540_I2S_DO12_OE		(0x1 << 4)
@@ -161,6 +162,7 @@
 #define NAU8540_I2S_BLK_DIV_MASK	0x7
 
 /* PCM_CTRL1 (0x12) */
+#define NAU8540_I2S_DO34_TRI		(0x1 << 15)
 #define NAU8540_I2S_DO34_OE		(0x1 << 11)
 #define NAU8540_I2S_TSLOT_L_MASK	0x3ff
 
-- 
2.6.4
