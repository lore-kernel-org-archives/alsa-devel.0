From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v03 2/4] ASoC: davinci-mcasp: Correct RX start
	sequence
Date: Wed, 29 Oct 2014 13:55:45 +0200
Message-ID: <1414583747-25065-3-git-send-email-peter.ujfalusi@ti.com>
References: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A42F260526
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

Follow the sequence described in the TRMs when starting RX.
Write to RXBUF register was not correct and there is no need to release the
RX state machine/Receive frame sync generator twice.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e1c1f40dd77f..142da94f8878 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -154,9 +154,9 @@ static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
 
 static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
+	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
-
 	/*
 	 * When ASYNC == 0 the transmit and receive sections operate
 	 * synchronously from the transmit clock and frame sync. We need to make
@@ -167,16 +167,12 @@ static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
 	}
 
+	/* Activate serializer(s) */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXBUF_REG, 0);
-
-	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
-	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXBUF_REG, 0);
-
+	/* Release RX state machine */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	/* Release Frame Sync generator */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
-
 	if (mcasp_is_synchronous(mcasp))
 		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
 }
-- 
2.1.2
