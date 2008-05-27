From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Tue, 27 May 2008 17:47:19 +0400
Message-ID: <483C10E7.7070203@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>
	<s5hprrduwdk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020004060904030506090200"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.mtu.ru (smtp05.mtu.ru [62.5.255.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 53E7A243DA
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 15:47:26 +0200 (CEST)
In-Reply-To: <s5hprrduwdk.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------020004060904030506090200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

Takashi Iwai wrote:
> No, close callback is always after the hw_free callback.
> So, in hw_free callback, you just need to assure that hrtimer callback
> is finished (and/or cancel it).  After that, you are free to work
> without considering hrtimer stuff.
Here is my first attempt on that.
The optimization you mention above
is possible, but I haven't done it
(yet). Because I think it will obscure
things.
I can't really say if this code is
better than before - it looks cleaner
but adds 3 locks.

> We don't drop pcm substream lock here because we don't need to acquire
> it.
Why not? Because it is not recommended
to use any more, or for some other
reason? I mostly need the hrtimer
callback to be protected from all
the pcm callbacks, modulo the (IMO
questionable) optimization. So why
not would I just use the substream
lock?

--------------020004060904030506090200
Content-Type: text/x-patch;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.diff"

diff -r 63405ae5a92b drivers/pcsp/pcsp.c
--- a/drivers/pcsp/pcsp.c	Tue May 27 15:37:48 2008 +0400
+++ b/drivers/pcsp/pcsp.c	Tue May 27 17:24:31 2008 +0400
@@ -73,6 +73,9 @@
 	pcsp_chip.pcspkr = 1;
 
 	spin_lock_init(&pcsp_chip.substream_lock);
+	spin_lock_init(&pcsp_chip.dmabuf_lock);
+	spin_lock_init(&pcsp_chip.ptr_lock);
+	spin_lock_init(&pcsp_chip.timer_lock);
 
 	pcsp_chip.card = card;
 	pcsp_chip.port = 0x61;
diff -r 63405ae5a92b drivers/pcsp/pcsp.h
--- a/drivers/pcsp/pcsp.h	Tue May 27 15:37:48 2008 +0400
+++ b/drivers/pcsp/pcsp.h	Tue May 27 17:24:31 2008 +0400
@@ -61,6 +61,9 @@
 	struct hrtimer timer;
 	unsigned short port, irq, dma;
 	spinlock_t substream_lock;
+	spinlock_t dmabuf_lock;
+	spinlock_t ptr_lock;
+	spinlock_t timer_lock;
 	struct snd_pcm_substream *playback_substream;
 	size_t playback_ptr;
 	size_t period_ptr;
diff -r 63405ae5a92b drivers/pcsp/pcsp_lib.c
--- a/drivers/pcsp/pcsp_lib.c	Tue May 27 15:37:48 2008 +0400
+++ b/drivers/pcsp/pcsp_lib.c	Tue May 27 17:24:31 2008 +0400
@@ -40,34 +40,23 @@
 	}
 
 	spin_lock_irq(&chip->substream_lock);
-	/* Takashi Iwai says regarding this extra lock:
-
-	If the irq handler handles some data on the DMA buffer, it should
-	do snd_pcm_stream_lock().
-	That protects basically against all races among PCM callbacks, yes.
-	However, there are two remaining issues:
-	1. The substream pointer you try to lock isn't protected _before_
-	  this lock yet.
-	2. snd_pcm_period_elapsed() itself acquires the lock.
-	The requirement of another lock is because of 1.  When you get
-	chip->playback_substream, it's not protected.
-	Keeping this lock while snd_pcm_period_elapsed() assures the substream
-	is still protected (at least, not released).  And the other status is
-	handled properly inside snd_pcm_stream_lock() in
-	snd_pcm_period_elapsed().
-
-	*/
 	if (!chip->playback_substream)
 		goto exit_nr_unlock1;
 	substream = chip->playback_substream;
-	snd_pcm_stream_lock(substream);
+
+	spin_lock(&chip->timer_lock);
 	if (!atomic_read(&chip->timer_active))
 		goto exit_nr_unlock2;
 
 	runtime = substream->runtime;
 	fmt_size = snd_pcm_format_physical_width(runtime->format) >> 3;
+	spin_lock(&chip->ptr_lock);
 	/* assume it is mono! */
