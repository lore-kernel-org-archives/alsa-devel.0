From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Click after draining
Date: Mon, 1 Nov 2004 20:29:49 +0100
Message-ID: <20041101202949.358eda16.pochini@shiny.it>
References: <20040921221318.4e0c7c7f.pochini@shiny.it>
	<20041007205801.6fb143ad.pochini@shiny.it>
	<s5hlleh5ilm.wl@alsa2.suse.de>
	<s5hhdp55h2e.wl@alsa2.suse.de>
	<20041016213113.1744f887.pochini@shiny.it>
	<s5h7jpojn0t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jpojn0t.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Oct 2004 13:14:58 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > With your patch snd_pcm_do_drain_init() does:
> >
> > 	if (! runtime->silence_size) {
> > 		/* fill silence until the priod end */
> > 		snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
> > 		snd_pcm_uframes_t delta = appl_ptr % runtime->period_size;
> > 		if (delta > 0)
> > 			snd_pcm_lib_fill_silence(substream,
> > 					appl_ptr % runtime->buffer_size,
> > 					runtime->period_size - delta);
> > 	}
> >
> > In my case delta is always 0. It seems ALSA aligns appl_ptr to the offset of
> > the next period without silencing the current one.
>
> If so, it has to be in alsa-lib.  Not a bug of ALSA driver.

No, the bug is in my analysis. I had some time to look at this issue again.
Your patch is ok. I was fooled by aplay that explicitly fills the last part
of each block before writing it in chunks that have always the same size and
my driver, which used unequally-sized periods, contributed to mess up the
numbers.

The patch below is mostly the one you wrote, with these changes: it handles
the case when the period to be silences crosses the buffer boundary and it
fills with silence the last played period while draining. It's not the right
thing of course but it work for me. Actually, it should fill only the first
x frames of the period following the last one, but I need another variable.


> > Also, I don't think filling with silence until the end of the period is
> > enough. ALSA stops the card some time it gets the interrupt, thus it should
> > silence also the subsequent period, or its beginning part.
>
> I thought of that, too, but concluded that it's a questionary behavior.

It's a minor problem because it only shows up during playback and if the
song has a quick fade out. In my case the card reads at least 32 frames
before it's stopped.




--- /home/Giu/soft/ad/alsa-kernel/core/pcm_lib.c	Fri Oct  8 22:01:08 2004
+++ alsa-kernel/core/pcm_lib.c	Mon Nov  1 19:46:09 2004
@@ -95,32 +95,10 @@
 	ofs = (runtime->silence_start + runtime->silence_filled) % runtime->buffer_size;
 	while (frames > 0) {
 		transfer = ofs + frames > runtime->buffer_size ? runtime->buffer_size - ofs : frames;
-		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
-		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
-			if (substream->ops->silence) {
-				int err;
-				err = substream->ops->silence(substream, -1, ofs, transfer);
-				snd_assert(err >= 0, );
-			} else {
-				char *hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
-				snd_pcm_format_set_silence(runtime->format, hwbuf, transfer * runtime->channels);
-			}
-		} else {
-			unsigned int c;
-			unsigned int channels = runtime->channels;
-			if (substream->ops->silence) {
-				for (c = 0; c < channels; ++c) {
-					int err;
-					err = substream->ops->silence(substream, c, ofs, transfer);
-					snd_assert(err >= 0, );
-				}
-			} else {
-				size_t dma_csize = runtime->dma_bytes / channels;
-				for (c = 0; c < channels; ++c) {
-					char *hwbuf = runtime->dma_area + (c * dma_csize) + samples_to_bytes(runtime, ofs);
-					snd_pcm_format_set_silence(runtime->format, hwbuf, transfer);
-				}
-			}
+
+		if (snd_pcm_lib_fill_silence(substream, ofs, transfer) < 0) {
+			snd_printk(KERN_ERR "fill_silence error\n");
+			break;
 		}
 		runtime->silence_filled += transfer;
 		frames -= transfer;
@@ -128,6 +106,60 @@
 	}
 }
 
