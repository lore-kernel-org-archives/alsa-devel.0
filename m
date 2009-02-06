From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 1/3] ASoC: Blackfin: cleanup sport handling in
	ASoC Blackfin AC97 code
Date: Fri,  6 Feb 2009 18:12:34 +0800
Message-ID: <1233915156-17985-2-git-send-email-cooloney@kernel.org>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 881821037EE
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:10:44 +0100 (CET)
In-Reply-To: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

- make sport number handling more dynamic as not all
  Blackfins have a linear sport map starting at 0
- indexes can be macroed away too

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97.c |   92 ++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 3be2be6..5885702 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -31,72 +31,46 @@
 #include "bf5xx-sport.h"
 #include "bf5xx-ac97.h"
 
-#if defined(CONFIG_BF54x)
-#define PIN_REQ_SPORT_0 {P_SPORT0_TFS, P_SPORT0_DTPRI, P_SPORT0_TSCLK, \
-		P_SPORT0_RFS, P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0}
-
-#define PIN_REQ_SPORT_1 {P_SPORT1_TFS, P_SPORT1_DTPRI, P_SPORT1_TSCLK, \
-		P_SPORT1_RFS, P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0}
-
-#define PIN_REQ_SPORT_2 {P_SPORT2_TFS, P_SPORT2_DTPRI, P_SPORT2_TSCLK, \
-		P_SPORT2_RFS, P_SPORT2_DRPRI, P_SPORT2_RSCLK, 0}
-
-#define PIN_REQ_SPORT_3 {P_SPORT3_TFS, P_SPORT3_DTPRI, P_SPORT3_TSCLK, \
-		P_SPORT3_RFS, P_SPORT3_DRPRI, P_SPORT3_RSCLK, 0}
-#else
-#define PIN_REQ_SPORT_0 {P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS, \
-		 P_SPORT0_DRPRI, P_SPORT0_RSCLK, 0}
-
-#define PIN_REQ_SPORT_1 {P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT1_RFS, \
-		 P_SPORT1_DRPRI, P_SPORT1_RSCLK, 0}
-#endif
-
 static int *cmd_count;
 static int sport_num = CONFIG_SND_BF5XX_SPORT_NUM;
 
+#define SPORT_REQ(x) \
+	[x] = {P_SPORT##x##_TFS, P_SPORT##x##_DTPRI, P_SPORT##x##_TSCLK, \
+	       P_SPORT##x##_RFS, P_SPORT##x##_DRPRI, P_SPORT##x##_RSCLK, 0}
 static u16 sport_req[][7] = {
-		PIN_REQ_SPORT_0,
-#ifdef PIN_REQ_SPORT_1
-		PIN_REQ_SPORT_1,
+#ifdef SPORT0_TCR1
+	SPORT_REQ(0),
 #endif
-#ifdef PIN_REQ_SPORT_2
-		PIN_REQ_SPORT_2,
+#ifdef SPORT1_TCR1
+	SPORT_REQ(1),
 #endif
-#ifdef PIN_REQ_SPORT_3
-		PIN_REQ_SPORT_3,
+#ifdef SPORT2_TCR1
+	SPORT_REQ(2),
 #endif
-	};
+#ifdef SPORT3_TCR1
+	SPORT_REQ(3),
+#endif
+};
 
+#define SPORT_PARAMS(x) \
+	[x] = { \
+		.dma_rx_chan = CH_SPORT##x##_RX, \
+		.dma_tx_chan = CH_SPORT##x##_TX, \
+		.err_irq     = IRQ_SPORT##x##_ERROR, \
+		.regs        = (struct sport_register *)SPORT##x##_TCR1, \
+	}
 static struct sport_param sport_params[4] = {
-	{
-		.dma_rx_chan	= CH_SPORT0_RX,
-		.dma_tx_chan	= CH_SPORT0_TX,
-		.err_irq	= IRQ_SPORT0_ERROR,
-		.regs		= (struct sport_register *)SPORT0_TCR1,
-	},
-#ifdef PIN_REQ_SPORT_1
-	{
-		.dma_rx_chan	= CH_SPORT1_RX,
-		.dma_tx_chan	= CH_SPORT1_TX,
-		.err_irq	= IRQ_SPORT1_ERROR,
-		.regs		= (struct sport_register *)SPORT1_TCR1,
-	},
+#ifdef SPORT0_TCR1
+	SPORT_PARAMS(0),
 #endif
-#ifdef PIN_REQ_SPORT_2
-	{
-		.dma_rx_chan	= CH_SPORT2_RX,
-		.dma_tx_chan	= CH_SPORT2_TX,
-		.err_irq	= IRQ_SPORT2_ERROR,
-		.regs		= (struct sport_register *)SPORT2_TCR1,
-	},
+#ifdef SPORT1_TCR1
+	SPORT_PARAMS(1),
 #endif
-#ifdef PIN_REQ_SPORT_3
-	{
-		.dma_rx_chan	= CH_SPORT3_RX,
-		.dma_tx_chan	= CH_SPORT3_TX,
-		.err_irq	= IRQ_SPORT3_ERROR,
-		.regs		= (struct sport_register *)SPORT3_TCR1,
-	}
+#ifdef SPORT2_TCR1
+	SPORT_PARAMS(2),
+#endif
+#ifdef SPORT3_TCR1
+	SPORT_PARAMS(3),
 #endif
 };
 
@@ -332,11 +306,11 @@ static int bf5xx_ac97_probe(struct platform_device *pdev,
 	if (cmd_count == NULL)
 		return -ENOMEM;
 
-	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
+	if (peripheral_request_list(sport_req[sport_num], "soc-audio")) {
 		pr_err("Requesting Peripherals failed\n");
 		ret =  -EFAULT;
 		goto peripheral_err;
-		}
+	}
 
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	/* Request PB3 as reset pin */
@@ -385,7 +359,7 @@ sport_err:
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
 gpio_err:
-	peripheral_free_list(&sport_req[sport_num][0]);
+	peripheral_free_list(sport_req[sport_num]);
 peripheral_err:
 	free_page((unsigned long)cmd_count);
 	cmd_count = NULL;
@@ -398,7 +372,7 @@ static void bf5xx_ac97_remove(struct platform_device *pdev,
 {
 	free_page((unsigned long)cmd_count);
 	cmd_count = NULL;
-	peripheral_free_list(&sport_req[sport_num][0]);
+	peripheral_free_list(sport_req[sport_num]);
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
-- 
1.5.6.3
