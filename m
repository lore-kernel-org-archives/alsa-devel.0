From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] ASoC: davinci-mcasp: When stopping
	TX/RX stop the AFIFO as the last step
Date: Fri, 28 Mar 2014 11:25:16 +0200
Message-ID: <1395998717-27067-4-git-send-email-peter.ujfalusi@ti.com>
References: <1395998717-27067-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 43FFC2654AD
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 10:25:29 +0100 (CET)
In-Reply-To: <1395998717-27067-1-git-send-email-peter.ujfalusi@ti.com>
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

The AFIFO should not be stopped (or started for that matter) when McASP is
running since it can cause unpredictable issues because we are switching off
AFIFO for the direction which was handling the requests from McASP and was
generating DMA request toward the system DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0250353dc6ab..b1926f9096e5 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -215,6 +215,12 @@ static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, 0);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+
+	if (mcasp->rxnumevt) {	/* disable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+	}
 }
 
 static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
@@ -230,27 +236,22 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, val);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+
+	if (mcasp->txnumevt) {	/* disable FIFO */
+		u32 reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+
+		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
+	}
 }
 
 static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
 {
-	u32 reg;
-
 	mcasp->streams--;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (mcasp->txnumevt) {	/* disable FIFO */
-			reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-			mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
-		}
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		mcasp_stop_tx(mcasp);
-	} else {
-		if (mcasp->rxnumevt) {	/* disable FIFO */
-			reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-			mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
-		}
+	else
 		mcasp_stop_rx(mcasp);
-	}
 }
 
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
-- 
1.9.1
