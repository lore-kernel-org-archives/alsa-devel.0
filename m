From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 02/15] ASoC: twl6040: Modify the IRQ handler
Date: Mon, 6 Dec 2010 18:17:44 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D3A1E10397D
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:17:46 +0100 (CET)
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

Multiples interrupts can be received. The irq handler is modified
to attend all of them.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 59018b3..e908146 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -398,27 +398,23 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 
 	twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &intid, TWL6040_REG_INTID);
 
-	switch (intid) {
-	case TWL6040_THINT:
+	if (intid & TWL6040_THINT)
 		dev_alert(codec->dev, "die temp over-limit detection\n");
-		break;
-	case TWL6040_PLUGINT:
-	case TWL6040_UNPLUGINT:
-	case TWL6040_HOOKINT:
-		break;
-	case TWL6040_HFINT:
+
+	if (intid & TWL6040_PLUGINT)
+		dev_alert(codec->dev, "headset plug detection\n");
+
+	if (intid & TWL6040_UNPLUGINT)
+		dev_alert(codec->dev, "headset unplug detection\n");
+
+	if (intid & TWL6040_HFINT)
 		dev_alert(codec->dev, "hf drivers over current detection\n");
-		break;
-	case TWL6040_VIBINT:
+
+	if (intid & TWL6040_VIBINT)
 		dev_alert(codec->dev, "vib drivers over current detection\n");
-		break;
-	case TWL6040_READYINT:
+
+	if (intid & TWL6040_READYINT)
 		complete(&priv->ready);
-		break;
-	default:
-		dev_err(codec->dev, "unknown audio interrupt %d\n", intid);
-		break;
-	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.4
