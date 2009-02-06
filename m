From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/3] ASoC: Blackfin: drop unnecessary dma casts
Date: Fri,  6 Feb 2009 18:12:35 +0800
Message-ID: <1233915156-17985-3-git-send-email-cooloney@kernel.org>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 7915C1037ED
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:10:44 +0100 (CET)
In-Reply-To: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Bryan Wu <cooloney@kernel.org>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-sport.c |  104 ++++++++++++++++----------------------
 1 files changed, 43 insertions(+), 61 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 3b99e48..b7953c8 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -133,7 +133,7 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 	int i;
 
 	for (i = 0; i < fragcount; ++i) {
-		desc[i].next_desc_addr  = (unsigned long)&(desc[i + 1]);
+		desc[i].next_desc_addr  = &(desc[i + 1]);
 		desc[i].start_addr = (unsigned long)buf + i*fragsize;
 		desc[i].cfg = cfg;
 		desc[i].x_count = x_count;
@@ -143,12 +143,12 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 	}
 
 	/* make circular */
-	desc[fragcount-1].next_desc_addr = (unsigned long)desc;
+	desc[fragcount-1].next_desc_addr = desc;
 
-	pr_debug("setup desc: desc0=%p, next0=%lx, desc1=%p,"
-		"next1=%lx\nx_count=%x,y_count=%x,addr=0x%lx,cfs=0x%x\n",
-		&(desc[0]), desc[0].next_desc_addr,
-		&(desc[1]), desc[1].next_desc_addr,
+	pr_debug("setup desc: desc0=%p, next0=%p, desc1=%p,"
+		"next1=%p\nx_count=%x,y_count=%x,addr=0x%lx,cfs=0x%x\n",
+		desc, desc[0].next_desc_addr,
+		desc+1, desc[1].next_desc_addr,
 		desc[0].x_count, desc[0].y_count,
 		desc[0].start_addr, desc[0].cfg);
 }
@@ -184,22 +184,20 @@ static inline int sport_hook_rx_dummy(struct sport_device *sport)
 	BUG_ON(sport->curr_rx_desc == sport->dummy_rx_desc);
 
 	/* Maybe the dummy buffer descriptor ring is damaged */
-	sport->dummy_rx_desc->next_desc_addr = \
-			(unsigned long)(sport->dummy_rx_desc+1);
+	sport->dummy_rx_desc->next_desc_addr = sport->dummy_rx_desc + 1;
 
 	local_irq_save(flags);
-	desc = (struct dmasg *)get_dma_next_desc_ptr(sport->dma_rx_chan);
+	desc = get_dma_next_desc_ptr(sport->dma_rx_chan);
 	/* Copy the descriptor which will be damaged to backup */
 	temp_desc = *desc;
 	desc->x_count = 0xa;
 	desc->y_count = 0;
-	desc->next_desc_addr = (unsigned long)(sport->dummy_rx_desc);
+	desc->next_desc_addr = sport->dummy_rx_desc;
 	local_irq_restore(flags);
 	/* Waiting for dummy buffer descriptor is already hooked*/
 	while ((get_dma_curr_desc_ptr(sport->dma_rx_chan) -
-			sizeof(struct dmasg)) !=
-			(unsigned long)sport->dummy_rx_desc)
-		;
+			sizeof(struct dmasg)) != sport->dummy_rx_desc)
+		continue;
 	sport->curr_rx_desc = sport->dummy_rx_desc;
 	/* Restore the damaged descriptor */
 	*desc = temp_desc;
