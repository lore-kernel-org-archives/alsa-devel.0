From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/6] dma: pl330: Set residue_granularity
Date: Sat, 11 Jan 2014 14:02:17 +0100
Message-ID: <1389445341-17227-3-git-send-email-lars@metafoo.de>
References: <1389445341-17227-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 044BD261983
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:02:01 +0100 (CET)
In-Reply-To: <1389445341-17227-1-git-send-email-lars@metafoo.de>
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

The pl330 driver currently does not support residue reporting, so set the
residue granularity to DMA_RESIDUE_GRANULARITY_DESCRIPTOR.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
No changes since v2
No changes since v1
---
 drivers/dma/pl330.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 536632f..c90edec 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2884,6 +2884,7 @@ static int pl330_dma_device_slave_caps(struct dma_chan *dchan,
 	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	caps->cmd_pause = false;
 	caps->cmd_terminate = true;
+	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
 	return 0;
 }
-- 
1.8.0
