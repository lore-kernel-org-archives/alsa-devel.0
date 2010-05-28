From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ALSA/davinci: Use the resource_size , __devinit and __devexit.
Date: Fri, 28 May 2010 13:26:55 +0800
Message-ID: <4BFF541F.2080209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Dear all,

Use the resource_size function instead of manually calculating the
resource size.  This reduces the chance of introducing off-by-one
errors.

In addition, to use __devinit and __devexit is good too.

Signed-off-by:Wan ZongShun<mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>From 6e492675606a92bcf9e1719c37219dfc5d11e6ca Mon Sep 17 00:00:00 2001
From: zswan <zswan@zswan-marvell.(none)>
Date: Fri, 28 May 2010 13:18:40 +0800
Subject: [PATCH 5/5] fix davinci resource size

---
 sound/soc/davinci/davinci-i2s.c   |   12 ++++++------
 sound/soc/davinci/davinci-mcasp.c |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index adadcd3..763ba73 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -521,7 +521,7 @@ struct snd_soc_dai davinci_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(davinci_i2s_dai);

-static int davinci_i2s_probe(struct platform_device *pdev)
+static int __devinit davinci_i2s_probe(struct platform_device *pdev)
 {
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_mcbsp_dev *dev;
@@ -534,7 +534,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}

-	ioarea = request_mem_region(mem->start, (mem->end - mem->start) + 1,
+	ioarea = request_mem_region(mem->start, resource_size(mem),
 				    pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "McBSP region already claimed\n");
@@ -597,12 +597,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 err_free_mem:
 	kfree(dev);
 err_release_region:
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));

 	return ret;
 }

-static int davinci_i2s_remove(struct platform_device *pdev)
+static int __devexit davinci_i2s_remove(struct platform_device *pdev)
 {
 	struct davinci_mcbsp_dev *dev = davinci_i2s_dai.private_data;
 	struct resource *mem;
@@ -613,14 +613,14 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	dev->clk = NULL;
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));

 	return 0;
 }

 static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
-	.remove		= davinci_i2s_remove,
+	.remove		= __devexit_p(davinci_i2s_remove),
 	.driver		= {
 		.name	= "davinci-asp",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 79f0f4a..bd328d6 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -844,7 +844,7 @@ struct snd_soc_dai davinci_mcasp_dai[] = {
 };
 EXPORT_SYMBOL_GPL(davinci_mcasp_dai);

-static int davinci_mcasp_probe(struct platform_device *pdev)
+static int __devinit davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_data;
 	struct resource *mem, *ioarea, *res;
@@ -864,7 +864,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}

 	ioarea = request_mem_region(mem->start,
-			(mem->end - mem->start) + 1, pdev->name);
+			resource_size(mem), pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "Audio region already claimed\n");
 		ret = -EBUSY;
@@ -928,14 +928,14 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	return 0;

 err_release_region:
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));
 err_release_data:
 	kfree(dev);

 	return ret;
 }

-static int davinci_mcasp_remove(struct platform_device *pdev)
+static int __devexit davinci_mcasp_remove(struct platform_device *pdev)
 {
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_audio_dev *dev;
@@ -948,7 +948,7 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	dev->clk = NULL;

 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	release_mem_region(mem->start, resource_size(mem));

 	kfree(dev);

@@ -957,7 +957,7 @@ static int davinci_mcasp_remove(struct platform_device *pdev)

 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
-	.remove		= davinci_mcasp_remove,
+	.remove		= __devexit_p(davinci_mcasp_remove),
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
-- 
1.6.3.3
