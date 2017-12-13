From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v3 06/11] ASoC: fsl_ssi: Refine printk outputs
Date: Wed, 13 Dec 2017 15:18:23 -0800
Message-ID: <1513207108-30430-7-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFFF267975
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 00:19:01 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id k15so2117620pgr.7
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 15:19:01 -0800 (PST)
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mail@maciej.szmigiero.name, timur@tabi.org, kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patches unifies the error message in the "failed to xxxx" format.

It also reduces the length of one line and adds spaces to an operator.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a3b9116..7b6aedd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -701,7 +701,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	 * never greater than 1/5 IPG clock rate
 	 */
 	if (freq * 5 > clk_get_rate(ssi->clk)) {
-		dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
+		dev_err(cpu_dai->dev, "bitclk > ipgclk / 5\n");
 		return -EINVAL;
 	}
 
@@ -873,7 +873,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	ssi->dai_fmt = fmt;
 
 	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
-		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
+		dev_err(dev, "missing baudclk for master mode\n");
 		return -EINVAL;
 	}
 
@@ -1289,7 +1289,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		ssi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ssi->clk)) {
 		ret = PTR_ERR(ssi->clk);
-		dev_err(dev, "could not get clock: %d\n", ret);
+		dev_err(dev, "failed to get clock: %d\n", ret);
 		return ret;
 	}
 
@@ -1305,7 +1305,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	/* Do not error out for slave cases that live without a baud clock */
 	ssi->baudclk = devm_clk_get(dev, "baud");
 	if (IS_ERR(ssi->baudclk))
-		dev_dbg(dev, "could not get baud clock: %ld\n",
+		dev_dbg(dev, "failed to get baud clock: %ld\n",
 			 PTR_ERR(ssi->baudclk));
 
 	ssi->dma_params_tx.maxburst = ssi->dma_maxburst;
@@ -1426,7 +1426,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 						      &regconfig);
 	}
 	if (IS_ERR(ssi->regs)) {
-		dev_err(dev, "Failed to init register map\n");
+		dev_err(dev, "failed to init register map\n");
 		return PTR_ERR(ssi->regs);
 	}
 
@@ -1485,7 +1485,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		mutex_init(&ssi->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
-			dev_err(dev, "could not set AC'97 ops\n");
+			dev_err(dev, "failed to set AC'97 ops\n");
 			goto error_ac97_ops;
 		}
 	}
@@ -1501,7 +1501,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, ssi->irq, fsl_ssi_isr, 0,
 				       dev_name(dev), ssi);
 		if (ret < 0) {
-			dev_err(dev, "could not claim irq %u\n", ssi->irq);
+			dev_err(dev, "failed to claim irq %u\n", ssi->irq);
 			goto error_asoc_register;
 		}
 	}
@@ -1543,7 +1543,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
 		if (ret) {
-			dev_err(dev, "cannot get SSI index property\n");
+			dev_err(dev, "failed to get SSI index property\n");
 			goto error_sound_card;
 		}
 
-- 
2.1.4
