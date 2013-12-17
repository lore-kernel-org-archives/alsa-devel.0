From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: mmp-pcm: config pcm slave via generic
	dmaengine
Date: Tue, 17 Dec 2013 16:22:24 +0800
Message-ID: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id ADFDC260850
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 09:22:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: haojian.zhuang@gmail.com, zhangfei.gao@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

use snd_dmaengine_pcm_prepare_slave_config to set slave config,
and remove the max_burst_size = 4 hard code.

select SND_SOC_GENERIC_DMAENGINE_PCM for mmp-pcm.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/pxa/Kconfig   |    2 +-
 sound/soc/pxa/mmp-pcm.c |   18 +++---------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 4db74a0..6473052 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -11,7 +11,7 @@ config SND_PXA2XX_SOC
 config SND_MMP_SOC
 	bool "Soc Audio for Marvell MMP chips"
 	depends on ARCH_MMP
-	select SND_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
 	help
 	  Say Y if you want to add support for codecs attached to
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 7929e19..682ee52 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -67,27 +67,15 @@ static int mmp_pcm_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_dmaengine_dai_dma_data *dma_params;
 	struct dma_slave_config slave_config;
 	int ret;
 
-	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-	if (!dma_params)
-		return 0;
-
-	ret = snd_hwparams_to_dma_slave_config(substream, params, &slave_config);
+	ret =
+	    snd_dmaengine_pcm_prepare_slave_config(substream, params,
+						   &slave_config);
 	if (ret)
 		return ret;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		slave_config.dst_addr     = dma_params->addr;
-		slave_config.dst_maxburst = 4;
-	} else {
-		slave_config.src_addr	  = dma_params->addr;
-		slave_config.src_maxburst = 4;
-	}
-
 	ret = dmaengine_slave_config(chan, &slave_config);
 	if (ret)
 		return ret;
-- 
1.7.0.4
