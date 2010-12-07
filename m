From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 12/15] ASoC: twl6040: Enable plug detection
	interrupts
Date: Mon, 6 Dec 2010 18:18:15 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD2@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id F0E0C1039B5
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:17 +0100 (CET)
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

From: Misael Lopez Cruz <misael.lopez@ti.com>

Enable plug detection interrupt mask in order to get headset
PLUGINT/UNPLUGINT interrupts.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   10 +++-------
 sound/soc/codecs/twl6040.h |    1 +
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 17a8715..bfb8dec 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1589,7 +1589,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	struct twl6040_data *priv;
 	int audpwron, naudint;
 	int ret = 0;
-	u8 icrev;
+	u8 icrev, intmr = TWL6040_ALLINT_MSK;
 
 	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
 	if (priv == NULL)
@@ -1629,16 +1629,12 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		priv->codec_powered = 0;
 
 		/* enable only codec ready interrupt */
-		twl6040_write(codec, TWL6040_REG_INTMR,
-					~TWL6040_READYMSK & TWL6040_ALLINT_MSK);
+		intmr &= ~(TWL6040_READYMSK | TWL6040_PLUGMSK);
 
 		/* reset interrupt status to allow correct power up sequence */
 		twl6040_read_reg_volatile(codec, TWL6040_REG_INTID);
-	} else {
-		/* no interrupts at all */
-		twl6040_write_reg_cache(codec, TWL6040_REG_INTMR,
-						TWL6040_ALLINT_MSK);
 	}
+	twl6040_write(codec, TWL6040_REG_INTMR, intmr);
 
 	if (naudint) {
 		/* audio interrupt */
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index 5456c18..1b48857 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -79,6 +79,7 @@
 
 /* INTMR (0x04) fields */
 
+#define TWL6040_PLUGMSK			0x02
 #define TWL6040_READYMSK		0x40
 #define TWL6040_ALLINT_MSK		0x7B
 
-- 
1.7.0.4
