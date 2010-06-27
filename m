From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 14/15] ASoC: multi-component - Winbond/Nuvoton
	NUC900 Platform
Date: Sun, 27 Jun 2010 12:52:13 +0100
Message-ID: <1277639534-5104-15-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CDD3D1038C7
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:51 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so919374wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:51 -0700 (PDT)
In-Reply-To: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Winbond-Nuvoton platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/nuc900/nuc900-ac97.c  |    8 +++-----
 sound/soc/nuc900/nuc900-audio.c |   15 +++++----------
 sound/soc/nuc900/nuc900-audio.h |    4 ++--
 sound/soc/nuc900/nuc900-pcm.c   |   36 ++++++++++++++++++++++++++++--------
 4 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index caa7c90..8bc5e2b 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -297,7 +297,7 @@ static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
 	.trigger	= nuc900_ac97_trigger,
 };
 
-struct snd_soc_dai nuc900_ac97_dai = {
+struct snd_soc_dai_driver nuc900_ac97_dai = {
 	.name			= "nuc900-ac97",
 	.probe			= nuc900_ac97_probe,
 	.remove			= nuc900_ac97_remove,
@@ -365,9 +365,7 @@ static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
 
 	nuc900_ac97_data = nuc900_audio;
 
-	nuc900_audio->dev = nuc900_ac97_dai.dev =  &pdev->dev;
-
-	ret = snd_soc_register_dai(&nuc900_ac97_dai);
+	ret = snd_soc_register_dai(&pdev->dev, pdev->id, &nuc900_ac97_dai);
 	if (ret)
 		goto out3;
 
@@ -390,7 +388,7 @@ out0:
 static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
 {
 
-	snd_soc_unregister_dai(&nuc900_ac97_dai);
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
 
 	clk_put(nuc900_ac97_data->clk);
 	iounmap(nuc900_ac97_data->mmio);
diff --git a/sound/soc/nuc900/nuc900-audio.c b/sound/soc/nuc900/nuc900-audio.c
index 72e6f51..c245623 100644
--- a/sound/soc/nuc900/nuc900-audio.c
+++ b/sound/soc/nuc900/nuc900-audio.c
@@ -26,20 +26,16 @@
 static struct snd_soc_dai_link nuc900evb_ac97_dai = {
 	.name		= "AC97",
 	.stream_name	= "AC97 HiFi",
-	.cpu_dai	= &nuc900_ac97_dai,
-	.codec_dai	= &ac97_dai,
+	.cpu_dai_drv	= &nuc900_ac97_dai,
+	.codec_dai_drv	= &ac97_dai,
+	.codec_drv	= &soc_codec_dev_ac97,
+	.platform_drv	= &nuc900_soc_platform,
 };
 
 static struct snd_soc_card nuc900evb_audio_machine = {
 	.name		= "NUC900EVB_AC97",
 	.dai_link	= &nuc900evb_ac97_dai,
 	.num_links	= 1,
-	.platform	= &nuc900_soc_platform,
-};
-
-static struct snd_soc_device nuc900evb_ac97_devdata = {
-	.card		= &nuc900evb_audio_machine,
-	.codec_dev	= &soc_codec_dev_ac97,
 };
 
 static struct platform_device *nuc900evb_asoc_dev;
@@ -54,9 +50,8 @@ static int __init nuc900evb_audio_init(void)
 		goto out;
 
 	/* nuc900 board audio device */
-	platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_ac97_devdata);
+	platform_set_drvdata(nuc900evb_asoc_dev, &nuc900evb_audio_machine);
 
-	nuc900evb_ac97_devdata.dev = &nuc900evb_asoc_dev->dev;
 	ret = platform_device_add(nuc900evb_asoc_dev);
 
 	if (ret) {
diff --git a/sound/soc/nuc900/nuc900-audio.h b/sound/soc/nuc900/nuc900-audio.h
index 3038f51..b0f9719 100644
--- a/sound/soc/nuc900/nuc900-audio.h
+++ b/sound/soc/nuc900/nuc900-audio.h
@@ -111,7 +111,7 @@ struct nuc900_audio {
 };
 
 extern struct nuc900_audio *nuc900_ac97_data;
-extern struct snd_soc_dai nuc900_ac97_dai;
-extern struct snd_soc_platform nuc900_soc_platform;
+extern struct snd_soc_dai_driver nuc900_ac97_dai;
+extern struct snd_soc_platform_driver nuc900_soc_platform;
 
 #endif /*end _NUC900_AUDIO_H */
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index e81e803..dbb730e 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -328,26 +328,46 @@ static int nuc900_dma_new(struct snd_card *card,
 	return 0;
 }
 
-struct snd_soc_platform nuc900_soc_platform = {
+struct snd_soc_platform_driver nuc900_soc_platform = {
 	.name		= "nuc900-dma",
-	.pcm_ops	= &nuc900_dma_ops,
+	.ops		= &nuc900_dma_ops,
 	.pcm_new	= nuc900_dma_new,
 	.pcm_free	= nuc900_dma_free_dma_buffers,
 }
 EXPORT_SYMBOL_GPL(nuc900_soc_platform);
 
-static int __init nuc900_soc_platform_init(void)
+static int __devinit nuc900_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&nuc900_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &nuc900_soc_platform);
 }
 
-static void __exit nuc900_soc_platform_exit(void)
+static int __devexit nuc900_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&nuc900_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
 }
 
-module_init(nuc900_soc_platform_init);
-module_exit(nuc900_soc_platform_exit);
+static struct platform_driver nuc900_pcm_driver = {
+	.driver = {
+			.name = "nuc900-pcm",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = nuc900_soc_platform_probe,
+	.remove = __devexit_p(nuc900_soc_platform_remove),
+};
+
+static int __init nuc900_pcm_init(void)
+{
+	return platform_driver_register(&nuc900_pcm_driver);
+}
+module_init(nuc900_pcm_init);
+
+static void __exit nuc900_pcm_exit(void)
+{
+	platform_driver_unregister(&nuc900_pcm_driver);
+}
+module_exit(nuc900_pcm_exit);
 
 MODULE_AUTHOR("Wan ZongShun, <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("nuc900 Audio DMA module");
-- 
1.7.0.4
