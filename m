From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 17/20] ASoC: davinci-mcasp: Fix synchronous
	master receive mode
Date: Thu, 14 Nov 2013 11:35:33 +0200
Message-ID: <1384421737-4467-18-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C0E55265177
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:21 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In synchronous mode both transmit and receive sections are using the TX
clocks. In setup like this the TX clocks need to be enabled when capture
is running.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 48 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 35a6292..93f2e29 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -48,6 +48,7 @@ struct davinci_mcasp {
 	u8	*serial_dir;
 	u8	version;
 	u16	bclk_lrclk_ratio;
+	int	streams;
 
 	/* McASP FIFO related */
 	u8	txnumevt;
@@ -110,10 +111,31 @@ static void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
 		printk(KERN_ERR "GBLCTL write error\n");
 }
 
+static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
+{
+	u32 rxfmctl = mcasp_get_reg(mcasp->base + DAVINCI_MCASP_RXFMCTL_REG);
+	u32 aclkxctl = mcasp_get_reg(mcasp->base + DAVINCI_MCASP_ACLKXCTL_REG);
+
+	return !(aclkxctl & TX_ASYNC) && rxfmctl & AFSRE;
+}
+
 static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
 	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
 	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
+
+	/*
+	 * When ASYNC == 0 the transmit and receive sections operate
+	 * synchronously from the transmit clock and frame sync. We need to make
+	 * sure that the TX signlas are enabled when starting reception.
+	 */
+	if (mcasp_is_synchronous(mcasp)) {
+		mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG,
+				  TXHCLKRST);
+		mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG,
+				  TXCLKRST);
+	}
+
 	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
 	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXBUF_REG, 0);
 
@@ -123,6 +145,10 @@ static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 
 	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
 	mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+
+	if (mcasp_is_synchronous(mcasp))
+		mcasp_set_ctl_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG,
+				  TXFSRST);
 }
 
 static void mcasp_start_tx(struct davinci_mcasp *mcasp)
@@ -158,6 +184,8 @@ static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
 {
 	u32 reg;
 
+	mcasp->streams++;
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (mcasp->txnumevt) {	/* enable FIFO */
 			reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
@@ -177,13 +205,29 @@ static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
 
 static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 {
+	/*
+	 * In synchronous mode stop the TX clocks if no other stream is
+	 * running
+	 */
+	if (mcasp_is_synchronous(mcasp) && !mcasp->streams)
+		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
+
 	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLR_REG, 0);
 	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
 }
 
 static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 {
-	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
+	u32 val = 0;
+
+	/*
+	 * In synchronous mode keep TX clocks running if the capture stream is
+	 * still running.
+	 */
+	if (mcasp_is_synchronous(mcasp) && mcasp->streams)
+		val =  TXHCLKRST | TXCLKRST | TXFSRST;
+
+	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_GBLCTLX_REG, val);
 	mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 }
 
@@ -191,6 +235,8 @@ static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
 {
 	u32 reg;
 
+	mcasp->streams--;
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (mcasp->txnumevt) {	/* disable FIFO */
 			reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-- 
1.8.4.2
