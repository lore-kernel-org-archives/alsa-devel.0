From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Fix of-node refcount
	unbalance in DAI-link parser" to the asoc tree
Date: Wed, 20 Feb 2019 12:13:13 +0000 (GMT)
Message-ID: <20190220121313.F275411274ED@debutante.sirena.org.uk>
References: <20190219154652.13644-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F88DF807AE
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 13:13:21 +0100 (CET)
In-Reply-To: <20190219154652.13644-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Fix of-node refcount unbalance in DAI-link parser

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

>From 0b9c9ed6dd3b61b1d3ef1638786a7216006f67c5 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 19 Feb 2019 16:46:49 +0100
Subject: [PATCH] ASoC: simple-card: Fix of-node refcount unbalance in DAI-link
 parser

The function simple_for_each_link() has a few missing places that
forgot unrefereing of-nodes after the use.  The main do-while loop
may abort when loop=0, and this leaves the node object still
referenced.  A similar leak is found in the error handling of NULL
codec that aborts the loop as well.  Last but not least, the inner
for_each_child_of_node() loop may abort in the middle, and this leaks
the refcount of the iterator node.

This patch addresses these missing refcount issues.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 092963e90e1e..7147bba45a2a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -442,6 +442,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 	struct device_node *top = dev->of_node;
 	struct device_node *node;
 	bool is_top = 0;
+	int ret = 0;
 
 	/* Check if it has dai-link */
 	node = of_get_child_by_name(top, PREFIX "dai-link");
@@ -456,13 +457,14 @@ static int simple_for_each_link(struct simple_priv *priv,
 		struct device_node *codec;
 		struct device_node *np;
 		int num = of_get_child_count(node);
-		int ret;
 
 		/* get codec */
 		codec = of_get_child_by_name(node, is_top ?
 					     PREFIX "codec" : "codec");
-		if (!codec)
-			return -ENODEV;
+		if (!codec) {
+			ret = -ENODEV;
+			goto error;
+		}
 
 		of_node_put(codec);
 
@@ -485,14 +487,18 @@ static int simple_for_each_link(struct simple_priv *priv,
 			else
 				ret = func_noml(priv, np, codec, li, is_top);
 
-			if (ret < 0)
-				return ret;
+			if (ret < 0) {
+				of_node_put(np);
+				goto error;
+			}
 		}
 
 		node = of_get_next_child(top, node);
 	} while (!is_top && node);
 
-	return 0;
+ error:
+	of_node_put(node);
+	return ret;
 }
 
 static int simple_parse_aux_devs(struct device_node *node,
-- 
2.20.1
