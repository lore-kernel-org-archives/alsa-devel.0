From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 1/6] ASoC: ux500: Drop pinctrl sleep support
Date: Fri, 24 May 2013 12:39:15 +0200
Message-ID: <1369391960-27320-2-git-send-email-fabio.baltieri@linaro.org>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f49.google.com (mail-ee0-f49.google.com [74.125.83.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F1C2650C4
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 12:39:28 +0200 (CEST)
Received: by mail-ee0-f49.google.com with SMTP id d17so2482296eek.8
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 03:39:27 -0700 (PDT)
In-Reply-To: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Drop pinctrl default/sleep state switching code, as it was breaking the
capture interface by putting the I2S pins in hi-z mode regardless of its
usage status, and not giving any real benefit.

Pinctrl default mode configuration is already managed automatically by a
specific pinctrl hog.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 56 ++---------------------------------------
 sound/soc/ux500/ux500_msp_i2s.h |  6 -----
 2 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index f2db6c9..b029b2d 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -15,7 +15,6 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -26,9 +25,6 @@
 
 #include "ux500_msp_i2s.h"
 
-/* MSP1/3 Tx/Rx usage protection */
-static DEFINE_SPINLOCK(msp_rxtx_lock);
-
  /* Protocol desciptors */
 static const struct msp_protdesc prot_descs[] = {
 	{ /* I2S */
@@ -356,24 +352,8 @@ static int configure_multichannel(struct ux500_msp *msp,
 
 static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 {
-	int status = 0, retval = 0;
+	int status = 0;
 	u32 reg_val_DMACR, reg_val_GCR;
-	unsigned long flags;
-
-	/* Check msp state whether in RUN or CONFIGURED Mode */
-	if (msp->msp_state == MSP_STATE_IDLE) {
-		spin_lock_irqsave(&msp_rxtx_lock, flags);
-		if (msp->pinctrl_rxtx_ref == 0 &&
-			!(IS_ERR(msp->pinctrl_p) || IS_ERR(msp->pinctrl_def))) {
-			retval = pinctrl_select_state(msp->pinctrl_p,
-						msp->pinctrl_def);
-			if (retval)
-				pr_err("could not set MSP defstate\n");
-		}
-		if (!retval)
-			msp->pinctrl_rxtx_ref++;
-		spin_unlock_irqrestore(&msp_rxtx_lock, flags);
-	}
 
 	/* Configure msp with protocol dependent settings */
 	configure_protocol(msp, config);
@@ -630,8 +610,7 @@ int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
 
 int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 {
-	int status = 0, retval = 0;
-	unsigned long flags;
+	int status = 0;
 
 	dev_dbg(msp->dev, "%s: Enter (dir = 0x%01x).\n", __func__, dir);
 
@@ -643,18 +622,6 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 			       (~(FRAME_GEN_ENABLE | SRG_ENABLE))),
 			      msp->registers + MSP_GCR);
 
-		spin_lock_irqsave(&msp_rxtx_lock, flags);
-		WARN_ON(!msp->pinctrl_rxtx_ref);
-		msp->pinctrl_rxtx_ref--;
-		if (msp->pinctrl_rxtx_ref == 0 &&
-			!(IS_ERR(msp->pinctrl_p) || IS_ERR(msp->pinctrl_sleep))) {
-			retval = pinctrl_select_state(msp->pinctrl_p,
-						msp->pinctrl_sleep);
-			if (retval)
-				pr_err("could not set MSP sleepstate\n");
-		}
-		spin_unlock_irqrestore(&msp_rxtx_lock, flags);
-
 		writel(0, msp->registers + MSP_GCR);
 		writel(0, msp->registers + MSP_TCF);
 		writel(0, msp->registers + MSP_RCF);
@@ -743,25 +710,6 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "I2S device-name: '%s'\n", i2s_cont->name);
 	msp->i2s_cont = i2s_cont;
 
-	msp->pinctrl_p = pinctrl_get(msp->dev);
-	if (IS_ERR(msp->pinctrl_p))
-		dev_err(&pdev->dev, "could not get MSP pinctrl\n");
-	else {
-		msp->pinctrl_def = pinctrl_lookup_state(msp->pinctrl_p,
-						PINCTRL_STATE_DEFAULT);
-		if (IS_ERR(msp->pinctrl_def)) {
-			dev_err(&pdev->dev,
-				"could not get MSP defstate (%li)\n",
-				PTR_ERR(msp->pinctrl_def));
-		}
-		msp->pinctrl_sleep = pinctrl_lookup_state(msp->pinctrl_p,
-						PINCTRL_STATE_SLEEP);
-		if (IS_ERR(msp->pinctrl_sleep))
-			dev_err(&pdev->dev,
-				"could not get MSP idlestate (%li)\n",
-				PTR_ERR(msp->pinctrl_def));
-	}
-
 	return 0;
 }
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index e5cd105..8ce014e 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -528,12 +528,6 @@ struct ux500_msp {
 	int loopback_enable;
 	u32 backup_regs[MAX_MSP_BACKUP_REGS];
 	unsigned int f_bitclk;
-	/* Pin modes */
-	struct pinctrl *pinctrl_p;
-	struct pinctrl_state *pinctrl_def;
-	struct pinctrl_state *pinctrl_sleep;
-	/* Reference Count */
-	int pinctrl_rxtx_ref;
 };
 
 struct ux500_msp_dma_params {
-- 
1.8.2
