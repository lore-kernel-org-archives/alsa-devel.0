From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 11/15] ASoC: twl6040: Clear interrupt status at
	boot time
Date: Mon, 6 Dec 2010 18:18:13 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C9EC1039B0
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:15 +0100 (CET)
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

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

On Phoenix 1.1, the INTID register default value is an invalid
one, causing the interrupt handler to think the phoenix power on
sequence is ready before it actually finishes.

This causes some i2c errors when trying to configure twl.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b2402ae..17a8715 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1627,6 +1627,17 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 			goto gpio2_err;
 
 		priv->codec_powered = 0;
+
+		/* enable only codec ready interrupt */
+		twl6040_write(codec, TWL6040_REG_INTMR,
+					~TWL6040_READYMSK & TWL6040_ALLINT_MSK);
+
+		/* reset interrupt status to allow correct power up sequence */
+		twl6040_read_reg_volatile(codec, TWL6040_REG_INTID);
+	} else {
+		/* no interrupts at all */
+		twl6040_write_reg_cache(codec, TWL6040_REG_INTMR,
+						TWL6040_ALLINT_MSK);
 	}
 
 	if (naudint) {
@@ -1637,16 +1648,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 				"twl6040_codec", codec);
 		if (ret)
 			goto gpio2_err;
-	} else {
-		if (gpio_is_valid(audpwron)) {
-			/* enable only codec ready interrupt */
-			twl6040_write_reg_cache(codec, TWL6040_REG_INTMR,
-					~TWL6040_READYMSK & TWL6040_ALLINT_MSK);
-		} else {
-			/* no interrupts at all */
-			twl6040_write_reg_cache(codec, TWL6040_REG_INTMR,
-						TWL6040_ALLINT_MSK);
-		}
 	}
 
 	/* init vio registers */
-- 
1.7.0.4
