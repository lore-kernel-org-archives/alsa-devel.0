From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Tue,  8 May 2012 15:15:14 +0300
Message-ID: <1336479314-27766-5-git-send-email-peter.ujfalusi@ti.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A0DF104323
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:15:21 +0200 (CEST)
Received: by lbok6 with SMTP id k6so5577803lbo.18
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 05:15:18 -0700 (PDT)
In-Reply-To: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

When the board boots with device tree the driver will receive the name of
the card, DAPM routing map, number of DAI links, the DAI link connections,
mclk speed, and the possibility of detecting the jack detection.

The card will be set up based on this information.
Since the routing is provided via DT we can mark the card fully routed so
core can take care of disconnecting the unused pins.

Example of dts section for audio support:

sound: sound { /* ASoC */
	compatible = "ti,abe-twl6040";
	abe-twl6040,model = "PandaBoard";

	abe-twl6040,jack_detection = <0>;
	abe-twl6040,mclk_freq = <38400000>;

	/* Number of DAI link connections */
	abe-twl6040,number-of-links = <1>;

	dai-link1,codec = <&twl6040_codec>;
	dai-link1,dai = <&mcpdm>;

	/* Audio routing */
	abe-twl6040,audio-routing =
		"Headset Stereophone", "HSOL",
		"Headset Stereophone", "HSOR",
		"Ext Spk", "HFL",
		"Ext Spk", "HFR",
		"Line Out", "AUXL",
		"Line Out", "AUXR",
		"HSMIC", "Headset Mic",
		"Headset Mic", "Headset Mic Bias",
		"AFML", "Line In",
		"AFMR", "Line In";
};

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-abe-twl6040.txt |   57 ++++++++
 sound/soc/omap/omap-abe-twl6040.c                  |  149 ++++++++++++++++----
 2 files changed, 179 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt

diff --git a/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
new file mode 100644
index 0000000..80eddb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-abe-twl6040.txt
@@ -0,0 +1,57 @@
+* Texas Instruments OMAP4+ and twl6040 based audio setups
+
+Required properties:
+- compatible: "ti,abe-twl6040"
+- abe-twl6040,model: Name of the sound card ( for example "SDP4430")
+- abe-twl6040,mclk_freq: MCLK frequency for HPPLL operation
+- abe-twl6040,number-of-links: Number of dai links on the card
+- dai-linkX,codec: phandle for the codec on dai link X (X = 1, 2, ...)
+- dai-linkX,dai: phandle for the CPU dai on dai link X (X = 1, 2, ...)
+- abe-twl6040,audio-routing: List of connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+
+Optional properties:
+- abe-twl6040,jack_detection: Need to be set to <1> if the board capable to
+  detect jack insertion, removal.
+
+Example:
+
+sound { /* ASoC */
+	compatible = "ti,abe-twl6040";
+	abe-twl6040,model = "SDP4430";
+
+	abe-twl6040,jack_detection = <1>;
+	abe-twl6040,mclk_freq = <38400000>;
+
+	/* Number of DAI link connections */
+	abe-twl6040,number-of-links = <2>;
+
+	dai-link1,codec = <&twl6040_codec>;
+	dai-link1,dai = <&mcpdm>;
+
+	dai-link2,codec = <&dmic_codec>;
+	dai-link2,dai = <&dmic>;
+
+	/* Audio routing */
+	abe-twl6040,audio-routing =
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
index 9d93793..f0aeda0 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/twl6040.h>
 #include <linux/platform_data/omap-abe-twl6040.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -185,17 +186,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
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
@@ -216,6 +206,24 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
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
 
@@ -267,9 +275,49 @@ static struct snd_soc_card omap_abe_card = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
+inline const struct device_node *omap_abe_of_get_node(
+	struct snd_soc_card *card, int id, char *component)
+{
+	struct device_node *node;
+	char property[64];
+
+	snprintf(property, sizeof(property), "dai-link%d,%s", id, component);
+
+	node = of_parse_phandle(card->dev->of_node, property, 0);
+	if (!node)
+		dev_err(card->dev, "Invalid property: %s\n", property);
+
+	return node;
+}
+
+static __devinit int omap_abe_of_get_link_config(struct snd_soc_card *card,
+						int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		abe_twl6040_dai_links[i].codec_name = NULL;
+		abe_twl6040_dai_links[i].codec_of_node = omap_abe_of_get_node(
+							card, i + 1, "codec");
+		if (!abe_twl6040_dai_links[i].codec_of_node)
+			return -EINVAL;
+
+		abe_twl6040_dai_links[i].cpu_dai_name = NULL;
+		abe_twl6040_dai_links[i].cpu_dai_of_node = omap_abe_of_get_node(
+							card, i + 1, "dai");
+		if (!abe_twl6040_dai_links[i].cpu_dai_of_node)
+			return -EINVAL;
+
+		if (i)
+			abe_twl6040_dai_links[i].init = NULL;
+	}
+	return 0;
+}
+
 static __devinit int omap_abe_probe(struct platform_device *pdev)
 {
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_abe_card;
 	struct abe_twl6040 *priv;
 	int num_links = 0;
@@ -277,36 +325,76 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 
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
+	if (node) {
+		if (snd_soc_of_parse_card_name(card, "abe-twl6040,model")) {
+			dev_err(&pdev->dev, "Card name is not provided\n");
+			return -ENODEV;
+		}
+
+		ret = snd_soc_of_parse_audio_routing(card,
+						"abe-twl6040,audio-routing");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Error while parsing DAPM routing\n");
+			return -EINVAL;
+		}
+
+		of_property_read_u32(node, "abe-twl6040,number-of-links",
+				     &num_links);
+		if (num_links <= 0 ||
+		    num_links > ARRAY_SIZE(abe_twl6040_dai_links)) {
+			dev_err(&pdev->dev, "Invalid number of links: %d\n",
+				num_links);
+			return -EINVAL;
+		}
+
+		ret = omap_abe_of_get_link_config(card, num_links);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to get link configuration\n");
+			return -EINVAL;
+		}
+
+		of_property_read_u32(node, "abe-twl6040,jack_detection",
+				     &priv->jack_detection);
+		of_property_read_u32(node, "abe-twl6040,mclk_freq",
+				     &priv->mclk_freq);
+		if (!priv->mclk_freq) {
+			dev_err(&pdev->dev, "MCLK frequency not provided\n");
+			return -EINVAL;
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
 		return -ENODEV;
 	}
 
-	if (pdata->has_dmic)
-		num_links = 2;
-	else
-		num_links = 1;
-
 	card->dai_link = abe_twl6040_dai_links;
 	card->num_links = num_links;
 
@@ -329,11 +417,18 @@ static int __devexit omap_abe_remove(struct platform_device *pdev)
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
