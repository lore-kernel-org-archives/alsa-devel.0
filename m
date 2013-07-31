From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ASoC: omap-abe-twl6040: Remove support for
	pdata (legacy boot)
Date: Wed, 31 Jul 2013 19:00:32 +0200
Message-ID: <1375290032-21708-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AEAF265510
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 19:00:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Just recently OMAP4 legacy boot support has been removed. No reason to keep
the code used by the legacy boot (pdata based) since neither OMAP4 or OMAP5
can boot in this mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

Changes since v1:
- Remove the header file which is no longer in use.

Regards,
Peter

 include/linux/platform_data/omap-abe-twl6040.h |  49 ---------
 sound/soc/omap/omap-abe-twl6040.c              | 133 ++++++++-----------------
 2 files changed, 41 insertions(+), 141 deletions(-)
 delete mode 100644 include/linux/platform_data/omap-abe-twl6040.h

diff --git a/include/linux/platform_data/omap-abe-twl6040.h b/include/linux/platform_data/omap-abe-twl6040.h
deleted file mode 100644
index 5d298ac..0000000
--- a/include/linux/platform_data/omap-abe-twl6040.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/**
- * omap-abe-twl6040.h - ASoC machine driver OMAP4+ devices, header.
- *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
- * All rights reserved.
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- */
-
-#ifndef _OMAP_ABE_TWL6040_H_
-#define _OMAP_ABE_TWL6040_H_
-
-/* To select if only one channel is connected in a stereo port */
-#define ABE_TWL6040_LEFT	(1 << 0)
-#define ABE_TWL6040_RIGHT	(1 << 1)
-
-struct omap_abe_twl6040_data {
-	char *card_name;
-	/* Feature flags for connected audio pins */
-	u8	has_hs;
-	u8	has_hf;
-	bool	has_ep;
-	u8	has_aux;
-	u8	has_vibra;
-	bool	has_dmic;
-	bool	has_hsmic;
-	bool	has_mainmic;
-	bool	has_submic;
-	u8	has_afm;
-	/* Other features */
-	bool	jack_detection;	/* board can detect jack events */
-	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
-};
-
-#endif /* _OMAP_ABE_TWL6040_H_ */
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 70cd5c7..ebb1390 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl6040.h>
-#include <linux/platform_data/omap-abe-twl6040.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
@@ -166,19 +165,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"AFMR", NULL, "Line In"},
 };
 
-static inline void twl6040_disconnect_pin(struct snd_soc_dapm_context *dapm,
-					  int connected, char *pin)
-{
-	if (!connected)
-		snd_soc_dapm_disable_pin(dapm, pin);
-}
-
 static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = codec->card;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
 	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int hs_trim;
 	int ret = 0;
@@ -203,24 +193,6 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
 	}
 
-	/*
-	 * NULL pdata means we booted with DT. In this case the routing is
-	 * provided and the card is fully routed, no need to mark pins.
-	 */
-	if (!pdata)
-		return ret;
-
-	/* Disable not connected paths if not used */
-	twl6040_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
-	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
-	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
-	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
-	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vibrator");
-	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
-	twl6040_disconnect_pin(dapm, pdata->has_afm, "Line In");
-
 	return ret;
 }
 
@@ -274,13 +246,18 @@ static struct snd_soc_card omap_abe_card = {
 
 static int omap_abe_probe(struct platform_device *pdev)
 {
-	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_abe_card;
+	struct device_node *dai_node;
 	struct abe_twl6040 *priv;
 	int num_links = 0;
 	int ret = 0;
 
+	if (!node) {
+		dev_err(&pdev->dev, "of node is missing.\n");
+		return -ENODEV;
+	}
+
 	card->dev = &pdev->dev;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct abe_twl6040), GFP_KERNEL);
@@ -289,78 +266,50 @@ static int omap_abe_probe(struct platform_device *pdev)
 
 	priv->dmic_codec_dev = ERR_PTR(-EINVAL);
 
