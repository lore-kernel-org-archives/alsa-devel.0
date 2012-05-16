From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Wed, 16 May 2012 14:57:05 +0300
Message-ID: <1337169425-9449-5-git-send-email-peter.ujfalusi@ti.com>
References: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F6C310442B
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2012 13:57:30 +0200 (CEST)
Received: by lbon10 with SMTP id n10so827744lbo.27
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2012 04:57:27 -0700 (PDT)
In-Reply-To: <1337169425-9449-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

When the board boots with device tree the driver will receive the name of the
card, DAPM routing map, phandle for the audio components described in the dts
file, mclk speed, and the possibility of detecting the jack detection.

The card will be set up based on this information.
Since the routing is provided via DT we can mark the card fully routed so
core can take care of disconnecting the unused pins.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-abe-twl6040.txt |   91 ++++++++++++
 sound/soc/omap/omap-abe-twl6040.c                  |  145 ++++++++++++++++----
 2 files changed, 206 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
new file mode 100644
index 0000000..65dec87
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
@@ -0,0 +1,91 @@
+* Texas Instruments OMAP4+ and twl6040 based audio setups
+
+Required properties:
+- compatible: "ti,abe-twl6040"
+- ti,model: Name of the sound card ( for example "SDP4430")
+- ti,mclk-freq: MCLK frequency for HPPLL operation
+- ti,mcpdm: phandle for the McPDM node
+- ti,twl6040: phandle for the twl6040 core node
+- ti,audio-routing: List of connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+
+Optional properties:
+- ti,dmic: phandle for the OMAP dmic node if the machine have it connected
+- ti,jack_detection: Need to be set to <1> if the board capable to detect jack
+  insertion, removal.
+
+Available audio endpoints for the audio-routing table:
+
+Board connectors:
+ * Headset Stereophone
+ * Earphone Spk
+ * Ext Spk
+ * Line Out
+ * Vibrator
+ * Headset Mic
+ * Main Handset Mic
+ * Sub Handset Mic
+ * Line In
+ * Digital Mic
+
+twl6040 pins:
+ * HSOL
+ * HSOR
+ * EP
+ * HFL
+ * HFR
+ * AUXL
+ * AUXR
+ * VIBRAL
+ * VIBRAR
+ * HSMIC
+ * MAINMIC
+ * SUBMIC
+ * AFML
+ * AFMR
+
+ * Headset Mic Bias
+ * Main Mic Bias
+ * Digital Mic1 Bias
+ * Digital Mic2 Bias
+
+Digital mic pins:
+ * DMic
+
+Example:
+
+sound {
+	compatible = "ti,abe-twl6040";
+	ti,model = "SDP4430";
+
+	ti,jack-detection = <1>;
+	ti,mclk-freq = <38400000>;
+
+	ti,mcpdm = <&mcpdm>;
+	ti,dmic = <&dmic>;
+
+	ti,twl6040 = <&twl6040>;
+
+	/* Audio routing */
+	ti,audio-routing =
+		"Headset Stereophone", "HSOL",
+		"Headset Stereophone", "HSOR",
+		"Earphone Spk", "EP",
+		"Ext Spk", "HFL",
+		"Ext Spk", "HFR",
+		"Line Out", "AUXL",
+		"Line Out", "AUXR",
+		"Vibrator", "VIBRAL",
+		"Vibrator", "VIBRAR",
+		"HSMIC", "Headset Mic",
+		"Headset Mic", "Headset Mic Bias",
+		"MAINMIC", "Main Handset Mic",
+		"Main Handset Mic", "Main Mic Bias",
+		"SUBMIC", "Sub Handset Mic",
+		"Sub Handset Mic", "Main Mic Bias",
+		"AFML", "Line In",
+		"AFMR", "Line In",
+		"DMic", "Digital Mic",
+		"Digital Mic", "Digital Mic1 Bias";
+};
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 9d93793..1995a7f 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/twl6040.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -43,6 +44,8 @@
 struct abe_twl6040 {
 	int	jack_detection;	/* board can detect jack events */
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
+
+	struct platform_device *dmic_codec_dev;
 };
 
 static int omap_abe_hw_params(struct snd_pcm_substream *substream,
@@ -185,17 +188,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	int hs_trim;
 	int ret = 0;
 
-	/* Disable not connected paths if not used */
-	twl6040_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
-	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
-	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
-	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
-	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vinrator");
-	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_afm, "Line In");
-
 	/*
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
 	 * twl6040.
@@ -216,6 +208,24 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
 	}
 
+	/*
+	 * NULL pdata means we booted with DT. In this case the routing is
+	 * provided and the card is fully routed, no need to mark pins.
+	 */
+	if (!pdata)
+		return ret;
+
+	/* Disable not connected paths if not used */
+	twl6040_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
+	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
+	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
+	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vinrator");
+	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
+	twl6040_disconnect_pin(dapm, pdata->has_afm, "Line In");
+
 	return ret;
 }
 
