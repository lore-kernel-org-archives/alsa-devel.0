From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 14/19] ASoC 0.13 pxa2xx AC97 driver
Date: Fri, 02 Feb 2007 14:45:46 +0000
Message-ID: <1170427546.18082.144.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-n7KhvfT3Hn6C4g0NWHIS"
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


--=-n7KhvfT3Hn6C4g0NWHIS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch updates the pxa2xx AC97 driver to the new API in ASoC 0.13.

Changes:-

o Removed DAI capabilities matching code in favour of manual matching in
the machine drivers.

o Added DAI operations for codec and CPU interfaces.

o Added pxa2xx-ac97.h header 

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-n7KhvfT3Hn6C4g0NWHIS
Content-Disposition: attachment; filename=asoc13-pxa2xx-ac97.patch
Content-Type: text/x-patch; name=asoc13-pxa2xx-ac97.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/pxa/pxa2xx-ac97.c
--- a/soc/pxa/pxa2xx-ac97.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/pxa/pxa2xx-ac97.c	Thu Feb 01 17:52:39 2007 +0000
@@ -31,26 +31,11 @@
 #include <asm/arch/audio.h>
 
 #include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
 
 static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
-
-#define AC97_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-#define AC97_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
-
-/* may need to expand this */
-static struct snd_soc_dai_mode pxa2xx_ac97_modes[] = {
-	{
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = AC97_RATES,
-		.pcmdir = AC97_DIR,
-	},
-};
 
 /*
  * Beware PXA27x bugs:
@@ -334,11 +319,12 @@ static int pxa2xx_ac97_hw_params(struct 
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_out;
-	else
-		rtd->cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_in;
+		cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_out;
+	else
+		cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_in;
 
 	return 0;
 }
@@ -347,11 +333,12 @@ static int pxa2xx_ac97_hw_aux_params(str
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
-	else
-		rtd->cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_in;
+		cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
+	else
+		cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_in;
 
 	return 0;
 }
@@ -360,14 +347,19 @@ static int pxa2xx_ac97_hw_mic_params(str
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 	else
-		rtd->cpu_dai->dma_data = &pxa2xx_ac97_pcm_mic_mono_in;
-
-	return 0;
-}
+		cpu_dai->dma_data = &pxa2xx_ac97_pcm_mic_mono_in;
+
+	return 0;
+}
+
+#define PXA2XX_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | \
+		SNDRV_PCM_RATE_48000)
 
 /*
  * There is only 1 physical AC97 interface for pxa2xx, but it
@@ -385,16 +377,17 @@ struct snd_soc_cpu_dai pxa_ac97_dai[] = 
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = PXA2XX_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
 		.stream_name = "AC97 Capture",
 		.channels_min = 2,
-		.channels_max = 2,},
+		.channels_max = 2,
+		.rates = PXA2XX_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.hw_params = pxa2xx_ac97_hw_params,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(pxa2xx_ac97_modes),
-		.mode = pxa2xx_ac97_modes,},
 },
 {
 	.name = "pxa2xx-ac97-aux",
@@ -403,16 +396,17 @@ struct snd_soc_cpu_dai pxa_ac97_dai[] = 
 	.playback = {
 		.stream_name = "AC97 Aux Playback",
 		.channels_min = 1,
-		.channels_max = 1,},
+		.channels_max = 1,
+		.rates = PXA2XX_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
 		.stream_name = "AC97 Aux Capture",
 		.channels_min = 1,
-		.channels_max = 1,},
+		.channels_max = 1,
+		.rates = PXA2XX_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.hw_params = pxa2xx_ac97_hw_aux_params,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(pxa2xx_ac97_modes),
-		.mode = pxa2xx_ac97_modes,},
 },
 {
 	.name = "pxa2xx-ac97-mic",
@@ -421,12 +415,12 @@ struct snd_soc_cpu_dai pxa_ac97_dai[] = 
 	.capture = {
 		.stream_name = "AC97 Mic Capture",
 		.channels_min = 1,
-		.channels_max = 1,},
+		.channels_max = 1,
+		.rates = PXA2XX_AC97_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = {
 		.hw_params = pxa2xx_ac97_hw_mic_params,},
-	.caps = {
-		.num_modes = ARRAY_SIZE(pxa2xx_ac97_modes),
-		.mode = pxa2xx_ac97_modes,},},
+},
 };
 
 EXPORT_SYMBOL_GPL(pxa_ac97_dai);
diff -r fc216dd0eb92 soc/pxa/pxa2xx-ac97.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/pxa/pxa2xx-ac97.h	Wed Jan 31 16:43:17 2007 +0000
@@ -0,0 +1,22 @@
+/*
+ * linux/sound/arm/pxa2xx-ac97.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PXA2XX_AC97_H
+#define _PXA2XX_AC97_H
+
+/* pxa2xx DAI ID's */
+#define PXA2XX_DAI_AC97_HIFI	0
+#define PXA2XX_DAI_AC97_AUX		1
+#define PXA2XX_DAI_AC97_MIC		2
+
+extern struct snd_soc_cpu_dai pxa_ac97_dai[3];
+
+/* platform data */
+extern struct snd_ac97_bus_ops pxa2xx_ac97_ops;
+
+#endif

--=-n7KhvfT3Hn6C4g0NWHIS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-n7KhvfT3Hn6C4g0NWHIS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-n7KhvfT3Hn6C4g0NWHIS--
