From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/7] ASoC: fold pxa2xx-pcm into its only user,
	pxa2xx-ac97
Date: Wed, 27 Jun 2018 21:33:53 +0200
Message-ID: <20180627193359.26631-2-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B4D92679A7
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:09 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the PXA SSP bits are ported over to generic DMA, the pxa2xx-pcm
code only has a single user left. This patch folds the remaining bits into
its only user and removes the unnecessary glue layer along with its header
file.

The include dependency to linux/dma/pxa-dma.h is also gone now.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/arm/Kconfig          |   5 --
 sound/arm/Makefile         |   3 -
 sound/arm/pxa2xx-ac97.c    | 114 +++++++++++++++++++++-----------
 sound/arm/pxa2xx-pcm-lib.c |   2 -
 sound/arm/pxa2xx-pcm.c     | 129 -------------------------------------
 sound/arm/pxa2xx-pcm.h     |  27 --------
 sound/soc/pxa/pxa-ssp.c    |   1 -
 sound/soc/pxa/pxa2xx-pcm.c |   2 -
 8 files changed, 76 insertions(+), 207 deletions(-)
 delete mode 100644 sound/arm/pxa2xx-pcm.c
 delete mode 100644 sound/arm/pxa2xx-pcm.h

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 65171f6657a2..5fbd47a9177e 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -17,14 +17,9 @@ config SND_ARMAACI
 	select SND_PCM
 	select SND_AC97_CODEC
 
-config SND_PXA2XX_PCM
-	tristate
-	select SND_PCM
-
 config SND_PXA2XX_AC97
 	tristate "AC97 driver for the Intel PXA2xx chip"
 	depends on ARCH_PXA
-	select SND_PXA2XX_PCM
 	select SND_AC97_CODEC
 	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index e10d5b169565..34c769489877 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -6,9 +6,6 @@
 obj-$(CONFIG_SND_ARMAACI)	+= snd-aaci.o
 snd-aaci-objs			:= aaci.o
 
-obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
-snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
-
 obj-$(CONFIG_SND_PXA2XX_LIB)	+= snd-pxa2xx-lib.o
 snd-pxa2xx-lib-y		:= pxa2xx-pcm-lib.o
 snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 236a63cdaf9f..7d8d7b7199dc 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
-#include <linux/dma/pxa-dma.h>
+#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -27,8 +27,6 @@
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-#include "pxa2xx-pcm.h"
-
 static void pxa2xx_ac97_legacy_reset(struct snd_ac97 *ac97)
 {
 	if (!pxa2xx_ac97_try_cold_reset())
@@ -63,51 +61,46 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_legacy_reset,
 };
 
-static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_out = {
-	.addr		= __PREG(PCDR),
-	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-	.chan_name	= "pcm_pcm_stereo_out",
-	.maxburst	= 32,
-};
-
-static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_in = {
-	.addr		= __PREG(PCDR),
-	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-	.chan_name	= "pcm_pcm_stereo_in",
-	.maxburst	= 32,
-};
-
 static struct snd_pcm *pxa2xx_ac97_pcm;
 static struct snd_ac97 *pxa2xx_ac97_ac97;
 
-static int pxa2xx_ac97_pcm_startup(struct snd_pcm_substream *substream)
+static int pxa2xx_ac97_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	pxa2xx_audio_ops_t *platform_ops;
-	int r;
+	int ret, i;
+
+	ret = __pxa2xx_pcm_open(substream);
+	if (ret)
+		return ret;
 
 	runtime->hw.channels_min = 2;
 	runtime->hw.channels_max = 2;
 
-	r = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-	    AC97_RATES_FRONT_DAC : AC97_RATES_ADC;
-	runtime->hw.rates = pxa2xx_ac97_ac97->rates[r];
+	i = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		AC97_RATES_FRONT_DAC : AC97_RATES_ADC;
+	runtime->hw.rates = pxa2xx_ac97_ac97->rates[i];
 	snd_pcm_limit_hw_rates(runtime);
 
-       	platform_ops = substream->pcm->card->dev->platform_data;
-	if (platform_ops && platform_ops->startup)
-		return platform_ops->startup(substream, platform_ops->priv);
-	else
-		return 0;
+	platform_ops = substream->pcm->card->dev->platform_data;
+	if (platform_ops && platform_ops->startup) {
+		ret = platform_ops->startup(substream, platform_ops->priv);
+		if (ret < 0)
+			__pxa2xx_pcm_close(substream);
+	}
+
+	return ret;
 }
 
