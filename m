From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 3/3] ASoC: simple-card: add support for clock
	divider setup
Date: Mon, 28 May 2018 21:35:03 +0200
Message-ID: <20180528193503.18905-4-daniel@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id DB4582673F5
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 21:35:12 +0200 (CEST)
In-Reply-To: <20180528193503.18905-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Add support to call into snd_soc_dai_set_clkdiv() for both CPU and codec
DAIs from simple-card's hw_params().

This allows platforms to set hardware-specific values without providing an
own machine driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/sound/simple-card.txt      |  5 +++
 include/sound/simple_card_utils.h                  | 18 +++++++++
 sound/soc/generic/simple-card-utils.c              | 47 ++++++++++++++++++++++
 sound/soc/generic/simple-card.c                    | 35 ++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c8d268285a9e..d3d83256ab5d 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -97,6 +97,10 @@ Optional CPU/CODEC subnodes properties:
 - system-clock-index			: index of the system clock to use when
 					  the mclk frequency is on the CPU/CODEC
 					  DAI. Defaults to 0.
+- clock-dividers                        : Array of index/value pairs for CPU/CODEC
+					  specific clock dividers to configure at
+					  stream start time. Optional. No divider
+					  is configured if not specified.
 
 Example 1 - single DAI link:
 
@@ -152,6 +156,7 @@ sound {
 		format = "i2s";
 		cpu {
 			sound-dai = <&audio1 0>;
+			clock-dividers = <0 4>;
 		};
 		codec {
 			sound-dai = <&tda998x 0>;
diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index ebdf52c9884f..ed3180f975af 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -12,6 +12,11 @@
 
 #include <sound/soc.h>
 
+struct asoc_simple_clkdiv {
+	int div_id;
+	int div;
+};
+
 struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
@@ -22,6 +27,8 @@ struct asoc_simple_dai {
 	unsigned int rx_slot_mask;
 	struct clk *clk;
 	int sysclk_id;
+	struct asoc_simple_clkdiv *clkdiv;
+	int num_clkdiv;
 };
 
 struct asoc_simple_card_data {
@@ -55,6 +62,17 @@ int asoc_simple_card_parse_clk(struct device *dev,
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai);
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 
+#define asoc_simple_card_parse_clkdiv_cpu(dev, node, dai_link, simple_dai)	\
+	asoc_simple_card_parse_clkdiv(dev, node, simple_dai,			\
+				      dai_link->cpu_dai_name)
+#define asoc_simple_card_parse_clkdiv_codec(dev, node, dai_link, simple_dai)	\
+	asoc_simple_card_parse_clkdiv(dev, node, simple_dai,			\
+				      dai_link->codec_dai_name)
+int asoc_simple_card_parse_clkdiv(struct device *dev,
+				  struct device_node *node,
+				  struct asoc_simple_dai *simple_dai,
+				  const char *name);
+
 #define asoc_simple_card_parse_cpu(node, dai_link,				\
 				   list_name, cells_name, is_single_link)	\
 	asoc_simple_card_parse_dai(node, &dai_link->cpu_of_node,		\
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 493c9b1f057e..ad7912871240 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -209,6 +209,53 @@ int asoc_simple_card_parse_clk(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clk);
 
+int asoc_simple_card_parse_clkdiv(struct device *dev,
+				  struct device_node *node,
+				  struct asoc_simple_dai *simple_dai,
+				  const char *name)
+{
+	const char *pname = "clock-dividers";
+	int i, ret, count;
+	u32 val;
+
+	count = of_property_count_u32_elems(node, pname);
+	if (count <= 0)
+		return 0;
+
+	if (count & 1) {
+		dev_err(dev, "Invalid number of values for %s property", pname);
+		return -EINVAL;
+	}
+
+	simple_dai->num_clkdiv = count / 2;
+	simple_dai->clkdiv = devm_kcalloc(dev, simple_dai->num_clkdiv,
+					  sizeof(struct asoc_simple_clkdiv),
+					  GFP_KERNEL);
+	if (!simple_dai->clkdiv)
+		return -ENOMEM;
+
+	for (i = 0; i < simple_dai->num_clkdiv; i++) {
+		ret = of_property_read_u32_index(node, pname, i * 2, &val);
+		if (ret < 0)
+			return ret;
+
+		simple_dai->clkdiv[i].div_id = val;
+
+		ret = of_property_read_u32_index(node, pname, i * 2 + 1, &val);
+		if (ret < 0)
+			return ret;
+
+		simple_dai->clkdiv[i].div = val;
+
+		dev_dbg(dev, "%s : clkdiv #%d = %d\n", name,
+			simple_dai->clkdiv[i].div_id,
+			simple_dai->clkdiv[i].div);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_parse_clkdiv);
+
 int asoc_simple_card_parse_dai(struct device_node *node,
 				    struct device_node **dai_of_node,
 				    const char **dai_name,
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 5b4afa624395..56d1d774feac 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -135,6 +135,23 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
+static int asoc_simple_card_set_clkdiv(struct snd_soc_dai *dai,
+				       unsigned int mclk,
+				       const struct asoc_simple_dai *simple_dai)
+{
+	int ret, i;
+
+	for (i = 0; i < simple_dai->num_clkdiv; i++) {
+		ret = snd_soc_dai_set_clkdiv(dai,
+					     simple_dai->clkdiv[i].div_id,
+					     simple_dai->clkdiv[i].div);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
@@ -164,11 +181,21 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 
+		ret = asoc_simple_card_set_clkdiv(codec_dai, mclk,
+						  &dai_props->codec_dai);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+
 		ret = snd_soc_dai_set_sysclk(cpu_dai,
 					     dai_props->cpu_dai.sysclk_id,
 					     mclk, SND_SOC_CLOCK_OUT);
 		if (ret && ret != -ENOTSUPP)
 			goto err;
+
+		ret = asoc_simple_card_set_clkdiv(cpu_dai, mclk,
+						  &dai_props->cpu_dai);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
 	}
 	return 0;
 err:
@@ -287,6 +314,14 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	ret = asoc_simple_card_parse_clkdiv_cpu(dev, cpu, dai_link, cpu_dai);
+	if (ret < 0)
+		goto dai_link_of_err;
+
+	ret = asoc_simple_card_parse_clkdiv_codec(dev, codec, dai_link, codec_dai);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	ret = asoc_simple_card_canonicalize_dailink(dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-- 
2.14.3
