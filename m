From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:30:47 +0000
Message-ID: <E1elDFv-0003IM-Q6@debutante>
References: <87d12fgb15.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8CD626765F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:51 +0100 (CET)
In-Reply-To: <87d12fgb15.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel: replace platform to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6dea9df84aa2c2c1c645fac933adf1c4e0c20ac7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:44:05 +0000
Subject: [PATCH] ASoC: atmel: replace platform to component

Now platform can be replaced to component, let's do it.
To avoid complex operation, this patch adds device pointer
to atmel_classd.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c  | 4 +++-
 sound/soc/atmel/atmel-pcm-pdc.c | 6 +++---
 sound/soc/atmel/atmel-pdmic.c   | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index ebabed69f0e6..6bc2b729495c 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -32,6 +32,7 @@ struct atmel_classd {
 	struct regmap *regmap;
 	struct clk *pclk;
 	struct clk *gclk;
+	struct device *dev;
 	int irq;
 	const struct atmel_classd_pdata *pdata;
 };
@@ -165,7 +166,7 @@ atmel_classd_platform_configure_dma(struct snd_pcm_substream *substream,
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
 
 	if (params_physical_width(params) != 16) {
-		dev_err(rtd->platform->dev,
+		dev_err(dd->dev,
 			"only supports 16-bit audio data\n");
 		return -EINVAL;
 	}
@@ -587,6 +588,7 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	}
 
 	dd->phy_base = res->start;
+	dd->dev = dev;
 
 	dd->regmap = devm_regmap_init_mmio(dev, io_base,
 					&atmel_classd_regmap_config);
diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 91b7069c3499..99ca23d527c9 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -393,7 +393,7 @@ static const struct snd_pcm_ops atmel_pcm_ops = {
 	.mmap		= atmel_pcm_mmap,
 };
 
-static struct snd_soc_platform_driver atmel_soc_platform = {
+static struct snd_soc_component_driver atmel_soc_platform = {
 	.ops		= &atmel_pcm_ops,
 	.pcm_new	= atmel_pcm_new,
 	.pcm_free	= atmel_pcm_free,
@@ -401,13 +401,13 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 
 int atmel_pcm_pdc_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(dev, &atmel_soc_platform);
+	return devm_snd_soc_register_component(dev, &atmel_soc_platform,
+					       NULL, 0);
 }
 EXPORT_SYMBOL(atmel_pcm_pdc_platform_register);
 
 void atmel_pcm_pdc_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(dev);
 }
 EXPORT_SYMBOL(atmel_pcm_pdc_platform_unregister);
 
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 8e3d34be9e69..4eea738c1047 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -32,6 +32,7 @@ struct atmel_pdmic {
 	struct regmap *regmap;
 	struct clk *pclk;
 	struct clk *gclk;
+	struct device *dev;
 	int irq;
 	struct snd_pcm_substream *substream;
 	const struct atmel_pdmic_pdata *pdata;
@@ -206,7 +207,7 @@ atmel_pdmic_platform_configure_dma(struct snd_pcm_substream *substream,
 	ret = snd_hwparams_to_dma_slave_config(substream, params,
 					       slave_config);
 	if (ret) {
-		dev_err(rtd->platform->dev,
+		dev_err(dd->dev,
 			"hw params to dma slave configure failed\n");
 		return ret;
 	}
@@ -596,6 +597,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dd->pdata = pdata;
+	dd->dev = dev;
 
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
-- 
2.16.1
