From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] dmaengine: axi_dmac: Add synchronization support
Date: Tue, 20 Oct 2015 11:46:30 +0200
Message-ID: <1445334391-12272-4-git-send-email-lars@metafoo.de>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Laurent Pinchart <renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Qiao Zhou <zhouqiao@marvell.com>, Shengjiu Wang <shengjiu.wang@freescale.com>, Matt Campbell <mcampbell@izotope.com>, Jonah Petri <jpetri@izotope.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Implement the new device_synchronize() callback to allow proper
synchronization when stopping a channel. Since the driver already makes
sure that no new complete callbacks are scheduled after the
device_terminate_all() callback has been called, all left to do in the
device_synchronize() callback is to wait for all currently running complete
callbacks to finish.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/dma-axi-dmac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5b2395e..c346809 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -307,6 +307,13 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
+static void axi_dmac_synchronize(struct dma_chan *c)
+{
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+
+	vchan_synchronize(&chan->vchan);
+}
+
 static void axi_dmac_issue_pending(struct dma_chan *c)
 {
 	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
@@ -613,6 +620,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_prep_dma_cyclic = axi_dmac_prep_dma_cyclic;
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
+	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
 	dma_dev->chancnt = 1;
 	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-- 
2.1.4
