From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 09/15] ASoC: twl6040: Enable automatic power
	for phoenix 1.1
Date: Mon, 6 Dec 2010 18:18:07 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCCF@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 478171039A3
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:10 +0100 (CET)
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

Phoenix 1.1 supports automatic power on sequence, a
verification is added to use it with new revision of
the chip.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d92fb6d..0079e12 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1101,19 +1101,24 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	struct twl6040_data *priv;
 	int audpwron, naudint;
 	int ret = 0;
+	u8 icrev;
 
 	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, priv);
 
-	if (twl_codec) {
+	twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &icrev, TWL6040_REG_ASICREV);
+
+	if (twl_codec && (icrev > 0))
 		audpwron = twl_codec->audpwron_gpio;
-		naudint = twl_codec->naudint_irq;
-	} else {
+	else
 		audpwron = -EINVAL;
+
+	if (twl_codec)
+		naudint = twl_codec->naudint_irq;
+	else
 		naudint = 0;
-	}
 
 	priv->audpwron = audpwron;
 	priv->naudint = naudint;
-- 
1.7.0.4
