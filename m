From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: change output power for
	interrupt
Date: Tue, 22 Mar 2016 11:57:20 +0800
Message-ID: <1458619040-28355-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF4826516A
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 04:57:05 +0100 (CET)
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

The interrupt clock is gated by x1[10:8], one of them needs to be enabled
all the time for interrupts to happen. We change codec to enable ADC
because it's helpful to reduce playback pop noise.
Don't use force enable pin to enable ADC instead of ADC widget event.
That won't interfere DAPM operation and let bias work normally.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 40 ++++++++++++++++++++++++++++------------
 sound/soc/codecs/nau8825.h |  1 +
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 4c8572c..106c391 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -223,6 +223,29 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static int nau8825_adc_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
+			NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (!nau8825->irq)
+			regmap_update_bits(nau8825->regmap,
+				NAU8825_REG_ENA_CTRL, NAU8825_ENABLE_ADC, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nau8825_pump_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -338,7 +361,9 @@ static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Frontend PGA", NAU8825_REG_POWER_UP_CONTROL, 14, 0,
 		NULL, 0),
 
-	SND_SOC_DAPM_ADC("ADC", NULL, NAU8825_REG_ENA_CTRL, 8, 0),
+	SND_SOC_DAPM_ADC_E("ADC", NULL, SND_SOC_NOPM, 0, 0,
+		nau8825_adc_event, SND_SOC_DAPM_POST_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("ADC Clock", NAU8825_REG_ENA_CTRL, 7, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC Power", NAU8825_REG_ANALOG_ADC_2, 6, 0, NULL,
 		0),
@@ -928,13 +953,6 @@ static int nau8825_codec_probe(struct snd_soc_codec *codec)
 
 	nau8825->dapm = dapm;
 
-	/* The interrupt clock is gated by x1[10:8],
-	 * one of them needs to be enabled all the time for
-	 * interrupts to happen.
-	 */
-	snd_soc_dapm_force_enable_pin(dapm, "DDACR");
-	snd_soc_dapm_sync(dapm);
-
 	/* Unmask interruptions. Handler uses dapm object so we can enable
 	 * interruptions only after dapm is fully initialized.
 	 */
@@ -1338,11 +1356,9 @@ static int nau8825_setup_irq(struct nau8825 *nau8825)
 	/* Enable internal VCO needed for interruptions */
 	nau8825_configure_sysclk(nau8825, NAU8825_CLK_INTERNAL, 0);
 
-	/* Enable DDACR needed for interrupts
-	 * It is the same as force_enable_pin("DDACR") we do later
-	 */
+	/* Enable ADC needed for interrupts */
 	regmap_update_bits(regmap, NAU8825_REG_ENA_CTRL,
-		NAU8825_ENABLE_DACR, NAU8825_ENABLE_DACR);
+		NAU8825_ENABLE_ADC, NAU8825_ENABLE_ADC);
 
 	/* Chip needs one FSCLK cycle in order to generate interrupts,
 	 * as we cannot guarantee one will be provided by the system. Turning
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 5fe009d..4427df9 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -99,6 +99,7 @@
 #define NAU8825_ENABLE_DACR	(1 << NAU8825_ENABLE_DACR_SFT)
 #define NAU8825_ENABLE_DACL_SFT	9
 #define NAU8825_ENABLE_ADC_SFT	8
+#define NAU8825_ENABLE_ADC		(1 << NAU8825_ENABLE_ADC_SFT)
 #define NAU8825_ENABLE_SAR_SFT	1
 
 /* CLK_DIVIDER (0x3) */
-- 
2.6.4
