From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when
	using	certain samplerates and kernel HZ
Date: Thu, 21 Feb 2008 01:06:01 +0100
Message-ID: <20080221000601.GA4829@mathematik.uni-freiburg.de>
References: <20080219030144.GA12698@mathematik.uni-freiburg.de>
	<20080219125046.GA6455@mathematik.uni-freiburg.de>
	<s5hhcg3svd4.wl%tiwai@suse.de>
	<20080220141906.GA15096@mathematik.uni-freiburg.de>
	<s5h3arnpq4i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx02.qsc.de (mx02.qsc.de [213.148.130.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B44E24571
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 01:06:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3arnpq4i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

removed my old debugging macros.
renamed variables to make it more clear.

[snd-aloop - even more cleanups]
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-driver-hg-=
aloop-ainan-patch1.diff
[Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>]

i promised to improve and clean up snd-dummy too, so here it is:
reused the same method to improve timing, renamed the variables,
added snd_pcm_format_set_silence on prepare.

[snd-dummy - improved timing, silence on prepare]
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-kernel-hg-=
dummy-ainan-patch0.diff
[Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>]

patches are relative to current hg-tree.

ahmet

--
admin der abteilung f=C3=BCr angewandte mathematik, tel. 0761-203-5626

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-driver-hg-aloop-ainan-patch1.diff"

diff -r 04f0b432fb15 drivers/aloop-kernel.c
--- a/drivers/aloop-kernel.c	Wed Feb 20 17:10:53 2008 +0100
+++ b/drivers/aloop-kernel.c	Wed Feb 20 23:50:27 2008 +0100
@@ -29,9 +29,6 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
-/* comment in to trash your kernel logfiles */
-/* #define SND_CARD_LOOPBACK_VERBOSE */
-
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("A loopback soundcard");
 MODULE_LICENSE("GPL");
@@ -81,12 +78,12 @@ typedef struct snd_card_loopback_pcm {
 	snd_card_loopback_t *loopback;
 	spinlock_t lock;
 	struct timer_list timer;
-	unsigned int pcm_size;
-	unsigned int pcm_count;
+	unsigned int pcm_buffer_size;
+	unsigned int pcm_period_size;
 	unsigned int pcm_bps;		/* bytes per second */
 	unsigned int pcm_hz;		/* HZ */
 	unsigned int pcm_irq_pos;	/* IRQ position */
-	unsigned int pcm_period_pos;	/* period aligned pos in buffer */
+	unsigned int pcm_buf_pos;	/* position in buffer */
 	struct snd_pcm_substream *substream;
 	struct snd_card_loopback_cable *cable;
 } snd_card_loopback_pcm_t;
@@ -161,10 +158,10 @@ static int snd_card_loopback_prepare(str
 		return -EINVAL;
 	dpcm->pcm_bps = bps;
 	dpcm->pcm_hz = HZ;
-	dpcm->pcm_size = frames_to_bytes(runtime, runtime->buffer_size);
-	dpcm->pcm_count = frames_to_bytes(runtime, runtime->period_size);
+	dpcm->pcm_buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
+	dpcm->pcm_period_size = frames_to_bytes(runtime, runtime->period_size);
 	dpcm->pcm_irq_pos = 0;
-	dpcm->pcm_period_pos = 0;
+	dpcm->pcm_buf_pos = 0;
 
 	cable->hw.formats = (1ULL << runtime->format);
 	cable->hw.rate_min = runtime->rate;
@@ -189,19 +186,6 @@ static int snd_card_loopback_prepare(str
 		cable->capture_valid = 1;
 	}
 
-#ifdef SND_CARD_LOOPBACK_VERBOSE
-	printk(KERN_INFO "snd-aloop(c%dd%ds%d%c): frq=%d chs=%d fmt=%d buf=%d per=%d pers=%d\n",
-			substream->pcm->card->number,
-			substream->pcm->device,
-			substream->stream,
-			(SNDRV_PCM_STREAM_PLAYBACK == substream->stream ? 'p' : 'c'),
-			runtime->rate,
-			runtime->channels,
-			snd_pcm_format_width(runtime->format),
-			frames_to_bytes(runtime, runtime->buffer_size),
-			frames_to_bytes(runtime, runtime->period_size),
-			runtime->periods);
-#endif
 	return 0;
 }
 
@@ -214,10 +198,10 @@ static void snd_card_loopback_timer_func
 	spin_lock_irq(&dpcm->lock);
 
 	dpcm->pcm_irq_pos += dpcm->pcm_bps;
-	if (dpcm->pcm_irq_pos >= dpcm->pcm_count * dpcm->pcm_hz) {
-		dpcm->pcm_irq_pos %= dpcm->pcm_count * dpcm->pcm_hz;
-		dpcm->pcm_period_pos += dpcm->pcm_count;
-		dpcm->pcm_period_pos %= dpcm->pcm_size;
+	if (dpcm->pcm_irq_pos >= dpcm->pcm_period_size * dpcm->pcm_hz) {
+		dpcm->pcm_irq_pos %= dpcm->pcm_period_size * dpcm->pcm_hz;
+		dpcm->pcm_buf_pos += dpcm->pcm_period_size;
+		dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size;
 		spin_unlock_irq(&dpcm->lock);	
 		snd_pcm_period_elapsed(dpcm->substream);
 	} else {
@@ -229,7 +213,7 @@ static snd_pcm_uframes_t snd_card_loopba
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
-	return bytes_to_frames(runtime, dpcm->pcm_period_pos);
+	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
 }
 
 static struct snd_pcm_hardware snd_card_loopback_info =
@@ -263,9 +247,6 @@ static int snd_card_loopback_hw_params(s
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
 	struct snd_dma_buffer *dmab = NULL;
 	if (NULL == dpcm->cable->dma_buffer) {
-#ifdef SND_CARD_LOOPBACK_VERBOSE
-		printk(KERN_INFO "snd-aloop: allocating dma buffer\n");
-#endif
 		dmab = kzalloc(sizeof(*dmab), GFP_KERNEL);
 		if (NULL == dmab)
 			return -ENOMEM;
@@ -302,9 +283,6 @@ static int snd_card_loopback_hw_free(str
 	if (NULL == cable->dma_buffer)
 		return 0;
 
-#ifdef SND_CARD_LOOPBACK_VERBOSE
-	printk(KERN_INFO "snd-aloop: freeing dma buffer\n");
-#endif
 	snd_dma_free_pages(cable->dma_buffer);
 	kfree(cable->dma_buffer);
 	cable->dma_buffer = NULL;

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-kernel-hg-dummy-ainan-patch0.diff"

diff -r 97f6e4d58851 drivers/dummy.c
--- a/drivers/dummy.c	Wed Feb 20 17:13:44 2008 +0100
+++ b/drivers/dummy.c	Thu Feb 21 00:14:46 2008 +0100
@@ -181,10 +181,10 @@ struct snd_dummy_pcm {
 	struct snd_dummy *dummy;
 	spinlock_t lock;
 	struct timer_list timer;
-	unsigned int pcm_size;
-	unsigned int pcm_count;
+	unsigned int pcm_buffer_size;
+	unsigned int pcm_period_size;
 	unsigned int pcm_bps;		/* bytes per second */
-	unsigned int pcm_jiffie;	/* bytes per one jiffie */
+	unsigned int pcm_hz;		/* HZ */
 	unsigned int pcm_irq_pos;	/* IRQ position */
 	unsigned int pcm_buf_pos;	/* position in buffer */
 	struct snd_pcm_substream *substream;
@@ -238,11 +238,15 @@ static int snd_card_dummy_pcm_prepare(st
 	if (bps <= 0)
 		return -EINVAL;
 	dpcm->pcm_bps = bps;
-	dpcm->pcm_jiffie = bps / HZ;
-	dpcm->pcm_size = snd_pcm_lib_buffer_bytes(substream);
-	dpcm->pcm_count = snd_pcm_lib_period_bytes(substream);
+	dpcm->pcm_hz = HZ;
+	dpcm->pcm_buffer_size = snd_pcm_lib_buffer_bytes(substream);
+	dpcm->pcm_period_size = snd_pcm_lib_period_bytes(substream);
 	dpcm->pcm_irq_pos = 0;
 	dpcm->pcm_buf_pos = 0;
+
+	snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
+			bytes_to_samples(runtime, runtime->dma_bytes));
+
 	return 0;
 }
 
@@ -254,11 +258,11 @@ static void snd_card_dummy_pcm_timer_fun
 	spin_lock_irqsave(&dpcm->lock, flags);
 	dpcm->timer.expires = 1 + jiffies;
 	add_timer(&dpcm->timer);
-	dpcm->pcm_irq_pos += dpcm->pcm_jiffie;
-	dpcm->pcm_buf_pos += dpcm->pcm_jiffie;
-	dpcm->pcm_buf_pos %= dpcm->pcm_size;
-	if (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
-		dpcm->pcm_irq_pos %= dpcm->pcm_count;
+	dpcm->pcm_irq_pos += dpcm->pcm_bps;
+	if (dpcm->pcm_irq_pos >= dpcm->pcm_period_size * dpcm->pcm_hz) {
+		dpcm->pcm_irq_pos %= dpcm->pcm_period_size * dpcm->pcm_hz;
+		dpcm->pcm_buf_pos += dpcm->pcm_period_size;
+		dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size;
 		spin_unlock_irqrestore(&dpcm->lock, flags);
 		snd_pcm_period_elapsed(dpcm->substream);
 	} else

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--lrZ03NoBR/3+SXJZ--
