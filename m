From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 15/19] ASoC 0.13 pxa2xx DMA
Date: Fri, 02 Feb 2007 14:45:56 +0000
Message-ID: <1170427556.18082.145.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ZfYoWdiVtwIjFdd/P99Q"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-ZfYoWdiVtwIjFdd/P99Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch updates the pxa2xx I2S driver to the new API in ASoC 0.13.

Changes:-

o Added check in hw_params to detect buffer less pcms (i.e. BT <-->
codec).

o Updated structures to new API

o Removed DAI's and ac97 ops from PCM header.

o Integer hardware constraint added for periods.

Signed-off-by: Andrew Johnson <ajohnson@intrinsyc.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-ZfYoWdiVtwIjFdd/P99Q
Content-Disposition: attachment; filename=asoc13-pxa2xx-pcm.patch
Content-Type: text/x-patch; name=asoc13-pxa2xx-pcm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/pxa/pxa2xx-pcm.c
--- a/soc/pxa/pxa2xx-pcm.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/pxa2xx-pcm.c	Thu Feb 01 17:50:32 2007 +0000
@@ -76,12 +76,17 @@ static int pxa2xx_pcm_hw_params(struct s
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pxa2xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct pxa2xx_pcm_dma_params *dma = rtd->cpu_dai->dma_data;
+	struct pxa2xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
 	size_t totsize = params_buffer_bytes(params);
 	size_t period = params_period_bytes(params);
 	pxa_dma_desc *dma_desc;
 	dma_addr_t dma_buff_phys, next_desc_phys;
 	int ret;
+
+	/* return if this is a bufferless transfer e.g.
+	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	 if (!dma)
+	 	return 0;
 
 	/* this may get called several times by oss emulation
 	 * with different params */
@@ -227,6 +232,10 @@ static int pxa2xx_pcm_open(struct snd_pc
 	if (ret)
 		goto out;
 
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto out;
+
 	prtd = kzalloc(sizeof(struct pxa2xx_runtime_data), GFP_KERNEL);
 	if (prtd == NULL) {
 		ret = -ENOMEM;
diff -r fc216dd0eb92 soc/pxa/pxa2xx-pcm.h
--- a/soc/pxa/pxa2xx-pcm.h	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/pxa2xx-pcm.h	Thu Feb 01 17:50:05 2007 +0000
@@ -28,21 +28,7 @@ struct pxa2xx_gpio {
 	u32 frm;
 };
 
-/* pxa2xx DAI ID's */
-#define PXA2XX_DAI_AC97_HIFI	0
-#define PXA2XX_DAI_AC97_AUX		1
-#define PXA2XX_DAI_AC97_MIC		2
-#define PXA2XX_DAI_I2S			0
-#define PXA2XX_DAI_SSP1			0
-#define PXA2XX_DAI_SSP2			1
-#define PXA2XX_DAI_SSP3			2
-
-extern struct snd_soc_cpu_dai pxa_ac97_dai[3];
-extern struct snd_soc_cpu_dai pxa_i2s_dai;
-extern struct snd_soc_cpu_dai pxa_ssp_dai[3];
-
 /* platform data */
 extern struct snd_soc_platform pxa2xx_soc_platform;
-extern struct snd_ac97_bus_ops pxa2xx_ac97_ops;
 
 #endif

--=-ZfYoWdiVtwIjFdd/P99Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-ZfYoWdiVtwIjFdd/P99Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-ZfYoWdiVtwIjFdd/P99Q--
