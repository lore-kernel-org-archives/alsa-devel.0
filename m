From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] dmaengine: virt-dma: Add synchronization helper function
Date: Tue, 20 Oct 2015 11:46:29 +0200
Message-ID: <1445334391-12272-3-git-send-email-lars@metafoo.de>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445334391-12272-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Laurent Pinchart <renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Qiao Zhou <zhouqiao@marvell.com>, Shengjiu Wang <shengjiu.wang@freescale.com>, Matt Campbell <mcampbell@izotope.com>, Jonah Petri <jpetri@izotope.com>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Add a synchronize helper function for the virt-dma library. The function
makes sure that any scheduled descriptor complete callbacks have finished
running before the function returns.

This needs to be called by drivers using virt-dma in their
device_synchronize() callback. Depending on the driver additional
operations might be necessary in addition to calling vchan_synchronize() to
ensure proper synchronization.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/virt-dma.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 181b9526..e93de76 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -151,4 +151,17 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 	vchan_dma_desc_free_list(vc, &head);
 }
 
+/**
+ * vchan_synchronize() - synchronize callback execution to the current context
+ * @vc: virtual channel to synchronize
+ *
+ * Makes sure that all scheduled or active callbacks have finished running. For
+ * proper operation the caller has to ensure that no new callbacks are scheduled
+ * after the invocation of this function started.
+ */
+static inline void vchan_synchronize(struct virt_dma_chan *vc)
+{
+	tasklet_kill(&vc->task);
+}
+
 #endif
-- 
2.1.4
