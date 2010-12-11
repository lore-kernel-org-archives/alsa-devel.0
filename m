From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 01/16] ASoC: twl6040: Update twl IO macro
Date: Fri, 10 Dec 2010 21:05:24 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B9432465E
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:05:27 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Update the codec to use the new twl core register macros

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 5d7e2f7..d33d2b4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -210,7 +210,7 @@ static int twl6040_read_reg_volatile(struct snd_soc_codec *codec,
 	if (reg >= TWL6040_CACHEREGNUM)
 		return -EIO;
 
-	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &value, reg);
+	twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &value, reg);
 	twl6040_write_reg_cache(codec, reg, value);
 
 	return value;
@@ -226,7 +226,7 @@ static int twl6040_write(struct snd_soc_codec *codec,
 		return -EIO;
 
 	twl6040_write_reg_cache(codec, reg, value);
-	return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
+	return twl_i2c_write_u8(TWL_MODULE_AUDIO_VOICE, value, reg);
 }
 
 static void twl6040_init_vio_regs(struct snd_soc_codec *codec)
@@ -439,7 +439,7 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	u8 intid;
 
-	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid, TWL6040_REG_INTID);
+	twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &intid, TWL6040_REG_INTID);
 
 	switch (intid) {
 	case TWL6040_THINT:
@@ -715,7 +715,7 @@ static int twl6040_power_up_completion(struct snd_soc_codec *codec,
 				msecs_to_jiffies(48));
 
 	if (!time_left) {
-		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid,
+		twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &intid,
 							TWL6040_REG_INTID);
 		if (!(intid & TWL6040_READYINT)) {
 			dev_err(codec->dev, "timeout waiting for READYINT\n");
-- 
1.7.0.4
