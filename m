From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/5] ASoC: twl6040: Switch to use system
	workqueue for jack reporting
Date: Fri, 11 Jan 2013 17:01:02 +0100
Message-ID: <1357920063-15141-5-git-send-email-peter.ujfalusi@ti.com>
References: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id CAEE926501D
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:11 +0100 (CET)
In-Reply-To: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's no need to create a queue for this anymore

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 90b721e..984911b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -75,7 +75,6 @@ struct twl6040_data {
 	u16 hf_right_step;
 	struct twl6040_jack_data hs_jack;
 	struct snd_soc_codec *codec;
-	struct workqueue_struct *workqueue;
 	struct mutex mutex;
 };
 
@@ -404,8 +403,7 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 	struct snd_soc_codec *codec = data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	queue_delayed_work(priv->workqueue, &priv->hs_jack.work,
-			   msecs_to_jiffies(200));
+	schedule_delayed_work(&priv->hs_jack.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
@@ -1162,10 +1160,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	priv->workqueue = alloc_workqueue("twl6040-codec", 0, 0);
-	if (!priv->workqueue)
-		return -ENOMEM;
-
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
 
 	mutex_init(&priv->mutex);
@@ -1175,27 +1169,18 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 					"twl6040_irq_plug", codec);
 	if (ret) {
 		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	twl6040_init_chip(codec);
 
 	/* power on device */
-	ret = twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (!ret)
-		return 0;
-
-err:
-	destroy_workqueue(priv->workqueue);
-	return ret;
+	return twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 }
 
 static int twl6040_remove(struct snd_soc_codec *codec)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	destroy_workqueue(priv->workqueue);
 
 	return 0;
 }
-- 
1.8.1
