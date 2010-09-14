From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] ASoC: tlv320aic3x: Complete the soc-cache
	conversion
Date: Tue, 14 Sep 2010 14:54:49 +0300
Message-ID: <1284465289-4865-3-git-send-email-jhnikula@gmail.com>
References: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D3DEC103882
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 13:55:09 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so3012819ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 04:55:09 -0700 (PDT)
In-Reply-To: <1284465289-4865-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Complete the phasing out of aic3x_read_reg_cache, aic3x_write_reg_cache,
aic3x_read and aic3x_write calls.

This patch replaces the aic3x_read with codec->hw_read that points to a
function implemented by soc-cache. There is no need to cache the value from
chip since the functions using aic3x_read are interested only read-only
bits.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   32 +++-----------------------------
 1 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 86e5a58..9737afa 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -111,32 +111,6 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 	0x00, 0x00, 0x02,	/* 100 */
 };
 
-/*
- * write aic3x register cache
- */
-static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
-					 u8 reg, u8 value)
-{
-	u8 *cache = codec->reg_cache;
-	if (reg >= AIC3X_CACHEREGNUM)
-		return;
-	cache[reg] = value;
-}
-
-/*
- * read from the aic3x register space
- */
-static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
-		      u8 *value)
-{
-	*value = reg & 0xff;
-
-	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
-
-	aic3x_write_reg_cache(codec, reg, *value);
-	return 0;
-}
-
 #define SOC_DAPM_SINGLE_AIC3X(xname, reg, shift, mask, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -1076,7 +1050,7 @@ int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
 	u8 reg = gpio ? AIC3X_GPIO2_REG : AIC3X_GPIO1_REG;
 	u8 val, bit = gpio ? 2: 1;
 
-	aic3x_read(codec, reg, &val);
+	val = codec->hw_read(codec, reg);
 	return (val >> bit) & 1;
 }
 EXPORT_SYMBOL_GPL(aic3x_get_gpio);
@@ -1103,7 +1077,7 @@ EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
 int aic3x_headset_detected(struct snd_soc_codec *codec)
 {
 	u8 val;
-	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	val = codec->hw_read(codec, AIC3X_HEADSET_DETECT_CTRL_B);
 	return (val >> 4) & 1;
 }
 EXPORT_SYMBOL_GPL(aic3x_headset_detected);
@@ -1111,7 +1085,7 @@ EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 int aic3x_button_pressed(struct snd_soc_codec *codec)
 {
 	u8 val;
-	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	val = codec->hw_read(codec, AIC3X_HEADSET_DETECT_CTRL_B);
 	return (val >> 5) & 1;
 }
 EXPORT_SYMBOL_GPL(aic3x_button_pressed);
-- 
1.7.1
