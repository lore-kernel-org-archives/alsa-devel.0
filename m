From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Add new parameter to
	s3c24xx_pcm_enqueue
Date: Wed,  5 Nov 2008 18:53:31 +0000
Message-ID: <1225911211-22474-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081105185220.GA10816@rakim.wolfsonmicro.main>
	<1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225911211-22474-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225911211-22474-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5097524358
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 19:53:33 +0100 (CET)
In-Reply-To: <1225911211-22474-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: David Anders <dave123_aml@yahoo.com>

The S3C24xx dma does not allow more than one buffer to be enqueue prior to
the dma transfers starting. This patch adds an additional parameter to
s3c24xx_pcm_enqueue() to allow for passing an initial dma maximum load
value.

Signed-off-by: David Anders <danders at amltd.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-pcm.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index e13e614..341198b 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -78,7 +78,8 @@ struct s3c24xx_runtime_data {
  * place a dma buffer onto the queue for the dma system
  * to handle.
 */
-static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
+static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream,
+				int dma_max)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
@@ -86,7 +87,10 @@ static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
 
 	DBG("Entered %s\n", __func__);
 
-	while (prtd->dma_loaded < prtd->dma_limit) {
+	if (!dma_max)
+		dma_max = prtd->dma_limit;
+
+	while (prtd->dma_loaded < dma_max) {
 		unsigned long len = prtd->dma_period;
 
 		DBG("dma_loaded: %d\n", prtd->dma_loaded);
@@ -132,7 +136,7 @@ static void s3c24xx_audio_buffdone(struct s3c2410_dma_chan *channel,
 	spin_lock(&prtd->lock);
 	if (prtd->state & ST_RUNNING) {
 		prtd->dma_loaded--;
-		s3c24xx_pcm_enqueue(substream);
+		s3c24xx_pcm_enqueue(substream, 0);
 	}
 
 	spin_unlock(&prtd->lock);
@@ -249,7 +253,7 @@ static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 	prtd->dma_pos = prtd->dma_start;
 
 	/* enqueue dma buffers */
-	s3c24xx_pcm_enqueue(substream);
+	s3c24xx_pcm_enqueue(substream, 1);
 
 	return ret;
 }
-- 
1.5.6.5
