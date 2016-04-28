From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: apply BIQ to reduce recording
	signal DC offset
Date: Thu, 28 Apr 2016 14:15:04 +0800
Message-ID: <1461824104-9236-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4B9265152
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 08:15:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Enable biquad filter as HPF in the ADC path when headset detected.
It helps to reduce recording signal DC offset. The biquad filter
parameters are applied for the ADC path when jack is inserted. The
biquad filter is cancelled when jack is ejected.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8825.h |  7 ++++++
 2 files changed, 66 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index f35019a..962d2f0 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -156,6 +156,20 @@ static const struct reg_default nau8825_reg_defaults[] = {
 	{ NAU8825_REG_CHARGE_PUMP, 0x0 },
 };
 
+/* Biquad filter coefficients for A1, A2, B0, B1, and B3 */
+static const struct reg_default nau8825_adc_biq_reg[] = {
+	{ NAU8825_REG_BIQ_COF1, 0x009B },
+	{ NAU8825_REG_BIQ_COF2, 0x0006 },
+	{ NAU8825_REG_BIQ_COF3, 0xff66 },
+	{ NAU8825_REG_BIQ_COF4, 0x0000 },
+	{ NAU8825_REG_BIQ_COF5, 0xffb3 },
+	{ NAU8825_REG_BIQ_COF6, 0x0000 },
+	{ NAU8825_REG_BIQ_COF7, 0x009A },
+	{ NAU8825_REG_BIQ_COF8, 0x0006 },
+	{ NAU8825_REG_BIQ_COF9, 0xffb3 },
+	{ NAU8825_REG_BIQ_COF10, 0x8000 },
+};
+
 static bool nau8825_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -217,12 +231,46 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
 	case NAU8825_REG_SARDOUT_RAM_STATUS:
 	case NAU8825_REG_CHARGE_PUMP_INPUT_READ:
 	case NAU8825_REG_GENERAL_STATUS:
+	case NAU8825_REG_BIQ_CTRL ... NAU8825_REG_BIQ_COF10:
 		return true;
 	default:
 		return false;
 	}
 }
 
+static void nau8825_adc_biq_apply(struct nau8825 *nau8825)
+{
+	int i;
+
+	/* Enable the BIQ parameter write/updated. The control is valid only
+	 * when change from 0 to 1. The driver applies the BIQ function into
+	 * the ADC path only.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN | NAU8825_BIQ_PATH_MASK,
+		NAU8825_BIQ_PATH_ADC);
+	for (i = 0; i < ARRAY_SIZE(nau8825_adc_biq_reg); i++)
+		regmap_write(nau8825->regmap, nau8825_adc_biq_reg[i].reg,
+				nau8825_adc_biq_reg[i].def);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN, NAU8825_BIQ_WRT_EN);
+}
+
+static void nau8825_adc_biq_cancel(struct nau8825 *nau8825)
+{
+	int i;
+
+	/* Disable the BIQ parameter write/updated. The control is valid only
+	 * when change from 0 to 1.
+	 */
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN, 0);
+	for (i = 0; i < ARRAY_SIZE(nau8825_adc_biq_reg); i++)
+		regmap_write(nau8825->regmap, nau8825_adc_biq_reg[i].reg, 0);
+	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIQ_CTRL,
+		NAU8825_BIQ_WRT_EN, NAU8825_BIQ_WRT_EN);
+}
+
 static int nau8825_adc_event(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kcontrol, int event)
 {
@@ -647,6 +695,9 @@ static void nau8825_eject_jack(struct nau8825 *nau8825)
 	struct snd_soc_dapm_context *dapm = nau8825->dapm;
 	struct regmap *regmap = nau8825->regmap;
 
+	/* Cancel biquad filter in ADC path */
+	nau8825_adc_biq_cancel(nau8825);
+
 	snd_soc_dapm_disable_pin(dapm, "SAR");
 	snd_soc_dapm_disable_pin(dapm, "MICBIAS");
 	/* Detach 2kOhm Resistors from MICBIAS to MICGND1/2 */
@@ -737,6 +788,14 @@ static int nau8825_jack_insert(struct nau8825 *nau8825)
 		break;
 	}
 
+	if (type & SND_JACK_MICROPHONE) {
+		/* Apply biquad filter into ADC path. It helps to avoid the DC
+		 * offset in recoding signal. The function will keep asleep
+		 * without clock and work up automatically when clock provided.
+		 */
+		nau8825_adc_biq_apply(nau8825);
+	}
+
 	/* Leaving HPOL/R grounded after jack insert by default. They will be
 	 * ungrounded as part of the widget power up sequence at the beginning
 	 * of playback to reduce pop.
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 9e6cb62..f3b4acb 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -231,6 +231,13 @@
 #define NAU8825_I2S_MS_MASTER	(1 << NAU8825_I2S_MS_SFT)
 #define NAU8825_I2S_MS_SLAVE	(0 << NAU8825_I2S_MS_SFT)
 
+/* BIQ_CTRL (0x20) */
+#define NAU8825_BIQ_WRT_EN	(1 << 4)
+#define NAU8825_BIQ_PATH_SFT	0
+#define NAU8825_BIQ_PATH_MASK	(1 << NAU8825_BIQ_PATH_SFT)
+#define NAU8825_BIQ_PATH_ADC	(0 << NAU8825_BIQ_PATH_SFT)
+#define NAU8825_BIQ_PATH_DAC	(1 << NAU8825_BIQ_PATH_SFT)
+
 /* ADC_RATE (0x2b) */
 #define NAU8825_ADC_SYNC_DOWN_SFT	0
 #define NAU8825_ADC_SYNC_DOWN_MASK	0x3
-- 
2.6.4
