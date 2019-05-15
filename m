From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/5] ASoC: meson: axg-card: set link name based on link node name
Date: Wed, 15 May 2019 15:18:54 +0200
Message-ID: <20190515131858.32130-2-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

So far the link names of the axg sound card was derived from the cpu name
of the link. Since the dai link must be unique, it works as long as a
device does not provide more than one cpu dai. However, the 'tohdmitx'
does provide 2 dais used as cpu on codec-to-codec links

Instead of cpu name, use the node name of the dai link. DT already enforce
the uniqueness of this name

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index aa54d2c612c9..5c8deee8d512 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -80,10 +80,11 @@ static int axg_card_parse_dai(struct snd_soc_card *card,
 
 static int axg_card_set_link_name(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *link,
+				  struct device_node *node,
 				  const char *prefix)
 {
 	char *name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
-				    prefix, link->cpu_of_node->full_name);
+				    prefix, node->full_name);
 	if (!name)
 		return -ENOMEM;
 
@@ -474,7 +475,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 		codec++;
 	}
 
-	ret = axg_card_set_link_name(card, link, "be");
+	ret = axg_card_set_link_name(card, link, node, "be");
 	if (ret)
 		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
@@ -483,6 +484,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 static int axg_card_set_fe_link(struct snd_soc_card *card,
 				struct snd_soc_dai_link *link,
+				struct device_node *node,
 				bool is_playback)
 {
 	link->dynamic = 1;
@@ -497,7 +499,7 @@ static int axg_card_set_fe_link(struct snd_soc_card *card,
 	else
 		link->dpcm_capture = 1;
 
-	return axg_card_set_link_name(card, link, "fe");
+	return axg_card_set_link_name(card, link, node, "fe");
 }
 
 static int axg_card_cpu_is_capture_fe(struct device_node *np)
@@ -527,9 +529,9 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 		return ret;
 
 	if (axg_card_cpu_is_playback_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, true);
+		ret = axg_card_set_fe_link(card, dai_link, np, true);
 	else if (axg_card_cpu_is_capture_fe(dai_link->cpu_of_node))
-		ret = axg_card_set_fe_link(card, dai_link, false);
+		ret = axg_card_set_fe_link(card, dai_link, np, false);
 	else
 		ret = axg_card_set_be_link(card, dai_link, np);
 
-- 
2.20.1
