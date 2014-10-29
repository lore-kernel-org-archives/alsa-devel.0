From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v03 3/4] ASoC: davinci-mcasp: When stopping
	TX/RX stop the AFIFO as the last step
Date: Wed, 29 Oct 2014 13:55:46 +0200
Message-ID: <1414583747-25065-4-git-send-email-peter.ujfalusi@ti.com>
References: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C036260537
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:56:00 +0100 (CET)
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

The AFIFO should not be stopped (or started for that matter) when McASP is
running since it can cause unpredictable issues because we are switching off
AFIFO for the direction which was handling the requests from McASP and was
generating DMA request toward the system DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 142da94f8878..002351f9fc40 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -233,6 +233,12 @@ static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 
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
@@ -248,27 +254,22 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 
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
2.1.2
