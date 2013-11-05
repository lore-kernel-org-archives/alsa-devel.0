From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/31] ASoC: txx9: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:40:07 +0100
Message-ID: <1383673218-18405-21-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4921326524F
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/txx9/txx9aclc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 45a6428cba8d..fbd077f4de72 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -115,8 +115,8 @@ static void txx9aclc_dma_complete(void *arg)
 	spin_lock_irqsave(&dmadata->dma_lock, flags);
 	if (dmadata->frag_count >= 0) {
 		dmadata->dmacount--;
-		BUG_ON(dmadata->dmacount < 0);
-		tasklet_schedule(&dmadata->tasklet);
+		if (!WARN_ON(dmadata->dmacount < 0))
+			tasklet_schedule(&dmadata->tasklet);
 	}
 	spin_unlock_irqrestore(&dmadata->dma_lock, flags);
 }
@@ -181,7 +181,10 @@ static void txx9aclc_dma_tasklet(unsigned long data)
 		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
 		return;
 	}
-	BUG_ON(dmadata->dmacount >= NR_DMA_CHAIN);
+	if (WARN_ON(dmadata->dmacount >= NR_DMA_CHAIN)) {
+		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+		return;
+	}
 	while (dmadata->dmacount < NR_DMA_CHAIN) {
 		dmadata->dmacount++;
 		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
-- 
1.8.4.2
