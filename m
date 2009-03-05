From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: add support for SSI asynchronous mode to
	the Freescale SSI drivers
Date: Thu,  5 Mar 2009 17:23:37 -0600
Message-ID: <1236295417-12013-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 16E46103836
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 00:24:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add a new device tree property for the SSI node: "fsl,ssi-asynchronous".  If
defined, the SSI is programmed into asynchronous mode, otherwise it is
programmed into synchronous mode.  In asynchronous mode, pin SRCK must be
connected to the same clock source as STFS, and pin SRFS must be connected to
the same signal as STFS.  Asynchronous mode allows playback and capture to
use different sample sizes.  It also technically allows different sample rates,
but the driver does not support that.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c      |   42 ++++++++++++++++++++++++++++++++----------
 sound/soc/fsl/fsl_ssi.h      |    2 ++
 sound/soc/fsl/mpc8610_hpcd.c |    5 +++++
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6844009..8cb6bcf 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -72,6 +72,7 @@
  * @dev: struct device pointer
  * @playback: the number of playback streams opened
  * @capture: the number of capture streams opened
+ * @asynchronous: 0=synchronous mode, 1=asynchronous mode
  * @cpu_dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
  * @stats: SSI statistics
@@ -86,6 +87,7 @@ struct fsl_ssi_private {
 	struct device *dev;
 	unsigned int playback;
 	unsigned int capture;
+	int asynchronous;
 	struct snd_soc_dai cpu_dai;
 	struct device_attribute dev_attr;
 
@@ -301,9 +303,10 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 *
 		 * FIXME: Little-endian samples require a different shift dir
 		 */
-		clrsetbits_be32(&ssi->scr, CCSR_SSI_SCR_I2S_MODE_MASK,
-			CCSR_SSI_SCR_TFR_CLK_DIS |
-			CCSR_SSI_SCR_I2S_MODE_SLAVE | CCSR_SSI_SCR_SYN);
+		clrsetbits_be32(&ssi->scr,
+			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
+			CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE
+			| (ssi_private->asynchronous ? 0 : CCSR_SSI_SCR_SYN));
 
 		out_be32(&ssi->stcr,
 			 CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
@@ -382,10 +385,15 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			SNDRV_PCM_HW_PARAM_RATE,
 			first_runtime->rate, first_runtime->rate);
 
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-			SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-			first_runtime->sample_bits,
-			first_runtime->sample_bits);
+		/* If we're in synchronous mode, then we need to constrain
+		 * the sample size as well.  We don't support independent sample
+		 * rates in asynchronous mode.
+		 */
+		if (!ssi_private->asynchronous)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
+				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				first_runtime->sample_bits,
+				first_runtime->sample_bits);
 
 		ssi_private->second_stream = substream;
 	}
@@ -421,13 +429,18 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 		unsigned int sample_size =
 			snd_pcm_format_width(params_format(hw_params));
-		u32 wl;
+		u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
 
 		/* The SSI should always be disabled at this points (SSIEN=0) */
-		wl = CCSR_SSI_SxCCR_WL(sample_size);
 
 		/* In synchronous mode, the SSI uses STCCR for capture */
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+		if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
+		    !ssi_private->asynchronous)
+			clrsetbits_be32(&ssi->stccr,
+					CCSR_SSI_SxCCR_WL_MASK, wl);
+		else
+			clrsetbits_be32(&ssi->srccr,
+					CCSR_SSI_SxCCR_WL_MASK, wl);
 	}
 
 	return 0;
@@ -653,6 +666,7 @@ struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 	ssi_private->ssi_phys = ssi_info->ssi_phys;
 	ssi_private->irq = ssi_info->irq;
 	ssi_private->dev = ssi_info->dev;
+	ssi_private->asynchronous = ssi_info->asynchronous;
 
 	ssi_private->dev->driver_data = fsl_ssi_dai;
 
@@ -703,6 +717,14 @@ void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai)
 }
 EXPORT_SYMBOL_GPL(fsl_ssi_destroy_dai);
 
+static int __init fsl_ssi_init(void)
+{
+	printk(KERN_INFO "Freescale Synchronous Serial Interface (SSI) ASoC Driver\n");
+
+	return 0;
+}
+module_init(fsl_ssi_init);
+
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 83b44d7..eade01f 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -208,6 +208,7 @@ struct ccsr_ssi {
  * ssi_phys: physical address of the SSI registers
  * irq: IRQ of this SSI
  * dev: struct device, used to create the sysfs statistics file
+ * asynchronous: 0=synchronous mode, 1=asynchronous mode
 */
 struct fsl_ssi_info {
 	unsigned int id;
@@ -215,6 +216,7 @@ struct fsl_ssi_info {
 	dma_addr_t ssi_phys;
 	unsigned int irq;
 	struct device *dev;
+	int asynchronous;
 };
 
 struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index acf39a6..ef67d1c 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -353,6 +353,11 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	}
 	ssi_info.irq = machine_data->ssi_irq;
 
+	/* Do we want to use asynchronous mode? */
+	ssi_info.asynchronous =
+		of_find_property(np, "fsl,ssi-asynchronous", NULL) ? 1 : 0;
+	if (ssi_info.asynchronous)
+		dev_info(&ofdev->dev, "using asynchronous mode\n");
 
 	/* Map the global utilities registers. */
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
-- 
1.6.1.3
