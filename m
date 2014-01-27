From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 3/6] ASoC: tlv320aic32x4: Use signed int
	mixer controls
Date: Mon, 27 Jan 2014 13:03:07 +0100
Message-ID: <1390824190-18376-4-git-send-email-mpa@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 811D8261B1E
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:03:29 +0100 (CET)
In-Reply-To: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

There are a number of mixer controls that support negative values. They
use signed values for this with different number of bits for the values.
Currently they only support the positive range.

This patch replaces the unsigned mixers with signed mixers to support
the full range.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 36a9cb9..c541213 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -68,18 +68,24 @@ struct aic32x4_priv {
 	int rstn_gpio;
 };
 
-/* 0dB min, 1dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_step_1, 0, 100, 0);
 /* 0dB min, 0.5dB steps */
 static DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);
+/* -63.5dB min, 0.5dB steps */
+static DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
+/* -6dB min, 1dB steps */
+static DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
+/* -12dB min, 0.5dB steps */
+static DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
 
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
-	SOC_DOUBLE_R_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
-			AIC32X4_RDACVOL, 0, 0x30, 0, tlv_step_0_5),
-	SOC_DOUBLE_R_TLV("HP Driver Gain Volume", AIC32X4_HPLGAIN,
-			AIC32X4_HPRGAIN, 0, 0x1D, 0, tlv_step_1),
-	SOC_DOUBLE_R_TLV("LO Driver Gain Volume", AIC32X4_LOLGAIN,
-			AIC32X4_LORGAIN, 0, 0x1D, 0, tlv_step_1),
+	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
+			AIC32X4_RDACVOL, 0, -0x7f, 0x30, 7, 0, tlv_pcm),
+	SOC_DOUBLE_R_S_TLV("HP Driver Gain Volume", AIC32X4_HPLGAIN,
+			AIC32X4_HPRGAIN, 0, -0x6, 0x1d, 5, 0,
+			tlv_driver_gain),
+	SOC_DOUBLE_R_S_TLV("LO Driver Gain Volume", AIC32X4_LOLGAIN,
+			AIC32X4_LORGAIN, 0, -0x6, 0x1d, 5, 0,
+			tlv_driver_gain),
 	SOC_DOUBLE_R("HP DAC Playback Switch", AIC32X4_HPLGAIN,
 			AIC32X4_HPRGAIN, 6, 0x01, 1),
 	SOC_DOUBLE_R("LO DAC Playback Switch", AIC32X4_LOLGAIN,
@@ -90,8 +96,8 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_SINGLE("ADCFGA Left Mute Switch", AIC32X4_ADCFGA, 7, 1, 0),
 	SOC_SINGLE("ADCFGA Right Mute Switch", AIC32X4_ADCFGA, 3, 1, 0),
 
-	SOC_DOUBLE_R_TLV("ADC Level Volume", AIC32X4_LADCVOL,
-			AIC32X4_RADCVOL, 0, 0x28, 0, tlv_step_0_5),
+	SOC_DOUBLE_R_S_TLV("ADC Level Volume", AIC32X4_LADCVOL,
+			AIC32X4_RADCVOL, 0, -0x18, 0x28, 6, 0, tlv_adc_vol),
 	SOC_DOUBLE_R_TLV("PGA Level Volume", AIC32X4_LMICPGAVOL,
 			AIC32X4_RMICPGAVOL, 0, 0x5f, 0, tlv_step_0_5),
 
-- 
1.8.5.2
