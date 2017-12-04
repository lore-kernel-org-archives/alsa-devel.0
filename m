From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 07/10] ASoC: fsl_ssi: Refine printk outputs
Date: Mon,  4 Dec 2017 12:46:40 -0800
Message-ID: <1512420403-10164-8-git-send-email-nicoleotsuka@gmail.com>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patches unifies the error message in the "failed to xxxx" format.

It also reduces the length of one line and adds spaces to an operator.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ae5d98b..e1c985b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -694,7 +694,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	 * never greater than 1/5 IPG clock rate
 	 */
 	if (freq * 5 > clk_get_rate(ssi->clk)) {
-		dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
+		dev_err(cpu_dai->dev, "bitclk > ipgclk / 5\n");
 		return -EINVAL;
 	}
 
@@ -858,7 +858,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	ssi->dai_fmt = fmt;
 
 	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
-		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
+		dev_err(dev, "missing baudclk for master mode\n");
 		return -EINVAL;
 	}
 
@@ -1268,7 +1268,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		ssi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ssi->clk)) {
 		ret = PTR_ERR(ssi->clk);
-		dev_err(dev, "could not get clock: %d\n", ret);
+		dev_err(dev, "failed to get clock: %d\n", ret);
 		return ret;
 	}
 
@@ -1284,7 +1284,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	/* Do not error out for slave cases that live without a baud clock */
 	ssi->baudclk = devm_clk_get(dev, "baud");
 	if (IS_ERR(ssi->baudclk))
-		dev_dbg(dev, "could not get baud clock: %ld\n",
+		dev_dbg(dev, "failed to get baud clock: %ld\n",
 			 PTR_ERR(ssi->baudclk));
 
 	ssi->dma_params_tx.maxburst = ssi->dma_maxburst;
@@ -1403,7 +1403,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 						      &regconfig);
 	}
 	if (IS_ERR(ssi->regs)) {
-		dev_err(dev, "Failed to init register map\n");
+		dev_err(dev, "failed to init register map\n");
 		return PTR_ERR(ssi->regs);
 	}
 
@@ -1462,7 +1462,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		mutex_init(&ssi->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
-			dev_err(dev, "could not set AC'97 ops\n");
+			dev_err(dev, "failed to set AC'97 ops\n");
 			goto error_ac97_ops;
 		}
 	}
@@ -1478,7 +1478,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, ssi->irq, fsl_ssi_isr, 0,
 				       dev_name(dev), ssi);
 		if (ret < 0) {
-			dev_err(dev, "could not claim irq %u\n", ssi->irq);
+			dev_err(dev, "failed to claim irq %u\n", ssi->irq);
 			goto error_asoc_register;
 		}
 	}
@@ -1520,7 +1520,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
 		if (ret) {
-			dev_err(dev, "cannot get SSI index property\n");
+			dev_err(dev, "failed to get SSI index property\n");
 			goto error_sound_card;
 		}
 
-- 
2.7.4
