From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 3/6] ASoC: ux500: Drop dangling struct
	i2s_controller
Date: Fri, 24 May 2013 12:39:17 +0200
Message-ID: <1369391960-27320-4-git-send-email-fabio.baltieri@linaro.org>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D4C852650B9
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 12:39:34 +0200 (CEST)
Received: by mail-ea0-f169.google.com with SMTP id m14so2492824eaj.0
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 03:39:34 -0700 (PDT)
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

Drop struct i2s_controller from the ux500 ASoC driver as right now it is
instantiated but not used anywhere.  Also drop a mismatched
device_unregister in the process.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 19 -------------------
 sound/soc/ux500/ux500_msp_i2s.h | 12 ------------
 2 files changed, 31 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index b029b2d..cba0e86 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -649,7 +649,6 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 			struct msp_i2s_platform_data *platform_data)
 {
 	struct resource *res = NULL;
-	struct i2s_controller *i2s_cont;
 	struct device_node *np = pdev->dev.of_node;
 	struct ux500_msp *msp;
 
@@ -694,22 +693,6 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 	msp->msp_state = MSP_STATE_IDLE;
 	msp->loopback_enable = 0;
 
-	/* I2S-controller is allocated and added in I2S controller class. */
-	i2s_cont = devm_kzalloc(&pdev->dev, sizeof(*i2s_cont), GFP_KERNEL);
-	if (!i2s_cont) {
-		dev_err(&pdev->dev,
-			"%s: ERROR: Failed to allocate I2S-controller!\n",
-			__func__);
-		return -ENOMEM;
-	}
-	i2s_cont->dev.parent = &pdev->dev;
-	i2s_cont->data = (void *)msp;
-	i2s_cont->id = (s16)msp->id;
-	snprintf(i2s_cont->name, sizeof(i2s_cont->name), "ux500-msp-i2s.%04x",
-		msp->id);
-	dev_dbg(&pdev->dev, "I2S device-name: '%s'\n", i2s_cont->name);
-	msp->i2s_cont = i2s_cont;
-
 	return 0;
 }
 
@@ -717,8 +700,6 @@ void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
 			struct ux500_msp *msp)
 {
 	dev_dbg(msp->dev, "%s: Enter (id = %d).\n", __func__, msp->id);
-
-	device_unregister(&msp->i2s_cont->dev);
 }
 
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 8ce014e..ccfcc32 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -469,17 +469,6 @@ struct i2s_message {
 	size_t period_len;
 };
 
-struct i2s_controller {
-	struct module *owner;
-	unsigned int id;
-	unsigned int class;
-	const struct i2s_algorithm *algo; /* the algorithm to access the bus */
-	void *data;
-	struct mutex bus_lock;
-	struct device dev; /* the controller device */
-	char name[48];
-};
-
 struct ux500_msp_config {
 	unsigned int f_inputclk;
 	unsigned int rx_clk_sel;
@@ -515,7 +504,6 @@ struct ux500_msp {
 	enum enum_i2s_controller id;
 	void __iomem *registers;
 	struct device *dev;
-	struct i2s_controller *i2s_cont;
 	struct stedma40_chan_cfg *dma_cfg_rx;
 	struct stedma40_chan_cfg *dma_cfg_tx;
 	struct dma_chan *tx_pipeid;
-- 
1.8.2
