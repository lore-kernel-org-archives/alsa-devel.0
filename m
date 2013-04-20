From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC: mxs: Use generic dmaengine PCM
Date: Sat, 20 Apr 2013 19:29:03 +0200
Message-ID: <1366478947-9377-4-git-send-email-lars@metafoo.de>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-081.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 58D2E265185
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 19:30:00 +0200 (CEST)
In-Reply-To: <1366478947-9377-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Use the generic dmaengine PCM driver instead of a custom implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	Set SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX to reflect that the DMA channel is
	shared between playback and capture
---
 sound/soc/mxs/Kconfig   |   2 +-
 sound/soc/mxs/mxs-pcm.c | 136 ++++--------------------------------------------
 2 files changed, 12 insertions(+), 126 deletions(-)

diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index b6fa776..78d321c 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -1,7 +1,7 @@
 menuconfig SND_MXS_SOC
 	tristate "SoC Audio for Freescale MXS CPUs"
 	depends on ARCH_MXS
-	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the MXS SAIF interface.
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 907cdb1..b41fffc 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -18,27 +18,18 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/dmaengine.h>
 
 #include <sound/core.h>
-#include <sound/initval.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
 #include "mxs-pcm.h"
 
-static struct snd_pcm_hardware snd_mxs_hardware = {
+static const struct snd_pcm_hardware snd_mxs_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_PAUSE |
@@ -56,7 +47,6 @@ static struct snd_pcm_hardware snd_mxs_hardware = {
 	.periods_max		= 52,
 	.buffer_bytes_max	= 64 * 1024,
 	.fifo_size		= 32,
-
 };
 
 static bool filter(struct dma_chan *chan, void *param)
@@ -74,129 +64,25 @@ static bool filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	return 0;
-}
-
-static int snd_mxs_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
-
-	return snd_dmaengine_pcm_open_request_chan(substream, filter,
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
-}
-
-static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
-		struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-					runtime->dma_area,
-					runtime->dma_addr,
-					runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops mxs_pcm_ops = {
-	.open		= snd_mxs_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= snd_mxs_pcm_hw_params,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-	.mmap		= snd_mxs_pcm_mmap,
-};
-
-static int mxs_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = snd_mxs_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-
-	return 0;
-}
-
-static u64 mxs_pcm_dmamask = DMA_BIT_MASK(32);
-static int mxs_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &mxs_pcm_dmamask;
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = mxs_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = mxs_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
-	}
-
-out:
-	return ret;
-}
-
-static void mxs_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static struct snd_soc_platform_driver mxs_soc_platform = {
-	.ops		= &mxs_pcm_ops,
-	.pcm_new	= mxs_pcm_new,
-	.pcm_free	= mxs_pcm_free,
+static const struct snd_dmaengine_pcm_config mxs_dmaengine_pcm_config = {
+	.pcm_hardware = &snd_mxs_hardware,
+	.compat_filter_fn = filter,
+	.prealloc_buffer_size = 64 * 1024,
 };
 
 int mxs_pcm_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(dev, &mxs_soc_platform);
+	return snd_dmaengine_pcm_register(dev, &mxs_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+		SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT |
+		SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX);
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
 
 void mxs_pcm_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(dev);
+	snd_dmaengine_pcm_unregister(dev);
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_unregister);
 
-- 
1.8.0
