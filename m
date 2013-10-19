From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dmaengine: Use filter_data rather than
	dma_data for compat requests
Date: Sat, 19 Oct 2013 14:35:39 +0100
Message-ID: <1382189739-22732-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ED25E260886
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 15:35:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

When using the legacy filter function channel requests we currently pass
the audio specific struct snd_dmaengine_dai_dma_data which isn't likely to
be helpful for actual filtering. Since there's already a field in the
structure called filter_data clearly intended for use here convert the
driver to use that.

All existing users of plain filter functions have been converted to use
an explict compat function to override this behaviour.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 99f9495..2eea2e0 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -168,6 +168,9 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
 		return pcm->chan[0];
@@ -176,7 +179,7 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 		return pcm->config->compat_request_channel(rtd, substream);
 
 	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
+						 dma_data->filter_data);
 }
 
 static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
-- 
1.8.4.rc3
