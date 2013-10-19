From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: ep93xx: Open code dma channel request
Date: Sat, 19 Oct 2013 14:13:04 +0100
Message-ID: <1382188384-18063-2-git-send-email-broonie@kernel.org>
References: <1382188384-18063-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 064B32608E9
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 15:13:11 +0200 (CEST)
In-Reply-To: <1382188384-18063-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Ryan Mallon <rmallon@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Currently the ep93xx DMA code is one of the few users relying on the fact
that the compat code uses the dma_data as the filter data for non-DT
channel requests. Since the rest of the core expects this to be a struct
snd_dmaengine_dai_data this isn't terribly helpful this will be changed to
use the already existing filter data so avoid breaking ep93xx by open
coding the current behaviour.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/cirrus/ep93xx-pcm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 0e9f56e..cfe517e 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -57,9 +57,22 @@ static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
 	return false;
 }
 
+static struct dma_chan *ep93xx_compat_request_channel(
+	struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_substream *substream)
+{
+	struct snd_dmaengine_dai_dma_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	return snd_dmaengine_pcm_request_channel(ep93xx_pcm_dma_filter,
+						 dma_data);
+}
+
 static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 	.pcm_hardware = &ep93xx_pcm_hardware,
 	.compat_filter_fn = ep93xx_pcm_dma_filter,
+	.compat_request_channel = ep93xx_compat_request_channel,
 	.prealloc_buffer_size = 131072,
 };
 
-- 
1.8.4.rc3
