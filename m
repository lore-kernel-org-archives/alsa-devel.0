From: linux@audioscience.com
Subject: [PATCH - asihpi 6/6] Return from timer func if XRUN.
 Avoids read/write of reset stream.
Date: Fri, 22 Aug 2008 17:26:33 +1200
Message-ID: <1219382793-21272-3-git-send-email-linux@audioscience.com>
References: <1219382793-21272-1-git-send-email-linux@audioscience.com>
	<1219382793-21272-2-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1219382793-21272-2-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 584310c..fa0718f 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -22,7 +22,7 @@
  *  for any purpose including commercial applications.
  */
 /* >0: print Hw params, timer vars. >1: print stream write/copy sizes  */
-#define REALLY_VERBOSE_LOGGING 0
+#define REALLY_VERBOSE_LOGGING 2
 
 #if REALLY_VERBOSE_LOGGING
 #define VPRINTK1 printk
@@ -483,9 +483,9 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (err)
 		return err;
 
-	VPRINTK1(KERN_INFO "Format %d chan, %d format, %dHz\n",
-				params_channels(params),
-				wFormat, params_rate(params));
+	VPRINTK1(KERN_INFO "Format %d, %d chans, %dHz\n",
+				wFormat,params_channels(params),
+				params_rate(params));
 
 	HPI_HandleError(HPI_FormatCreate(&dpcm->Format, params_channels(params),
 			     wFormat, params_rate(params), 0, 0));
@@ -506,7 +506,9 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 			params_buffer_bytes(params),  runtime->dma_addr);
 		if (err == 0) {
 			snd_printd(KERN_INFO
-					"StreamHostBufferAttach succeeded\n");
+					"StreamHostBufferAttach succeeded %u %u\n",
+						params_buffer_bytes(params),
+						runtime->dma_addr);
 		} else {
 			snd_printd(KERN_INFO
 					"StreamHostBufferAttach error %d\n",
@@ -530,16 +532,8 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	dpcm->bytes_per_sec = bytes_per_sec;
 	dpcm->pcm_size = params_buffer_bytes(params);
 	dpcm->pcm_count = params_period_bytes(params);
-	snd_printd(KERN_INFO "pcm_size x%x, pcm_count x%x\n",
-			dpcm->pcm_size, dpcm->pcm_count);
-
-#ifdef FORCE_TIMER_JIFFIES
-	if (dpcm->pcm_jiffie_per_period > FORCE_TIMER_JIFFIES) {
-		dpcm->pcm_jiffie_per_period = FORCE_TIMER_JIFFIES;
-		snd_printd(KERN_INFO "Forced timer jiffies to %d\n",
-				FORCE_TIMER_JIFFIES);
-	}
-#endif
+	snd_printd(KERN_INFO "pcm_size x%x, pcm_count x%x, Bps %d\n",
+			dpcm->pcm_size, dpcm->pcm_count, bytes_per_sec);
 
 	dpcm->pcm_irq_pos = 0;
 	dpcm->pcm_buf_pos = 0;
@@ -689,8 +683,6 @@ static void snd_card_asihpi_runtime_free(struct snd_pcm_runtime *runtime)
 	kfree(dpcm);
 }
 
-/***************************** PLAYBACK OPS ****************/
-
 /*algorithm outline
  Without linking degenerates to getting single stream pos etc
  Without mmap 2nd loop degenerates to snd_pcm_period_elapsed
@@ -766,6 +758,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 			snd_printd(KERN_WARNING  "OStream %d drained\n",
 					s->number);
 			snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
+			return;
 		}
 
 		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -819,9 +812,10 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							ds->pcm_count);
 					HPI_HandleError(
 						HPI_OutStreamWriteBuf(
-							phSubSys,
-							ds->hStream,
-							NULL, xfercount,
+							phSubSys, ds->hStream,
+							&s->runtime->
+								dma_area[0],
+							xfercount,
 							&ds->Format));
 				} else {
 					VPRINTK2("Read IS%d x%04x\n",
@@ -841,6 +835,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 		add_timer(&dpcm->timer);
 }
 
+/***************************** PLAYBACK OPS ****************/
 static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 					  unsigned int cmd, void *arg)
 {
@@ -848,8 +843,6 @@ static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
-
-
 static int snd_card_asihpi_playback_prepare(struct snd_pcm_substream *
 					    substream)
 {
@@ -2893,7 +2886,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->out_max_chans = 2;
 	}
 
-	printk(KERN_INFO "Supports mmap:%d grouping:%d mrx%d\n",
+	printk(KERN_INFO "Supports mmap:%d grouping:%d mrx:%d\n",
 			asihpi->support_mmap,
 			asihpi->support_grouping,
 			asihpi->support_mrx
-- 
1.5.4.3
