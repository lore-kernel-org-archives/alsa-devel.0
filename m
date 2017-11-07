From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 1/3] ASoC: nau8540: reset state machine for
	channel phase sync
Date: Tue, 7 Nov 2017 15:23:17 +0800
Message-ID: <1510039399-12807-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13841267327
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 08:23:24 +0100 (CET)
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

The four channel ADCs in NAU85L40 have difference control registers,
it is hard to synchronous these four channels without correct sequence.
The phase difference will not be a constant and not to conjecture easily.
It may be 2.55 degree, or more ,or less.
Intended to prevent phase difference of channels, the solution as follows:
(1)Channel_Sync need to be enabled.
(2)Do soft reset without affecting register when recording done.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8540.c | 23 ++++++++++++++++++++---
 sound/soc/codecs/nau8540.h |  1 +
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 4d18158..2efa431 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -233,6 +233,19 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new digital_ch1_mux =
 	SOC_DAPM_ENUM("Digital CH1 Select", digital_ch1_enum);
 
+static int aiftx_power_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		regmap_write(nau8540->regmap, NAU8540_REG_RST, 0x0001);
+		regmap_write(nau8540->regmap, NAU8540_REG_RST, 0x0000);
+	}
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget nau8540_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("MICBIAS2", NAU8540_REG_MIC_BIAS, 11, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", NAU8540_REG_MIC_BIAS, 10, 0, NULL, 0),
@@ -270,7 +283,8 @@ static const struct snd_soc_dapm_widget nau8540_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Digital CH1 Mux",
 		SND_SOC_NOPM, 0, 0, &digital_ch1_mux),
 
-	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT_E("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0,
+		aiftx_power_control, SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route nau8540_dapm_routes[] = {
@@ -717,9 +731,12 @@ static void nau8540_init_regs(struct nau8540 *nau8540)
 	regmap_update_bits(regmap, NAU8540_REG_CLOCK_CTRL,
 		NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN,
 		NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN);
-	/* ADC OSR selection, CLK_ADC = Fs * OSR */
+	/* ADC OSR selection, CLK_ADC = Fs * OSR;
+	 * Channel time alignment enable.
+	 */
 	regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
-		NAU8540_ADC_OSR_MASK, NAU8540_ADC_OSR_64);
+		NAU8540_CH_SYNC | NAU8540_ADC_OSR_MASK,
+		NAU8540_CH_SYNC | NAU8540_ADC_OSR_64);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index ab2a132..5e0dd18 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -170,6 +170,7 @@
 #define NAU8540_TDM_TX_MASK		0xf
 
 /* ADC_SAMPLE_RATE (0x3A) */
+#define NAU8540_CH_SYNC		(0x1 << 14)
 #define NAU8540_ADC_OSR_MASK		0x3
 #define NAU8540_ADC_OSR_256		0x3
 #define NAU8540_ADC_OSR_128		0x2
-- 
2.6.4
