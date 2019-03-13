From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers when available
Date: Wed, 13 Mar 2019 14:58:11 +0900
Message-ID: <20190313055811.26135-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

Some of SoCs have both basic and extended dmac registers set
basic set only supports busif0 ~ busif3, in order to use
busif4 ~ busif7, extended audio dmac registers need to be used.

This patch changes to use extended dmac registers set when it is
available in device-tree.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 0324a5c39619..905502ccedba 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -830,7 +830,10 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 	/*
 	 * for Gen2 or later
 	 */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "audmapp");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "extaudmapp");
+	if (!res)
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "audmapp");
 	dmac = devm_kzalloc(dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac || !res) {
 		dev_err(dev, "dma allocate failed\n");
-- 
2.19.2
