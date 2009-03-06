From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 4/5] ASoC: Blackfin: drop pointless casts due
	to dma updates
Date: Fri,  6 Mar 2009 15:53:29 +0800
Message-ID: <1236326010-683-5-git-send-email-cooloney@kernel.org>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E0341038AF
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 08:51:24 +0100 (CET)
In-Reply-To: <1236326010-683-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/blackfin/bf53x_sport.c |   55 ++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/sound/blackfin/bf53x_sport.c b/sound/blackfin/bf53x_sport.c
index 8dfa694..23ef579 100644
--- a/sound/blackfin/bf53x_sport.c
+++ b/sound/blackfin/bf53x_sport.c
@@ -165,7 +165,7 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 	int i;
 
 	for (i=0; i<fragcount; ++i) {
-		desc[i].next_desc_addr  = (unsigned long)&(desc[i + 1]);
+		desc[i].next_desc_addr  = &desc[i + 1];
 		desc[i].start_addr = (unsigned long)buf + i*fragsize;
 		desc[i].cfg = cfg;
 		desc[i].x_count = x_count;
@@ -175,7 +175,7 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 	}
 
 	/* make circular */
-	desc[fragcount-1].next_desc_addr = (unsigned long)desc;
+	desc[fragcount-1].next_desc_addr = desc;
 
 	/* printk(KERN_ERR "setup desc: desc0=%p, next0=%lx, desc1=%p,"
 		"next1=%lx\nx_count=%x,y_count=%x,addr=0x%lx,cfs=0x%x\n",
@@ -217,8 +217,7 @@ static inline int sport_hook_rx_dummy(struct bf53x_sport *sport)
 	SPORT_ASSERT(sport->dummy_rx_desc != NULL);
 	SPORT_ASSERT(sport->curr_rx_desc != sport->dummy_rx_desc);
 
-	sport->dummy_rx_desc->next_desc_addr = \
-			(unsigned long)(sport->dummy_rx_desc+1);
+	sport->dummy_rx_desc->next_desc_addr = sport->dummy_rx_desc + 1;
 
 	local_irq_save(flags);
 	desc = (struct dmasg *)get_dma_next_desc_ptr(sport->dma_rx_chan);
@@ -226,12 +225,12 @@ static inline int sport_hook_rx_dummy(struct bf53x_sport *sport)
 	temp_desc = *desc;
 	desc->x_count=0x10;
 	desc->y_count=0;
-	desc->next_desc_addr = (unsigned long)(sport->dummy_rx_desc);
+	desc->next_desc_addr = sport->dummy_rx_desc;
 	local_irq_restore(flags);
 	/* Waiting for dummy buffer descriptor is already hooked*/
 	while ((get_dma_curr_desc_ptr(sport->dma_rx_chan) - \
-			sizeof(struct dmasg)) != \
-			(unsigned long)sport->dummy_rx_desc) {}
+	        sizeof(struct dmasg)) != sport->dummy_rx_desc)
+		continue;
 	sport->curr_rx_desc = sport->dummy_rx_desc;
 	/* Restore the damaged descriptor */
 	*desc = temp_desc;
@@ -244,13 +243,12 @@ static inline int sport_rx_dma_start(struct bf53x_sport *sport, int dummy)
 	struct dma_register *dma = sport->dma_rx;
 
 	if (dummy) {
-		sport->dummy_rx_desc->next_desc_addr = \
-				(unsigned long) sport->dummy_rx_desc;
+		sport->dummy_rx_desc->next_desc_addr = sport->dummy_rx_desc;
 		sport->curr_rx_desc = sport->dummy_rx_desc;
 	} else
 		sport->curr_rx_desc = sport->dma_rx_desc;
 
-	dma->next_desc_ptr = (unsigned long)(sport->curr_rx_desc);
+	dma->next_desc_ptr = sport->curr_rx_desc;
 	dma->cfg           = DMAFLOW_LARGE | NDSIZE_9 | WDSIZE_32 | WNR;
 	dma->x_count       = 0;
 	dma->x_modify      = 0;
@@ -267,13 +265,12 @@ static inline int sport_tx_dma_start(struct bf53x_sport *sport, int dummy)
 	struct dma_register *dma = sport->dma_tx;
 
 	if (dummy) {
-		sport->dummy_tx_desc->next_desc_addr = \
-				(unsigned long) sport->dummy_tx_desc;
+		sport->dummy_tx_desc->next_desc_addr = sport->dummy_tx_desc;
 		sport->curr_tx_desc = sport->dummy_tx_desc;
 	} else
 		sport->curr_tx_desc = sport->dma_tx_desc;
 
