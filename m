From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 10/15] ASoC: multi-component - RMI Alchemy AU1x
	Platform
Date: Sun, 27 Jun 2010 12:52:09 +0100
Message-ID: <1277639534-5104-11-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C04A1038B2
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:48 +0200 (CEST)
Received: by wyf23 with SMTP id 23so919374wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:46 -0700 (PDT)
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

Update the RMI Alchemy platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Removed empty remove() functions

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/au1x/db1200.c   |   34 ++++++++++++----------------------
 sound/soc/au1x/dbdma2.c   |   16 +++++-----------
 sound/soc/au1x/psc-ac97.c |   17 +++++------------
 sound/soc/au1x/psc-i2s.c  |   17 +++++------------
 sound/soc/au1x/psc.h      |    6 +++---
 5 files changed, 30 insertions(+), 60 deletions(-)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index cdf7be1..613cecc 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -28,20 +28,16 @@
 static struct snd_soc_dai_link db1200_ac97_dai = {
 	.name		= "AC97",
 	.stream_name	= "AC97 HiFi",
-	.cpu_dai	= &au1xpsc_ac97_dai,
-	.codec_dai	= &ac97_dai,
+	.cpu_dai_drv	= &au1xpsc_ac97_dai,
+	.codec_dai_drv	= &ac97_dai,
+	.platform_drv	= &au1xpsc_soc_platform,
+	.codec_drv	= &soc_codec_dev_ac97,
 };
 
 static struct snd_soc_card db1200_ac97_machine = {
 	.name		= "DB1200_AC97",
 	.dai_link	= &db1200_ac97_dai,
 	.num_links	= 1,
-	.platform	= &au1xpsc_soc_platform,
-};
-
-static struct snd_soc_device db1200_ac97_devdata = {
-	.card		= &db1200_ac97_machine,
-	.codec_dev	= &soc_codec_dev_ac97,
 };
 
 /*-------------------------  I2S PART  ---------------------------*/
