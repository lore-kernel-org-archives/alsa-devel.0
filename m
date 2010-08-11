From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX SDMA support
Date: Wed, 11 Aug 2010 10:42:13 +0200
Message-ID: <20100811084213.GN27749@pengutronix.de>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de>
	<1281449263.3059.53.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AD1182433F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:42:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281449263.3059.53.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 03:07:43PM +0100, Liam Girdwood wrote:
> On Tue, 2010-08-10 at 15:15 +0200, Sascha Hauer wrote:
> 
> > I just looked at the i.MX part in the multi-component update and this
> > is currently far from being in a working state, so there's still some
> > work to do before thinking about possible conflicts...
> 
> Ok, I don't think it's that far off. Everything builds for i.MX and all
> components should register. The part I can't test is the component
> probe() and playback/capture.
> 
> Have you seen an oops ?

Many of them, yes ;)

The following patch puts i.MX (nearly) back into business.

Sascha

commit cbd076cc6238efcabd1e23176b3829ddc74266e8
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Wed Aug 11 10:37:34 2010 +0200

    ASoC: multi-component - i.MX fixes
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index bb69825..413b78d 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -241,15 +241,8 @@ static int ssi_irq = 0;
 static int imx_pcm_fiq_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
-	struct imx_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = claim_fiq(&fh);
-	if (ret) {
-		dev_err(dai->dev, "failed to claim fiq: %d", ret);
-		return ret;
-	}
-
 	ret = imx_pcm_new(card, dai, pcm);
 	if (ret)
 		return ret;
@@ -270,17 +263,6 @@ static int imx_pcm_fiq_new(struct snd_card *card, struct snd_soc_dai *dai,
 		imx_ssi_fiq_rx_buffer = (unsigned long)buf->area;
 	}
 
-	mxc_set_irq_fiq(ssi->irq, 1);
-	ssi_irq = ssi->irq;
-
-	imx_pcm_fiq = ssi->irq;
-
-	imx_ssi_fiq_base = (unsigned long)ssi->base;
-
-	ssi->dma_params_tx.burstsize = 4;
-	ssi->dma_params_rx.burstsize = 6;
-
-
 	set_fiq_handler(&imx_ssi_fiq_start,
 		&imx_ssi_fiq_end - &imx_ssi_fiq_start);
 
@@ -302,7 +284,36 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 
 static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
+	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = claim_fiq(&fh);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to claim fiq: %d", ret);
+		return ret;
+	}
+
+	mxc_set_irq_fiq(ssi->irq, 1);
+	ssi_irq = ssi->irq;
+
+	imx_pcm_fiq = ssi->irq;
+
+	imx_ssi_fiq_base = (unsigned long)ssi->base;
+
+	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_rx.burstsize = 6;
+
+	ret = snd_soc_register_platform(&pdev->dev, &imx_soc_platform_fiq);
+	if (ret)
+		goto failed_register;
+
+	return 0;
+
+failed_register:
+	mxc_set_irq_fiq(ssi_irq, 0);
+	release_fiq(&fh);
+
+	return ret;
 }
 
 static int __devexit imx_soc_platform_remove(struct platform_device *pdev)
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 6a27048..7eb318f 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -452,7 +452,22 @@ static struct snd_soc_dai_driver imx_ssi_dai = {
 	.ops = &imx_ssi_pcm_dai_ops,
 };
 
+static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct imx_ssi *ssi = dev_get_drvdata(dai->dev);
+	uint32_t val;
+
+	snd_soc_dai_set_drvdata(dai, ssi);
+
+	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
+		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
+	writel(val, ssi->base + SSI_SFCSR);
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver imx_ac97_dai = {
+	.probe = imx_ssi_dai_probe,
 	.ac97_control = 1,
 	.playback = {
 		.stream_name = "AC97 Playback",
@@ -572,15 +587,12 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 };
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-static struct snd_soc_dai_driver imx_ssi_pcm_dai[2];
-
 static int imx_ssi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct imx_ssi *ssi;
 	struct imx_ssi_platform_data *pdata = pdev->dev.platform_data;
 	int ret = 0;
-	unsigned int val;
 	struct snd_soc_dai_driver *dai;
 
 	ssi = kzalloc(sizeof(*ssi), GFP_KERNEL);
@@ -654,9 +666,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		ssi->flags |= IMX_SSI_DMA;
 	}
 
-	val = SSI_SFCSR_TFWM0(ssi->dma_params_tx.burstsize) |
-		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
-	writel(val, ssi->base + SSI_SFCSR);
+	platform_set_drvdata(pdev, ssi);
 
 	ret = snd_soc_register_dai(&pdev->dev, dai);
 	if (ret) {
@@ -664,10 +674,22 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
-	platform_set_drvdata(pdev, ssi);
+	ssi->soc_platform_pdev = platform_device_alloc("imx-fiq-pcm-audio", pdev->id);
+	if (!ssi->soc_platform_pdev)
+		goto failed_pdev_alloc;
+	platform_set_drvdata(ssi->soc_platform_pdev, ssi);
+	ret = platform_device_add(ssi->soc_platform_pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add platform device\n");
+		goto failed_pdev_add;
+	}
 
 	return 0;
 
+failed_pdev_add:
+	platform_device_put(ssi->soc_platform_pdev);
+failed_pdev_alloc:
+	snd_soc_unregister_dai(&pdev->dev);
 failed_register:
 failed_ac97:
 	iounmap(ssi->base);
@@ -687,6 +709,9 @@ static int __devexit imx_ssi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
+	platform_device_del(ssi->soc_platform_pdev);
+	platform_device_put(ssi->soc_platform_pdev);
+
 	snd_soc_unregister_dai(&pdev->dev);
 
 	if (ssi->flags & IMX_SSI_USE_AC97)
@@ -706,7 +731,7 @@ static struct platform_driver imx_ssi_driver = {
 	.remove = __devexit_p(imx_ssi_remove),
 
 	.driver = {
-		.name = "imx-ssi-dai",
+		.name = "imx-ssi",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index c46d8df..53b780d 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -210,6 +210,8 @@ struct imx_ssi {
 	struct imx_pcm_dma_params	dma_params_tx;
 
 	int enabled;
+
+	struct platform_device *soc_platform_pdev;
 };
 
 struct snd_soc_platform *imx_ssi_fiq_init(struct platform_device *pdev,
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 18fa91b..6a65dd7 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -34,8 +34,8 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 		.stream_name	= "HiFi",
 		.codec_dai_name		= "wm9712-hifi",
 		.codec_name	= "wm9712-codec",
-		.cpu_dai_name	= "imx-ssi-dai.0",
-		.platform_name	= "imx-pcm-audio",
+		.cpu_dai_name	= "imx-ssi.0",
+		.platform_name	= "imx-fiq-pcm-audio.0",
 		.ops		= &imx_phycore_hifi_ops,
 	},
 };
@@ -63,6 +63,11 @@ static int __init imx_phycore_init(void)
 	platform_set_drvdata(imx_phycore_snd_device, &imx_phycore);
 	ret = platform_device_add(imx_phycore_snd_device);
 
+	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
+	if (!imx_phycore_snd_device)
+		return -ENOMEM;
+	ret = platform_device_add(imx_phycore_snd_device);
+
 	if (ret) {
 		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
 		platform_device_put(imx_phycore_snd_device);

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
