From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: imx: Open code dma channel request
Date: Sat, 19 Oct 2013 21:02:13 +0100
Message-ID: <1382212933-15641-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 17AB626260F
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:02:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Currently the imx DMA code is one of the few users relying on the fact
that the compat code uses the dma_data as the filter data for non-DT
channel requests. Since the rest of the core expects this to be a struct
snd_dmaengine_dai_data this isn't terribly helpful this will be changed to
use the already existing filter data so avoid breaking imx by open
coding the current behaviour.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/imx-pcm-dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 4dc1296..318f1fc 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -35,6 +35,17 @@ static bool filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
+static struct dma_chan *imx_compat_request_channel(
+	struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_substream *substream)
+{
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	return snd_dmaengine_pcm_request_channel(filter, dma_data);
+}
+
 static const struct snd_pcm_hardware imx_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -58,6 +69,7 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
 	.pcm_hardware = &imx_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.compat_filter_fn = filter,
+	.compat_request_channel = imx_compat_request_channel,
 	.prealloc_buffer_size = IMX_SSI_DMABUF_SIZE,
 };
 
-- 
1.8.4.rc3
