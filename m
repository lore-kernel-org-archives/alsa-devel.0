From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 4/4] DMA: PL330: Modify pl330 filter based on new generic dma
 dt bindings.
Date: Fri, 18 Jan 2013 17:03:44 +0530
Message-ID: <1358508824-20352-5-git-send-email-padma.v@samsung.com>
References: <1358508824-20352-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1358508824-20352-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: padma.v@samsung.com, padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch modify the filter function to filter the required channel
based on new filter params.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/dma/pl330.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index b80ef97..a773ea7 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2378,15 +2378,8 @@ bool pl330_filter(struct dma_chan *chan, void *param)
 
 #ifdef CONFIG_OF
 	if (chan->device->dev->of_node) {
-		const __be32 *prop_value;
-		phandle phandle;
-		struct device_node *node;
-
-		prop_value = ((struct property *)param)->value;
-		phandle = be32_to_cpup(prop_value++);
-		node = of_find_node_by_phandle(phandle);
-		return ((chan->private == node) &&
-				(chan->chan_id == be32_to_cpup(prop_value)));
+		struct of_phandle_args *dma_spec = param;
+		return ((chan->private == dma_spec->np) && (chan->chan_id == dma_spec->args[0]));
 	}
 #endif
 
-- 
1.7.4.4
