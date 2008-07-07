From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 06/10] asoc: fsl - merge structs
	snd_soc_codec_dai and	snd_soc_cpu_dai.
Date: Mon, 07 Jul 2008 16:08:00 +0100
Message-ID: <1215443280.4882.183.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F8AF10382A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 17:08:01 +0200 (CEST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


This patch merges struct snd_soc_codec_dai and struct
snd_soc_cpu_dai into struct snd_soc_dai for the Freescale PPC platform.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/fsl/fsl_dma.c      |    2 +-
 sound/soc/fsl/fsl_dma.h      |    2 +-
 sound/soc/fsl/fsl_ssi.c      |   24 ++++++++++++------------
 sound/soc/fsl/fsl_ssi.h      |    4 ++--
 sound/soc/fsl/mpc8610_hpcd.c |    4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 78de716..da2bc59 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -282,7 +282,7 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
  * once for each .dai_link in the machine driver's snd_soc_machine
  * structure.
  */
-static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
+static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
 	static u64 fsl_dma_dmamask = DMA_BIT_MASK(32);
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 430a6ce..385d4a4 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -126,7 +126,7 @@ struct fsl_dma_link_descriptor {
 	u8 res[4];      /* Reserved */
 } __attribute__ ((aligned(32), packed));
 
-/* DMA information needed to create a snd_soc_cpu_dai object
+/* DMA information needed to create a snd_soc_dai object
  *
  * ssi_stx_phys: bus address of SSI STX register to use
  * ssi_srx_phys: bus address of SSI SRX register to use
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f588545..71bff33 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -82,7 +82,7 @@ struct fsl_ssi_private {
 	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
-	struct snd_soc_cpu_dai cpu_dai;
+	struct snd_soc_dai cpu_dai;
 	struct device_attribute dev_attr;
 
 	struct {
@@ -479,7 +479,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
  * @freq: the frequency of the given clock ID, currently ignored
  * @dir: SND_SOC_CLOCK_IN (clock slave) or SND_SOC_CLOCK_OUT (clock master)
  */
-static int fsl_ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+static int fsl_ssi_set_sysclk(struct snd_soc_dai *cpu_dai,
 			      int clk_id, unsigned int freq, int dir)
 {
 
@@ -497,7 +497,7 @@ static int fsl_ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
  *
  * @format: one of SND_SOC_DAIFMT_xxx
  */
-static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
+static int fsl_ssi_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
 {
 	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
 }
@@ -505,7 +505,7 @@ static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
 /**
  * fsl_ssi_dai_template: template CPU DAI for the SSI
  */
-static struct snd_soc_cpu_dai fsl_ssi_dai_template = {
+static struct snd_soc_dai fsl_ssi_dai_template = {
 	.playback = {
 		/* The SSI does not support monaural audio. */
 		.channels_min = 2,
@@ -569,15 +569,15 @@ static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 }
 
 /**
- * fsl_ssi_create_dai: create a snd_soc_cpu_dai structure
+ * fsl_ssi_create_dai: create a snd_soc_dai structure
  *
- * This function is called by the machine driver to create a snd_soc_cpu_dai
+ * This function is called by the machine driver to create a snd_soc_dai
  * structure.  The function creates an ssi_private object, which contains
- * the snd_soc_cpu_dai.  It also creates the sysfs statistics device.
+ * the snd_soc_dai.  It also creates the sysfs statistics device.
  */
-struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
+struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 {
-	struct snd_soc_cpu_dai *fsl_ssi_dai;
+	struct snd_soc_dai *fsl_ssi_dai;
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
 	struct device_attribute *dev_attr;
@@ -588,7 +588,7 @@ struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 		return NULL;
 	}
 	memcpy(&ssi_private->cpu_dai, &fsl_ssi_dai_template,
-	       sizeof(struct snd_soc_cpu_dai));
+	       sizeof(struct snd_soc_dai));
 
 	fsl_ssi_dai = &ssi_private->cpu_dai;
 	dev_attr = &ssi_private->dev_attr;
@@ -623,11 +623,11 @@ struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 EXPORT_SYMBOL_GPL(fsl_ssi_create_dai);
 
 /**
- * fsl_ssi_destroy_dai: destroy the snd_soc_cpu_dai object
+ * fsl_ssi_destroy_dai: destroy the snd_soc_dai object
  *
  * This function undoes the operations of fsl_ssi_create_dai()
  */
-void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai)
+void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai)
 {
 	struct fsl_ssi_private *ssi_private =
 	container_of(fsl_ssi_dai, struct fsl_ssi_private, cpu_dai);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index c5ce88e..83b44d7 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -217,8 +217,8 @@ struct fsl_ssi_info {
 	struct device *dev;
 };
 
-struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
-void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai);
+struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
+void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai);
 
 #endif
 
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 8820c3f..59d7e49 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -96,8 +96,8 @@ static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct mpc8610_hpcd_data *machine_data =
 		rtd->socdev->dev->platform_data;
 	int ret = 0;
-- 
1.5.4.2
