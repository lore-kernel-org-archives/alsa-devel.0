From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: No need to read the INTID
	register
Date: Fri, 23 Sep 2011 09:52:02 +0300
Message-ID: <1316760722-27576-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F104103B72
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 08:52:32 +0200 (CEST)
Received: by bkbzt12 with SMTP id zt12so3844815bkb.26
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 23:52:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Since our irq handler has been called, it is granted, that
the reason was either PLUGINT, or UNPLUGINT.
The INTID register has been checked in the MFD part of
twl6040 driver (twl6040-irq.c).
We have no reason to read from chip again here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index f924827..d5c4bb4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -747,15 +747,10 @@ static void twl6040_accessory_work(struct work_struct *work)
 static irqreturn_t twl6040_audio_handler(int irq, void *data)
 {
 	struct snd_soc_codec *codec = data;
-	struct twl6040 *twl6040 = codec->control_data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	u8 intid;
-
-	intid = twl6040_reg_read(twl6040, TWL6040_REG_INTID);
 
-	if ((intid & TWL6040_PLUGINT) || (intid & TWL6040_UNPLUGINT))
-		queue_delayed_work(priv->workqueue, &priv->delayed_work,
-							msecs_to_jiffies(200));
+	queue_delayed_work(priv->workqueue, &priv->delayed_work,
+			   msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
-- 
1.7.6.1