+	spin_lock(&chip->dmabuf_lock);
+	if (!runtime->dma_area)
+		goto exit_nr_unlock4;
 	val = runtime->dma_area[chip->playback_ptr + fmt_size - 1];
+	spin_unlock(&chip->dmabuf_lock);
 	if (snd_pcm_format_signed(runtime->format))
 		val ^= 0x80;
 	timer_cnt = val * CUR_DIV() / 256;
@@ -101,13 +90,15 @@
 	/* wrap the pointer _before_ calling snd_pcm_period_elapsed(),
 	 * or ALSA will BUG on us. */
 	chip->playback_ptr %= buffer_bytes;
-
-	snd_pcm_stream_unlock(substream);
+	spin_unlock(&chip->ptr_lock);
+	spin_unlock(&chip->timer_lock);
 
 	if (periods_elapsed) {
 		snd_pcm_period_elapsed(substream);
+		spin_lock(&chip->ptr_lock);
 		chip->period_ptr += periods_elapsed * period_bytes;
 		chip->period_ptr %= buffer_bytes;
+		spin_unlock(&chip->ptr_lock);
 	}
 
 	spin_unlock_irq(&chip->substream_lock);
@@ -121,8 +112,11 @@
 	hrtimer_forward(&chip->timer, chip->timer.expires, ktime_set(0, ns));
 	return HRTIMER_RESTART;
 
+exit_nr_unlock4:
+	spin_unlock(&chip->dmabuf_lock);
+	spin_unlock(&chip->ptr_lock);
 exit_nr_unlock2:
-	snd_pcm_stream_unlock(substream);
+	spin_unlock(&chip->timer_lock);
 exit_nr_unlock1:
 	spin_unlock_irq(&chip->substream_lock);
 	return HRTIMER_NORESTART;
@@ -142,7 +136,9 @@
 	chip->val61 = inb(0x61) | 0x03;
 	outb_p(0x92, 0x43);	/* binary, mode 1, LSB only, ch 2 */
 	spin_unlock(&i8253_lock);
+	spin_lock(&chip->timer_lock);
 	atomic_set(&chip->timer_active, 1);
+	spin_unlock(&chip->timer_lock);
 	chip->thalf = 0;
 
 	hrtimer_start(&pcsp_chip.timer, ktime_set(0, 0), HRTIMER_MODE_REL);
@@ -156,7 +152,9 @@
 	if (!atomic_read(&chip->timer_active))
 		return;
 
+	spin_lock(&chip->timer_lock);
 	atomic_set(&chip->timer_active, 0);
+	spin_unlock(&chip->timer_lock);
 	spin_lock(&i8253_lock);
 	/* restore the timer */
 	outb_p(0xb6, 0x43);	/* binary, mode 3, LSB/MSB, ch 2 */
@@ -184,19 +182,25 @@
 				       struct snd_pcm_hw_params *hw_params)
 {
 	int err;
+	struct snd_pcsp *chip = snd_pcm_substream_chip(substream);
+	spin_lock_irq(&chip->dmabuf_lock);
 	err = snd_pcm_lib_malloc_pages(substream,
 				      params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-	return 0;
+	spin_unlock_irq(&chip->dmabuf_lock);
+	return err;
 }
 
 static int snd_pcsp_playback_hw_free(struct snd_pcm_substream *substream)
 {
+	int err;
+	struct snd_pcsp *chip = snd_pcm_substream_chip(substream);
 #if PCSP_DEBUG
 	printk(KERN_INFO "PCSP: hw_free called\n");
 #endif
-	return snd_pcm_lib_free_pages(substream);
+	spin_lock_irq(&chip->dmabuf_lock);
+	err = snd_pcm_lib_free_pages(substream);
+	spin_unlock_irq(&chip->dmabuf_lock);
+	return err;
 }
 
 static int snd_pcsp_playback_prepare(struct snd_pcm_substream *substream)
@@ -211,8 +215,10 @@
 			snd_pcm_lib_period_bytes(substream),
 			substream->runtime->periods);
 #endif
+	spin_lock_irq(&chip->ptr_lock);
 	chip->playback_ptr = 0;
 	chip->period_ptr = 0;
+	spin_unlock_irq(&chip->ptr_lock);
 	return 0;
 }
 

--------------020004060904030506090200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020004060904030506090200--
