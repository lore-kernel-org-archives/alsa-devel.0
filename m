From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] ASoC: au1x: convert to platform drivers.
Date: Sat, 31 Oct 2009 20:15:08 +0100
Message-ID: <1257016508-13195-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com
	[209.85.219.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 358481037F3
	for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2009 20:14:21 +0100 (CET)
Received: by ewy24 with SMTP id 24so3555206ewy.46
	for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2009 12:14:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

Convert psc-ac97,i2s to platform drivers similar to the davinci ones.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
As suggested by Mark Brown a few months back. Against linus-git.
Tested on DB1200.

 sound/soc/au1x/dbdma2.c   |  117 +++++++++++++++++++++++-----
 sound/soc/au1x/psc-ac97.c |  194 ++++++++++++++++++++++++++++-----------------
 sound/soc/au1x/psc-i2s.c  |  189 ++++++++++++++++++++++++++++----------------
 sound/soc/au1x/psc.h      |    7 ++-
 4 files changed, 344 insertions(+), 163 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 72617d7..b8965d9 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -2,7 +2,7 @@
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
  * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -331,6 +331,30 @@ static int au1xpsc_pcm_new(struct snd_card *card,
 
 static int au1xpsc_pcm_probe(struct platform_device *pdev)
 {
+	if (!au1xpsc_audio_pcmdma[PCM_TX] || !au1xpsc_audio_pcmdma[PCM_RX])
+		return -ENODEV;
+
+	return 0;
+}
+
+static int au1xpsc_pcm_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* au1xpsc audio platform */
+struct snd_soc_platform au1xpsc_soc_platform = {
+	.name		= "au1xpsc-pcm-dbdma",
+	.probe		= au1xpsc_pcm_probe,
+	.remove		= au1xpsc_pcm_remove,
+	.pcm_ops 	= &au1xpsc_pcm_ops,
+	.pcm_new	= au1xpsc_pcm_new,
+	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(au1xpsc_soc_platform);
+
+static int __devinit au1xpsc_pcm_drvprobe(struct platform_device *pdev)
+{
 	struct resource *r;
 	int ret;
 
@@ -363,7 +387,9 @@ static int au1xpsc_pcm_probe(struct platform_device *pdev)
 	}
 	(au1xpsc_audio_pcmdma[PCM_RX])->ddma_id = r->start;
 
-	return 0;
+	ret = snd_soc_register_platform(&au1xpsc_soc_platform);
+	if (!ret)
+		return ret;
 
 out2:
 	kfree(au1xpsc_audio_pcmdma[PCM_RX]);
@@ -374,10 +400,12 @@ out1:
 	return ret;
 }
 
-static int au1xpsc_pcm_remove(struct platform_device *pdev)
+static int __devexit au1xpsc_pcm_drvremove(struct platform_device *pdev)
 {
 	int i;
 
+	snd_soc_unregister_platform(&au1xpsc_soc_platform);
+
 	for (i = 0; i < 2; i++) {
 		if (au1xpsc_audio_pcmdma[i]) {
 			au1x_pcm_dbdma_free(au1xpsc_audio_pcmdma[i]);
@@ -389,32 +417,83 @@ static int au1xpsc_pcm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* au1xpsc audio platform */
-struct snd_soc_platform au1xpsc_soc_platform = {
-	.name		= "au1xpsc-pcm-dbdma",
-	.probe		= au1xpsc_pcm_probe,
-	.remove		= au1xpsc_pcm_remove,
-	.pcm_ops 	= &au1xpsc_pcm_ops,
-	.pcm_new	= au1xpsc_pcm_new,
-	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
+static struct platform_driver au1xpsc_pcm_driver = {
+	.driver	= {
+		.name	= "au1xpsc-pcm",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1xpsc_pcm_drvprobe,
+	.remove		= __devexit_p(au1xpsc_pcm_drvremove),
 };
-EXPORT_SYMBOL_GPL(au1xpsc_soc_platform);
 
-static int __init au1xpsc_audio_dbdma_init(void)
+static int __init au1xpsc_audio_dbdma_load(void)
 {
 	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
 	au1xpsc_audio_pcmdma[PCM_RX] = NULL;
-	return snd_soc_register_platform(&au1xpsc_soc_platform);
+	return platform_driver_register(&au1xpsc_pcm_driver);
 }
 
-static void __exit au1xpsc_audio_dbdma_exit(void)
+static void __exit au1xpsc_audio_dbdma_unload(void)
 {
-	snd_soc_unregister_platform(&au1xpsc_soc_platform);
+	platform_driver_unregister(&au1xpsc_pcm_driver);
+}
+
+module_init(au1xpsc_audio_dbdma_load);
+module_exit(au1xpsc_audio_dbdma_unload);
+
+
+struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev)
+{
+	struct resource *res, *r;
+	struct platform_device *pd;
+	int id[2];
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r)
+		return NULL;
+	id[0] = r->start;
+
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r)
+		return NULL;
+	id[1] = r->start;
+
+	res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	res[0].start = res[0].end = id[0];
+	res[1].start = res[1].end = id[1];
+	res[0].flags = res[1].flags = IORESOURCE_DMA;
+
+	pd = platform_device_alloc("au1xpsc-pcm", -1);
+	if (!pd)
+		goto out;
+
+	pd->resource = res;
+	pd->num_resources = 2;
+
+	ret = platform_device_add(pd);
+	if (!ret)
+		return pd;
+
+out:
+	kfree(res);
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(au1xpsc_pcm_add);
 
-module_init(au1xpsc_audio_dbdma_init);
-module_exit(au1xpsc_audio_dbdma_exit);
+void au1xpsc_pcm_destroy(struct platform_device *dmapd)
+{
+	if (dmapd) {
+		kfree(dmapd->resource);
+		dmapd->resource = NULL;
+		platform_device_unregister(dmapd);
+	}
+}
+EXPORT_SYMBOL_GPL(au1xpsc_pcm_destroy);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC Audio DMA driver");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 2a06a9c..340311d 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -317,19 +317,55 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 static int au1xpsc_ac97_probe(struct platform_device *pdev,
 			      struct snd_soc_dai *dai)
 {
+	return au1xpsc_ac97_workdata ? 0 : -ENODEV;
+}
+
+static void au1xpsc_ac97_remove(struct platform_device *pdev,
+				struct snd_soc_dai *dai)
+{
+}
+
+static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
+	.trigger	= au1xpsc_ac97_trigger,
+	.hw_params	= au1xpsc_ac97_hw_params,
+};
+
+struct snd_soc_dai au1xpsc_ac97_dai = {
+	.name			= "au1xpsc_ac97",
+	.ac97_control		= 1,
+	.probe			= au1xpsc_ac97_probe,
+	.remove			= au1xpsc_ac97_remove,
+	.playback = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &au1xpsc_ac97_dai_ops,
+};
+EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
+
+static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
+{
 	int ret;
 	struct resource *r;
 	unsigned long sel;
+	struct au1xpsc_audio_data *wd;
 
 	if (au1xpsc_ac97_workdata)
 		return -EBUSY;
 
-	au1xpsc_ac97_workdata =
-		kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
-	if (!au1xpsc_ac97_workdata)
+	wd = kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
+	if (!wd)
 		return -ENOMEM;
 
-	mutex_init(&au1xpsc_ac97_workdata->lock);
+	mutex_init(&wd->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -338,81 +374,95 @@ static int au1xpsc_ac97_probe(struct platform_device *pdev,
 	}
 
 	ret = -EBUSY;
-	au1xpsc_ac97_workdata->ioarea =
-		request_mem_region(r->start, r->end - r->start + 1,
+	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
 					"au1xpsc_ac97");
-	if (!au1xpsc_ac97_workdata->ioarea)
+	if (!wd->ioarea)
 		goto out0;
 
-	au1xpsc_ac97_workdata->mmio = ioremap(r->start, 0xffff);
-	if (!au1xpsc_ac97_workdata->mmio)
+	wd->mmio = ioremap(r->start, 0xffff);
+	if (!wd->mmio)
 		goto out1;
 
 	/* configuration: max dma trigger threshold, enable ac97 */
-	au1xpsc_ac97_workdata->cfg = PSC_AC97CFG_RT_FIFO8 |
-				     PSC_AC97CFG_TT_FIFO8 |
-				     PSC_AC97CFG_DE_ENABLE;
+	wd->cfg = PSC_AC97CFG_RT_FIFO8 | PSC_AC97CFG_TT_FIFO8 |
+		  PSC_AC97CFG_DE_ENABLE;
 
-	/* preserve PSC clock source set up by platform (dev.platform_data
-	 * is already occupied by soc layer)
-	 */
-	sel = au_readl(PSC_SEL(au1xpsc_ac97_workdata)) & PSC_SEL_CLK_MASK;
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	/* preserve PSC clock source set up by platform	 */
+	sel = au_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
-	au_writel(0, PSC_SEL(au1xpsc_ac97_workdata));
+	au_writel(0, PSC_SEL(wd));
 	au_sync();
-	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(au1xpsc_ac97_workdata));
+	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(wd));
 	au_sync();
-	/* next up: cold reset.  Dont check for PSC-ready now since
-	 * there may not be any codec clock yet.
-	 */
 
-	return 0;
+	ret = snd_soc_register_dai(&au1xpsc_ac97_dai);
+	if (ret)
+		goto out1;
+
+	wd->dmapd = au1xpsc_pcm_add(pdev);
+	if (wd->dmapd) {
+		platform_set_drvdata(pdev, wd);
+		au1xpsc_ac97_workdata = wd;	/* MDEV */
+		return 0;
+	}
 
+	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
 out1:
-	release_resource(au1xpsc_ac97_workdata->ioarea);
-	kfree(au1xpsc_ac97_workdata->ioarea);
+	release_resource(wd->ioarea);
+	kfree(wd->ioarea);
 out0:
-	kfree(au1xpsc_ac97_workdata);
-	au1xpsc_ac97_workdata = NULL;
+	kfree(wd);
 	return ret;
 }
 
-static void au1xpsc_ac97_remove(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
+static int __devexit au1xpsc_ac97_drvremove(struct platform_device *pdev)
 {
+	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
+
+	if (wd->dmapd)
+		au1xpsc_pcm_destroy(wd->dmapd);
+
+	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
+
 	/* disable PSC completely */
-	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	au_writel(0, AC97_CFG(wd));
 	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
 
-	iounmap(au1xpsc_ac97_workdata->mmio);
-	release_resource(au1xpsc_ac97_workdata->ioarea);
-	kfree(au1xpsc_ac97_workdata->ioarea);
-	kfree(au1xpsc_ac97_workdata);
-	au1xpsc_ac97_workdata = NULL;
+	iounmap(wd->mmio);
+	release_resource(wd->ioarea);
+	kfree(wd->ioarea);
+	kfree(wd);
+
+	au1xpsc_ac97_workdata = NULL;	/* MDEV */
+
+	return 0;
 }
 
-static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
+#ifdef CONFIG_PM
+static int au1xpsc_ac97_drvsuspend(struct device *dev)
 {
+	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
+
 	/* save interesting registers and disable PSC */
-	au1xpsc_ac97_workdata->pm[0] =
-			au_readl(PSC_SEL(au1xpsc_ac97_workdata));
+	wd->pm[0] = au_readl(PSC_SEL(wd));
 
-	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
+	au_writel(0, AC97_CFG(wd));
 	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_ac97_workdata));
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
 
 	return 0;
 }
 
-static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
+static int au1xpsc_ac97_drvresume(struct device *dev)
 {
+	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
+
 	/* restore PSC clock config */
-	au_writel(au1xpsc_ac97_workdata->pm[0] | PSC_SEL_PS_AC97MODE,
-			PSC_SEL(au1xpsc_ac97_workdata));
+	au_writel(wd->pm[0] | PSC_SEL_PS_AC97MODE, PSC_SEL(wd));
 	au_sync();
 
 	/* after this point the ac97 core will cold-reset the codec.
@@ -422,48 +472,44 @@ static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
-	.trigger	= au1xpsc_ac97_trigger,
-	.hw_params	= au1xpsc_ac97_hw_params,
+static struct dev_pm_ops au1xpscac97_pmops = {
+	.suspend	= au1xpsc_ac97_drvsuspend,
+	.resume		= au1xpsc_ac97_drvresume,
 };
 
-struct snd_soc_dai au1xpsc_ac97_dai = {
-	.name			= "au1xpsc_ac97",
-	.ac97_control		= 1,
-	.probe			= au1xpsc_ac97_probe,
-	.remove			= au1xpsc_ac97_remove,
-	.suspend		= au1xpsc_ac97_suspend,
-	.resume			= au1xpsc_ac97_resume,
-	.playback = {
-		.rates		= AC97_RATES,
-		.formats	= AC97_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 2,
-	},
-	.capture = {
-		.rates		= AC97_RATES,
-		.formats	= AC97_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 2,
+#define AU1XPSCAC97_PMOPS &au1xpscac97_pmops
+
+#else
+
+#define AU1XPSCAC97_PMOPS NULL
+
+#endif
+
+static struct platform_driver au1xpsc_ac97_driver = {
+	.driver	= {
+		.name	= "au1xpsc_ac97",
+		.owner	= THIS_MODULE,
+		.pm	= AU1XPSCAC97_PMOPS,
 	},
-	.ops = &au1xpsc_ac97_dai_ops,
+	.probe		= au1xpsc_ac97_drvprobe,
+	.remove		= __devexit_p(au1xpsc_ac97_drvremove),
 };
-EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
 
-static int __init au1xpsc_ac97_init(void)
+static int __init au1xpsc_ac97_load(void)
 {
 	au1xpsc_ac97_workdata = NULL;
-	return snd_soc_register_dai(&au1xpsc_ac97_dai);
+	return platform_driver_register(&au1xpsc_ac97_driver);
 }
 
-static void __exit au1xpsc_ac97_exit(void)
+static void __exit au1xpsc_ac97_unload(void)
 {
-	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
+	platform_driver_unregister(&au1xpsc_ac97_driver);
 }
 
-module_init(au1xpsc_ac97_init);
-module_exit(au1xpsc_ac97_exit);
+module_init(au1xpsc_ac97_load);
+module_exit(au1xpsc_ac97_unload);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC AC97 ALSA ASoC audio driver");
-MODULE_AUTHOR("Manuel Lauss <manuel.lauss@gmail.com>");
+MODULE_AUTHOR("Manuel Lauss");
+
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index bb58932..0cf2ca6 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -2,7 +2,7 @@
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
  * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -265,16 +265,52 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 static int au1xpsc_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
+	return 	au1xpsc_i2s_workdata ? 0 : -ENODEV;
+}
+
+static void au1xpsc_i2s_remove(struct platform_device *pdev,
+			       struct snd_soc_dai *dai)
+{
+}
+
+static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
+	.trigger	= au1xpsc_i2s_trigger,
+	.hw_params	= au1xpsc_i2s_hw_params,
+	.set_fmt	= au1xpsc_i2s_set_fmt,
+};
+
+struct snd_soc_dai au1xpsc_i2s_dai = {
+	.name			= "au1xpsc_i2s",
+	.probe			= au1xpsc_i2s_probe,
+	.remove			= au1xpsc_i2s_remove,
+	.playback = {
+		.rates		= AU1XPSC_I2S_RATES,
+		.formats	= AU1XPSC_I2S_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 8,	/* 2 without external help */
+	},
+	.capture = {
+		.rates		= AU1XPSC_I2S_RATES,
+		.formats	= AU1XPSC_I2S_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 8,	/* 2 without external help */
+	},
+	.ops = &au1xpsc_i2s_dai_ops,
+};
+EXPORT_SYMBOL(au1xpsc_i2s_dai);
+
+static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
+{
 	struct resource *r;
 	unsigned long sel;
 	int ret;
+	struct au1xpsc_audio_data *wd;
 
 	if (au1xpsc_i2s_workdata)
 		return -EBUSY;
 
-	au1xpsc_i2s_workdata =
-		kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
-	if (!au1xpsc_i2s_workdata)
+	wd = kzalloc(sizeof(struct au1xpsc_audio_data), GFP_KERNEL);
+	if (!wd)
 		return -ENOMEM;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -284,131 +320,146 @@ static int au1xpsc_i2s_probe(struct platform_device *pdev,
 	}
 
 	ret = -EBUSY;
-	au1xpsc_i2s_workdata->ioarea =
-		request_mem_region(r->start, r->end - r->start + 1,
+	wd->ioarea = request_mem_region(r->start, r->end - r->start + 1,
 					"au1xpsc_i2s");
-	if (!au1xpsc_i2s_workdata->ioarea)
+	if (!wd->ioarea)
 		goto out0;
 
-	au1xpsc_i2s_workdata->mmio = ioremap(r->start, 0xffff);
-	if (!au1xpsc_i2s_workdata->mmio)
+	wd->mmio = ioremap(r->start, 0xffff);
+	if (!wd->mmio)
 		goto out1;
 
 	/* preserve PSC clock source set up by platform (dev.platform_data
 	 * is already occupied by soc layer)
 	 */
-	sel = au_readl(PSC_SEL(au1xpsc_i2s_workdata)) & PSC_SEL_CLK_MASK;
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	sel = au_readl(PSC_SEL(wd)) & PSC_SEL_CLK_MASK;
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
-	au_writel(PSC_SEL_PS_I2SMODE | sel, PSC_SEL(au1xpsc_i2s_workdata));
-	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	au_writel(PSC_SEL_PS_I2SMODE | sel, PSC_SEL(wd));
+	au_writel(0, I2S_CFG(wd));
 	au_sync();
 
 	/* preconfigure: set max rx/tx fifo depths */
-	au1xpsc_i2s_workdata->cfg |=
-			PSC_I2SCFG_RT_FIFO8 | PSC_I2SCFG_TT_FIFO8;
+	wd->cfg |= PSC_I2SCFG_RT_FIFO8 | PSC_I2SCFG_TT_FIFO8;
 
 	/* don't wait for I2S core to become ready now; clocks may not
 	 * be running yet; depending on clock input for PSC a wait might
 	 * time out.
 	 */
 
-	return 0;
+	ret = snd_soc_register_dai(&au1xpsc_i2s_dai);
+	if (ret)
+		goto out1;
 
+	/* finally add the DMA device for this PSC */
+	wd->dmapd = au1xpsc_pcm_add(pdev);
+	if (wd->dmapd) {
+		platform_set_drvdata(pdev, wd);
+		au1xpsc_i2s_workdata = wd;
+		return 0;
+	}
+
+	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
 out1:
-	release_resource(au1xpsc_i2s_workdata->ioarea);
-	kfree(au1xpsc_i2s_workdata->ioarea);
+	release_resource(wd->ioarea);
+	kfree(wd->ioarea);
 out0:
-	kfree(au1xpsc_i2s_workdata);
-	au1xpsc_i2s_workdata = NULL;
+	kfree(wd);
 	return ret;
 }
 
-static void au1xpsc_i2s_remove(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
 {
-	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
+
+	if (wd->dmapd)
+		au1xpsc_pcm_destroy(wd->dmapd);
+
+	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
+
+	au_writel(0, I2S_CFG(wd));
 	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
 
-	iounmap(au1xpsc_i2s_workdata->mmio);
-	release_resource(au1xpsc_i2s_workdata->ioarea);
-	kfree(au1xpsc_i2s_workdata->ioarea);
-	kfree(au1xpsc_i2s_workdata);
-	au1xpsc_i2s_workdata = NULL;
+	iounmap(wd->mmio);
+	release_resource(wd->ioarea);
+	kfree(wd->ioarea);
+	kfree(wd);
+
+	au1xpsc_i2s_workdata = NULL;	/* MDEV */
+
+	return 0;
 }
 
-static int au1xpsc_i2s_suspend(struct snd_soc_dai *cpu_dai)
+#ifdef CONFIG_PM
+static int au1xpsc_i2s_drvsuspend(struct device *dev)
 {
+	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
+
 	/* save interesting register and disable PSC */
-	au1xpsc_i2s_workdata->pm[0] =
-		au_readl(PSC_SEL(au1xpsc_i2s_workdata));
+	wd->pm[0] = au_readl(PSC_SEL(wd));
 
-	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
+	au_writel(0, I2S_CFG(wd));
 	au_sync();
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
 
 	return 0;
 }
 
-static int au1xpsc_i2s_resume(struct snd_soc_dai *cpu_dai)
+static int au1xpsc_i2s_drvresume(struct device *dev)
 {
+	struct au1xpsc_audio_data *wd = dev_get_drvdata(dev);
+
 	/* select I2S mode and PSC clock */
-	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
+	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(wd));
 	au_sync();
-	au_writel(0, PSC_SEL(au1xpsc_i2s_workdata));
+	au_writel(0, PSC_SEL(wd));
 	au_sync();
-	au_writel(au1xpsc_i2s_workdata->pm[0],
-			PSC_SEL(au1xpsc_i2s_workdata));
+	au_writel(wd->pm[0], PSC_SEL(wd));
 	au_sync();
 
 	return 0;
 }
 
-static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
-	.trigger	= au1xpsc_i2s_trigger,
-	.hw_params	= au1xpsc_i2s_hw_params,
-	.set_fmt	= au1xpsc_i2s_set_fmt,
+static struct dev_pm_ops au1xpsci2s_pmops = {
+	.suspend	= au1xpsc_i2s_drvsuspend,
+	.resume		= au1xpsc_i2s_drvresume,
 };
 
-struct snd_soc_dai au1xpsc_i2s_dai = {
-	.name			= "au1xpsc_i2s",
-	.probe			= au1xpsc_i2s_probe,
-	.remove			= au1xpsc_i2s_remove,
-	.suspend		= au1xpsc_i2s_suspend,
-	.resume			= au1xpsc_i2s_resume,
-	.playback = {
-		.rates		= AU1XPSC_I2S_RATES,
-		.formats	= AU1XPSC_I2S_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 8,	/* 2 without external help */
-	},
-	.capture = {
-		.rates		= AU1XPSC_I2S_RATES,
-		.formats	= AU1XPSC_I2S_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 8,	/* 2 without external help */
+#define AU1XPSCI2S_PMOPS &au1xpsci2s_pmops
+
+#else
+
+#define AU1XPSCI2S_PMOPS NULL
+
+#endif
+
+static struct platform_driver au1xpsc_i2s_driver = {
+	.driver		= {
+		.name	= "au1xpsc_i2s",
+		.owner	= THIS_MODULE,
+		.pm	= AU1XPSCI2S_PMOPS,
 	},
-	.ops = &au1xpsc_i2s_dai_ops,
+	.probe		= au1xpsc_i2s_drvprobe,
+	.remove		= __devexit_p(au1xpsc_i2s_drvremove),
 };
-EXPORT_SYMBOL(au1xpsc_i2s_dai);
 
-static int __init au1xpsc_i2s_init(void)
+static int __init au1xpsc_i2s_load(void)
 {
 	au1xpsc_i2s_workdata = NULL;
-	return snd_soc_register_dai(&au1xpsc_i2s_dai);
+	return platform_driver_register(&au1xpsc_i2s_driver);
 }
 
-static void __exit au1xpsc_i2s_exit(void)
+static void __exit au1xpsc_i2s_unload(void)
 {
-	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
+	platform_driver_unregister(&au1xpsc_i2s_driver);
 }
 
-module_init(au1xpsc_i2s_init);
-module_exit(au1xpsc_i2s_exit);
+module_init(au1xpsc_i2s_load);
+module_exit(au1xpsc_i2s_unload);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC I2S ALSA ASoC audio driver");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 3f474e8..32d3807 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -2,7 +2,7 @@
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
  * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,6 +21,10 @@ extern struct snd_soc_dai au1xpsc_i2s_dai;
 extern struct snd_soc_platform au1xpsc_soc_platform;
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
+/* DBDMA helpers */
+extern struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev);
+extern void au1xpsc_pcm_destroy(struct platform_device *dmapd);
+
 struct au1xpsc_audio_data {
 	void __iomem *mmio;
 
@@ -30,6 +34,7 @@ struct au1xpsc_audio_data {
 	unsigned long pm[2];
 	struct resource *ioarea;
 	struct mutex lock;
+	struct platform_device *dmapd;
 };
 
 #define PCM_TX	0
-- 
1.6.5.1
