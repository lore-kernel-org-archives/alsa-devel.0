From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC: dmaengine_pcm: Setup device_fc in
	snd_hwparams_to_dma_slave_config
Date: Wed,  3 Apr 2013 11:02:56 +0200
Message-ID: <1364979780-15364-2-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-217.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E60F265322
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:03:53 +0200 (CEST)
In-Reply-To: <1364979780-15364-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Usually device_fc should be set to false for audio DMAs. Initialize it in a
common place so drivers don't have to do this manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/atmel-pcm-dma.c | 2 --
 sound/soc/fsl/imx-pcm-dma.c     | 2 --
 sound/soc/soc-dmaengine-pcm.c   | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index b8570e3..bb07989 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -129,8 +129,6 @@ static int atmel_pcm_configure_dma(struct snd_pcm_substream *substream,
 		slave_config.src_maxburst = 1;
 	}
 
-	slave_config.device_fc = false;
-
 	dma_chan = snd_dmaengine_pcm_get_chan(substream);
 	if (dmaengine_slave_config(dma_chan, &slave_config)) {
 		pr_err("atmel-pcm: failed to configure dma channel\n");
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 6832c49..64af573 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -57,8 +57,6 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	slave_config.device_fc = false;
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		slave_config.dst_addr = dma_params->dma_addr;
 		slave_config.dst_maxburst = dma_params->burstsize;
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index e8b1215..7c24ded 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -89,6 +89,8 @@ int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
 		slave_config->src_addr_width = buswidth;
 	}
 
+	slave_config->device_fc = false;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
-- 
1.8.0
