From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] sound: soc: tlv320aic3x: remove unused code
Date: Wed,  1 Feb 2012 03:06:20 +0200
Message-ID: <1328058380-29360-3-git-send-email-felipe.contreras@gmail.com>
References: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A121038DE
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 02:07:07 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id s15so378662lag.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 17:07:07 -0800 (PST)
In-Reply-To: <1328058380-29360-1-git-send-email-felipe.contreras@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Felipe Contreras <felipe.contreras@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Looks like nobody is or will be using this code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   36 ------------------------------------
 sound/soc/codecs/tlv320aic3x.h |    9 ---------
 2 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 00eb29d..4dd10e2 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1185,25 +1185,6 @@ static int aic3x_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state)
-{
-	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
-	u8 bit = gpio ? 3: 0;
-	u8 val = snd_soc_read(codec, reg) & ~(1 << bit);
-	snd_soc_write(codec, reg, val | (!!state << bit));
-}
-EXPORT_SYMBOL_GPL(aic3x_set_gpio);
-
-int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
-{
-	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
-	u8 val = 0, bit = gpio ? 2 : 1;
-
-	aic3x_read(codec, reg, &val);
-	return (val >> bit) & 1;
-}
-EXPORT_SYMBOL_GPL(aic3x_get_gpio);
-
 void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
 				 int headset_debounce, int button_debounce)
 {
@@ -1221,23 +1202,6 @@ void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
 
 	snd_soc_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, val);
 }
-EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
-
-int aic3x_headset_detected(struct snd_soc_codec *codec)
-{
-	u8 val = 0;
-	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
-	return (val >> 4) & 1;
-}
-EXPORT_SYMBOL_GPL(aic3x_headset_detected);
-
-int aic3x_button_pressed(struct snd_soc_codec *codec)
-{
-	u8 val = 0;
-	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
-	return (val >> 5) & 1;
-}
-EXPORT_SYMBOL_GPL(aic3x_button_pressed);
 
 #define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 06a1978..6f097fb 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -212,9 +212,6 @@
 /* Default input volume */
 #define DEFAULT_GAIN    0x20
 
-void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
-int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
-
 /* headset detection / button API */
 
 /* The AIC3x supports detection of stereo headsets (GND + left + right signal)
@@ -252,10 +249,4 @@ enum {
 #define AIC3X_BUTTON_DEBOUNCE_SHIFT 	0
 #define AIC3X_BUTTON_DEBOUNCE_MASK	3
 
-/* see the enums above for valid parameters to this function */
-void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
-				 int headset_debounce, int button_debounce);
-int aic3x_headset_detected(struct snd_soc_codec *codec);
-int aic3x_button_pressed(struct snd_soc_codec *codec);
-
 #endif /* _AIC3X_H */
-- 
1.7.9
