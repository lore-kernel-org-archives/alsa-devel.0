From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 02/16] ASoC: twl6040: Modify the IRQ handler
Date: Fri, 10 Dec 2010 21:05:30 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D397F10393F
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:05:33 +0100 (CET)
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
 sound/soc/codecs/twl6040.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d33d2b4..8a6c623 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -441,30 +441,24 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 
 	twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &intid, TWL6040_REG_INTID);
 
-	switch (intid) {
-	case TWL6040_THINT:
+	if (intid & TWL6040_THINT)
 		dev_alert(codec->dev, "die temp over-limit detection\n");
-		break;
-	case TWL6040_PLUGINT:
-	case TWL6040_UNPLUGINT:
+
+	if ((intid & TWL6040_PLUGINT) || (intid & TWL6040_UNPLUGINT))
 		queue_delayed_work(priv->workqueue, &priv->delayed_work,
 							msecs_to_jiffies(200));
-		break;
-	case TWL6040_HOOKINT:
-		break;
-	case TWL6040_HFINT:
+
+	if (intid & TWL6040_HOOKINT)
+		dev_info(codec->dev, "hook detection\n");
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
