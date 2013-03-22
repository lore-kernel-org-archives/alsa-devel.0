From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/14] ASoC: mxs: Embed the mxs_dma_data struct
	in the mxs_pcm_dma_params struct
Date: Fri, 22 Mar 2013 14:12:13 +0100
Message-ID: <1363957934-20059-14-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A9F266566
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:18 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Currently the mxs_dma_data struct, which gets passed to the dmaengine driver, is
allocated in the pcm driver's open callback. The mxs_dma_data struct has exactly
one field which is initialized from the the same field in the mxs_pcm_dma_params
struct. The mxs_pcm_dma_params struct gets passed to the pcm driver from the dai
driver. Instead of taking this indirection embed the mxs_dma_data struct
directly in the mxs_pcm_dma_params struct. This allows us to simplify the pcm
driver quite a bit, since we don't have to care about memory managing the
mxs_dma_data struct anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-pcm.c  | 43 +++++--------------------------------------
 sound/soc/mxs/mxs-pcm.h  |  4 +++-
 sound/soc/mxs/mxs-saif.c |  6 +++---
 3 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 564b5b6..ebbef85 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -28,7 +28,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmaengine.h>
-#include <linux/fsl/mxs-dma.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -39,11 +38,6 @@
 
 #include "mxs-pcm.h"
 
-struct mxs_pcm_dma_data {
-	struct mxs_dma_data dma_data;
-	struct mxs_pcm_dma_params *dma_params;
-};
-
 static struct snd_pcm_hardware snd_mxs_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
@@ -66,8 +60,7 @@ static struct snd_pcm_hardware snd_mxs_hardware = {
 
 static bool filter(struct dma_chan *chan, void *param)
 {
-	struct mxs_pcm_dma_data *pcm_dma_data = param;
-	struct mxs_pcm_dma_params *dma_params = pcm_dma_data->dma_params;
+	struct mxs_pcm_dma_params *dma_params = param;
 
 	if (!mxs_dma_is_apbx(chan))
 		return false;
@@ -75,7 +68,7 @@ static bool filter(struct dma_chan *chan, void *param)
 	if (chan->chan_id != dma_params->chan_num)
 		return false;
 
-	chan->private = &pcm_dma_data->dma_data;
+	chan->private = &dma_params->dma_data;
 
 	return true;
 }
@@ -91,37 +84,11 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 static int snd_mxs_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mxs_pcm_dma_data *pcm_dma_data;
-	int ret;
-
-	pcm_dma_data = kzalloc(sizeof(*pcm_dma_data), GFP_KERNEL);
-	if (pcm_dma_data == NULL)
-		return -ENOMEM;
-
-	pcm_dma_data->dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	pcm_dma_data->dma_data.chan_irq = pcm_dma_data->dma_params->chan_irq;
-
-	ret = snd_dmaengine_pcm_open(substream, filter, pcm_dma_data);
-	if (ret) {
-		kfree(pcm_dma_data);
-		return ret;
-	}
 
 	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
 
-	snd_dmaengine_pcm_set_data(substream, pcm_dma_data);
-
-	return 0;
-}
-
-static int snd_mxs_close(struct snd_pcm_substream *substream)
-{
-	struct mxs_pcm_dma_data *pcm_dma_data = snd_dmaengine_pcm_get_data(substream);
-
-	snd_dmaengine_pcm_close(substream);
-	kfree(pcm_dma_data);
-
-	return 0;
+	return snd_dmaengine_pcm_open(substream, filter,
+		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
 static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
@@ -137,7 +104,7 @@ static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops mxs_pcm_ops = {
 	.open		= snd_mxs_open,
-	.close		= snd_mxs_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_mxs_pcm_hw_params,
 	.trigger	= snd_dmaengine_pcm_trigger,
diff --git a/sound/soc/mxs/mxs-pcm.h b/sound/soc/mxs/mxs-pcm.h
index 35ba2ca..3aa918f 100644
--- a/sound/soc/mxs/mxs-pcm.h
+++ b/sound/soc/mxs/mxs-pcm.h
@@ -19,8 +19,10 @@
 #ifndef _MXS_PCM_H
 #define _MXS_PCM_H
 
+#include <linux/fsl/mxs-dma.h>
+
 struct mxs_pcm_dma_params {
-	int chan_irq;
+	struct mxs_dma_data dma_data;
 	int chan_num;
 };
 
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 3a2aa1d..f13bd87 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -753,9 +753,9 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
-	if (saif->dma_param.chan_irq < 0) {
-		ret = saif->dma_param.chan_irq;
+	saif->dma_param.dma_data.chan_irq = platform_get_irq(pdev, 1);
+	if (saif->dma_param.dma_data.chan_irq < 0) {
+		ret = saif->dma_param.dma_data.chan_irq;
 		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
 			ret);
 		return ret;
-- 
1.8.0