@@ -270,52 +280,116 @@ static struct snd_soc_card omap_abe_card = {
 static __devinit int omap_abe_probe(struct platform_device *pdev)
 {
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_abe_card;
 	struct abe_twl6040 *priv;
 	int num_links = 0;
-	int ret;
+	int ret = 0;
 
 	card->dev = &pdev->dev;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "Missing pdata\n");
-		return -ENODEV;
-	}
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct abe_twl6040), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	if (pdata->card_name) {
-		card->name = pdata->card_name;
+	priv->dmic_codec_dev = ERR_PTR(-EINVAL);
+
+	if (node) {
+		struct device_node *dai_node;
+
+		if (snd_soc_of_parse_card_name(card, "ti,model")) {
+			dev_err(&pdev->dev, "Card name is not provided\n");
+			return -ENODEV;
+		}
+
+		ret = snd_soc_of_parse_audio_routing(card,
+						"ti,audio-routing");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Error while parsing DAPM routing\n");
+			return -EINVAL;
+		}
+
+		dai_node = of_parse_phandle(node, "ti,mcpdm", 0);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "McPDM node is not provided\n");
+			return -EINVAL;
+		}
+		abe_twl6040_dai_links[0].cpu_dai_name  = NULL;
+		abe_twl6040_dai_links[0].cpu_dai_of_node = dai_node;
+
+		dai_node = of_parse_phandle(node, "ti,dmic", 0);
+		if (dai_node) {
+			num_links = 2;
+			abe_twl6040_dai_links[1].cpu_dai_name  = NULL;
+			abe_twl6040_dai_links[1].cpu_dai_of_node = dai_node;
+
+			priv->dmic_codec_dev = platform_device_register_simple(
+						"dmic-codec", -1, NULL, 0);
+			if (IS_ERR(priv->dmic_codec_dev)) {
+				dev_err(&pdev->dev,
+					"Can't instantiate dmic-codec\n");
+				return PTR_ERR(priv->dmic_codec_dev);
+			}
+		} else {
+			num_links = 1;
+		}
+
+		of_property_read_u32(node, "ti,jack-detection",
+				     &priv->jack_detection);
+		of_property_read_u32(node, "ti,mclk-freq",
+				     &priv->mclk_freq);
+		if (!priv->mclk_freq) {
+			dev_err(&pdev->dev, "MCLK frequency not provided\n");
+			ret = -EINVAL;
+			goto err_unregister;
+		}
+
+		omap_abe_card.fully_routed = 1;
+	} else if (pdata) {
+		if (pdata->card_name) {
+			card->name = pdata->card_name;
+		} else {
+			dev_err(&pdev->dev, "Card name is not provided\n");
+			return -ENODEV;
+		}
+
+		if (pdata->has_dmic)
+			num_links = 2;
+		else
+			num_links = 1;
+
+		priv->jack_detection = pdata->jack_detection;
+		priv->mclk_freq = pdata->mclk_freq;
 	} else {
-		dev_err(&pdev->dev, "Card name is not provided\n");
+		dev_err(&pdev->dev, "Missing pdata\n");
 		return -ENODEV;
 	}
 
-	priv->jack_detection = pdata->jack_detection;
-	priv->mclk_freq = pdata->mclk_freq;
-
 
 	if (!priv->mclk_freq) {
 		dev_err(&pdev->dev, "MCLK frequency missing\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_unregister;
 	}
 
-	if (pdata->has_dmic)
-		num_links = 2;
-	else
-		num_links = 1;
-
 	card->dai_link = abe_twl6040_dai_links;
 	card->num_links = num_links;
 
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
+		goto err_unregister;
+	}
+
+	return 0;
+
+err_unregister:
+	if (!IS_ERR(priv->dmic_codec_dev))
+		platform_device_unregister(priv->dmic_codec_dev);
 
 	return ret;
 }
@@ -323,17 +397,28 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 static int __devexit omap_abe_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
 
+	if (!IS_ERR(priv->dmic_codec_dev))
+		platform_device_unregister(priv->dmic_codec_dev);
+
 	return 0;
 }
 
+static const struct of_device_id omap_abe_of_match[] = {
+	{.compatible = "ti,abe-twl6040", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap_abe_of_match);
+
 static struct platform_driver omap_abe_driver = {
 	.driver = {
 		.name = "omap-abe-twl6040",
 		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
+		.of_match_table = omap_abe_of_match,
 	},
 	.probe = omap_abe_probe,
 	.remove = __devexit_p(omap_abe_remove),
-- 
1.7.8.6
