From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Breakage in pcm_lib.c
Date: Sat, 25 Apr 2009 21:48:55 -0400
Message-ID: <9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
References: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 03BBF2433E
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 03:48:56 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1418354qwk.56
	for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2009 18:48:56 -0700 (PDT)
In-Reply-To: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org

This appears to be a bug in this code...

	if (delta < 0) {
		delta += runtime->period_size * runtime->periods;

it was adding, buffer_size. But buffer_size is not correct when the
periods don't evenly fit into the buffer

		if (delta < 0) {
			hw_ptr_error(substream,
				     "Unexpected hw_pointer value "
				     "(stream=%i, pos=%ld, intr_ptr=%ld)\n",
				     substream->stream, (long)pos,
				     (long)hw_ptr_interrupt);
			/* rebase to interrupt position */
			hw_base = new_hw_ptr = hw_ptr_interrupt;
			/* align hw_base to buffer_size */
			hw_base -= hw_base % runtime->buffer_size;
			delta = 0;
		} else {
			hw_base += runtime->period_size * runtime->periods;

same here

			if (hw_base >= runtime->boundary)
				hw_base = 0;
			new_hw_ptr = hw_base + pos;
		}
	}

I have my hardware working again with this fix plus an estimator
function for how far the DMA hardware is into the buffer...

static snd_pcm_uframes_t
psc_dma_pcm_pointer(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_dma *psc_dma = rtd->dai->cpu_dai->private_data;
	struct psc_dma_stream *s;
	dma_addr_t count;
	snd_pcm_uframes_t frames;
	int delta;

	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
		s = &psc_dma->capture;
	else
		s = &psc_dma->playback;

	count = s->period_current_pt - s->period_start;

	delta = jiffies - s->jiffies; /* s->jiffies recorded at DMA
interrrupt at end of buffer */
	delta = delta * runtime->rate / HZ;

	frames = bytes_to_frames(substream->runtime, count);
	printk("psc_dma_pcm_pointer pos %ld %d\n", frames, delta);
	return frames + delta;
}


-- 
Jon Smirl
jonsmirl@gmail.com