@@ -49,8 +45,8 @@ static struct snd_soc_device db1200_ac97_devdata = {
 static int db1200_i2s_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 
 	/* WM8731 has its own 12MHz crystal */
@@ -80,8 +76,10 @@ static struct snd_soc_ops db1200_i2s_wm8731_ops = {
 static struct snd_soc_dai_link db1200_i2s_dai = {
 	.name		= "WM8731",
 	.stream_name	= "WM8731 PCM",
-	.cpu_dai	= &au1xpsc_i2s_dai,
-	.codec_dai	= &wm8731_dai,
+	.cpu_dai_drv	= &au1xpsc_i2s_dai,
+	.codec_dai_drv	= &wm8731_dai,
+	.platform_drv	= &au1xpsc_soc_platform,
+	.codec_drv	= &soc_codec_dev_wm8731,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
@@ -89,12 +87,6 @@ static struct snd_soc_card db1200_i2s_machine = {
 	.name		= "DB1200_I2S",
 	.dai_link	= &db1200_i2s_dai,
 	.num_links	= 1,
-	.platform	= &au1xpsc_soc_platform,
-};
-
-static struct snd_soc_device db1200_i2s_devdata = {
-	.card		= &db1200_i2s_machine,
-	.codec_dev	= &soc_codec_dev_wm8731,
 };
 
 /*-------------------------  COMMON PART  ---------------------------*/
@@ -112,12 +104,10 @@ static int __init db1200_audio_load(void)
 
 	/* DB1200 board setup set PSC1MUX to preferred audio device */
 	if (bcsr_read(BCSR_RESETS) & BCSR_RESETS_PSC1MUX)
-		platform_set_drvdata(db1200_asoc_dev, &db1200_i2s_devdata);
+		platform_set_drvdata(db1200_asoc_dev, &db1200_i2s_machine);
 	else
-		platform_set_drvdata(db1200_asoc_dev, &db1200_ac97_devdata);
+		platform_set_drvdata(db1200_asoc_dev, &db1200_ac97_machine);
 
-	db1200_ac97_devdata.dev = &db1200_asoc_dev->dev;
-	db1200_i2s_devdata.dev = &db1200_asoc_dev->dev;
 	ret = platform_device_add(db1200_asoc_dev);
 
 	if (ret) {
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 6d9f4c6..f57a548 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -329,7 +329,7 @@ static int au1xpsc_pcm_new(struct snd_card *card,
 	return 0;
 }
 
-static int au1xpsc_pcm_probe(struct platform_device *pdev)
+static int au1xpsc_pcm_probe(struct snd_soc_platform *platform)
 {
 	if (!au1xpsc_audio_pcmdma[PCM_TX] || !au1xpsc_audio_pcmdma[PCM_RX])
 		return -ENODEV;
@@ -337,17 +337,11 @@ static int au1xpsc_pcm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int au1xpsc_pcm_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 /* au1xpsc audio platform */
-struct snd_soc_platform au1xpsc_soc_platform = {
+struct snd_soc_platform_driver au1xpsc_soc_platform = {
 	.name		= "au1xpsc-pcm-dbdma",
 	.probe		= au1xpsc_pcm_probe,
-	.remove		= au1xpsc_pcm_remove,
-	.pcm_ops 	= &au1xpsc_pcm_ops,
+	.ops		= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
 	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
 };
@@ -387,7 +381,7 @@ static int __devinit au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 	}
 	(au1xpsc_audio_pcmdma[PCM_RX])->ddma_id = r->start;
 
-	ret = snd_soc_register_platform(&au1xpsc_soc_platform);
+	ret = snd_soc_register_platform(&pdev->dev, -1, &au1xpsc_soc_platform);
 	if (!ret)
 		return ret;
 
@@ -404,7 +398,7 @@ static int __devexit au1xpsc_pcm_drvremove(struct platform_device *pdev)
 {
 	int i;
 
-	snd_soc_unregister_platform(&au1xpsc_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
 
 	for (i = 0; i < 2; i++) {
 		if (au1xpsc_audio_pcmdma[i]) {
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index d14a5a9..d2117d0 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -315,27 +315,20 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int au1xpsc_ac97_probe(struct platform_device *pdev,
-			      struct snd_soc_dai *dai)
+static int au1xpsc_ac97_probe(struct snd_soc_dai *dai)
 {
 	return au1xpsc_ac97_workdata ? 0 : -ENODEV;
 }
 
-static void au1xpsc_ac97_remove(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
-{
-}
-
 static struct snd_soc_dai_ops au1xpsc_ac97_dai_ops = {
 	.trigger	= au1xpsc_ac97_trigger,
 	.hw_params	= au1xpsc_ac97_hw_params,
 };
 
-struct snd_soc_dai au1xpsc_ac97_dai = {
+struct snd_soc_dai_driver au1xpsc_ac97_dai = {
 	.name			= "au1xpsc_ac97",
 	.ac97_control		= 1,
 	.probe			= au1xpsc_ac97_probe,
-	.remove			= au1xpsc_ac97_remove,
 	.playback = {
 		.rates		= AC97_RATES,
 		.formats	= AC97_FMTS,
@@ -395,7 +388,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	au_writel(PSC_SEL_PS_AC97MODE | sel, PSC_SEL(wd));
 	au_sync();
 
-	ret = snd_soc_register_dai(&au1xpsc_ac97_dai);
+	ret = snd_soc_register_dai(&pdev->dev, -1, &au1xpsc_ac97_dai);
 	if (ret)
 		goto out1;
 
@@ -406,7 +399,7 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 		return 0;
 	}
 
-	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 out1:
 	release_mem_region(r->start, resource_size(r));
 out0:
@@ -422,7 +415,7 @@ static int __devexit au1xpsc_ac97_drvremove(struct platform_device *pdev)
 	if (wd->dmapd)
 		au1xpsc_pcm_destroy(wd->dmapd);
 
-	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 
 	/* disable PSC completely */
 	au_writel(0, AC97_CFG(wd));
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 737b238..2337bcb 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -263,27 +263,20 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static int au1xpsc_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int au1xpsc_i2s_probe(struct snd_soc_dai *dai)
 {
 	return 	au1xpsc_i2s_workdata ? 0 : -ENODEV;
 }
 
-static void au1xpsc_i2s_remove(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
-{
-}
-
 static struct snd_soc_dai_ops au1xpsc_i2s_dai_ops = {
 	.trigger	= au1xpsc_i2s_trigger,
 	.hw_params	= au1xpsc_i2s_hw_params,
 	.set_fmt	= au1xpsc_i2s_set_fmt,
 };
 
-struct snd_soc_dai au1xpsc_i2s_dai = {
+struct snd_soc_dai_driver au1xpsc_i2s_dai = {
 	.name			= "au1xpsc_i2s",
 	.probe			= au1xpsc_i2s_probe,
-	.remove			= au1xpsc_i2s_remove,
 	.playback = {
 		.rates		= AU1XPSC_I2S_RATES,
 		.formats	= AU1XPSC_I2S_FMTS,
@@ -346,7 +339,7 @@ static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	 * time out.
 	 */
 
-	ret = snd_soc_register_dai(&au1xpsc_i2s_dai);
+	ret = snd_soc_register_dai(&pdev->dev, -1, &au1xpsc_i2s_dai);
 	if (ret)
 		goto out1;
 
@@ -358,7 +351,7 @@ static int __init au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 		return 0;
 	}
 
-	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 out1:
 	release_mem_region(r->start, resource_size(r));
 out0:
@@ -374,7 +367,7 @@ static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
 	if (wd->dmapd)
 		au1xpsc_pcm_destroy(wd->dmapd);
 
-	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 
 	au_writel(0, I2S_CFG(wd));
 	au_sync();
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 093775d..1d2e1fd 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -16,9 +16,9 @@
 #ifndef _AU1X_PCM_H
 #define _AU1X_PCM_H
 
-extern struct snd_soc_dai au1xpsc_ac97_dai;
-extern struct snd_soc_dai au1xpsc_i2s_dai;
-extern struct snd_soc_platform au1xpsc_soc_platform;
+extern struct snd_soc_dai_driver au1xpsc_ac97_dai;
+extern struct snd_soc_dai_driver au1xpsc_i2s_dai;
+extern struct snd_soc_platform_driver au1xpsc_soc_platform;
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
 /* DBDMA helpers */
-- 
1.7.0.4