-static void pxa2xx_ac97_pcm_shutdown(struct snd_pcm_substream *substream)
+static int pxa2xx_ac97_pcm_close(struct snd_pcm_substream *substream)
 {
 	pxa2xx_audio_ops_t *platform_ops;
 
-       	platform_ops = substream->pcm->card->dev->platform_data;
+	platform_ops = substream->pcm->card->dev->platform_data;
 	if (platform_ops && platform_ops->shutdown)
 		platform_ops->shutdown(substream, platform_ops->priv);
+
+	return 0;
 }
 
 static int pxa2xx_ac97_pcm_prepare(struct snd_pcm_substream *substream)
@@ -115,17 +108,15 @@ static int pxa2xx_ac97_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
+	int ret;
+
+	ret = __pxa2xx_pcm_prepare(substream);
+	if (ret < 0)
+		return ret;
+
 	return snd_ac97_set_rate(pxa2xx_ac97_ac97, reg, runtime->rate);
 }
 
-static struct pxa2xx_pcm_client pxa2xx_ac97_pcm_client = {
-	.playback_params	= &pxa2xx_ac97_pcm_out,
-	.capture_params		= &pxa2xx_ac97_pcm_in,
-	.startup		= pxa2xx_ac97_pcm_startup,
-	.shutdown		= pxa2xx_ac97_pcm_shutdown,
-	.prepare		= pxa2xx_ac97_pcm_prepare,
-};
-
 #ifdef CONFIG_PM_SLEEP
 
 static int pxa2xx_ac97_do_suspend(struct snd_card *card)
@@ -183,6 +174,53 @@ static int pxa2xx_ac97_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops, pxa2xx_ac97_suspend, pxa2xx_ac97_resume);
 #endif
 