-	dma->next_desc_ptr = (unsigned long)(sport->curr_tx_desc);
+	dma->next_desc_ptr = sport->curr_tx_desc;
 	dma->cfg           = DMAFLOW_LARGE | NDSIZE_9 | WDSIZE_32 ;
 	dma->x_count       = 0;
 	dma->x_modify      = 0;
@@ -298,10 +295,9 @@ int bf53x_sport_rx_start(struct bf53x_sport *sport)
 		SPORT_ASSERT(sport->curr_rx_desc == sport->dummy_rx_desc);
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_rx_chan) - \
-			sizeof(struct dmasg)) != \
-			(unsigned long)sport->dummy_rx_desc) {}
-		sport->dummy_rx_desc->next_desc_addr = \
-				(unsigned long)(sport->dma_rx_desc);
+		        sizeof(struct dmasg)) != sport->dummy_rx_desc)
+			continue;
+		sport->dummy_rx_desc->next_desc_addr = sport->dma_rx_desc;
 		local_irq_restore(flags);
 		sport->curr_rx_desc = sport->dma_rx_desc;
 	} else {
@@ -343,8 +339,7 @@ static inline int sport_hook_tx_dummy(struct bf53x_sport *sport)
 	SPORT_ASSERT(sport->dummy_tx_desc != NULL);
 	SPORT_ASSERT(sport->curr_tx_desc != sport->dummy_tx_desc);
 
-	sport->dummy_tx_desc->next_desc_addr = \
-			(unsigned long)(sport->dummy_tx_desc+1);
+	sport->dummy_tx_desc->next_desc_addr = sport->dummy_tx_desc + 1;
 
 	/* Shorten the time on last normal descriptor */
 	local_irq_save(flags);
@@ -353,12 +348,12 @@ static inline int sport_hook_tx_dummy(struct bf53x_sport *sport)
 	temp_desc = *desc;
 	desc->x_count = 0x10;
 	desc->y_count = 0;
-	desc->next_desc_addr = (unsigned long)(sport->dummy_tx_desc);
+	desc->next_desc_addr = sport->dummy_tx_desc;
 	local_irq_restore(flags);
 	/* Waiting for dummy buffer descriptor is already hooked*/
 	while ((get_dma_curr_desc_ptr(sport->dma_tx_chan) - \
-			sizeof(struct dmasg)) != \
-			(unsigned long)sport->dummy_tx_desc) {}
+	        sizeof(struct dmasg)) != sport->dummy_tx_desc)
+		continue;
 	sport->curr_tx_desc = sport->dummy_tx_desc;
 	/* Restore the damaged descriptor */
 	*desc = temp_desc;
@@ -381,10 +376,9 @@ int bf53x_sport_tx_start(struct bf53x_sport *sport)
 		/* Hook the normal buffer descriptor */
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_tx_chan) - \
-			sizeof(struct dmasg)) != \
-			(unsigned long)sport->dummy_tx_desc) {}
-		sport->dummy_tx_desc->next_desc_addr = \
-				(unsigned long)(sport->dma_tx_desc);
+		       sizeof(struct dmasg)) != sport->dummy_tx_desc)
+			continue;
+		sport->dummy_tx_desc->next_desc_addr = sport->dma_tx_desc;
 		local_irq_restore(flags);
 		sport->curr_tx_desc = sport->dma_tx_desc;
 	} else {
@@ -587,8 +581,8 @@ static int sport_config_rx_dummy(struct bf53x_sport *sport, size_t size)
 	desc->y_count = 0;
 	desc->y_modify = 0;
 	memcpy(desc+1, desc, sizeof(*desc));
-	desc->next_desc_addr = (unsigned long)(desc+1);
-	desc[1].next_desc_addr = (unsigned long)desc;
+	desc->next_desc_addr = desc + 1;
+	desc[1].next_desc_addr = desc;
 
 	return 0;
 }
@@ -623,8 +617,8 @@ static int sport_config_tx_dummy(struct bf53x_sport *sport, size_t size)
 	desc->y_count = 0;
 	desc->y_modify = 0;
 	memcpy(desc+1, desc, sizeof(*desc));
-	desc->next_desc_addr = (unsigned long)(desc+1);
-	desc[1].next_desc_addr = (unsigned long)desc;
+	desc->next_desc_addr = desc + 1;
+	desc[1].next_desc_addr = desc;
 
 	return 0;
 }
@@ -918,6 +912,5 @@ void bf53x_sport_done(struct bf53x_sport *sport)
 	free_dma(sport->dma_tx_chan);
 	free_irq(sport->err_irq, sport);
 
-
 	kfree(sport);
 }
-- 
1.5.6.3
