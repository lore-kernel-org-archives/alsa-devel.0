From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-abe-twl6040: Fix missing audio card
	caused by deferred probing
Date: Wed, 14 Nov 2018 14:58:20 +0200
Message-ID: <20181114125820.7424-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by alsa0.perex.cz (Postfix) with ESMTP id E17002677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 13:57:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The machine driver fails to probe in next-20181113 with:

[    2.539093] omap-abe-twl6040 sound: ASoC: CODEC DAI twl6040-legacy not registered
[    2.546630] omap-abe-twl6040 sound: devm_snd_soc_register_card() failed: -517
...
[    3.693206] omap-abe-twl6040 sound: ASoC: Both platform name/of_node are set for TWL6040
[    3.701446] omap-abe-twl6040 sound: ASoC: failed to init link TWL6040
[    3.708007] omap-abe-twl6040 sound: devm_snd_soc_register_card() failed: -22
[    3.715148] omap-abe-twl6040: probe of sound failed with error -22

Bisect pointed to a merge commit:
first bad commit: [0f688ab20a540aafa984c5dbd68a71debebf4d7f] Merge remote-tracking branch 'net-next/master'

and a diff between a working kernel does not reveal anything which would
explain the change in behavior.

Further investigation showed that on the second try of loading fails
because the dai_link->platform is no longer NULL and it might be pointing
to uninitialized memory.

The fix is to move the snd_soc_dai_link and snd_soc_card inside of the
abe_twl6040 struct, which is dynamically allocated every time the driver
probes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c | 67 +++++++++++++------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index d5ae9eb8c756..fed45b41f9d3 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -36,6 +36,8 @@
 #include "../codecs/twl6040.h"
 
 struct abe_twl6040 {
+	struct snd_soc_card card;
+	struct snd_soc_dai_link dai_links[2];
 	int	jack_detection;	/* board can detect jack events */
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
 };
@@ -208,40 +210,10 @@ static int omap_abe_dmic_init(struct snd_soc_pcm_runtime *rtd)
 				ARRAY_SIZE(dmic_audio_map));
 }
 
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link abe_twl6040_dai_links[] = {
-	{
-		.name = "TWL6040",
-		.stream_name = "TWL6040",
-		.codec_dai_name = "twl6040-legacy",
-		.codec_name = "twl6040-codec",
-		.init = omap_abe_twl6040_init,
-		.ops = &omap_abe_ops,
-	},
-	{
-		.name = "DMIC",
-		.stream_name = "DMIC Capture",
-		.codec_dai_name = "dmic-hifi",
-		.codec_name = "dmic-codec",
-		.init = omap_abe_dmic_init,
-		.ops = &omap_abe_dmic_ops,
-	},
-};
-
-/* Audio machine driver */
-static struct snd_soc_card omap_abe_card = {
-	.owner = THIS_MODULE,
-
-	.dapm_widgets = twl6040_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
-};
-
 static int omap_abe_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct snd_soc_card *card = &omap_abe_card;
+	struct snd_soc_card *card;
 	struct device_node *dai_node;
 	struct abe_twl6040 *priv;
 	int num_links = 0;
@@ -252,12 +224,18 @@ static int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	card->dev = &pdev->dev;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct abe_twl6040), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
+	card = &priv->card;
+	card->dev = &pdev->dev;
+	card->owner = THIS_MODULE;
+	card->dapm_widgets = twl6040_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(twl6040_dapm_widgets);
+	card->dapm_routes = audio_map;
+	card->num_dapm_routes = ARRAY_SIZE(audio_map);
+
 	if (snd_soc_of_parse_card_name(card, "ti,model")) {
 		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
@@ -274,14 +252,27 @@ static int omap_abe_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "McPDM node is not provided\n");
 		return -EINVAL;
 	}
-	abe_twl6040_dai_links[0].cpu_of_node = dai_node;
-	abe_twl6040_dai_links[0].platform_of_node = dai_node;
+
+	priv->dai_links[0].name = "DMIC";
+	priv->dai_links[0].stream_name = "TWL6040";
+	priv->dai_links[0].cpu_of_node = dai_node;
+	priv->dai_links[0].platform_of_node = dai_node;
+	priv->dai_links[0].codec_dai_name = "twl6040-legacy";
+	priv->dai_links[0].codec_name = "twl6040-codec";
+	priv->dai_links[0].init = omap_abe_twl6040_init;
+	priv->dai_links[0].ops = &omap_abe_ops;
 
 	dai_node = of_parse_phandle(node, "ti,dmic", 0);
 	if (dai_node) {
 		num_links = 2;
-		abe_twl6040_dai_links[1].cpu_of_node = dai_node;
-		abe_twl6040_dai_links[1].platform_of_node = dai_node;
+		priv->dai_links[1].name = "TWL6040";
+		priv->dai_links[1].stream_name = "DMIC Capture";
+		priv->dai_links[1].cpu_of_node = dai_node;
+		priv->dai_links[1].platform_of_node = dai_node;
+		priv->dai_links[1].codec_dai_name = "dmic-hifi";
+		priv->dai_links[1].codec_name = "dmic-codec";
+		priv->dai_links[1].init = omap_abe_dmic_init;
+		priv->dai_links[1].ops = &omap_abe_dmic_ops;
 	} else {
 		num_links = 1;
 	}
@@ -300,7 +291,7 @@ static int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	card->dai_link = abe_twl6040_dai_links;
+	card->dai_link = priv->dai_links;
 	card->num_links = num_links;
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
