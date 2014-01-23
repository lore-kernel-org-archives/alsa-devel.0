From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 6/8] ASoC: simple-card: add tdm slot supports
Date: Thu, 23 Jan 2014 13:02:48 +0800
Message-ID: <1390453370-29194-7-git-send-email-Li.Xiubo@freescale.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, shawn.guo@linaro.org, kuninori.morimoto.gx@renesas.com
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For some CPU/CODEC DAI devices the tdm slot maybe needed. This patch
adds the tdm slot supporting for simple-card driver.

The style of the tdm slot in DT:

For instance:

	simple-tdm-slot = <0xffffffc 0xffffffc 2 0>;

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---

The VF610 Tower and VF610 LS1 platforms' SPDIF will depend on this patch.


 include/sound/simple_card.h     |  8 ++++++
 sound/soc/generic/simple-card.c | 61 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
index e1ac996..cfc5b66 100644
--- a/include/sound/simple_card.h
+++ b/include/sound/simple_card.h
@@ -14,10 +14,18 @@
 
 #include <sound/soc.h>
 
+struct asoc_simple_tdm_slot {
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+	int slots;
+	int slot_width;
+};
+
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int fmt;
 	unsigned int sysclk;
+	struct asoc_simple_tdm_slot *tdm;
 };
 
 struct asoc_simple_card_info {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 546b93d..d067e0a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -32,7 +32,7 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 		ret = snd_soc_dai_set_fmt(dai, set->fmt);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_fmt error\n");
-			return ret;
+			goto err;
 		}
 	}
 
@@ -40,10 +40,22 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 		ret = snd_soc_dai_set_sysclk(dai, 0, set->sysclk, 0);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
-			return ret;
+			goto err;
+		}
+	}
+
+	if (set->tdm) {
+		ret = snd_soc_dai_set_tdm_slot(dai, set->tdm->tx_mask,
+						set->tdm->rx_mask,
+						set->tdm->slots,
+						set->tdm->slot_width);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_tdm_slot error\n");
+			goto err;
 		}
 	}
 
+err:
 	return ret;
 }
 
@@ -67,11 +79,43 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 static int
+asoc_simple_card_of_parse_tdm_slot(struct device_node *np,
+				   struct device *dev,
+				   struct asoc_simple_dai *dai,
+				   const char *propname)
+{
+	struct asoc_simple_tdm_slot *tdm;
+	u32 out_value[4];
+	int ret;
+
+	if (!of_property_read_bool(np, propname))
+		return 0;
+
+	tdm = devm_kzalloc(dev, sizeof(*tdm), GFP_KERNEL);
+	if (!tdm)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, propname, out_value, 4);
+	if (ret)
+		return ret;
+
+	tdm->tx_mask = out_value[0];
+	tdm->rx_mask = out_value[1];
+	tdm->slots = out_value[2];
+	tdm->slot_width = out_value[3];
+
+	dai->tdm = tdm;
+
+	return 0;
+}
+
+static int
 asoc_simple_card_sub_parse_of(struct device_node *np,
 			      unsigned int daifmt,
 			      struct asoc_simple_dai *dai,
 			      const struct device_node **p_node,
-			      const char **name)
+			      const char **name,
+			      struct device *dev)
 {
 	struct device_node *node;
 	struct clk *clk;
@@ -91,6 +135,11 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	if (ret < 0)
 		goto parse_error;
 
+	/* parse tdm_slot */
+	ret = asoc_simple_card_of_parse_tdm_slot(np, dev, dai, "tdm-slot");
+	if (ret < 0)
+		goto parse_error;
+
 	/*
 	 * bitclock-inversion, frame-inversion
 	 * bitclock-master,    frame-master
@@ -162,7 +211,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		ret = asoc_simple_card_sub_parse_of(np, priv->daifmt,
 						  &priv->cpu_dai,
 						  &dai_link->cpu_of_node,
-						  &dai_link->cpu_dai_name);
+						  &dai_link->cpu_dai_name,
+						  dev);
 	if (ret < 0)
 		return ret;
 
@@ -173,7 +223,8 @@ static int asoc_simple_card_parse_of(struct device_node *node,
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
