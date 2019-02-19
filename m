From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ASoC: simple-card: Fix of-node refcount
	unbalance in DAI-link parser
Date: Tue, 19 Feb 2019 16:46:49 +0100
Message-ID: <20190219154652.13644-4-tiwai@suse.de>
References: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACAE265540
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:46:54 +0100 (CET)
In-Reply-To: <20190219154652.13644-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The function simple_for_each_link() has a few missing places that
forgot unrefereing of-nodes after the use.  The main do-while loop
may abort when loop=0, and this leaves the node object still
referenced.  A similar leak is found in the error handling of NULL
codec that aborts the loop as well.  Last but not least, the inner
for_each_child_of_node() loop may abort in the middle, and this leaks
the refcount of the iterator node.

This patch addresses these missing refcount issues.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/soc/generic/simple-card.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3e677dd1137e..30ae0a5281b3 100644
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
2.16.4
