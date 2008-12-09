From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/18] ASoC: Register platform drivers
Date: Tue,  9 Dec 2008 14:01:38 +0000
Message-ID: <1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1294A10382B
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is done at modprobe time, mirroring current behaviour, except for
mpc5200_psc_i2s where we do registration at the same time as we register
with soc-of-simple. Since the core currently ignores registration this
has no practical impact.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/atmel-pcm.c         |   12 ++++++++++++
 sound/soc/au1x/dbdma2.c             |    3 ++-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   12 ++++++++++++
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   12 ++++++++++++
 sound/soc/davinci/davinci-pcm.c     |   12 ++++++++++++
 sound/soc/fsl/fsl_dma.c             |   12 ++++++++++++
 sound/soc/fsl/mpc5200_psc_i2s.c     |    4 ++++
 sound/soc/omap/omap-pcm.c           |   12 ++++++++++++
 sound/soc/pxa/pxa2xx-pcm.c          |   12 ++++++++++++
 sound/soc/s3c24xx/s3c24xx-pcm.c     |   12 ++++++++++++
 sound/soc/sh/dma-sh7760.c           |   12 ++++++++++++
 11 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 8507aa1..d6bcb4e 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -477,6 +477,18 @@ struct snd_soc_platform atmel_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(atmel_soc_platform);
 
+static int __devinit atmel_pcm_modinit(void)
+{
+	return snd_soc_register_platform(&atmel_soc_platform);
+}
+module_init(atmel_pcm_modinit);
+
+static void __exit atmel_pcm_exit(void)
+{
+	snd_soc_unregister_platform(&atmel_soc_platform);
+}
+module_exit(atmel_pcm_modexit);
+
 MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
 MODULE_DESCRIPTION("Atmel PCM module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 1466d93..74c823d 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -406,11 +406,12 @@ static int __init au1xpsc_audio_dbdma_init(void)
 {
 	au1xpsc_audio_pcmdma[PCM_TX] = NULL;
 	au1xpsc_audio_pcmdma[PCM_RX] = NULL;
-	return 0;
+	return snd_soc_register_platform(&au1xpsc_soc_platform);
 }
 
 static void __exit au1xpsc_audio_dbdma_exit(void)
 {
+	snd_soc_unregister_platform(&au1xpsc_soc_platform);
 }
 
 module_init(au1xpsc_audio_dbdma_init);
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index d3d51bc..5b27e0d 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -451,6 +451,18 @@ struct snd_soc_platform bf5xx_ac97_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(bf5xx_ac97_soc_platform);
 
+static int __devinit bfin_ac97_init(void)
+{
+	return snd_soc_register_platform(&bf5xx_ac97_soc_platform);
+}
+module_init(bfin_ac97_init);
+
+static void __exit bfin_ac97_exit(void)
+{
+	snd_soc_unregister_platform(&bf5xx_ac97_soc_platform);
+}
+module_exit(bfin_ac97_exit);
+
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin AC97 PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 61fccf9..c58b12a 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -283,6 +283,18 @@ struct snd_soc_platform bf5xx_i2s_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(bf5xx_i2s_soc_platform);
 
+static int __devinit bfin_i2s_init(void)
+{
+	return snd_soc_register_platform(&bf5xx_i2s_soc_platform);
+}
+module_init(bfin_i2s_init);
+
+static void __exit bfin_i2s_exit(void)
+{
+	snd_soc_unregister_platform(&bf5xx_i2s_soc_platform);
+}
+module_exit(bfin_i2s_exit);
+
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin I2S PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 76feaa6..f1b6e02 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -384,6 +384,18 @@ struct snd_soc_platform davinci_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(davinci_soc_platform);
 
+static int __devinit davinci_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&davinci_soc_platform);
+}
+module_init(davinci_soc_platform_init);
+
+static void __exit davinci_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&davinci_soc_platform);
+}
+module_exit(davinci_soc_platform_exit);
+
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index bf92331..646c807 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -853,6 +853,18 @@ int fsl_dma_configure(struct fsl_dma_info *dma_info)
 }
 EXPORT_SYMBOL_GPL(fsl_dma_configure);
 
+static int __devinit fsl_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&fsl_soc_platform);
+}
+module_init(fsl_soc_platform_init);
+
+static void __exit fsl_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&fsl_soc_platform);
+}
+module_exit(fsl_soc_platform_exit);
+
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Elo DMA ASoC PCM module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 9ad8f9a..9eb1ce1 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -828,6 +828,8 @@ static int __devinit psc_i2s_of_probe(struct of_device *op,
 	if (rc)
 		dev_info(psc_i2s->dev, "error creating sysfs files\n");
 
+	snd_soc_register_platform(&psc_i2s_pcm_soc_platform);
+
 	/* Tell the ASoC OF helpers about it */
 	of_snd_soc_register_platform(&psc_i2s_pcm_soc_platform, op->node,
 				     &psc_i2s->dai);
@@ -841,6 +843,8 @@ static int __devexit psc_i2s_of_remove(struct of_device *op)
 
 	dev_dbg(&op->dev, "psc_i2s_remove()\n");
 
+	snd_soc_unregister_platform(&psc_i2s_pcm_soc_platform);
+
 	bcom_gen_bd_rx_release(psc_i2s->capture.bcom_task);
 	bcom_gen_bd_tx_release(psc_i2s->playback.bcom_task);
 
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index e9084fd..9940de2 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -354,6 +354,18 @@ struct snd_soc_platform omap_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(omap_soc_platform);
 
+static int __devinit omap_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&omap_soc_platform);
+}
+module_init(omap_soc_platform_init);
+
+static void __exit omap_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&omap_soc_platform);
+}
+module_exit(omap_soc_platform_exit);
+
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 0f6b7bb..4fa1578 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -118,6 +118,18 @@ struct snd_soc_platform pxa2xx_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(pxa2xx_soc_platform);
 
+static int __devinit pxa2xx_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&pxa2xx_soc_platform);
+}
+module_init(pxa2xx_soc_platform_init);
+
+static void __exit pxa2xx_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&pxa2xx_soc_platform);
+}
+module_exit(pxa2xx_soc_platform_exit);
+
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index e13e614..ea5a9ca 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -465,6 +465,18 @@ struct snd_soc_platform s3c24xx_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(s3c24xx_soc_platform);
 
+static int __devinit s3c24xx_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&s3c24xx_soc_platform);
+}
+module_init(s3c24xx_soc_platform_init);
+
+static void __exit s3c24xx_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&s3c24xx_soc_platform);
+}
+module_exit(s3c24xx_soc_platform_exit);
+
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C24XX PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 9faa126..39ffca0 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -348,6 +348,18 @@ struct snd_soc_platform sh7760_soc_platform = {
 };
 EXPORT_SYMBOL_GPL(sh7760_soc_platform);
 
+static int __devinit sh7760_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&sh7760_soc_platform);
+}
+module_init(sh7760_soc_platform_init);
+
+static void __exit sh7760_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&sh7760_soc_platform);
+}
+module_exit(sh7760_soc_platform_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SH7760 Audio DMA (DMABRG) driver");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.5.6.5
