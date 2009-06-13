From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH] ASoC: au1x: platform driver restructuring
Date: Sat, 13 Jun 2009 17:00:00 +0200
Message-ID: <4A33BEF0.6020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 698EF2455C
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 17:00:09 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2697728bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 08:00:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark!

Please have a look at the patch below and verify it does what you
suggested earlier, and if you have no objections, add it to your
patchqueue.

Both the AC97 and I2S modules are converted to full platform drivers;
the PCM (DMA) interface is initialized during platform probe.
Run-tested on DB1200 board.

Thank you!
	Manuel Lauss

---

From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] ASoC: au1x: platform driver restructuring

Make the AC97/I2S modules full platform drivers and update the
sample machine code.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 sound/soc/au1x/dbdma2.c      |   24 +++++-----
 sound/soc/au1x/psc-ac97.c    |  103 +++++++++++++++++++++++++-----------------
 sound/soc/au1x/psc-i2s.c     |  103 ++++++++++++++++++++++++------------------
 sound/soc/au1x/psc.h         |    7 ++-
 sound/soc/au1x/sample-ac97.c |   48 +++++++++++--------
 5 files changed, 165 insertions(+), 120 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 594c6c5..10d21ec 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -1,8 +1,8 @@
 /*
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ * (c) 2007-2009 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -331,7 +331,7 @@ static int au1xpsc_pcm_new(struct snd_card *card,
 	return 0;
 }

-static int au1xpsc_pcm_probe(struct platform_device *pdev)
+int au1xpsc_asoc_dbdma_init(struct platform_device *pdev)
 {
 	struct resource *r;
 	int ret;
@@ -375,8 +375,9 @@ out1:
 	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
 	return ret;
 }
+EXPORT_SYMBOL_GPL(au1xpsc_asoc_dbdma_init);

-static int au1xpsc_pcm_remove(struct platform_device *pdev)
+void au1xpsc_asoc_dbdma_exit(void)
 {
 	int i;

@@ -387,36 +388,33 @@ static int au1xpsc_pcm_remove(struct platform_device *pdev)
 			au1xpsc_audio_pcmdma[i] = NULL;
 		}
 	}
-
-	return 0;
 }
+EXPORT_SYMBOL_GPL(au1xpsc_asoc_dbdma_exit);

 /* au1xpsc audio platform */
 struct snd_soc_platform au1xpsc_soc_platform = {
 	.name		= "au1xpsc-pcm-dbdma",
-	.probe		= au1xpsc_pcm_probe,
-	.remove		= au1xpsc_pcm_remove,
 	.pcm_ops 	= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
 	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(au1xpsc_soc_platform);

-static int __init au1xpsc_audio_dbdma_init(void)
+static int __init au1xpsc_audio_dbdma_load(void)
 {
 	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
 	au1xpsc_audio_pcmdma[PCM_RX] = NULL;
 	return snd_soc_register_platform(&au1xpsc_soc_platform);
 }

-static void __exit au1xpsc_audio_dbdma_exit(void)
+static void __exit au1xpsc_audio_dbdma_unload(void)
 {
 	snd_soc_unregister_platform(&au1xpsc_soc_platform);
 }

-module_init(au1xpsc_audio_dbdma_init);
-module_exit(au1xpsc_audio_dbdma_exit);
+module_init(au1xpsc_audio_dbdma_load);
+module_exit(au1xpsc_audio_dbdma_unload);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC Audio DMA driver");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 479d7bd..ee8e642 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -1,8 +1,8 @@
 /*
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ * (c) 2007-2009 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -236,8 +236,32 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }

-static int au1xpsc_ac97_probe(struct platform_device *pdev,
-			      struct snd_soc_dai *dai)
+static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
+	.trigger	= au1xpsc_ac97_trigger,
+	.hw_params	= au1xpsc_ac97_hw_params,
+};
+
+struct snd_soc_dai au1xpsc_ac97_dai = {
+	.name			= "au1xpsc_ac97",
+	.ac97_control		= 1,
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
+
+static int __devinit au1xpsc_ac97_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *r;
@@ -287,8 +311,18 @@ static int au1xpsc_ac97_probe(struct platform_device *pdev,
 	 * there may not be any codec clock yet.
 	 */

-	return 0;
+	ret = au1xpsc_asoc_dbdma_init(pdev);
+	if (ret)
+		goto out2;
+
+	ret = snd_soc_register_dai(&au1xpsc_ac97_dai);
+	if (!ret)
+		return 0;
+

+	au1xpsc_asoc_dbdma_exit();
+out2:
+	iounmap(au1xpsc_ac97_workdata->mmio);
 out1:
 	release_resource(au1xpsc_ac97_workdata->ioarea);
 	kfree(au1xpsc_ac97_workdata->ioarea);
@@ -298,9 +332,11 @@ out0:
 	return ret;
 }

