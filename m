From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 4.8] ASoC: omap-abe-twl6040: Correct
	dmic-codec device registration
Date: Fri, 19 Aug 2016 09:34:24 +0300
Message-ID: <20160819063424.16383-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 829B8265834
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 08:34:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The dmic-codec was registered within the platform_driver's probe function,
which can cause deferred probe to run in loops as reported and analyzed by
Russell King.

Use module_init/exit in the driver and handle the dmic-codec device
registration and removal at that level instead of the platform_driver
probe/remove.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Russell King <linux@arm.linux.org.uk>
---
 sound/soc/omap/omap-abe-twl6040.c | 61 ++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 0843a68f277c..f61b3b58083b 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -38,10 +38,10 @@
 struct abe_twl6040 {
 	int	jack_detection;	/* board can detect jack events */
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
-
-	struct platform_device *dmic_codec_dev;
 };
 
+struct platform_device *dmic_codec_dev;
+
 static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -258,8 +258,6 @@ static int omap_abe_probe(struct platform_device *pdev)
 	if (priv == NULL)
 		return -ENOMEM;
 
-	priv->dmic_codec_dev = ERR_PTR(-EINVAL);
-
 	if (snd_soc_of_parse_card_name(card, "ti,model")) {
 		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
@@ -284,13 +282,6 @@ static int omap_abe_probe(struct platform_device *pdev)
 		num_links = 2;
 		abe_twl6040_dai_links[1].cpu_of_node = dai_node;
 		abe_twl6040_dai_links[1].platform_of_node = dai_node;
-
-		priv->dmic_codec_dev = platform_device_register_simple(
-						"dmic-codec", -1, NULL, 0);
-		if (IS_ERR(priv->dmic_codec_dev)) {
-			dev_err(&pdev->dev, "Can't instantiate dmic-codec\n");
-			return PTR_ERR(priv->dmic_codec_dev);
-		}
 	} else {
 		num_links = 1;
 	}
@@ -299,16 +290,14 @@ static int omap_abe_probe(struct platform_device *pdev)
 	of_property_read_u32(node, "ti,mclk-freq", &priv->mclk_freq);
 	if (!priv->mclk_freq) {
 		dev_err(&pdev->dev, "MCLK frequency not provided\n");
-		ret = -EINVAL;
-		goto err_unregister;
+		return -EINVAL;
 	}
 
 	card->fully_routed = 1;
 
 	if (!priv->mclk_freq) {
 		dev_err(&pdev->dev, "MCLK frequency missing\n");
-		ret = -ENODEV;
-		goto err_unregister;
+		return -ENODEV;
 	}
 
 	card->dai_link = abe_twl6040_dai_links;
@@ -317,17 +306,9 @@ static int omap_abe_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_register_card(card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
-		goto err_unregister;
-	}
-
-	return 0;
-
-err_unregister:
-	if (!IS_ERR(priv->dmic_codec_dev))
-		platform_device_unregister(priv->dmic_codec_dev);
 
 	return ret;
 }
@@ -335,13 +316,9 @@ err_unregister:
 static int omap_abe_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
 
-	if (!IS_ERR(priv->dmic_codec_dev))
-		platform_device_unregister(priv->dmic_codec_dev);
-
 	return 0;
 }
 
@@ -361,7 +338,33 @@ static struct platform_driver omap_abe_driver = {
 	.remove = omap_abe_remove,
 };
 
-module_platform_driver(omap_abe_driver);
+static int __init omap_abe_init(void)
+{
+	int ret;
+
+	dmic_codec_dev = platform_device_register_simple("dmic-codec", -1, NULL,
+							 0);
+	if (IS_ERR(dmic_codec_dev)) {
+		pr_err("%s: dmic-codec device registration failed\n", __func__);
+		return PTR_ERR(dmic_codec_dev);
+	}
+
+	ret = platform_driver_register(&omap_abe_driver);
+	if (ret) {
+		pr_err("%s: platform driver registration failed\n", __func__);
+		platform_device_unregister(dmic_codec_dev);
+	}
+
+	return ret;
+}
+module_init(omap_abe_init);
+
+static void __exit omap_abe_exit(void)
+{
+	platform_driver_unregister(&omap_abe_driver);
+	platform_device_unregister(dmic_codec_dev);
+}
+module_exit(omap_abe_exit);
 
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC for OMAP boards with ABE and twl6040 codec");
-- 
2.9.2
