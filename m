From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] ASoC: Fix mic bias handling in TI tlv320aic32x
	codec.
Date: Thu,  5 Jan 2012 16:05:04 +0100
Message-ID: <1325775904-22177-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 55E9224484
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 16:05:11 +0100 (CET)
Received: by werb12 with SMTP id b12so464744wer.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 07:05:11 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

tlv320aic32x doesn't have a dedicated MIC input, it
has a MICBIAS pin instead, which is used to provide
power to an external microphone.

This means one can enable this MICBIAS pin for any input
configuration of INX_L and INX_R.

For this reason it's not possible to add this as
a DAPM event since we lack the possibility to associate
it to a DAPM route. So we use platform data totell the
device whether we are connecting a microphone or not.
---
 sound/soc/codecs/tlv320aic32x4.c |    6 +++---
 sound/soc/codecs/tlv320aic32x4.h |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e93b9d1..f260e60 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -208,7 +208,6 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 			   ARRAY_SIZE(right_input_mixer_controls)),
 	SND_SOC_DAPM_ADC("Left ADC", "Left Capture", AIC32X4_ADCSETUP, 7, 0),
 	SND_SOC_DAPM_ADC("Right ADC", "Right Capture", AIC32X4_ADCSETUP, 6, 0),
-	SND_SOC_DAPM_MICBIAS("Mic Bias", AIC32X4_MICBIAS, 6, 0),
 
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
@@ -659,8 +658,9 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 
 	/* Power platform configuration */
 	if (aic32x4->power_cfg & AIC32X4_PWR_MICBIAS_2075_LDOIN) {
-		snd_soc_write(codec, AIC32X4_MICBIAS, AIC32X4_MICBIAS_LDOIN |
-						      AIC32X4_MICBIAS_2075V);
+		snd_soc_write(codec, AIC32X4_MICBIAS,
+				AIC32X4_MICBIAS_ON | AIC32X4_MICBIAS_LDOIN |
+				AIC32X4_MICBIAS_2075V);
 	}
 	if (aic32x4->power_cfg & AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE) {
 		snd_soc_write(codec, AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE);
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index aae2b24..7b9ed7e 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -113,6 +113,7 @@
 
 #define AIC32X4_PLLCLKIN		0x03
 
+#define AIC32X4_MICBIAS_ON		0x40
 #define AIC32X4_MICBIAS_LDOIN		0x08
 #define AIC32X4_MICBIAS_2075V		0x60
 
-- 
1.7.0.4
