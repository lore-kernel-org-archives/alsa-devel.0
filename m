From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: tidyup dai format for DPCM"
	to the asoc tree
Date: Fri, 18 Dec 2015 12:15:41 +0000
Message-ID: <E1a9twj-0006D7-OH@debutante>
References: <87fuz1iyg4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EEBB266689
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:49 +0100 (CET)
In-Reply-To: <87fuz1iyg4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: tidyup dai format for DPCM

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From af998f853124231ef3bff05621f157a19af05d20 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:49:43 +0000
Subject: [PATCH] ASoC: rsrc-card: tidyup dai format for DPCM

rsrc-card is DPCM supported version of simple-card. Thus it has similar
DT format. OTOH, snd_soc_dai_link requests cpu/codec, but one of them
will be snd-soc-dummy in DPCM case, and DPCM requests frontend/backend
dai_link. This means it might have multi backend/codec.
And, SND_SOC_DAIFMT_xxx is based on "codec". Because of these
difference, current rsrc card can't detect correct dai_fmt.
This patch detect correct dai fmt from 1st "codec".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsrc-card.c | 82 +++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 9f522ba881fa..5fe0b51cdb44 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -155,14 +155,13 @@ static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 }
 
 static int rsrc_card_parse_daifmt(struct device_node *node,
-				  struct device_node *np,
+				  struct device_node *codec,
 				  struct rsrc_card_priv *priv,
-				  int idx, bool is_fe)
+				  struct snd_soc_dai_link *dai_link,
+				  unsigned int *retfmt)
 {
-	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct device_node *bitclkmaster = NULL;
 	struct device_node *framemaster = NULL;
-	struct device_node *codec = is_fe ? NULL : np;
 	unsigned int daifmt;
 
 	daifmt = snd_soc_of_parse_daifmt(node, NULL,
@@ -179,11 +178,11 @@ static int rsrc_card_parse_daifmt(struct device_node *node,
 		daifmt |= (codec == framemaster) ?
 			SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
 
-	dai_link->dai_fmt = daifmt;
-
 	of_node_put(bitclkmaster);
 	of_node_put(framemaster);
 
+	*retfmt = daifmt;
+
 	return 0;
 }
 
@@ -325,24 +324,16 @@ static int rsrc_card_parse_clk(struct device_node *np,
 	return 0;
 }
 
-static int rsrc_card_dai_link_of(struct device_node *node,
-				 struct device_node *np,
-				 struct rsrc_card_priv *priv,
-				 int idx)
+static int rsrc_card_dai_sub_link_of(struct device_node *node,
+				     struct device_node *np,
+				     struct rsrc_card_priv *priv,
+				     int idx, bool is_fe)
 {
 	struct device *dev = rsrc_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = rsrc_priv_to_link(priv, idx);
 	struct rsrc_card_dai *dai_props = rsrc_priv_to_props(priv, idx);
-	bool is_fe = false;
 	int ret;
 
-	if (0 == strcmp(np->name, "cpu"))
-		is_fe = true;
-
-	ret = rsrc_card_parse_daifmt(node, np, priv, idx, is_fe);
-	if (ret < 0)
-		return ret;
-
 	ret = rsrc_card_parse_links(np, priv, idx, is_fe);
 	if (ret < 0)
 		return ret;
@@ -359,6 +350,48 @@ static int rsrc_card_dai_link_of(struct device_node *node,
 	return ret;
 }
 
+static int rsrc_card_dai_link_of(struct device_node *node,
+				 struct rsrc_card_priv *priv)
+{
+	struct snd_soc_dai_link *dai_link;
+	struct device_node *np;
+	unsigned int daifmt = 0;
+	int ret, i;
+	bool is_fe;
+
+	/* find 1st codec */
+	i = 0;
+	for_each_child_of_node(node, np) {
+		dai_link = rsrc_priv_to_link(priv, i);
+
+		if (strcmp(np->name, "codec") == 0) {
+			ret = rsrc_card_parse_daifmt(node, np, priv,
+						     dai_link, &daifmt);
+			if (ret < 0)
+				return ret;
+			break;
+		}
+		i++;
+	}
+
+	i = 0;
+	for_each_child_of_node(node, np) {
+		dai_link = rsrc_priv_to_link(priv, i);
+		dai_link->dai_fmt = daifmt;
+
+		is_fe = false;
+		if (strcmp(np->name, "cpu") == 0)
+			is_fe = true;
+
+		ret = rsrc_card_dai_sub_link_of(node, np, priv, i, is_fe);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
 static int rsrc_card_parse_of(struct device_node *node,
 			      struct rsrc_card_priv *priv,
 			      struct device *dev)
@@ -366,9 +399,8 @@ static int rsrc_card_parse_of(struct device_node *node,
 	const struct rsrc_card_of_data *of_data = rsrc_dev_to_of_data(dev);
 	struct rsrc_card_dai *props;
 	struct snd_soc_dai_link *links;
-	struct device_node *np;
 	int ret;
-	int i, num;
+	int num;
 
 	if (!node)
 		return -EINVAL;
@@ -409,13 +441,9 @@ static int rsrc_card_parse_of(struct device_node *node,
 		priv->snd_card.name ? priv->snd_card.name : "",
 		priv->convert_rate);
 
-	i = 0;
-	for_each_child_of_node(node, np) {
-		ret = rsrc_card_dai_link_of(node, np, priv, i);
-		if (ret < 0)
-			return ret;
-		i++;
-	}
+	ret = rsrc_card_dai_link_of(node, priv);
+	if (ret < 0)
+		return ret;
 
 	if (!priv->snd_card.name)
 		priv->snd_card.name = priv->snd_card.dai_link->name;
-- 
2.6.2
