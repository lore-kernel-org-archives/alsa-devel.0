From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: dmaengine: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()
Date: Fri,  2 Jan 2015 13:56:07 +0100
Message-ID: <1420203373-1844-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-235.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id ED4EA2604B7
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 13:56:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed when the PCM
itself is freed. There is no need to do this manually in the driver.
Similarly there is also no need to do it on the pcm_new() error path as the
PCM will be freed if a error is returned.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index b329b84..4864392 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -200,11 +200,6 @@ static int dmaengine_pcm_open(struct snd_pcm_substream *substream)
 	return snd_dmaengine_pcm_open(substream, chan);
 }
 
-static void dmaengine_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	struct snd_soc_pcm_runtime *rtd,
 	struct snd_pcm_substream *substream)
@@ -283,8 +278,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (!pcm->chan[i]) {
 			dev_err(rtd->platform->dev,
 				"Missing dma channel for stream: %d\n", i);
-			ret = -EINVAL;
-			goto err_free;
+			return -EINVAL;
 		}
 
 		ret = snd_pcm_lib_preallocate_pages(substream,
@@ -293,7 +287,7 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 				prealloc_buffer_size,
 				max_buffer_size);
 		if (ret)
-			goto err_free;
+			return ret;
 
 		/*
 		 * This will only return false if we know for sure that at least
@@ -307,10 +301,6 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	return 0;
-
-err_free:
-	dmaengine_pcm_free(rtd->pcm);
-	return ret;
 }
 
 static snd_pcm_uframes_t dmaengine_pcm_pointer(
@@ -341,7 +331,6 @@ static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
 	},
 	.ops		= &dmaengine_pcm_ops,
 	.pcm_new	= dmaengine_pcm_new,
-	.pcm_free	= dmaengine_pcm_free,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {
-- 
1.8.0
