From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 1/2] ASoC: simple-card: Fix bug of forgetting decrement DT node's refcount
Date: Mon, 1 Sep 2014 09:35:26 +0800
Message-ID: <1409535327-11449-2-git-send-email-Li.Xiubo@freescale.com>
References: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409535327-11449-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

We shouldn't forget decrement the last DT node when the
for_each_child_of_node() has finished searching.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fd8b045..9e170fe 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -360,6 +360,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			}
 			i++;
 		}
+		of_node_put(np);
 	} else {
 		ret = asoc_simple_card_dai_link_of(node, dev,
 						   dai_link, dai_props, true);
-- 
1.8.4
