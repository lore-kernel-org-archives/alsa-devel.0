From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] dma: Indicate residue granularity in
	dma_slave_caps
Date: Sun,  8 Dec 2013 17:18:07 +0100
Message-ID: <1386519489-1935-2-git-send-email-lars@metafoo.de>
References: <1386519489-1935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 221AE261B1C
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 17:17:26 +0100 (CET)
In-Reply-To: <1386519489-1935-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds a new field to the dma_slave_caps struct which indicates the
granularity with which the driver is able to update the residue field of the
dma_tx_state struct. Making this information available to dmaengine users allows
them to make better decisions on how to operate. E.g. for audio certain features
like wakeup less operation or timer based scheduling only make sense and work
correctly if the reported residue is fine-grained enough.

Right now four different levels of granularity are supported:
	* DESCRIPTOR: The DMA channel is only able to tell whether a descriptor has
	  been completed or not, which means residue reporting is not supported by
	  this channel. The residue field of the dma_tx_state field will always be
	  0.
	* SEGMENT: The DMA channel updates the residue field after each successfully
	  completed segment of the transfer (For cyclic transfers this is after each
	  period). This is typically implemented by having the hardware generate an
	  interrupt after each transferred segment and then the drivers updates the
	  outstanding residue by the size of the segment. Another possibility is if
	  the hardware supports SG and the segment descriptor has a field which gets
	  set after the segment has been completed. The driver then counts the
	  number of segments without the flag set to compute the residue.
	* BURST: The DMA channel updates the residue field after each transferred
	  burst. This is typically only supported if the hardware has a progress
	  register of some sort (E.g. a register with the current read/write address
	  or a register with the amount of bursts/beats/bytes that have been
	  transferred or still need to be transferred).
	* BYTE: Same as BURST but with a byte level granularity.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/dmaengine.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 41cf0c3..b7a14d0 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -363,6 +363,21 @@ struct dma_slave_config {
 	unsigned int slave_id;
 };
 
+/**
+ * enum dma_residue_granularity - Granularity of the reported transfer residue
+ * @DMA_RESIDUE_GRANULATRITY_DESCRIPTOR: Residue reporting is not supported.
+ * @DMA_RESIDUE_GRANULATRITY_SEGMENT: Residue is updated with each completed
+ *  segment in the descriptor.
+ * @DMA_RESIDUE_GRANULATRITY_BURST: Residue is updated with each transfered burst
+ * @DMA_RESIDUE_GRANULATRITY_BYTE: Residue is updated with each transfered byte
+ */
+enum dma_residue_granularity {
+	DMA_RESIDUE_GRANULARITY_DESCRIPTOR = 0,
+	DMA_RESIDUE_GRANULARITY_SEGMENT = 1,
+	DMA_RESIDUE_GRANULARITY_BURST = 2,
+	DMA_RESIDUE_GRANULARITY_BYTE = 3,
+};
+
 /* struct dma_slave_caps - expose capabilities of a slave channel only
  *
  * @src_addr_widths: bit mask of src addr widths the channel supports
@@ -373,6 +388,7 @@ struct dma_slave_config {
  * 	should be checked by controller as well
  * @cmd_pause: true, if pause and thereby resume is supported
  * @cmd_terminate: true, if terminate cmd is supported
+ * @residue_granularity: granularity of the reported transfer residue
  */
 struct dma_slave_caps {
 	u32 src_addr_widths;
@@ -380,6 +396,7 @@ struct dma_slave_caps {
 	u32 directions;
 	bool cmd_pause;
 	bool cmd_terminate;
+	enum dma_residue_granularity residue_granularity;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
1.8.0
