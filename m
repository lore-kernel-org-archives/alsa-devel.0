From: Misael Lopez Cruz <misael.lopez@ti.com>
Subject: [PATCH] ALSA: pcm_dmaengine: Run complete cb only if
	runtime check passes
Date: Wed, 15 Jul 2015 12:23:14 -0500
Message-ID: <1436980994-29340-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C04265D92
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 19:23:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DMA complete callback uses substream's runtime data, so make
sure the runtime check passes before going forward.

The callback could run while the stream is closing or after it's
already closed.  By then, the substream's runtime data might already
been freed and cause NULL pointer dereferences.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/core/pcm_dmaengine.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index fba365a..061a8f7 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -133,7 +133,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 static void dmaengine_pcm_dma_complete(void *arg)
 {
 	struct snd_pcm_substream *substream = arg;
-	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dmaengine_pcm_runtime_data *prtd;
+
+	if (PCM_RUNTIME_CHECK(substream))
+		return;
+
+	prtd = substream_to_prtd(substream);
 
 	prtd->pos += snd_pcm_lib_period_bytes(substream);
 	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
-- 
1.7.9.5
