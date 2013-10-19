From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dmaengine: Use filter_data rather than
	dma_data for compat requests
Date: Sat, 19 Oct 2013 21:38:26 +0100
Message-ID: <1382215106-31069-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BEBC6262625
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:38:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

When using the legacy filter function channel requests we currently pass
the audio specific struct snd_dmaengine_dai_dma_data which isn't likely to
be helpful for actual filtering. Since there's already a field in the
structure called filter_data clearly intended for use here convert the
driver to use that.

All existing users of plain filter functions have been converted to use
an explict compat function to override this behaviour except i.MX which
is working around this issue in its filter function and is updated to
just use filter_data directly here.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/imx-pcm-dma.c           | 4 +---
 sound/soc/soc-generic-dmaengine-pcm.c | 5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 4dc1296..aee2307 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -25,12 +25,10 @@
 
 static bool filter(struct dma_chan *chan, void *param)
 {
-	struct snd_dmaengine_dai_dma_data *dma_data = param;
-
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
-	chan->private = dma_data->filter_data;
+	chan->private = param;
 
 	return true;
 }
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index e29ec3c..17dd379 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -126,6 +126,9 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
 		return pcm->chan[0];
@@ -134,7 +137,7 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 		return pcm->config->compat_request_channel(rtd, substream);
 
 	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
+						 dma_data->filter_data);
 }
 
 static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
-- 
1.8.4.rc3
