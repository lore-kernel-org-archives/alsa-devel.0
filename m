From: Marek Vasut <marex@denx.de>
Subject: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
	enabling/disabling order
Date: Fri, 24 May 2013 05:34:56 +0200
Message-ID: <1369366496-15329-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 886A82650AB
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 05:35:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The VAG_POWER must be enabled after all other bits in CHIP_ANA_POWER
and disabled before any other bit in CHIP_ANA_POWER. See the SGTL5000
datasheet (Table 31, BIT 7, page 42-43). Failing to follow this order
will result in ugly loud "POP" noise at the end of playback.

To achieve such order, use the _PRE and _POST DAPM widgets to trigger
the power_vag_event, where the event type check has to be fixed
accordingly as well.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/sgtl5000.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 92bbfec..2068c36 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -151,15 +151,15 @@ static int power_vag_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
 		break;
 
-	case SND_SOC_DAPM_POST_PMD:
+	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, 0);
-		msleep(400);
+		mdelay(400);
 		break;
 	default:
 		break;
@@ -217,12 +217,11 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 				0, SGTL5000_CHIP_DIG_POWER,
 				1, 0),
 
-	SND_SOC_DAPM_SUPPLY("VAG_POWER", SGTL5000_CHIP_ANA_POWER, 7, 0,
-			    power_vag_event,
-			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-
 	SND_SOC_DAPM_ADC("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0),
+
+	SND_SOC_DAPM_PRE("VAG_POWER_PRE", power_vag_event),
+	SND_SOC_DAPM_POST("VAG_POWER_POST", power_vag_event),
 };
 
 /* routes for sgtl5000 */
@@ -230,16 +229,13 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
 	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
 
-	{"ADC", NULL, "VAG_POWER"},
 	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
 	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
 
-	{"DAC", NULL, "VAG_POWER"},
 	{"DAC", NULL, "AIFIN"},			/* i2s-->dac,skip audio mux */
 	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
 	{"LO", NULL, "DAC"},			/* dac --> line_out */
 
-	{"LINE_IN", NULL, "VAG_POWER"},
 	{"Headphone Mux", "LINE_IN", "LINE_IN"},/* line_in --> hp_mux */
 	{"HP", NULL, "Headphone Mux"},		/* hp_mux --> hp */
 
-- 
1.7.10.4
