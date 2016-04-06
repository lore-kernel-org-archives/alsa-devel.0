From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/6] ASoC: Davinci: McBSP: add device tree support for McBSP
Date: Wed,  6 Apr 2016 15:21:29 +0200
Message-ID: <1459948893-4206-3-git-send-email-petr@barix.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459948893-4206-1-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
 sound/soc/davinci/Kconfig       |   6 ++-
 sound/soc/davinci/davinci-i2s.c | 106 ++++++++++++++++++++++++++++++++++------
 2 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 50ca291cc225..6b732d8e5896 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -16,7 +16,11 @@ config SND_EDMA_SOC
 	  - DRA7xx family
 
 config SND_DAVINCI_SOC_I2S
-	tristate
+	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
+	depends on SND_EDMA_SOC
+	help
+	  Say Y or M here if you want to have support for McBSP IP found in
+	  Texas Instruments DaVinci DA850 SoCs.
 
 config SND_DAVINCI_SOC_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index ec98548a5fc9..2ebfe86dd584 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -4,9 +4,15 @@
  * Author:      Vladimir Barinov, <vbarinov-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
  *
+ * DT support	(c) 2016 Petr Kulhavy, Barix AG <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
+ *		based on davinci-mcasp.c DT support
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * TODO:
+ * on DA850 implement HW FIFOs instead of DMA into DXR and DRR registers
  */
 
 #include <linux/init.h>
@@ -648,15 +654,82 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
 	.name		= "davinci-i2s",
 };
 
+static struct snd_platform_data*
+davinci_i2s_set_pdata_from_of(struct platform_device *pdev)
+{
+	struct snd_platform_data *pdata = NULL;
+	struct device_node *np;
+	struct of_phandle_args dma_spec;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
+		return dev_get_platdata(&pdev->dev);
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	np = pdev->dev.of_node;
+
+	ret = of_property_match_string(np, "dma-names", "tx");
+	if (ret >= 0) {
+		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
+						 &dma_spec);
+		if (ret >= 0)
+			pdata->tx_dma_channel = dma_spec.args[0];
+	}
+
+	ret = of_property_match_string(np, "dma-names", "rx");
+	if (ret >= 0) {
+		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
+						 &dma_spec);
+		if (ret >= 0)
+			pdata->rx_dma_channel = dma_spec.args[0];
+	}
+
+	/* optional parameters */
+
+	pdata->enable_channel_combine =
+		of_property_read_bool(np, "channel-combine");
+
+	/*
+	 * pdata->clk_input_pin is deliberately not exported to DT
+	 * and the default value of the clk_input_pin is MCBSP_CLKR.
+	 * The value MCBSP_CLKS makes no sense as it turns the CPU
+	 * to a bit clock master in the SND_SOC_DAIFMT_CBM_CFS mode
+	 * where it should be bit clock slave!
+	 */
+
+	return pdata;
+}
+
 static int davinci_i2s_probe(struct platform_device *pdev)
 {
+	struct snd_platform_data *pdata;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *res;
 	void __iomem *io_base;
 	int *dma;
 	int ret;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdata = davinci_i2s_set_pdata_from_of(pdev);
+	if (IS_ERR(pdata)) {
+		dev_err(&pdev->dev, "Error populating platform data, err %ld\n",
+			PTR_ERR(pdata));
+		return PTR_ERR(pdata);
+	}
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
+	if (!mem) {
+		dev_warn(&pdev->dev,
+			 "\"mpu\" mem resource not found, using index 0\n");
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!mem) {
+			dev_err(&pdev->dev, "no mem resource?\n");
+			return -ENODEV;
+		}
+	}
+
 	io_base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
@@ -680,25 +753,21 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
 
 	/* first TX, then RX */
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto err_release_clk;
-	}
 	dma = &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
-	*dma = res->start;
 	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = dma;
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (res)
+		*dma = res->start;
+	else
+		*dma = pdata->tx_dma_channel;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "no DMA resource\n");
-		ret = -ENXIO;
-		goto err_release_clk;
-	}
 	dma = &dev->dma_request[SNDRV_PCM_STREAM_CAPTURE];
-	*dma = res->start;
 	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data = dma;
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (res)
+		*dma = res->start;
+	else
+		*dma = pdata->rx_dma_channel;
 
 	dev->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, dev);
@@ -737,11 +806,18 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id davinci_mcbsp_match[] = {
+	{ .compatible = "ti,da850-mcbsp-audio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, davinci_mcbsp_match);
+
 static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
 	.remove		= davinci_i2s_remove,
 	.driver		= {
 		.name	= "davinci-mcbsp",
+		.of_match_table = of_match_ptr(davinci_mcbsp_match),
 	},
 };
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
