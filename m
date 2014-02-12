From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 3/3] ASoC: simple-card: add slot information parsing supports
Date: Wed, 12 Feb 2014 15:45:12 +0800
Message-ID: <1392191112-27028-4-git-send-email-Li.Xiubo@freescale.com>
References: <1392191112-27028-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392191112-27028-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, perex@perex.cz, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For some CPU/CODEC DAI devices the slot information maybe needed. This
patch adds the slot information parsing for simple-card driver.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/sound/simple-card.txt      |  1 +
 include/sound/simple_card.h                        |  1 +
 sound/soc/generic/simple-card.c                    | 35 ++++++++++++++++++++--
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 0527358..7abf8f3 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -18,6 +18,7 @@ Optional properties:
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
+- simple-audio-card,slot-info		: Please refer to tdm-slot.txt.
 
 Required subnodes:
 
diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index e1ac996..d645241 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -18,6 +18,7 @@ struct asoc_simple_dai {
 	const char *name;
 	unsigned int fmt;
 	unsigned int sysclk;
+	struct soc_slot_info *slot;
 };
 
 struct asoc_simple_card_info {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4fe8abc..fd230c7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -9,11 +9,14 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <sound/simple_card.h>
+#include <sound/soc-dai.h>
+#include <sound/soc.h>
 
 struct simple_card_data {
 	struct snd_soc_card snd_card;
@@ -44,6 +47,17 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 		}
 	}
 
+	if (set->slot) {
+		ret = snd_soc_dai_set_tdm_slot(dai, set->slot->tx_mask,
+						set->slot->rx_mask,
+						set->slot->slots,
+						set->slot->slot_width);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_tdm_slot error\n");
+			goto err;
+		}
+	}
+
 	ret = 0;
 
 err:
@@ -74,7 +88,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      unsigned int daifmt,
 			      struct asoc_simple_dai *dai,
 			      const struct device_node **p_node,
-			      const char **name)
+			      const char **name,
+			      struct device *dev)
 {
 	struct device_node *node;
 	struct clk *clk;
@@ -94,6 +109,18 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	if (ret < 0)
 		goto parse_error;
 
+	/* parse TDM slot information */
+	if (of_property_read_bool(np, "simple-audio-card,slot-info")) {
+		dai->slot = devm_kzalloc(dev, sizeof(*dai->slot), GFP_KERNEL);
+		if (!dai->slot)
+			return -ENOMEM;
+
+		ret = snd_soc_of_parse_slot_info(np, dai->slot,
+				"simple-audio-card,slot-info");
+		if (ret < 0)
+			goto parse_error;
+	}
+
 	/*
 	 * bitclock-inversion, frame-inversion
 	 * bitclock-master,    frame-master
@@ -173,7 +200,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
-						  &dai_link->cpu_dai_name);
+						  &dai_link->cpu_dai_name,
+						  dev);
 	if (ret < 0)
 		return ret;
 
@@ -184,7 +212,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->codec_dai,
 						  &dai_link->codec_of_node,
-						  &dai_link->codec_dai_name);
+						  &dai_link->codec_dai_name,
+						  dev);
 	if (ret < 0)
 		return ret;
 
-- 
1.8.4
