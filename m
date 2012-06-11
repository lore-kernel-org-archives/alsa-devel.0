From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/3] dmaengine: Add wrapper for
	device_tx_status callback
Date: Mon, 11 Jun 2012 20:11:40 +0200
Message-ID: <1339438302-12417-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-199.synserver.de (smtp-out-208.synserver.de
	[212.40.185.208])
	by alsa0.perex.cz (Postfix) with ESMTP id DE8D7104023
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 20:11:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Mika Westerberg <mika.westerberg@iki.fi>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds a small inline wrapper for the devivce_tx_status callback of a
dma device. This makes the source code of users of this function a bit more
compact and a bit more legible.

E.g.:
-status = chan->device->device_tx_status(chan, cookie, &state)
+status = dmaengine_tx_status(chan, cookie, &state)

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
No changes since v1

---
 include/linux/dmaengine.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 56377df..cc0756a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -670,6 +670,12 @@ static inline int dmaengine_resume(struct dma_chan *chan)
 	return dmaengine_device_control(chan, DMA_RESUME, 0);
 }
 
+static inline enum dma_status dmaengine_tx_status(struct dma_chan *chan,
+	dma_cookie_t cookie, struct dma_tx_state *state)
+{
+	return chan->device->device_tx_status(chan, cookie, state);
+}
+
 static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc)
 {
 	return desc->tx_submit(desc);
-- 
1.7.10
