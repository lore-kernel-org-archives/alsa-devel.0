From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
 (v2)
Date: Tue, 19 May 2009 00:25:42 +0900 (JST)
Message-ID: <20090519.002542.39155238.anemo@mba.ocn.ne.jp>
References: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20090518142305.GE1629@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 560012447E
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:25:45 +0200 (CEST)
In-Reply-To: <20090518142305.GE1629@sirena.org.uk>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 May 2009 15:23:05 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > +static int txx9aclc_ac97_probe(struct platform_device *pdev,
> > +			       struct snd_soc_dai *dai)
...
> > +	irq = platform_get_irq(aclc_pdev, 0);
> 
> This isn't what I meant by moving the resources to the DAI and DMA
> drivers.  You have moved the calls to read the resources to these
> drivers (which is good) but the resources are still being obtained from
> the main ASoC device rather than by themselves from the device code.
> 
> There aren't too many platforms using this approach yet but take a look
> at the way the pxa2xx-ac97 driver deals with registering the DAI (it
> doesn't do anything with resources ATM) - you want to be registering
> your DAI and grabbing the resources from a platform driver probe like it
> does.

Thank you for elaboration.  Then, this untested patch (on top of the
last patch) is what you mean?  If yes, I will split this into arch
part and driver part, and then update both patches.


 arch/mips/txx9/generic/setup.c    |    6 +++---
 arch/mips/txx9/rbtx4927/setup.c   |    1 +
 arch/mips/txx9/rbtx4938/setup.c   |    1 +
 arch/mips/txx9/rbtx4939/setup.c   |    1 +
 sound/soc/txx9/txx9aclc-ac97.c    |   28 +++++++++++++++++++++++++---
 sound/soc/txx9/txx9aclc-generic.c |    1 -
 6 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index bc358ab..7f91012 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -882,8 +882,8 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in)
 {
-#if defined(CONFIG_SND_SOC_TXX9ACLC_GENERIC) || \
-	defined(CONFIG_SND_SOC_TXX9ACLC_GENERIC_MODULE)
+#if defined(CONFIG_SND_SOC_TXX9ACLC) || \
+	defined(CONFIG_SND_SOC_TXX9ACLC_MODULE)
 	unsigned int dma_base = dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
 	struct resource res[] = {
 		{
@@ -904,7 +904,7 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 		}
 	};
 	struct platform_device *pdev =
-		platform_device_alloc("txx9aclc-generic", -1);
+		platform_device_alloc("txx9aclc-ac97", -1);
 
 	if (!pdev ||
 	    platform_device_add_resources(pdev, res, ARRAY_SIZE(res)) ||
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index ece43db..ee468ea 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -344,6 +344,7 @@ static void __init rbtx4927_device_init(void)
 		tx4938_dmac_init(0, 2);
 		tx4938_aclc_init();
 	}
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 	txx9_iocled_init(RBTX4927_LED_ADDR - IO_BASE, -1, 3, 1, "green", NULL);
 	rbtx4927_gpioled_init();
 }
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index c0aa889..8da66e9 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -357,6 +357,7 @@ static void __init rbtx4938_device_init(void)
 	tx4938_ata_init(RBTX4938_IRQ_IOC_ATA, 0, 1);
 	tx4938_dmac_init(0, 2);
 	tx4938_aclc_init();
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
 }
 
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 1d01126..d5ad5ab 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -500,6 +500,7 @@ static void __init rbtx4939_device_init(void)
 	tx4939_rtc_init();
 	tx4939_dmac_init(0, 2);
 	tx4939_aclc_init();
+	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
 }
 
 static void __init rbtx4939_setup(void)
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 5e04409..f198104 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -155,11 +155,12 @@ static int txx9aclc_ac97_probe(struct platform_device *pdev,
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct txx9aclc_soc_device *dev =
 		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
-	struct platform_device *aclc_pdev = dev->aclc_pdev;
+	struct platform_device *aclc_pdev = to_platform_device(dai->dev);
 	struct resource *r;
 	int err;
 	int irq;
 
+	dev->aclc_pdev = aclc_pdev;
 	dev->irq = -1;
 	irq = platform_get_irq(aclc_pdev, 0);
 	if (irq < 0)
@@ -225,14 +226,35 @@ struct snd_soc_dai txx9aclc_ac97_dai = {
 };
 EXPORT_SYMBOL_GPL(txx9aclc_ac97_dai);
 
-static int __init txx9aclc_ac97_init(void)
+static int __devinit txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 {
+	txx9aclc_ac97_dai.dev = &pdev->dev;
 	return snd_soc_register_dai(&txx9aclc_ac97_dai);
 }
 
-static void __exit txx9aclc_ac97_exit(void)
+static int __devexit txx9aclc_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&txx9aclc_ac97_dai);
+	return 0;
+}
+
+static struct platform_driver txx9aclc_ac97_driver = {
+	.probe		= txx9aclc_ac97_dev_probe,
+	.remove		= __devexit_p(txx9aclc_ac97_dev_remove),
+	.driver		= {
+		.name	= "txx9aclc-ac97",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init txx9aclc_ac97_init(void)
+{
+	return platform_driver_register(&txx9aclc_ac97_driver);
+}
+
+static void __exit txx9aclc_ac97_exit(void)
+{
+	platform_driver_unregister(&txx9aclc_ac97_driver);
 }
 
 module_init(txx9aclc_ac97_init);
diff --git a/sound/soc/txx9/txx9aclc-generic.c b/sound/soc/txx9/txx9aclc-generic.c
index d27aba6..3175de9 100644
--- a/sound/soc/txx9/txx9aclc-generic.c
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -54,7 +54,6 @@ static int __init txx9aclc_generic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(soc_pdev, &dev->soc_dev);
 	dev->soc_dev.dev = &soc_pdev->dev;
-	dev->aclc_pdev = pdev;
 	ret = platform_device_add(soc_pdev);
 	if (ret) {
 		platform_device_put(soc_pdev);

---
Atsushi Nemoto
