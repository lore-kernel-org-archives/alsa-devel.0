From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH V6 10/10] dmaengine: Fix compilation error in non-DT case
Date: Fri, 18 Jan 2013 17:17:09 +0530
Message-ID: <1358509629-20471-11-git-send-email-padma.v@samsung.com>
References: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: padma.v@samsung.com, padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org, lrg@ti.com, tiwai@suse.de, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/dmaengine.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8cd0e25..c88f302 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -992,7 +992,7 @@ static inline struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask,
 static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
 							 char *name)
 {
-	return NULL
+	return NULL;
 }
 static inline void dma_release_channel(struct dma_chan *chan)
 {
-- 
1.7.4.4
