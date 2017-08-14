From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: Add some spaces for better code readability" to the asoc tree
Date: Mon, 14 Aug 2017 17:42:53 +0100
Message-ID: <E1dhIS5-0005AB-H8@finisterre>
References: <2c2fabf2-3238-ab23-4df8-d93c702ff51e@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c2fabf2-3238-ab23-4df8-d93c702ff51e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: blackfin: Add some spaces for better code readability

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 11f25bbaaa87bf583a453b202db9c8ee9b3cbd50 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 22:20:07 +0200
Subject: [PATCH] ASoC: blackfin: Add some spaces for better code readability

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
