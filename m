From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/5] ASoC: twl6040: Convert to use devm_*
	when possible
Date: Fri, 11 Jan 2013 17:01:01 +0100
Message-ID: <1357920063-15141-4-git-send-email-peter.ujfalusi@ti.com>
References: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B576E26501C
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:10 +0100 (CET)
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

In this way we can clean up the probe and remove paths

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 86f12a4..90b721e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1131,9 +1131,10 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 						   struct platform_device, dev);
 	int ret = 0;
 
-	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
+	priv = devm_kzalloc(codec->dev, sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
+
 	snd_soc_codec_set_drvdata(codec, priv);
 
 	priv->codec = codec;
@@ -1158,25 +1159,23 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
 		dev_err(codec->dev, "invalid irq\n");
-		ret = -EINVAL;
-		goto work_err;
+		return -EINVAL;
 	}
 
 	priv->workqueue = alloc_workqueue("twl6040-codec", 0, 0);
-	if (!priv->workqueue) {
-		ret = -ENOMEM;
-		goto work_err;
-	}
+	if (!priv->workqueue)
+		return -ENOMEM;
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
 
 	mutex_init(&priv->mutex);
 
-	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
-				   IRQF_NO_SUSPEND, "twl6040_irq_plug", codec);
+	ret = devm_request_threaded_irq(codec->dev, priv->plug_irq, NULL,
+					twl6040_audio_handler, IRQF_NO_SUSPEND,
+					"twl6040_irq_plug", codec);
 	if (ret) {
 		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
-		goto plugirq_err;
+		goto err;
 	}
 
 	twl6040_init_chip(codec);
@@ -1186,12 +1185,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	if (!ret)
 		return 0;
 
-	/* Error path */
-	free_irq(priv->plug_irq, codec);
-plugirq_err:
+err:
 	destroy_workqueue(priv->workqueue);
-work_err:
-	kfree(priv);
 	return ret;
 }
 
@@ -1200,9 +1195,7 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	free_irq(priv->plug_irq, codec);
 	destroy_workqueue(priv->workqueue);
-	kfree(priv);
 
 	return 0;
 }
-- 
1.8.1
