From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/5] ASoC: twl6040: Do not use wrapper for irq request
Date: Tue, 5 Jul 2011 22:49:34 +0300
Message-ID: <1309895376-17446-4-git-send-email-peter.ujfalusi@ti.com>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: alsa-devel@alsa-project.org

The twl6040_request_irq/free_irq inline functions are going
to be removed, so replace them with direct calls.
The irq number is provided by the core driver via resource.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0145041..14e3a58 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -76,6 +76,7 @@ struct twl6040_jack_data {
 
 /* codec private data */
 struct twl6040_data {
+	int plug_irq;
 	int codec_powered;
 	int pll;
 	int non_lp;
@@ -1527,6 +1528,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
 	struct twl4030_codec_data *pdata = dev_get_platdata(codec->dev);
+	struct platform_device *pdev = container_of(codec->dev,
+						   struct platform_device, dev);
 	int ret = 0;
 
 	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
@@ -1553,6 +1556,13 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		priv->hf_right_step = 1;
 	}
 
+	priv->plug_irq = platform_get_irq(pdev, 0);
+	if (priv->plug_irq < 0) {
+		dev_err(codec->dev, "invalid irq\n");
+		ret = -EINVAL;
+		goto work_err;
+	}
+
 	priv->sysclk_constraints = &hp_constraints;
 	priv->workqueue = create_singlethread_workqueue("twl6040-codec");
 	if (!priv->workqueue) {
@@ -1581,9 +1591,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	INIT_DELAYED_WORK(&priv->hs_delayed_work, twl6040_pga_hs_work);
 	INIT_DELAYED_WORK(&priv->hf_delayed_work, twl6040_pga_hf_work);
 
-	ret = twl6040_request_irq(codec->control_data, TWL6040_IRQ_PLUG,
-				  twl6040_audio_handler, 0,
-				  "twl6040_irq_plug", codec);
+	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
+				   0, "twl6040_irq_plug", codec);
 	if (ret) {
 		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
 		goto plugirq_err;
@@ -1604,7 +1613,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	return 0;
 
 bias_err:
-	twl6040_free_irq(codec->control_data, TWL6040_IRQ_PLUG, codec);
+	free_irq(priv->plug_irq, codec);
 plugirq_err:
 	destroy_workqueue(priv->hs_workqueue);
 hswq_err:
@@ -1621,7 +1630,7 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	twl6040_free_irq(codec->control_data, TWL6040_IRQ_PLUG, codec);
+	free_irq(priv->plug_irq, codec);
 	destroy_workqueue(priv->workqueue);
 	destroy_workqueue(priv->hf_workqueue);
 	destroy_workqueue(priv->hs_workqueue);
-- 
1.7.6
