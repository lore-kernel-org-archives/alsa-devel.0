From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: add dai-link support"
	to the asoc tree
Date: Tue, 11 Dec 2018 20:36:50 +0000 (GMT)
Message-ID: <20181211203650.CDCCC112540E@debutante.sirena.org.uk>
References: <87a7lcbvpg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 271B8267BEB
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 21:36:51 +0100 (CET)
In-Reply-To: <87a7lcbvpg.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: add dai-link support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From da32d6537802a257879e9ba91a5e351a24ada889 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Dec 2018 03:24:57 +0000
Subject: [PATCH] ASoC: simple-scu-card: add dai-link support

simple-card is supporting dai-link support, but simple-scu-card
doesn't have it.
This patch support it. This is prepare for merging simple-card
and simple-scu-card.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 46 ++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 24099e61d1b1..666ace6175be 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -202,14 +202,15 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 
 {
 	struct device *dev = simple_priv_to_dev(priv);
-	struct device_node *node = dev->of_node;
+	struct device_node *top = dev->of_node;
+	struct device_node *node;
 	struct device_node *np;
 	struct device_node *codec;
 	struct snd_soc_card *card = simple_priv_to_card(priv);
 	bool is_fe;
-	int ret, i;
+	int ret, i, loop;
 
-	if (!node)
+	if (!top)
 		return -EINVAL;
 
 	ret = asoc_simple_card_of_parse_widgets(card, PREFIX);
@@ -220,25 +221,34 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, node, PREFIX, &priv->adata);
+	asoc_simple_card_parse_convert(dev, top, PREFIX, &priv->adata);
 
+	loop = 1;
 	i = 0;
-	codec = of_get_child_by_name(node, PREFIX "codec");
-	if (!codec)
-		return -ENODEV;
-
-	for_each_child_of_node(node, np) {
-		is_fe = false;
-		if (of_node_name_eq(np, PREFIX "cpu"))
-			is_fe = true;
-
-		ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
-						   i, is_fe, true);
-		if (ret < 0)
-			return ret;
-		i++;
+	node = of_get_child_by_name(top, PREFIX "dai-link");
+	if (!node) {
+		node = dev->of_node;
+		loop = 0;
 	}
 
+	do  {
+		codec = of_get_child_by_name(node,
+					     loop ? "codec" : PREFIX "codec");
+		if (!codec)
+			return -ENODEV;
+
+		for_each_child_of_node(node, np) {
+			is_fe = (np != codec);
+
+			ret = asoc_simple_card_dai_link_of(node, np, codec, priv,
+							   i, is_fe, !loop);
+			if (ret < 0)
+				return ret;
+			i++;
+		}
+		node = of_get_next_child(top, node);
+	} while (loop && node);
+
 	ret = asoc_simple_card_parse_card_name(card, PREFIX);
 	if (ret < 0)
 		return ret;
-- 
2.19.0.rc2
