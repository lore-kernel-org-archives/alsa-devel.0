From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Revert "ASoC: Add new parameter to
	s3c24xx_pcm_enqueue"
Date: Fri, 14 Nov 2008 14:58:45 +0000
Message-ID: <1226674726-11678-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081114145705.GA11635@rakim.wolfsonmicro.main>
	<1226674726-11678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226674726-11678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4C9E10381C
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 15:58:47 +0100 (CET)
In-Reply-To: <1226674726-11678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This reverts commit 8dc840f88d9c9f75f46d5dbe489242f8a114fab6.  Christian
Pellegrin <chripell@gmail.com> reported that on some systems the patch
caused DMA to fail which is much more serious than the original skipped
audio issue.  Further investigation by Dave shows that the behaviour
depends on the clock speed of the SoC - a better fix is neeeded.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-pcm.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 341198b..e13e614 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -78,8 +78,7 @@ struct s3c24xx_runtime_data {
  * place a dma buffer onto the queue for the dma system
  * to handle.
 */
-static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream,
-				int dma_max)
+static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
@@ -87,10 +86,7 @@ static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream,
 
 	DBG("Entered %s\n", __func__);
 
-	if (!dma_max)
-		dma_max = prtd->dma_limit;
-
-	while (prtd->dma_loaded < dma_max) {
+	while (prtd->dma_loaded < prtd->dma_limit) {
 		unsigned long len = prtd->dma_period;
 
 		DBG("dma_loaded: %d\n", prtd->dma_loaded);
@@ -136,7 +132,7 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 	spin_lock(&prtd->lock);
 	if (prtd->state & ST_RUNNING) {
 		prtd->dma_loaded--;
-		s3c24xx_pcm_enqueue(substream, 0);
+		s3c24xx_pcm_enqueue(substream);
 	}
 
 	spin_unlock(&prtd->lock);
@@ -253,7 +249,7 @@ static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 	prtd->dma_pos = prtd->dma_start;
 
 	/* enqueue dma buffers */
-	s3c24xx_pcm_enqueue(substream, 1);
+	s3c24xx_pcm_enqueue(substream);
 
 	return ret;
 }
-- 
1.5.6.5
