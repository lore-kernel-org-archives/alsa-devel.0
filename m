From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v03 1/4] ASoC: davinci-mcasp: Correct TX start
	sequence
Date: Wed, 29 Oct 2014 13:55:44 +0200
Message-ID: <1414583747-25065-2-git-send-email-peter.ujfalusi@ti.com>
References: <1414583747-25065-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 83BBF260515
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:55:56 +0100 (CET)
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

Follow the sequence described in the TRMs when starting TX. This sequence
will make sure that we are not facing with initial channel swap caused by
no data available in McASP for transmit.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 25 +++++++++----------------
 sound/soc/davinci/davinci-mcasp.h |  6 ++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0eed9b1b24e1..e1c1f40dd77f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -183,31 +183,24 @@ static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 
 static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 {
-	u8 offset = 0, i;
 	u32 cnt;
 
+	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	/* Activate serializer(s) */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXBUF_REG, 0);
 
-	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
-	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXBUF_REG, 0);
-	for (i = 0; i < mcasp->num_serializer; i++) {
-		if (mcasp->serial_dir[i] == TX_MODE) {
-			offset = i;
-			break;
-		}
-	}
-
-	/* wait for TX ready */
+	/* wait for XDATA to be cleared */
 	cnt = 0;
-	while (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(offset)) &
-		 TXSTATE) && (cnt < 100000))
+	while (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) &
+		 ~XRDATA) && (cnt < 100000))
 		cnt++;
 
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXBUF_REG, 0);
+	/* Release TX state machine */
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
+	/* Release Frame Sync generator */
+	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
 }
 
 static void davinci_mcasp_start(struct davinci_mcasp *mcasp, int stream)
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 98fbc451892a..9737108f0305 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -253,6 +253,12 @@
 #define TXFSRST		BIT(12)	/* Frame Sync Generator Reset */
 
 /*
+ * DAVINCI_MCASP_TXSTAT_REG - Transmitter Status Register Bits
+ * DAVINCI_MCASP_RXSTAT_REG - Receiver Status Register Bits
+ */
+#define XRDATA		BIT(5) /* Transmit/Receive data ready */
+
+/*
  * DAVINCI_MCASP_AMUTE_REG -  Mute Control Register Bits
  */
 #define MUTENA(val)	(val)
-- 
2.1.2