@@ -210,14 +208,12 @@ static inline int sport_hook_rx_dummy(struct sport_device *sport)
 static inline int sport_rx_dma_start(struct sport_device *sport, int dummy)
 {
 	if (dummy) {
-		sport->dummy_rx_desc->next_desc_addr = \
-				(unsigned long) sport->dummy_rx_desc;
+		sport->dummy_rx_desc->next_desc_addr = sport->dummy_rx_desc;
 		sport->curr_rx_desc = sport->dummy_rx_desc;
 	} else
 		sport->curr_rx_desc = sport->dma_rx_desc;
 
-	set_dma_next_desc_addr(sport->dma_rx_chan, \
-			(unsigned long)(sport->curr_rx_desc));
+	set_dma_next_desc_addr(sport->dma_rx_chan, sport->curr_rx_desc);
 	set_dma_x_count(sport->dma_rx_chan, 0);
 	set_dma_x_modify(sport->dma_rx_chan, 0);
 	set_dma_config(sport->dma_rx_chan, (DMAFLOW_LARGE | NDSIZE_9 | \
@@ -231,14 +227,12 @@ static inline int sport_rx_dma_start(struct sport_device *sport, int dummy)
 static inline int sport_tx_dma_start(struct sport_device *sport, int dummy)
 {
 	if (dummy) {
-		sport->dummy_tx_desc->next_desc_addr = \
-				(unsigned long) sport->dummy_tx_desc;
+		sport->dummy_tx_desc->next_desc_addr = sport->dummy_tx_desc;
 		sport->curr_tx_desc = sport->dummy_tx_desc;
 	} else
 		sport->curr_tx_desc = sport->dma_tx_desc;
 
-	set_dma_next_desc_addr(sport->dma_tx_chan, \
-			(unsigned long)(sport->curr_tx_desc));
+	set_dma_next_desc_addr(sport->dma_tx_chan, sport->curr_tx_desc);
 	set_dma_x_count(sport->dma_tx_chan, 0);
 	set_dma_x_modify(sport->dma_tx_chan, 0);
 	set_dma_config(sport->dma_tx_chan,
@@ -261,11 +255,9 @@ int sport_rx_start(struct sport_device *sport)
 		BUG_ON(sport->curr_rx_desc != sport->dummy_rx_desc);
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_rx_chan) -
-			sizeof(struct dmasg)) !=
-			(unsigned long)sport->dummy_rx_desc)
-			;
-		sport->dummy_rx_desc->next_desc_addr =
-				(unsigned long)(sport->dma_rx_desc);
+			sizeof(struct dmasg)) != sport->dummy_rx_desc)
+			continue;
+		sport->dummy_rx_desc->next_desc_addr = sport->dma_rx_desc;
 		local_irq_restore(flags);
 		sport->curr_rx_desc = sport->dma_rx_desc;
 	} else {
@@ -310,23 +302,21 @@ static inline int sport_hook_tx_dummy(struct sport_device *sport)
 	BUG_ON(sport->dummy_tx_desc == NULL);
 	BUG_ON(sport->curr_tx_desc == sport->dummy_tx_desc);
 
-	sport->dummy_tx_desc->next_desc_addr = \
-			(unsigned long)(sport->dummy_tx_desc+1);
+	sport->dummy_tx_desc->next_desc_addr = sport->dummy_tx_desc + 1;
 
 	/* Shorten the time on last normal descriptor */
 	local_irq_save(flags);
-	desc = (struct dmasg *)get_dma_next_desc_ptr(sport->dma_tx_chan);
+	desc = get_dma_next_desc_ptr(sport->dma_tx_chan);
 	/* Store the descriptor which will be damaged */
 	temp_desc = *desc;
 	desc->x_count = 0xa;
 	desc->y_count = 0;
-	desc->next_desc_addr = (unsigned long)(sport->dummy_tx_desc);
+	desc->next_desc_addr = sport->dummy_tx_desc;
 	local_irq_restore(flags);
 	/* Waiting for dummy buffer descriptor is already hooked*/
 	while ((get_dma_curr_desc_ptr(sport->dma_tx_chan) - \
-			sizeof(struct dmasg)) != \
-			(unsigned long)sport->dummy_tx_desc)
-		;
+			sizeof(struct dmasg)) != sport->dummy_tx_desc)
+		continue;
 	sport->curr_tx_desc = sport->dummy_tx_desc;
 	/* Restore the damaged descriptor */
 	*desc = temp_desc;
