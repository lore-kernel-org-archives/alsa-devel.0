From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: spear_pcm: Update to new pcm_new()
	API
Date: Mon, 18 Mar 2013 18:57:23 +0100
Message-ID: <1363629444-22082-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CAA82625C4
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 18:55:33 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 552d1ef6 ("ASoC: core - Optimise and refactor pcm_new() to pass only
rtd") updated the pcm_new() callback to take the rtd as the only parameter. The
spear PCM driver (which was merged much later) still uses the old API. This
patch updates the driver to the new API.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---

Btw. where are the Kconfig and Makefile files for spear?
---
 sound/soc/spear/spear_pcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 9b76cc5..5e7aebe 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -149,9 +149,9 @@ static void spear_pcm_free(struct snd_pcm *pcm)
 
 static u64 spear_pcm_dmamask = DMA_BIT_MASK(32);
 
-static int spear_pcm_new(struct snd_card *card,
-		struct snd_soc_dai *dai, struct snd_pcm *pcm)
+static int spear_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_card *card = rtd->card->snd_card;
 	int ret;
 
 	if (!card->dev->dma_mask)
@@ -159,16 +159,16 @@ static int spear_pcm_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->driver->playback.channels_min) {
-		ret = spear_pcm_preallocate_dma_buffer(pcm,
+	if (rtd->cpu_dai->driver->playback.channels_min) {
+		ret = spear_pcm_preallocate_dma_buffer(rtd->pcm,
 				SNDRV_PCM_STREAM_PLAYBACK,
 				spear_pcm_hardware.buffer_bytes_max);
 		if (ret)
 			return ret;
 	}
 
-	if (dai->driver->capture.channels_min) {
-		ret = spear_pcm_preallocate_dma_buffer(pcm,
+	if (rtd->cpu_dai->driver->capture.channels_min) {
+		ret = spear_pcm_preallocate_dma_buffer(rtd->pcm,
 				SNDRV_PCM_STREAM_CAPTURE,
 				spear_pcm_hardware.buffer_bytes_max);
 		if (ret)
-- 
1.8.0