-static void au1xpsc_ac97_remove(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
+static int __devexit au1xpsc_ac97_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
+	au1xpsc_asoc_dbdma_exit();
+
 	/* disable PSC completely */
 	au_writel(0, AC97_CFG(au1xpsc_ac97_workdata));
 	au_sync();
@@ -312,9 +348,11 @@ static void au1xpsc_ac97_remove(struct platform_device *pdev,
 	kfree(au1xpsc_ac97_workdata->ioarea);
 	kfree(au1xpsc_ac97_workdata);
 	au1xpsc_ac97_workdata = NULL;
+
+	return 0;
 }

-static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
+static int au1xpsc_ac97_suspend(struct platform_device *pdev, pm_message_t m)
 {
 	/* save interesting registers and disable PSC */
 	au1xpsc_ac97_workdata->pm[0] =
@@ -328,7 +366,7 @@ static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
 	return 0;
 }

-static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
+static int au1xpsc_ac97_resume(struct platform_device *pdev)
 {
 	/* restore PSC clock config */
 	au_writel(au1xpsc_ac97_workdata->pm[0] | PSC_SEL_PS_AC97MODE,
@@ -342,48 +380,31 @@ static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
 	return 0;
 }

-static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
-	.trigger	= au1xpsc_ac97_trigger,
-	.hw_params	= au1xpsc_ac97_hw_params,
-};
-
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
+static struct platform_driver au1xpsc_ac97_driver = {
+	.driver	= {
+		.name	= "au1xpsc_ac97",
+		.owner	= THIS_MODULE,
 	},
-	.capture = {
-		.rates		= AC97_RATES,
-		.formats	= AC97_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 2,
-	},
-	.ops = &au1xpsc_ac97_dai_ops,
+	.probe		= au1xpsc_ac97_probe,
+	.remove		= __devexit_p(au1xpsc_ac97_remove),
+	.suspend	= au1xpsc_ac97_suspend,
+	.resume		= au1xpsc_ac97_resume,
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
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index bb58932..f830f5a 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -1,8 +1,8 @@
 /*
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ * (c) 2007-2009 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -262,8 +262,31 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }

-static int au1xpsc_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
+	.trigger	= au1xpsc_i2s_trigger,
+	.hw_params	= au1xpsc_i2s_hw_params,
+	.set_fmt	= au1xpsc_i2s_set_fmt,
+};
+
+struct snd_soc_dai au1xpsc_i2s_dai = {
+	.name			= "au1xpsc_i2s",
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
+static int au1xpsc_i2s_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	unsigned long sel;
@@ -294,9 +317,7 @@ static int au1xpsc_i2s_probe(struct platform_device *pdev,
 	if (!au1xpsc_i2s_workdata->mmio)
 		goto out1;

-	/* preserve PSC clock source set up by platform (dev.platform_data
-	 * is already occupied by soc layer)
-	 */
+	/* preserve PSC clock source set up by platform  */
 	sel = au_readl(PSC_SEL(au1xpsc_i2s_workdata)) & PSC_SEL_CLK_MASK;
 	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
 	au_sync();
@@ -312,9 +333,16 @@ static int au1xpsc_i2s_probe(struct platform_device *pdev,
 	 * be running yet; depending on clock input for PSC a wait might
 	 * time out.
 	 */
+	ret = au1xpsc_asoc_dbdma_init(pdev);
+	if (ret)
+		goto out2;

-	return 0;
+	ret = snd_soc_register_dai(&au1xpsc_i2s_dai);
+	if (!ret)
+		return 0;

+out2:
+	iounmap(au1xpsc_i2s_workdata->mmio);
 out1:
 	release_resource(au1xpsc_i2s_workdata->ioarea);
 	kfree(au1xpsc_i2s_workdata->ioarea);
@@ -324,9 +352,11 @@ out0:
 	return ret;
 }

-static void au1xpsc_i2s_remove(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int __devexit au1xpsc_i2s_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
+	au1xpsc_asoc_dbdma_exit();
+
 	au_writel(0, I2S_CFG(au1xpsc_i2s_workdata));
 	au_sync();
 	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
@@ -337,9 +367,11 @@ static void au1xpsc_i2s_remove(struct platform_device *pdev,
 	kfree(au1xpsc_i2s_workdata->ioarea);
 	kfree(au1xpsc_i2s_workdata);
 	au1xpsc_i2s_workdata = NULL;
+
+	return 0;
 }

-static int au1xpsc_i2s_suspend(struct snd_soc_dai *cpu_dai)
+static int au1xpsc_i2s_suspend(struct platform_device *pdev, pm_message_t m)
 {
 	/* save interesting register and disable PSC */
 	au1xpsc_i2s_workdata->pm[0] =
@@ -353,7 +385,7 @@ static int au1xpsc_i2s_suspend(struct snd_soc_dai *cpu_dai)
 	return 0;
 }

-static int au1xpsc_i2s_resume(struct snd_soc_dai *cpu_dai)
+static int au1xpsc_i2s_resume(struct platform_device *pdev)
 {
 	/* select I2S mode and PSC clock */
 	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
@@ -367,48 +399,31 @@ static int au1xpsc_i2s_resume(struct snd_soc_dai *cpu_dai)
 	return 0;
 }

-static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
-	.trigger	= au1xpsc_i2s_trigger,
-	.hw_params	= au1xpsc_i2s_hw_params,
-	.set_fmt	= au1xpsc_i2s_set_fmt,
-};
-
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
+static struct platform_driver au1xpsc_i2s_driver = {
+	.driver	= {
+		.name	= "au1xpsc_i2s",
+		.owner	= THIS_MODULE,
 	},
-	.capture = {
-		.rates		= AU1XPSC_I2S_RATES,
-		.formats	= AU1XPSC_I2S_FMTS,
-		.channels_min	= 2,
-		.channels_max	= 8,	/* 2 without external help */
-	},
-	.ops = &au1xpsc_i2s_dai_ops,
+	.probe		= au1xpsc_i2s_probe,
+	.remove		= __devexit_p(au1xpsc_i2s_remove),
+	.suspend	= au1xpsc_i2s_suspend,
+	.resume		= au1xpsc_i2s_resume,
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
index 8fdb1a0..9ee4f59 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -1,8 +1,8 @@
 /*
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ * (c) 2007-2009 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,6 +21,9 @@ extern struct snd_soc_dai au1xpsc_i2s_dai;
 extern struct snd_soc_platform au1xpsc_soc_platform;
 extern struct snd_ac97_bus_ops soc_ac97_ops;

+extern int au1xpsc_asoc_dbdma_init(struct platform_device *pdev);
+extern void au1xpsc_asoc_dbdma_exit(void);
+
 struct au1xpsc_audio_data {
 	void __iomem *mmio;

diff --git a/sound/soc/au1x/sample-ac97.c b/sound/soc/au1x/sample-ac97.c
index 27683eb..86380f6 100644
--- a/sound/soc/au1x/sample-ac97.c
+++ b/sound/soc/au1x/sample-ac97.c
@@ -1,7 +1,7 @@
 /*
  * Sample Au12x0/Au1550 PSC AC97 sound machine.
  *
- * Copyright (c) 2007-2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ * Copyright (c) 2007-2009 Manuel Lauss <manuel.lauss@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms outlined in the file COPYING at the root of this
@@ -44,13 +44,13 @@ static struct snd_soc_dai_link au1xpsc_sample_ac97_dai = {

 static struct snd_soc_card au1xpsc_sample_ac97_machine = {
 	.name		= "Au1xxx PSC AC97 Audio",
+	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
 	.dai_link	= &au1xpsc_sample_ac97_dai,
 	.num_links	= 1,
 };

 static struct snd_soc_device au1xpsc_sample_ac97_devdata = {
 	.card		= &au1xpsc_sample_ac97_machine,
-	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
 	.codec_dev	= &soc_codec_dev_ac97,
 };

@@ -82,7 +82,14 @@ static struct resource au1xpsc_psc1_res[] = {
 	},
 };

-static struct platform_device *au1xpsc_sample_ac97_dev;
+static struct platform_device psc_ac97_dev = {
+	.name		= "au1xpsc_ac97",
+	.id		= 0,
+	.resource	= au1xpsc_psc1_res,
+	.num_resources	= ARRAY_SIZE(au1xpsc_psc1_res),
+};
+
+static struct platform_device *au1xpsc_sample_asoc_dev;

 static int __init au1xpsc_sample_ac97_load(void)
 {
@@ -99,41 +106,42 @@ static int __init au1xpsc_sample_ac97_load(void)
 	au_sync();
 #endif

-	ret = -ENOMEM;
-
 	/* setup PSC clock source for AC97 part: external clock provided
 	 * by codec.  The psc-ac97.c driver depends on this setting!
 	 */
 	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
 	au_sync();

-	au1xpsc_sample_ac97_dev = platform_device_alloc("soc-audio", -1);
-	if (!au1xpsc_sample_ac97_dev)
-		goto out;
+	/* register the PSC-AC97 platform device */
+	ret = platform_device_register(&psc_ac97_dev);
+	if (ret)
+		return -ENODEV;

-	au1xpsc_sample_ac97_dev->resource =
-		kmemdup(au1xpsc_psc1_res, sizeof(struct resource) *
-			ARRAY_SIZE(au1xpsc_psc1_res), GFP_KERNEL);
-	au1xpsc_sample_ac97_dev->num_resources = ARRAY_SIZE(au1xpsc_psc1_res);
-	au1xpsc_sample_ac97_dev->id = 1;
+	/* register machine fabric with ASoC core */
+	ret = -ENOMEM;
+	au1xpsc_sample_asoc_dev = platform_device_alloc("soc-audio", -1);
+	if (!au1xpsc_sample_asoc_dev)
+		goto out;

-	platform_set_drvdata(au1xpsc_sample_ac97_dev,
+	platform_set_drvdata(au1xpsc_sample_asoc_dev,
 			     &au1xpsc_sample_ac97_devdata);
-	au1xpsc_sample_ac97_devdata.dev = &au1xpsc_sample_ac97_dev->dev;
-	ret = platform_device_add(au1xpsc_sample_ac97_dev);
+	au1xpsc_sample_ac97_devdata.dev = &au1xpsc_sample_asoc_dev->dev;
+	ret = platform_device_add(au1xpsc_sample_asoc_dev);

 	if (ret) {
-		platform_device_put(au1xpsc_sample_ac97_dev);
-		au1xpsc_sample_ac97_dev = NULL;
+		platform_device_put(au1xpsc_sample_asoc_dev);
+		au1xpsc_sample_asoc_dev = NULL;
 	}

 out:
+	platform_device_unregister(&psc_ac97_dev);
 	return ret;
 }

 static void __exit au1xpsc_sample_ac97_exit(void)
 {
-	platform_device_unregister(au1xpsc_sample_ac97_dev);
+	platform_device_unregister(au1xpsc_sample_asoc_dev);
+	platform_device_unregister(&psc_ac97_dev);
 }

 module_init(au1xpsc_sample_ac97_load);
@@ -141,4 +149,4 @@ module_exit(au1xpsc_sample_ac97_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1xxx PSC sample AC97 machine");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss");
-- 
1.6.3.1
