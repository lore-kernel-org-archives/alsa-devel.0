From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/7] ASoC: pxa: clean up function names in
	pxa2xx-lib
Date: Wed, 27 Jun 2018 21:33:54 +0200
Message-ID: <20180627193359.26631-3-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A0132679AB
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:11 +0200 (CEST)
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

Clean up the namespace a bit and drop the __ prefix of all functions
exported by pxa2xx-lib. This improves the readability of the code.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 include/sound/pxa2xx-lib.h | 10 +++++-----
 sound/arm/pxa2xx-ac97.c    | 10 +++++-----
 sound/arm/pxa2xx-pcm-lib.c | 22 +++++++++++-----------
 sound/soc/pxa/pxa2xx-pcm.c | 21 +++++++--------------
 4 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/include/sound/pxa2xx-lib.h b/include/sound/pxa2xx-lib.h
index 63f75450d3db..b43de38de8b2 100644
--- a/include/sound/pxa2xx-lib.h
+++ b/include/sound/pxa2xx-lib.h
@@ -10,14 +10,14 @@ struct snd_pcm_substream;
 struct snd_pcm_hw_params;
 struct snd_pcm;
 
-extern int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
+extern int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params);
-extern int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream);
 extern int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
 extern snd_pcm_uframes_t pxa2xx_pcm_pointer(struct snd_pcm_substream *substream);
-extern int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream);
-extern int __pxa2xx_pcm_open(struct snd_pcm_substream *substream);
-extern int __pxa2xx_pcm_close(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_open(struct snd_pcm_substream *substream);
+extern int pxa2xx_pcm_close(struct snd_pcm_substream *substream);
 extern int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma);
 extern int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream);
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 7d8d7b7199dc..0d624337857b 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -70,7 +70,7 @@ static int pxa2xx_ac97_pcm_open(struct snd_pcm_substream *substream)
 	pxa2xx_audio_ops_t *platform_ops;
 	int ret, i;
 
-	ret = __pxa2xx_pcm_open(substream);
+	ret = pxa2xx_pcm_open(substream);
 	if (ret)
 		return ret;
 
@@ -86,7 +86,7 @@ static int pxa2xx_ac97_pcm_open(struct snd_pcm_substream *substream)
 	if (platform_ops && platform_ops->startup) {
 		ret = platform_ops->startup(substream, platform_ops->priv);
 		if (ret < 0)
-			__pxa2xx_pcm_close(substream);
+			pxa2xx_pcm_close(substream);
 	}
 
 	return ret;
@@ -110,7 +110,7 @@ static int pxa2xx_ac97_pcm_prepare(struct snd_pcm_substream *substream)
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
 	int ret;
 
-	ret = __pxa2xx_pcm_prepare(substream);
+	ret = pxa2xx_pcm_prepare(substream);
 	if (ret < 0)
 		return ret;
 
@@ -178,8 +178,8 @@ static const struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= pxa2xx_ac97_pcm_open,
 	.close		= pxa2xx_ac97_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= __pxa2xx_pcm_hw_params,
-	.hw_free	= __pxa2xx_pcm_hw_free,
+	.hw_params	= pxa2xx_pcm_hw_params,
+	.hw_free	= pxa2xx_pcm_hw_free,
 	.prepare	= pxa2xx_ac97_pcm_prepare,
 	.trigger	= pxa2xx_pcm_trigger,
 	.pointer	= pxa2xx_pcm_pointer,
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index b927fa5ddbc0..dc56dbebf441 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -33,8 +33,8 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
 {
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -62,14 +62,14 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-EXPORT_SYMBOL(__pxa2xx_pcm_hw_params);
+EXPORT_SYMBOL(pxa2xx_pcm_hw_params);
 
-int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
+int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	snd_pcm_set_runtime_buffer(substream, NULL);
 	return 0;
 }
-EXPORT_SYMBOL(__pxa2xx_pcm_hw_free);
+EXPORT_SYMBOL(pxa2xx_pcm_hw_free);
 
 int pxa2xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
@@ -84,13 +84,13 @@ pxa2xx_pcm_pointer(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL(pxa2xx_pcm_pointer);
 
-int __pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
+int pxa2xx_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	return 0;
 }
-EXPORT_SYMBOL(__pxa2xx_pcm_prepare);
+EXPORT_SYMBOL(pxa2xx_pcm_prepare);
 
-int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
+int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -127,13 +127,13 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 		substream, dma_request_slave_channel(rtd->cpu_dai->dev,
 						     dma_params->chan_name));
 }
-EXPORT_SYMBOL(__pxa2xx_pcm_open);
+EXPORT_SYMBOL(pxa2xx_pcm_open);
 
-int __pxa2xx_pcm_close(struct snd_pcm_substream *substream)
+int pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 {
 	return snd_dmaengine_pcm_close_release_chan(substream);
 }
-EXPORT_SYMBOL(__pxa2xx_pcm_close);
+EXPORT_SYMBOL(pxa2xx_pcm_close);
 
 int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 445e691126e5..da252d1f732e 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -20,8 +20,8 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_dmaengine_dai_dma_data *dma;
@@ -33,23 +33,16 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (!dma)
 		return 0;
 
-	return __pxa2xx_pcm_hw_params(substream, params);
-}
-
-static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	__pxa2xx_pcm_hw_free(substream);
-
-	return 0;
+	return pxa2xx_pcm_hw_params(substream, params);
 }
 
 static const struct snd_pcm_ops pxa2xx_pcm_ops = {
-	.open		= __pxa2xx_pcm_open,
-	.close		= __pxa2xx_pcm_close,
+	.open		= pxa2xx_pcm_open,
+	.close		= pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= pxa2xx_pcm_hw_params,
+	.hw_params	= __pxa2xx_pcm_hw_params,
 	.hw_free	= pxa2xx_pcm_hw_free,
-	.prepare	= __pxa2xx_pcm_prepare,
+	.prepare	= pxa2xx_pcm_prepare,
 	.trigger	= pxa2xx_pcm_trigger,
 	.pointer	= pxa2xx_pcm_pointer,
 	.mmap		= pxa2xx_pcm_mmap,
-- 
2.17.1