-	if (node) {
-		struct device_node *dai_node;
-
-		if (snd_soc_of_parse_card_name(card, "ti,model")) {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
+	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+		dev_err(&pdev->dev, "Card name is not provided\n");
+		return -ENODEV;
+	}
 
-		ret = snd_soc_of_parse_audio_routing(card,
-						"ti,audio-routing");
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Error while parsing DAPM routing\n");
-			return ret;
-		}
+	ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
+	if (ret) {
+		dev_err(&pdev->dev, "Error while parsing DAPM routing\n");
+		return ret;
+	}
 
-		dai_node = of_parse_phandle(node, "ti,mcpdm", 0);
-		if (!dai_node) {
-			dev_err(&pdev->dev, "McPDM node is not provided\n");
-			return -EINVAL;
-		}
-		abe_twl6040_dai_links[0].cpu_dai_name  = NULL;
-		abe_twl6040_dai_links[0].cpu_of_node = dai_node;
+	dai_node = of_parse_phandle(node, "ti,mcpdm", 0);
+	if (!dai_node) {
+		dev_err(&pdev->dev, "McPDM node is not provided\n");
+		return -EINVAL;
+	}
+	abe_twl6040_dai_links[0].cpu_dai_name  = NULL;
+	abe_twl6040_dai_links[0].cpu_of_node = dai_node;
 
-		dai_node = of_parse_phandle(node, "ti,dmic", 0);
-		if (dai_node) {
-			num_links = 2;
-			abe_twl6040_dai_links[1].cpu_dai_name  = NULL;
-			abe_twl6040_dai_links[1].cpu_of_node = dai_node;
+	dai_node = of_parse_phandle(node, "ti,dmic", 0);
+	if (dai_node) {
+		num_links = 2;
+		abe_twl6040_dai_links[1].cpu_dai_name  = NULL;
+		abe_twl6040_dai_links[1].cpu_of_node = dai_node;
 
-			priv->dmic_codec_dev = platform_device_register_simple(
+		priv->dmic_codec_dev = platform_device_register_simple(
 						"dmic-codec", -1, NULL, 0);
-			if (IS_ERR(priv->dmic_codec_dev)) {
-				dev_err(&pdev->dev,
-					"Can't instantiate dmic-codec\n");
-				return PTR_ERR(priv->dmic_codec_dev);
-			}
-		} else {
-			num_links = 1;
-		}
-
-		priv->jack_detection = of_property_read_bool(node,
-							   "ti,jack-detection");
-		of_property_read_u32(node, "ti,mclk-freq",
-				     &priv->mclk_freq);
-		if (!priv->mclk_freq) {
-			dev_err(&pdev->dev, "MCLK frequency not provided\n");
-			ret = -EINVAL;
-			goto err_unregister;
+		if (IS_ERR(priv->dmic_codec_dev)) {
+			dev_err(&pdev->dev, "Can't instantiate dmic-codec\n");
+			return PTR_ERR(priv->dmic_codec_dev);
 		}
-
-		omap_abe_card.fully_routed = 1;
-	} else if (pdata) {
-		if (pdata->card_name) {
-			card->name = pdata->card_name;
-		} else {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
-
-		if (pdata->has_dmic)
-			num_links = 2;
-		else
-			num_links = 1;
-
-		priv->jack_detection = pdata->jack_detection;
-		priv->mclk_freq = pdata->mclk_freq;
 	} else {
-		dev_err(&pdev->dev, "Missing pdata\n");
-		return -ENODEV;
+		num_links = 1;
+	}
+
+	priv->jack_detection = of_property_read_bool(node, "ti,jack-detection");
+	of_property_read_u32(node, "ti,mclk-freq", &priv->mclk_freq);
+	if (!priv->mclk_freq) {
+		dev_err(&pdev->dev, "MCLK frequency not provided\n");
+		ret = -EINVAL;
+		goto err_unregister;
 	}
 
+	card->fully_routed = 1;
 
 	if (!priv->mclk_freq) {
 		dev_err(&pdev->dev, "MCLK frequency missing\n");
-- 
1.8.3.2
