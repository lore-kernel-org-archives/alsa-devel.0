From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 2/3] ASoC: ux500: Set DMA address during device init
Date: Wed, 12 Jun 2013 09:57:58 +0200
Message-ID: <1371023879-21884-3-git-send-email-fabio.baltieri@linaro.org>
References: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371023879-21884-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add a field with the tx/rx register address to the DMA parameters
structure, and set it to the correct address during device
initialization.

This address used to be hardcoded in the DMA controller driver, it now
needs to be explicitly figured out by the device driver.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 3 +++
 sound/soc/ux500/ux500_msp_i2s.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 14a4a5b..1ca8b08 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -685,6 +685,9 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
+	msp->playback_dma_data.tx_rx_addr = res->start + MSP_DR;
+	msp->capture_dma_data.tx_rx_addr = res->start + MSP_DR;
+
 	msp->registers = devm_ioremap(&pdev->dev, res->start,
 				      resource_size(res));
 	if (msp->registers == NULL) {
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 8796171..258d0bc 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -470,6 +470,7 @@ struct ux500_msp_config {
 
 struct ux500_msp_dma_params {
 	unsigned int data_size;
+	dma_addr_t tx_rx_addr;
 	struct stedma40_chan_cfg *dma_cfg;
 };
 
-- 
1.8.2
