From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 13:51:45 +0800
Message-ID: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 84457104319
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 07:52:26 +0200 (CEST)
Received: by iakh37 with SMTP id h37so2671705iak.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 22:52:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Zeng Zhaoming <zengzm.kernel@gmail.com>

As manual described, VAG is an internal voltage reference of DAC/ADC,
So enabled it before DAC/ADC up.  As the result, the issue that
captured wave file has no sound gets fixed.

One more thing should care about is VAG fully ramped down requires 400ms,
wait it to avoid pop.

Signed-off-by: Zeng Zhaoming <zengzm.kernel@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d192626..d6f5aaf 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -143,11 +143,11 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 }
 
 /*
- * using codec assist to small pop, hp_powerup or lineout_powerup
- * should stay setting until vag_powerup is fully ramped down,
- * vag fully ramped down require 400ms.
+ * As manual described, ADC/DAC only works when VAG powerup,
+ * So enabled VAG before ADC/DAC up.
+ * In power down case, we need wait 400ms when vag fully ramped down.
  */
-static int small_pop_event(struct snd_soc_dapm_widget *w,
+static int power_vag_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	switch (event) {
@@ -156,7 +156,7 @@ static int small_pop_event(struct snd_soc_dapm_widget *w,
 			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
 		break;
 
-	case SND_SOC_DAPM_PRE_PMD:
+	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, 0);
 		msleep(400);
@@ -201,12 +201,8 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 				mic_bias_event,
 				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
-	SND_SOC_DAPM_PGA_E("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0,
-			small_pop_event,
-			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_PGA_E("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0,
-			small_pop_event,
-			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
 	SND_SOC_DAPM_MUX("Headphone Mux", SND_SOC_NOPM, 0, 0, &dac_mux),
@@ -221,15 +217,20 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 				0, SGTL5000_CHIP_DIG_POWER,
 				1, 0),
 
-	SND_SOC_DAPM_ADC("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0),
-
-	SND_SOC_DAPM_DAC("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0),
+	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0,
+			power_vag_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0,
+			power_vag_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
 /* routes for sgtl5000 */
 static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
 	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
+	{"Mic Bias", NULL, "MIC_IN"},		/* mic_in --> mic bias */
+	{"Capture Mux", "MIC_IN", "Mic Bias"},	/* mic bias --> adc_mux */
 
 	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
 	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
-- 
1.7.5.4
