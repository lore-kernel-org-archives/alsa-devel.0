From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] dma: Add a PAUSE_RESUME capability
Date: Wed, 29 May 2013 13:42:22 +0200
Message-ID: <1369827743-5533-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-220.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 9ECEA261ABC
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 13:42:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Scott Jiang <scott.jiang.linux@gmail.com>, Steven Miao <realmz6@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Add a capability which allows dmaengine consumers to query whether a dmaengine
controller supports the DMA_PAUSE and DMA_RESUME commands. Sometimes a user of
the dmaengine API needs to know in advance if a channel will support
pause/resume. E.g. in ALSA the information whether it is possible to
pause/resume a audio stream or whether it is necessary to abort and restart the
stream is communicated to userspace so it can act accordingly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/dmaengine.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 96d3e4a..ad98dfb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -74,6 +74,7 @@ enum dma_transaction_type {
 	DMA_SLAVE,
 	DMA_CYCLIC,
 	DMA_INTERLEAVE,
+	DMA_PAUSE_RESUME,
 /* last transaction type for creation of the capabilities mask */
 	DMA_TX_TYPE_END,
 };
-- 
1.8.0
