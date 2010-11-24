From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x - fix variable may be used uninitialized
 warning
Date: Wed, 24 Nov 2010 22:40:59 +0800
Message-ID: <1290609659.2749.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, vbarinov@embeddedalley.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If aic3x_read failed , val is used uninitialized.
Fix it by initializing val to 0.

This patch fixes below compile warning:
sound/soc/codecs/tlv320aic3x.c: In function 'aic3x_get_gpio':
sound/soc/codecs/tlv320aic3x.c:1183: warning: 'val' may be used uninitialized in this function
sound/soc/codecs/tlv320aic3x.c: In function 'aic3x_headset_detected':
sound/soc/codecs/tlv320aic3x.c:1211: warning: 'val' may be used uninitialized in this function
sound/soc/codecs/tlv320aic3x.c: In function 'aic3x_button_pressed':
sound/soc/codecs/tlv320aic3x.c:1219: warning: 'val' may be used uninitialized in this function

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index bfd036a..9de7c38 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1180,7 +1180,7 @@ EXPORT_SYMBOL_GPL(aic3x_set_gpio);
 int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
 {
 	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
-	u8 val, bit = gpio ? 2: 1;
+	u8 val = 0, bit = gpio ? 2 : 1;
 
 	aic3x_read(codec, reg, &val);
 	return (val >> bit) & 1;
@@ -1208,7 +1208,7 @@ EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
 
 int aic3x_headset_detected(struct snd_soc_codec *codec)
 {
-	u8 val;
+	u8 val = 0;
 	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
 	return (val >> 4) & 1;
 }
@@ -1216,7 +1216,7 @@ EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 
 int aic3x_button_pressed(struct snd_soc_codec *codec)
 {
-	u8 val;
+	u8 val = 0;
 	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
 	return (val >> 5) & 1;
 }
-- 
1.7.2
