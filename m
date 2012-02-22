From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 3/7] ASoC: mxs-pcm: Request DMA channel early
Date: Wed, 22 Feb 2012 10:49:07 +0100
Message-ID: <1329904151-5927-4-git-send-email-lars@metafoo.de>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 84934103B39
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:44 +0100 (CET)
In-Reply-To: <1329904151-5927-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Request the DMA channel in the PCM open callback instead of the hwparams
callback, this allows us to let open fail if no dma channel is available. This
also fixes a bug where the channel will be requested multiple times if hwparams
is called multiple times.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-pcm.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index 06c18ec..5b8c8d3 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -85,8 +85,7 @@ static bool filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int mxs_dma_alloc(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
+static int mxs_dma_alloc(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -112,11 +111,7 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
 	unsigned long dma_addr;
 	struct dma_chan *chan;
-	int ret;
 
-	ret = mxs_dma_alloc(substream, params);
-	if (ret)
-		return ret;
 	chan = iprtd->dma_chan;
 
 	iprtd->periods = params_periods(params);
@@ -143,19 +138,6 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_mxs_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
-
-	if (iprtd->dma_chan) {
-		dma_release_channel(iprtd->dma_chan);
-		iprtd->dma_chan = NULL;
-	}
-
-	return 0;
-}
-
 static int snd_mxs_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -208,6 +190,12 @@ static int snd_mxs_open(struct snd_pcm_substream *substream)
 		return ret;
 	}
 
+	ret = mxs_dma_alloc(substream);
+	if (ret) {
+		kfree(iprtd);
+		return ret;
+	}
+
 	snd_soc_set_runtime_hwparams(substream, &snd_mxs_hardware);
 
 	return 0;
@@ -218,6 +206,7 @@ static int snd_mxs_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct mxs_pcm_runtime_data *iprtd = runtime->private_data;
 
+	dma_release_channel(iprtd->dma_chan);
 	kfree(iprtd);
 
 	return 0;
@@ -239,7 +228,6 @@ static struct snd_pcm_ops mxs_pcm_ops = {
 	.close		= snd_mxs_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_mxs_pcm_hw_params,
-	.hw_free	= snd_mxs_pcm_hw_free,
 	.trigger	= snd_mxs_pcm_trigger,
 	.pointer	= snd_mxs_pcm_pointer,
 	.mmap		= snd_mxs_pcm_mmap,
-- 
1.7.9