@@ -347,11 +337,9 @@ int sport_tx_start(struct sport_device *sport)
 		/* Hook the normal buffer descriptor */
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_tx_chan) -
-			sizeof(struct dmasg)) !=
-			(unsigned long)sport->dummy_tx_desc)
-			;
-		sport->dummy_tx_desc->next_desc_addr =
-				(unsigned long)(sport->dma_tx_desc);
+			sizeof(struct dmasg)) != sport->dummy_tx_desc)
+			continue;
+		sport->dummy_tx_desc->next_desc_addr = sport->dma_tx_desc;
 		local_irq_restore(flags);
 		sport->curr_tx_desc = sport->dma_tx_desc;
 	} else {
@@ -536,19 +524,17 @@ static int sport_config_rx_dummy(struct sport_device *sport)
 	unsigned config;
 
 	pr_debug("%s entered\n", __func__);
-#if L1_DATA_A_LENGTH != 0
-	desc = (struct dmasg *) l1_data_sram_alloc(2 * sizeof(*desc));
-#else
-	{
+	if (L1_DATA_A_LENGTH)
+		desc = l1_data_sram_zalloc(2 * sizeof(*desc));
+	else {
 		dma_addr_t addr;
 		desc = dma_alloc_coherent(NULL, 2 * sizeof(*desc), &addr, 0);
+		memset(desc, 0, 2 * sizeof(*desc));
 	}
-#endif
 	if (desc == NULL) {
 		pr_err("Failed to allocate memory for dummy rx desc\n");
 		return -ENOMEM;
 	}
-	memset(desc, 0, 2 * sizeof(*desc));
 	sport->dummy_rx_desc = desc;
 	desc->start_addr = (unsigned long)sport->dummy_buf;
 	config = DMAFLOW_LARGE | NDSIZE_9 | compute_wdsize(sport->wdsize)
@@ -559,8 +545,8 @@ static int sport_config_rx_dummy(struct sport_device *sport)
 	desc->y_count = 0;
 	desc->y_modify = 0;
 	memcpy(desc+1, desc, sizeof(*desc));
-	desc->next_desc_addr = (unsigned long)(desc+1);
-	desc[1].next_desc_addr = (unsigned long)desc;
+	desc->next_desc_addr = desc + 1;
+	desc[1].next_desc_addr = desc;
 	return 0;
 }
 
@@ -571,19 +557,17 @@ static int sport_config_tx_dummy(struct sport_device *sport)
 
 	pr_debug("%s entered\n", __func__);
 
-#if L1_DATA_A_LENGTH != 0
-	desc = (struct dmasg *) l1_data_sram_alloc(2 * sizeof(*desc));
-#else
-	{
+	if (L1_DATA_A_LENGTH)
+		desc = l1_data_sram_zalloc(2 * sizeof(*desc));
+	else {
 		dma_addr_t addr;
 		desc = dma_alloc_coherent(NULL, 2 * sizeof(*desc), &addr, 0);
+		memset(desc, 0, 2 * sizeof(*desc));
 	}
-#endif
 	if (!desc) {
 		pr_err("Failed to allocate memory for dummy tx desc\n");
 		return -ENOMEM;
 	}
-	memset(desc, 0, 2 * sizeof(*desc));
 	sport->dummy_tx_desc = desc;
 	desc->start_addr = (unsigned long)sport->dummy_buf + \
 		sport->dummy_count;
@@ -595,8 +579,8 @@ static int sport_config_tx_dummy(struct sport_device *sport)
 	desc->y_count = 0;
 	desc->y_modify = 0;
 	memcpy(desc+1, desc, sizeof(*desc));
-	desc->next_desc_addr = (unsigned long)(desc+1);
-	desc[1].next_desc_addr = (unsigned long)desc;
+	desc->next_desc_addr = desc + 1;
+	desc[1].next_desc_addr = desc;
 	return 0;
 }
 
@@ -872,17 +856,15 @@ struct sport_device *sport_init(struct sport_param *param, unsigned wdsize,
 	sport->wdsize = wdsize;
 	sport->dummy_count = dummy_count;
 
-#if L1_DATA_A_LENGTH != 0
-	sport->dummy_buf = l1_data_sram_alloc(dummy_count * 2);
-#else
-	sport->dummy_buf = kmalloc(dummy_count * 2, GFP_KERNEL);
-#endif
+	if (L1_DATA_A_LENGTH)
+		sport->dummy_buf = l1_data_sram_zalloc(dummy_count * 2);
+	else
+		sport->dummy_buf = kzalloc(dummy_count * 2, GFP_KERNEL);
 	if (sport->dummy_buf == NULL) {
 		pr_err("Failed to allocate dummy buffer\n");
 		goto __error;
 	}
 
-	memset(sport->dummy_buf, 0, dummy_count * 2);
 	ret = sport_config_rx_dummy(sport);
 	if (ret) {
 		pr_err("Failed to config rx dummy ring\n");
@@ -939,6 +921,7 @@ void sport_done(struct sport_device *sport)
 		sport = NULL;
 }
 EXPORT_SYMBOL(sport_done);
+
 /*
 * It is only used to send several bytes when dma is not enabled
  * sport controller is configured but not enabled.
@@ -1029,4 +1012,3 @@ EXPORT_SYMBOL(sport_send_and_recv);
 MODULE_AUTHOR("Roy Huang");
 MODULE_DESCRIPTION("SPORT driver for ADI Blackfin");
 MODULE_LICENSE("GPL");
-
-- 
1.5.6.3
