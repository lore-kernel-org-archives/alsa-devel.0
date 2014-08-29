From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/2] ASoC: simple-card: Fix bug of forgetting decrement DT node's refcount
Date: Fri, 29 Aug 2014 17:19:32 +0800
Message-ID: <1409303973-1084-2-git-send-email-Li.Xiubo@freescale.com>
References: <1409303973-1084-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409303973-1084-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, moinejf@free.fr, kuninori.morimoto.gx@renesas.com, jsarha@ti.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

We shouldn't forget decrement the last DT node when the
of_get_next_child() has finished searching.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 21b0ea2..9675bf7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -344,6 +344,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 				return ret;
 			}
 		}
+		of_node_put(np);
 	} else {
 		ret = simple_card_dai_link_of(node, dev, dai_link, dai_props,
 					      true);
-- 
1.8.5
