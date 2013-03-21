From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] DMA: of: const name fixup
Date: Thu, 21 Mar 2013 15:45:42 +0100
Message-ID: <1363877142-14662-1-git-send-email-mpa@pengutronix.de>
References: <20130321125459.GU10326@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 575A826511D
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 15:46:34 +0100 (CET)
In-Reply-To: <20130321125459.GU10326@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Sorry, this one was actually missing in the first patch I sent.

Regards,

Markus

 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 274071c..f30b096 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1007,7 +1007,7 @@ struct dma_chan *net_dma_find_channel(void);
 static inline struct dma_chan
 *__dma_request_slave_channel_compat(dma_cap_mask_t *mask, dma_filter_fn fn,
 				  void *fn_param, struct device *dev,
-				  char *name)
+				  const char *name)
 {
 	struct dma_chan *chan;
 
-- 
1.8.1.5