+static const struct snd_pcm_ops pxa2xx_pcm_ops = {
+	.open		= pxa2xx_ac97_pcm_open,
+	.close		= pxa2xx_ac97_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= __pxa2xx_pcm_hw_params,
+	.hw_free	= __pxa2xx_pcm_hw_free,
+	.prepare	= pxa2xx_ac97_pcm_prepare,
+	.trigger	= pxa2xx_pcm_trigger,
+	.pointer	= pxa2xx_pcm_pointer,
+	.mmap		= pxa2xx_pcm_mmap,
+};
+
+
+static int pxa2xx_ac97_pcm_new(struct snd_card *card)
+{
+	struct snd_pcm *pcm;
+	int stream, ret;
+
+	ret = snd_pcm_new(card, "PXA2xx-PCM", 0, 1, 1, &pcm);
+	if (ret)
+		goto out;
+
+	pcm->private_free = pxa2xx_pcm_free_dma_buffers;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto out;
+
+	stream = SNDRV_PCM_STREAM_PLAYBACK;
+	snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+	ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
+	if (ret)
+		goto out;
+
+	stream = SNDRV_PCM_STREAM_CAPTURE;
+	snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
+	ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
+	if (ret)
+		goto out;
+
+	pxa2xx_ac97_pcm = pcm;
+	ret = 0;
+
+ out:
+	return ret;
+}
+
 static int pxa2xx_ac97_probe(struct platform_device *dev)
 {
 	struct snd_card *card;
@@ -204,7 +242,7 @@ static int pxa2xx_ac97_probe(struct platform_device *dev)
 
 	strlcpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
 
-	ret = pxa2xx_pcm_new(card, &pxa2xx_ac97_pcm_client, &pxa2xx_ac97_pcm);
+	ret = pxa2xx_ac97_pcm_new(card);
 	if (ret)
 		goto err;
 
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index dcbe7ecc1835..b927fa5ddbc0 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -16,8 +16,6 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include "pxa2xx-pcm.h"
-
 static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
deleted file mode 100644
index 1c6f4b436de3..000000000000
--- a/sound/arm/pxa2xx-pcm.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * linux/sound/arm/pxa2xx-pcm.c -- ALSA PCM interface for the Intel PXA2xx chip
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	(C) 2004 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/dma-mapping.h>
-#include <linux/dmaengine.h>
-
-#include <mach/dma.h>
-
-#include <sound/core.h>
-#include <sound/pxa2xx-lib.h>
-#include <sound/dmaengine_pcm.h>
-
-#include "pxa2xx-pcm.h"
-
-static int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_pcm_client *client = substream->private_data;
-
-	__pxa2xx_pcm_prepare(substream);
-
-	return client->prepare(substream);
-}
-
-static int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_pcm_client *client = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pxa2xx_runtime_data *rtd;
-	int ret;
-
-	ret = __pxa2xx_pcm_open(substream);
-	if (ret)
-		goto out;
-
-	rtd = runtime->private_data;
-
-	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		      client->playback_params : client->capture_params;
-
-	ret = client->startup(substream);
-	if (!ret)
-		goto err2;
-
-	return 0;
-
- err2:
-	__pxa2xx_pcm_close(substream);
- out:
-	return ret;
-}
-
-static int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct pxa2xx_pcm_client *client = substream->private_data;
-
-	client->shutdown(substream);
-
-	return __pxa2xx_pcm_close(substream);
-}
-
-static const struct snd_pcm_ops pxa2xx_pcm_ops = {
-	.open		= pxa2xx_pcm_open,
-	.close		= pxa2xx_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= __pxa2xx_pcm_hw_params,
-	.hw_free	= __pxa2xx_pcm_hw_free,
-	.prepare	= pxa2xx_pcm_prepare,
-	.trigger	= pxa2xx_pcm_trigger,
-	.pointer	= pxa2xx_pcm_pointer,
-	.mmap		= pxa2xx_pcm_mmap,
-};
-
-int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
-		   struct snd_pcm **rpcm)
-{
-	struct snd_pcm *pcm;
-	int play = client->playback_params ? 1 : 0;
-	int capt = client->capture_params ? 1 : 0;
-	int ret;
-
-	ret = snd_pcm_new(card, "PXA2xx-PCM", 0, play, capt, &pcm);
-	if (ret)
-		goto out;
-
-	pcm->private_data = client;
-	pcm->private_free = pxa2xx_pcm_free_dma_buffers;
-
-	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto out;
-
-	if (play) {
-		int stream = SNDRV_PCM_STREAM_PLAYBACK;
-		snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
-		if (ret)
-			goto out;
-	}
-	if (capt) {
-		int stream = SNDRV_PCM_STREAM_CAPTURE;
-		snd_pcm_set_ops(pcm, stream, &pxa2xx_pcm_ops);
-		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm, stream);
-		if (ret)
-			goto out;
-	}
-
-	if (rpcm)
-		*rpcm = pcm;
-	ret = 0;
-
- out:
-	return ret;
-}
-
-EXPORT_SYMBOL(pxa2xx_pcm_new);
-
-MODULE_AUTHOR("Nicolas Pitre");
-MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
-MODULE_LICENSE("GPL");
diff --git a/sound/arm/pxa2xx-pcm.h b/sound/arm/pxa2xx-pcm.h
deleted file mode 100644
index 8fa2b7c9e6b8..000000000000
--- a/sound/arm/pxa2xx-pcm.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * linux/sound/arm/pxa2xx-pcm.h -- ALSA PCM interface for the Intel PXA2xx chip
- *
- * Author:	Nicolas Pitre
- * Created:	Nov 30, 2004
- * Copyright:	MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-struct pxa2xx_runtime_data {
-	int dma_ch;
-	struct snd_dmaengine_dai_dma_data *params;
-};
-
-struct pxa2xx_pcm_client {
-	struct snd_dmaengine_dai_dma_data *playback_params;
-	struct snd_dmaengine_dai_dma_data *capture_params;
-	int (*startup)(struct snd_pcm_substream *);
-	void (*shutdown)(struct snd_pcm_substream *);
-	int (*prepare)(struct snd_pcm_substream *);
-};
-
-extern int pxa2xx_pcm_new(struct snd_card *, struct pxa2xx_pcm_client *, struct snd_pcm **);
-
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 0b441338bdd4..c1f4af869289 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -34,7 +34,6 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include "../../arm/pxa2xx-pcm.h"
 #include "pxa-ssp.h"
 
 /*
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 8b6a70e94c01..445e691126e5 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -20,8 +20,6 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include "../../arm/pxa2xx-pcm.h"
-
 static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-- 
2.17.1
