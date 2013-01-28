From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] ASoC: fsl: fix snd-soc-imx-pcm module build
Date: Mon, 28 Jan 2013 14:25:43 +0800
Message-ID: <1359354343-1711-2-git-send-email-shawn.guo@linaro.org>
References: <1359354343-1711-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 507F226514D
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 07:25:49 +0100 (CET)
In-Reply-To: <1359354343-1711-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

When building modules with CONFIG_SND_IMX_SOC=m in imx_v6_v7_defconfig,
we will see the following link error.

  LD [M]  sound/soc/fsl/snd-soc-fsl-ssi.o
  LD [M]  sound/soc/fsl/snd-soc-fsl-utils.o
  LD [M]  sound/soc/fsl/snd-soc-imx-ssi.o
  LD [M]  sound/soc/fsl/snd-soc-imx-audmux.o
  LD [M]  sound/soc/fsl/snd-soc-imx-pcm.o
sound/soc/fsl/imx-pcm-dma.o: In function `init_module':
imx-pcm-dma.c:(.init.text+0x0): multiple definition of `init_module'
sound/soc/fsl/imx-pcm-fiq.o:imx-pcm-fiq.c:(.init.text+0x0): first defined here
sound/soc/fsl/imx-pcm-dma.o: In function `cleanup_module':
imx-pcm-dma.c:(.exit.text+0x0): multiple definition of `cleanup_module'
sound/soc/fsl/imx-pcm-fiq.o:imx-pcm-fiq.c:(.exit.text+0x0): first defined here
make[4]: *** [sound/soc/fsl/snd-soc-imx-pcm.o] Error 1

The module snd-soc-imx-pcm is designed to link imx-pcm.o with
imx-pcm-dma.o or imx-pcm-fiq.o depending on if option SND_SOC_IMX_PCM_DMA
or SND_SOC_IMX_PCM_FIQ is enabled.  Both imx-pcm-dma and imx-pcm-fiq
register their own module_platform_driver.  However, these two options
are not mutually exclusive and can be enabled together.  And that's
why we see above multiple init_module definition error.

Instead of having both imx-pcm-dma and imx-pcm-fiq register their
own platform_driver, we should do only once in imx-pcm.c.  Using
platform_device_id to distinguish between imx-pcm-dma and imx-pcm-fiq,
we can run-time call imx-pcm-dma/fiq specific initialization in .probe
hook to have module snd-soc-imx-pcm work for both cases.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/imx-pcm-dma.c |   21 +--------------------
 sound/soc/fsl/imx-pcm-fiq.c |   22 +---------------------
 sound/soc/fsl/imx-pcm.c     |   32 ++++++++++++++++++++++++++++++++
 sound/soc/fsl/imx-pcm.h     |   18 ++++++++++++++++++
 4 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index bf363d8..500f8ce 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -154,26 +154,7 @@ static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 	.pcm_free	= imx_pcm_free,
 };
 
-static int imx_soc_platform_probe(struct platform_device *pdev)
+int imx_pcm_dma_init(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
-
-static int imx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver imx_pcm_driver = {
-	.driver = {
-			.name = "imx-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-	.probe = imx_soc_platform_probe,
-	.remove = imx_soc_platform_remove,
-};
-
-module_platform_driver(imx_pcm_driver);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:imx-pcm-audio");
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 5ec362a..920f945 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -281,7 +281,7 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 	.pcm_free	= imx_pcm_fiq_free,
 };
 
-static int imx_soc_platform_probe(struct platform_device *pdev)
+int imx_pcm_fiq_init(struct platform_device *pdev)
 {
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 	int ret;
@@ -314,23 +314,3 @@ failed_register:
 
 	return ret;
 }
-
-static int imx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver imx_pcm_driver = {
-	.driver = {
-			.name = "imx-fiq-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = imx_soc_platform_probe,
-	.remove = imx_soc_platform_remove,
-};
-
-module_platform_driver(imx_pcm_driver);
-
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
index d5cd9ef..0d0625b 100644
--- a/sound/soc/fsl/imx-pcm.c
+++ b/sound/soc/fsl/imx-pcm.c
@@ -104,6 +104,38 @@ void imx_pcm_free(struct snd_pcm *pcm)
 }
 EXPORT_SYMBOL_GPL(imx_pcm_free);
 
+static int imx_pcm_probe(struct platform_device *pdev)
+{
+	if (strcmp(pdev->id_entry->name, "imx-fiq-pcm-audio") == 0)
+		return imx_pcm_fiq_init(pdev);
+
+	return imx_pcm_dma_init(pdev);
+}
+
+static int imx_pcm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_device_id imx_pcm_devtype[] = {
+	{ .name = "imx-pcm-audio", },
+	{ .name = "imx-fiq-pcm-audio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, imx_pcm_devtype);
+
+static struct platform_driver imx_pcm_driver = {
+	.driver = {
+			.name = "imx-pcm",
+			.owner = THIS_MODULE,
+	},
+	.id_table = imx_pcm_devtype,
+	.probe = imx_pcm_probe,
+	.remove = imx_pcm_remove,
+};
+module_platform_driver(imx_pcm_driver);
+
 MODULE_DESCRIPTION("Freescale i.MX PCM driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 83c0ed7..5ae13a1 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -30,4 +30,22 @@ int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd);
 void imx_pcm_free(struct snd_pcm *pcm);
 
+#ifdef CONFIG_SND_SOC_IMX_PCM_DMA
+int imx_pcm_dma_init(struct platform_device *pdev);
+#else
+static inline int imx_pcm_dma_init(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
+#ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
+int imx_pcm_fiq_init(struct platform_device *pdev);
+#else
+static inline int imx_pcm_fiq_init(struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* _IMX_PCM_H */
-- 
1.7.9.5
