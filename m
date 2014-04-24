From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: simple-card: is_top_level_node parameter
	to simple_card_dai_link_of()
Date: Thu, 24 Apr 2014 19:42:00 +0300
Message-ID: <1398357720-2000-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id D858B2652E9
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 18:42:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: moinejf@free.fr, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, broonie@kernel.org, Guangyu.Chen@freescale.com
List-Id: alsa-devel@alsa-project.org

Restore correct parsing of dai-link subnodes with more explicit
implementation for applying the "simple-audio-card,"-prefix to
dai-link property and subnode names.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/generic/simple-card.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 98f97e5..06fe0e2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -144,7 +144,8 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 static int simple_card_dai_link_of(struct device_node *node,
 				   struct device *dev,
 				   struct snd_soc_dai_link *dai_link,
-				   struct simple_dai_props *dai_props)
+				   struct simple_dai_props *dai_props,
+				   bool is_top_level_node)
 {
 	struct device_node *np = NULL;
 	struct device_node *bitclkmaster = NULL;
@@ -155,7 +156,8 @@ static int simple_card_dai_link_of(struct device_node *node,
 	char *prefix = "";
 	int ret;
 
-	prefix = "simple-audio-card,";
+	if (is_top_level_node)
+		prefix = "simple-audio-card,";
 
 	daifmt = snd_soc_of_parse_daifmt(node, prefix,
 					 &bitclkmaster, &framemaster);
@@ -307,14 +309,15 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		for (i = 0; (np = of_get_next_child(node, np)); i++) {
 			dev_dbg(dev, "\tlink %d:\n", i);
 			ret = simple_card_dai_link_of(np, dev, dai_link + i,
-						      dai_props + i);
+						      dai_props + i, false);
 			if (ret < 0) {
 				of_node_put(np);
 				return ret;
 			}
 		}
 	} else {
-		ret = simple_card_dai_link_of(node, dev, dai_link, dai_props);
+		ret = simple_card_dai_link_of(node, dev, dai_link, dai_props,
+					      true);
 		if (ret < 0)
 			return ret;
 	}
-- 
1.7.9.5
