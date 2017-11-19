From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: audio-graph-scu-card: Use common error
 handling code in asoc_graph_card_parse_of()
Date: Sun, 19 Nov 2017 09:09:38 +0100
Message-ID: <3b978ab5-5a7f-369f-c663-938955a36e58@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 79DBF266F30
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 09:10:57 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Nov 2017 08:51:41 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/generic/audio-graph-scu-card.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index a967aa143d51..c4b999fba7e6 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -231,10 +231,8 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 		ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
 							    NULL, &daifmt);
-		if (ret < 0) {
-			of_node_put(cpu_port);
-			goto parse_of_err;
-		}
+		if (ret < 0)
+			goto put_node;
 	}
 
 	dai_idx = 0;
@@ -266,17 +264,13 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 				/* Back-End (= Codec) */
 				ret = asoc_graph_card_dai_link_of(codec_ep, priv, daifmt, dai_idx++, 0);
-				if (ret < 0) {
-					of_node_put(cpu_port);
-					goto parse_of_err;
-				}
+				if (ret < 0)
+					goto put_node;
 			} else {
 				/* Front-End (= CPU) */
 				ret = asoc_graph_card_dai_link_of(cpu_ep, priv, daifmt, dai_idx++, 1);
-				if (ret < 0) {
-					of_node_put(cpu_port);
-					goto parse_of_err;
-				}
+				if (ret < 0)
+					goto put_node;
 			}
 		}
 	}
@@ -285,8 +279,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	if (ret)
 		goto parse_of_err;
 
-	ret = 0;
+	return 0;
 
+put_node:
+	of_node_put(cpu_port);
 parse_of_err:
 	return ret;
 }
-- 
2.15.0
