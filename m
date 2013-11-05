From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/31] ASoC: blackfin: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:48 +0100
Message-ID: <1383673218-18405-2-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 40451265287
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:47 +0100 (CET)
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: uclinux-dist-devel@blackfin.uclinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/blackfin/bf5xx-sport.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 695351241db8..9dfa1241ea66 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -179,8 +179,9 @@ static inline int sport_hook_rx_dummy(struct sport_device *sport)
 	struct dmasg *desc, temp_desc;
 	unsigned long flags;
 
-	BUG_ON(sport->dummy_rx_desc == NULL);
-	BUG_ON(sport->curr_rx_desc == sport->dummy_rx_desc);
+	if (WARN_ON(!sport->dummy_rx_desc) ||
+	    WARN_ON(sport->curr_rx_desc == sport->dummy_rx_desc))
+		return -EINVAL;
 
 	/* Maybe the dummy buffer descriptor ring is damaged */
 	sport->dummy_rx_desc->next_desc_addr = sport->dummy_rx_desc + 1;
@@ -250,8 +251,9 @@ int sport_rx_start(struct sport_device *sport)
 		return -EBUSY;
 	if (sport->tx_run) {
 		/* tx is running, rx is not running */
-		BUG_ON(sport->dma_rx_desc == NULL);
-		BUG_ON(sport->curr_rx_desc != sport->dummy_rx_desc);
+		if (WARN_ON(!sport->dma_rx_desc) ||
+		    WARN_ON(sport->curr_rx_desc != sport->dummy_rx_desc))
+			return -EINVAL;
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_rx_chan) -
 			sizeof(struct dmasg)) != sport->dummy_rx_desc)
@@ -298,8 +300,9 @@ static inline int sport_hook_tx_dummy(struct sport_device *sport)
 	struct dmasg *desc, temp_desc;
 	unsigned long flags;
 
-	BUG_ON(sport->dummy_tx_desc == NULL);
-	BUG_ON(sport->curr_tx_desc == sport->dummy_tx_desc);
+	if (WARN_ON(!sport->dummy_tx_desc) ||
+	    WARN_ON(sport->curr_tx_desc == sport->dummy_tx_desc))
+		return -EINVAL;
 
 	sport->dummy_tx_desc->next_desc_addr = sport->dummy_tx_desc + 1;
 
@@ -331,8 +334,9 @@ int sport_tx_start(struct sport_device *sport)
 	if (sport->tx_run)
 		return -EBUSY;
 	if (sport->rx_run) {
-		BUG_ON(sport->dma_tx_desc == NULL);
-		BUG_ON(sport->curr_tx_desc != sport->dummy_tx_desc);
+		if (WARN_ON(!sport->dma_tx_desc) ||
+		    WARN_ON(sport->curr_tx_desc != sport->dummy_tx_desc))
+			return -EINVAL;
 		/* Hook the normal buffer descriptor */
 		local_irq_save(flags);
 		while ((get_dma_curr_desc_ptr(sport->dma_tx_chan) -
@@ -767,7 +771,8 @@ static irqreturn_t err_handler(int irq, void *dev_id)
 int sport_set_rx_callback(struct sport_device *sport,
 		       void (*rx_callback)(void *), void *rx_data)
 {
-	BUG_ON(rx_callback == NULL);
+	if (WARN_ON(!rx_callback))
+		return -EINVAL;
 	sport->rx_callback = rx_callback;
 	sport->rx_data = rx_data;
 
@@ -778,7 +783,8 @@ EXPORT_SYMBOL(sport_set_rx_callback);
 int sport_set_tx_callback(struct sport_device *sport,
 		void (*tx_callback)(void *), void *tx_data)
 {
-	BUG_ON(tx_callback == NULL);
+	if (WARN_ON(!tx_callback))
+		return -EINVAL;
 	sport->tx_callback = tx_callback;
 	sport->tx_data = tx_data;
 
@@ -789,7 +795,8 @@ EXPORT_SYMBOL(sport_set_tx_callback);
 int sport_set_err_callback(struct sport_device *sport,
 		void (*err_callback)(void *), void *err_data)
 {
-	BUG_ON(err_callback == NULL);
+	if (WARN_ON(!err_callback))
+		return -EINVAL;
 	sport->err_callback = err_callback;
 	sport->err_data = err_data;
 
@@ -856,7 +863,8 @@ struct sport_device *sport_init(struct platform_device *pdev,
 
 	param.wdsize = wdsize;
 	param.dummy_count = dummy_count;
-	BUG_ON(param.wdsize == 0 || param.dummy_count == 0);
+	if (WARN_ON(param.wdsize == 0 || param.dummy_count == 0))
+		return NULL;
 
 	ret = sport_config_pdev(pdev, &param);
 	if (ret)
-- 
1.8.4.2
