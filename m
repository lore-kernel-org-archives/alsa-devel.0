From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 13/15] ASoC: export snd_soc_of_get_slot_mask
Date: Tue, 17 Jul 2018 17:36:40 +0200
Message-ID: <20180717153643.8806-17-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Amlogic's axg card driver can't use snd_soc_of_parse_tdm_slot()
directly because it needs to handle 4 mask for each direction.
Yet the parsing of each mask is the same, so export
snd_soc_of_get_slot_mask() to reuse the the existing code.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..41cec42fb456 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1426,6 +1426,9 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3be0310d5c81..1344e8e602fd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3366,9 +3366,9 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
-static int snd_soc_of_get_slot_mask(struct device_node *np,
-				    const char *prop_name,
-				    unsigned int *mask)
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask)
 {
 	u32 val;
 	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
@@ -3383,6 +3383,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(snd_soc_of_get_slot_mask);
 
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
-- 
2.14.4