+static int snd_pcm_lib_fill_silence1(snd_pcm_substream_t *substream, unsigned int ofs, snd_pcm_uframes_t frames)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int c, channels = runtime->channels;
+	char *hwbuf;
+	size_t dma_csize;
+
+	//snd_printk("snd_pcm_lib_fill_silence(ofs=%d, frames=%d)\n", ofs, (int)frames);
+	if (substream->ops->silence) {
+		int err = 0;
+		if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+		    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED)
+			err = substream->ops->silence(substream, -1, ofs, frames);
+		else {
+			for (c = 0; c < channels; c++) {
+				if ((err = substream->ops->silence(substream, c, ofs, frames)) < 0)
+					break;
+			}
+		}
+		return err;
+	}
+
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
+		hwbuf = runtime->dma_area + frames_to_bytes(runtime, ofs);
+		//snd_printk("snd_pcm_lib_fill_silence() set_sil()\n");
+		snd_pcm_format_set_silence(runtime->format, hwbuf, frames * channels);
+	} else {
+		dma_csize = runtime->dma_bytes / channels;
+		hwbuf = runtime->dma_area + samples_to_bytes(runtime, ofs);
+		for (c = 0; c < channels; c++) {
+			snd_pcm_format_set_silence(runtime->format, hwbuf, frames);
+			hwbuf += dma_csize;
+		}
+	}
+	return 0;
+}
+
+int snd_pcm_lib_fill_silence(snd_pcm_substream_t *substream, unsigned int ofs, snd_pcm_uframes_t frames)
+{
+	int err;
+
+	if (ofs + frames <= substream->runtime->buffer_size)
+		return snd_pcm_lib_fill_silence1(substream, ofs, frames);
+	else { /* Uncommon case: the part to be silenced goes beyond the end of the buffer */
+		err = snd_pcm_lib_fill_silence1(substream, ofs, substream->runtime->buffer_size - ofs);
+		if (err)
+			return err;
+		return snd_pcm_lib_fill_silence1(substream, 0, ofs + frames - substream->runtime->buffer_size);
+	}
+};
+
+
+
 static void xrun(snd_pcm_substream_t *substream)
 {
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
@@ -222,10 +254,18 @@
 		new_hw_ptr = runtime->hw_ptr_base + pos;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    runtime->silence_size > 0)
-		snd_pcm_playback_silence(substream, new_hw_ptr);
-
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (runtime->silence_size > 0)
+			snd_pcm_playback_silence(substream, new_hw_ptr);
+#if 1
+		if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+			snd_pcm_uframes_t start;
+			start = runtime->status->hw_ptr % runtime->buffer_size;
+			start -= start % runtime->period_size;
+			snd_pcm_lib_fill_silence(substream, start, runtime->period_size);
+		}
+	}
+#endif
 	runtime->status->hw_ptr = new_hw_ptr;
 	runtime->hw_ptr_interrupt = new_hw_ptr - new_hw_ptr % runtime->period_size;
 
@@ -2080,12 +2120,12 @@
 	}
 	return 0;
 }
- 
+
 typedef int (*transfer_f)(snd_pcm_substream_t *substream, unsigned int hwoff,
 			  unsigned long data, unsigned int off,
 			  snd_pcm_uframes_t size);
 
-static snd_pcm_sframes_t snd_pcm_lib_write1(snd_pcm_substream_t *substream, 
+static snd_pcm_sframes_t snd_pcm_lib_write1(snd_pcm_substream_t *substream,
 					    unsigned long data,
 					    snd_pcm_uframes_t size,
 					    int nonblock,
--- /home/Giu/soft/ad/alsa-kernel/core/pcm_native.c	Fri Oct  8 22:01:09 2004
+++ alsa-kernel/core/pcm_native.c	Mon Nov  1 19:44:15 2004
@@ -1296,7 +1296,16 @@
 			runtime->status->state = SNDRV_PCM_STATE_DRAINING;
 			break;
 		default:
-			break;
+			return 0; /* do nothing */
+		}
+		if (!runtime->silence_size) {
+			/* fill silence until the period end */
+			snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
+			snd_pcm_uframes_t delta = appl_ptr % runtime->period_size;
+			if (delta > 0)
+				snd_pcm_lib_fill_silence(substream,
+							 appl_ptr % runtime->buffer_size,
+							 runtime->period_size - delta);
 		}
 	} else {
 		/* stop running stream */



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
