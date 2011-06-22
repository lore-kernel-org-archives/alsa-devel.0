From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: pxa-ssp: Correct check for stream
	presence
Date: Wed, 22 Jun 2011 20:48:25 +0200
Message-ID: <1308768505-19878-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 6803A2487C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:48:32 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Don't rely on the codec's channels_min information to decide wheter or
not allocate a substream's DMA buffer. Rather check if the substream
itself was allocated previously.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index d73d6f6..da28394 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -97,14 +97,14 @@ static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->driver->playback.channels_min) {
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
 		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->driver->capture.channels_min) {
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
-- 
1.7.5.4
