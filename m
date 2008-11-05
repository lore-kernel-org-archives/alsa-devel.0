From: David Anders <dave123_aml@yahoo.com>
Subject: [PATCH] ASoC: Add new parameter to s3c24xx_pcm_enqueue
Date: Wed, 5 Nov 2008 07:39:47 -0800 (PST)
Message-ID: <744601.10057.qm@web54402.mail.yahoo.com>
Reply-To: dave123_aml@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web54402.mail.yahoo.com (web54402.mail.yahoo.com
	[206.190.49.132])
	by alsa0.perex.cz (Postfix) with SMTP id 956231037FD
	for <Alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 16:39:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The S3C24xx dma does not allow more than one buffer to be enqueue prior to
the dma transfers starting. This patch adds an additional parameter to
s3c24xx_pcm_enqueue() to allow for passing an initial dma maximum load
value.

Signed-off-by: David Anders <danders at amltd.com>

diff -urN linux-2.6.27-clean/sound/soc/s3c24xx/s3c24xx-pcm.c linux-2.6.27/sound/soc/s3c24xx/s3c24xx-pcm.c
--- linux-2.6.27-clean/sound/soc/s3c24xx/s3c24xx-pcm.c	2008-11-05 08:27:23.000000000 -0600
+++ linux-2.6.27/sound/soc/s3c24xx/s3c24xx-pcm.c	2008-11-05 09:14:27.000000000 -0600
@@ -78,7 +78,8 @@
  * place a dma buffer onto the queue for the dma system
  * to handle.
 */
-static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream)
+static void s3c24xx_pcm_enqueue(struct snd_pcm_substream *substream,
+				int dma_max)
 {
 	struct s3c24xx_runtime_data *prtd = substream->runtime->private_data;
 	dma_addr_t pos = prtd->dma_pos;
@@ -86,7 +87,10 @@
 
 	DBG("Entered %s\n", __func__);
 
-	while (prtd->dma_loaded < prtd->dma_limit) {
+	if (!dma_max)
+		dma_max = prtd->dma_limit;
+
+	while (prtd->dma_loaded < dma_max) {
 		unsigned long len = prtd->dma_period;
 
 		DBG("dma_loaded: %d\n", prtd->dma_loaded);
@@ -132,7 +136,7 @@
 	spin_lock(&prtd->lock);
 	if (prtd->state & ST_RUNNING) {
 		prtd->dma_loaded--;
-		s3c24xx_pcm_enqueue(substream);
+		s3c24xx_pcm_enqueue(substream, 0);
 	}
 
 	spin_unlock(&prtd->lock);
@@ -249,7 +253,7 @@
 	prtd->dma_pos = prtd->dma_start;
 
 	/* enqueue dma buffers */
-	s3c24xx_pcm_enqueue(substream);
+	s3c24xx_pcm_enqueue(substream, 1);
 
 	return ret;
 }
