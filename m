From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/3] ASoC: meson: align axg card driver with DT bindings documentation
Date: Thu, 26 Jul 2018 14:45:44 +0200
Message-ID: <20180726124544.14740-4-jbrunet@baylibre.com>
References: <20180726124544.14740-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726124544.14740-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Drop amlogic prefix in front of the generic DT properties and change
property "name" to "model".

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index d6d1081d94ad..2914ba0d965b 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -123,7 +123,7 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	struct snd_soc_aux_dev *aux;
 	int num, i;
 
-	num = of_count_phandle_with_args(node, PREFIX "aux-devs", NULL);
+	num = of_count_phandle_with_args(node, "audio-aux-devs", NULL);
 	if (num == -ENOENT) {
 		/*
 		 * It is ok to have no auxiliary devices but for this card it
@@ -144,8 +144,8 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->num_aux_devs = num;
 
 	for (i = 0; i < card->num_aux_devs; i++, aux++) {
-		aux->codec_of_node = of_parse_phandle(node,
-						      PREFIX "aux-devs", i);
+		aux->codec_of_node =
+			of_parse_phandle(node, "audio-aux-devs", i);
 		if (!aux->codec_of_node)
 			return -EINVAL;
 	}
@@ -610,18 +610,18 @@ static int axg_card_probe(struct platform_device *pdev)
 	priv->card.owner = THIS_MODULE;
 	priv->card.dev = dev;
 
-	ret = snd_soc_of_parse_card_name(&priv->card, PREFIX "name");
+	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret < 0)
 		return ret;
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "routing",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-routing",
 					 snd_soc_of_parse_audio_routing);
 	if (ret) {
 		dev_err(dev, "error while parsing routing\n");
 		return ret;
 	}
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "widgets",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-widgets",
 					 snd_soc_of_parse_audio_simple_widgets);
 	if (ret) {
 		dev_err(dev, "error while parsing widgets\n");
-- 
2.17.1
