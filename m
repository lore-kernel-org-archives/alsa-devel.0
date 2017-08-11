From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ASoC: blackfin: Add some spaces for better
 code readability
Date: Fri, 11 Aug 2017 22:43:14 +0200
Message-ID: <2c2fabf2-3238-ab23-4df8-d93c702ff51e@users.sourceforge.net>
References: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id A35F9266D12
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 22:43:21 +0200 (CEST)
In-Reply-To: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 22:20:07 +0200

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/blackfin/bf6xx-sport.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index fcddebf2558c..d2caadfe7b6d 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -129,7 +129,7 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 
 	for (i = 0; i < fragcount; ++i) {
 		desc[i].next_desc_addr  = &(desc[i + 1]);
-		desc[i].start_addr = (unsigned long)buf + i*fragsize;
+		desc[i].start_addr = (unsigned long)buf + i * fragsize;
 		desc[i].cfg = cfg;
 		desc[i].x_count = count;
 		desc[i].x_modify = wdsize;
@@ -138,7 +138,7 @@ static void setup_desc(struct dmasg *desc, void *buf, int fragcount,
 	}
 
 	/* make circular */
-	desc[fragcount-1].next_desc_addr = desc;
+	desc[fragcount - 1].next_desc_addr = desc;
 }
 
 int sport_config_tx_dma(struct sport_device *sport, void *buf,
@@ -148,7 +148,7 @@ int sport_config_tx_dma(struct sport_device *sport, void *buf,
 	unsigned int cfg;
 	dma_addr_t addr;
 
-	count = fragsize/sport->wdsize;
+	count = fragsize / sport->wdsize;
 
 	if (sport->tx_desc)
 		dma_free_coherent(NULL, sport->tx_desc_size,
@@ -166,8 +166,7 @@ int sport_config_tx_dma(struct sport_device *sport, void *buf,
 	cfg = DMAFLOW_LIST | DI_EN | compute_wdsize(sport->wdsize) | NDSIZE_6;
 
 	setup_desc(sport->tx_desc, buf, fragcount, fragsize,
-			cfg|DMAEN, count, sport->wdsize);
-
+		   cfg | DMAEN, count, sport->wdsize);
 	return 0;
 }
 EXPORT_SYMBOL(sport_config_tx_dma);
@@ -179,7 +178,7 @@ int sport_config_rx_dma(struct sport_device *sport, void *buf,
 	unsigned int cfg;
 	dma_addr_t addr;
 
-	count = fragsize/sport->wdsize;
+	count = fragsize / sport->wdsize;
 
 	if (sport->rx_desc)
 		dma_free_coherent(NULL, sport->rx_desc_size,
@@ -198,8 +197,7 @@ int sport_config_rx_dma(struct sport_device *sport, void *buf,
 		| WNR | NDSIZE_6;
 
 	setup_desc(sport->rx_desc, buf, fragcount, fragsize,
-			cfg|DMAEN, count, sport->wdsize);
-
+		   cfg | DMAEN, count, sport->wdsize);
 	return 0;
 }
 EXPORT_SYMBOL(sport_config_rx_dma);
@@ -226,7 +224,7 @@ static irqreturn_t sport_tx_irq(int irq, void *dev_id)
 	static unsigned long status;
 
 	status = get_dma_curr_irqstat(sport->tx_dma_chan);
-	if (status & (DMA_DONE|DMA_ERR)) {
+	if (status & (DMA_DONE | DMA_ERR)) {
 		clear_dma_irqstat(sport->tx_dma_chan);
 		SSYNC();
 	}
@@ -241,7 +239,7 @@ static irqreturn_t sport_rx_irq(int irq, void *dev_id)
 	unsigned long status;
 
 	status = get_dma_curr_irqstat(sport->rx_dma_chan);
-	if (status & (DMA_DONE|DMA_ERR)) {
+	if (status & (DMA_DONE | DMA_ERR)) {
 		clear_dma_irqstat(sport->rx_dma_chan);
 		SSYNC();
 	}
-- 
2.14.0
