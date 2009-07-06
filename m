From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] ASoC: davinci: update after EDMA interface
	changes
Date: Mon,  6 Jul 2009 15:02:02 -0700
Message-ID: <1246917723-27071-2-git-send-email-khilman@deeprootsystems.com>
References: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D7B210387D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:02:09 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1612667wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 15:02:08 -0700 (PDT)
In-Reply-To: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Reviewed-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 sound/soc/davinci/davinci-evm.c |    8 ++++----
 sound/soc/davinci/davinci-pcm.c |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 58fd1cb..832d5db 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -175,8 +175,8 @@ static struct resource evm_snd_resources[] = {
 };
 
 static struct evm_snd_platform_data evm_snd_data = {
-	.tx_dma_ch	= DAVINCI_DMA_ASP0_TX,
-	.rx_dma_ch	= DAVINCI_DMA_ASP0_RX,
+	.tx_dma_ch	= EDMA_CTLR_CHAN(0, DAVINCI_DMA_ASP0_TX),
+	.rx_dma_ch	= EDMA_CTLR_CHAN(0, DAVINCI_DMA_ASP0_RX),
 };
 
 /* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
@@ -189,8 +189,8 @@ static struct resource dm335evm_snd_resources[] = {
 };
 
 static struct evm_snd_platform_data dm335evm_snd_data = {
-	.tx_dma_ch	= DAVINCI_DMA_ASP1_TX,
-	.rx_dma_ch	= DAVINCI_DMA_ASP1_RX,
+	.tx_dma_ch	= EDMA_CTLR_CHAN(0, DAVINCI_DMA_ASP1_TX),
+	.rx_dma_ch	= EDMA_CTLR_CHAN(0, DAVINCI_DMA_ASP1_RX),
 };
 
 static struct platform_device *evm_snd_device;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index a059965..3ee38b6 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -143,7 +143,7 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 	prtd->master_lch = ret;
 
 	/* Request parameter RAM reload slot */
-	ret = edma_alloc_slot(EDMA_SLOT_ANY);
+	ret = edma_alloc_slot(EDMA_CTLR(prtd->master_lch), EDMA_SLOT_ANY);
 	if (ret < 0) {
 		edma_free_channel(prtd->master_lch);
 		return ret;
@@ -160,8 +160,8 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
 	 */
 	edma_read_slot(prtd->slave_lch, &p_ram);
-	p_ram.opt |= TCINTEN | EDMA_TCC(prtd->master_lch);
-	p_ram.link_bcntrld = prtd->slave_lch << 5;
+	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->master_lch));
+	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->slave_lch) << 5;
 	edma_write_slot(prtd->slave_lch, &p_ram);
 
 	return 0;
-- 
1.6.3.3
