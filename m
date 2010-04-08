From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/3] imx-pcm-dma-mx2: restart DMA after an error
Date: Thu,  8 Apr 2010 11:31:25 +0200
Message-ID: <1270719086-23453-3-git-send-email-s.hauer@pengutronix.de>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 215AE10382F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 11:31:29 +0200 (CEST)
In-Reply-To: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 86668ab..aa88869 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -71,7 +71,12 @@ static void imx_ssi_dma_callback(int channel, void *data)
 
 static void snd_imx_dma_err_callback(int channel, void *data, int err)
 {
-	pr_err("DMA error callback called\n");
+	struct snd_pcm_substream *substream = data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct imx_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
+	int ret;
 
 	pr_err("DMA timeout on channel %d -%s%s%s%s\n",
 		 channel,
@@ -79,6 +84,14 @@ static void snd_imx_dma_err_callback(int channel, void *data, int err)
 		 err & IMX_DMA_ERR_REQUEST ?  " request" : "",
 		 err & IMX_DMA_ERR_TRANSFER ? " transfer" : "",
 		 err & IMX_DMA_ERR_BUFFER ?   " buffer" : "");
+
+	imx_dma_disable(iprtd->dma);
+	ret = imx_dma_setup_sg(iprtd->dma, iprtd->sg_list, iprtd->sg_count,
+			IMX_DMA_LENGTH_LOOP, dma_params->dma_addr,
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			DMA_MODE_WRITE : DMA_MODE_READ);
+	if (!ret)
+		imx_dma_enable(iprtd->dma);
 }
 
 static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
-- 
1.7.0
