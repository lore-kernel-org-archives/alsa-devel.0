From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v03 4/4] ASoC: davinci-mcasp: Move the AFIFO
	related code under start_tx/rx functions
Date: Wed, 29 Oct 2014 13:55:47 +0200
Message-ID: <1414583747-25065-5-git-send-email-peter.ujfalusi@ti.com>
References: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B4F4D2604FF
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:56:02 +0100 (CET)
In-Reply-To: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

In this way the start code for tx/rx going to be located at the same place.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 002351f9fc40..6b1bfd9de57d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -154,6 +154,13 @@ static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
 
 static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
+	if (mcasp->rxnumevt) {	/* enable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+		mcasp_set_bits(mcasp, reg, FIFO_ENABLE);
+	}
+
 	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
@@ -181,6 +188,13 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 {
 	u32 cnt;
 
+	if (mcasp->txnumevt) {	/* enable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+		mcasp_set_bits(mcasp, reg, FIFO_ENABLE);
+	}
+
 	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
@@ -201,25 +215,12 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 
 static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
 {
-	u32 reg;
-
 	mcasp->streams++;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (mcasp->txnumevt) {	/* enable FIFO */
-			reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-			mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
-			mcasp_set_bits(mcasp, reg, FIFO_ENABLE);
-		}
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		mcasp_start_tx(mcasp);
-	} else {
-		if (mcasp->rxnumevt) {	/* enable FIFO */
-			reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-			mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
-			mcasp_set_bits(mcasp, reg, FIFO_ENABLE);
-		}
+	else
 		mcasp_start_rx(mcasp);
-	}
 }
 
 static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
-- 
2.1.2
