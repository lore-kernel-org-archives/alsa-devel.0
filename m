From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Thu, 19 Oct 2006 18:12:30 -0400
Message-ID: <1161295951.15860.255.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe> <s5hhcytp6sy.wl%tiwai@suse.de>
	<1159581790.7086.141.camel@mindpipe>
	<1159889722.20801.59.camel@mindpipe> <s5hodssl9t4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodssl9t4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-10-04 at 11:17 +0200, Takashi Iwai wrote:
> At Tue, 03 Oct 2006 11:35:22 -0400,
> Lee Revell wrote:
> > 
> > On Fri, 2006-09-29 at 22:03 -0400, Lee Revell wrote:
> > > pcm-indirect.h:
> > > 
> > >  90  */
> > >  91 static inline snd_pcm_uframes_t
> > >  92 snd_pcm_indirect_playback_pointer(snd_pcm_substream_t *substream,
> > >  93                                   snd_pcm_indirect_t *rec,
> > > unsigned int ptr)
> > >  94 {
> > > 
> > > [ ... ]
> > > 
> > > 103         if (substream->ops->ack)
> > > 104                 substream->ops->ack(substream);
> > > 
> > > But, this cannot work with our hardware, if the ack callback always
> > > transfers 0x2000 words from the hardware, because the pointer callback
> > > is invoked many times per period.
> > 
> > If the ack callback is called many times per period, but our hardware
> > only supports writing in chunks of 0x2000 words, how can we copy to the
> > hardware from the ack callback as you recommend without using an
> > intermediate buffer?
> 
> I thought you don't have to write 0x2000 words at once but in a loop?
> Look at dream_playback_copy().  It has bytes argument.  That specifies
> the size to copy.  Setting snd_pcm_indirect.hw_buffer_size = 0x4000
> should restrict the max size to be written to 0x2000 words.
> 

Is there any way to force the upper layers to only ever transfer 0x2000
words - no more, no less?  I think the hardware gets unhappy if they are
not all transferred quickly.

Anyway, I still can't make it work with the PCM indirect API.  The best
I've managed to produce is choppy sound that seems to underrun every
period.  Do you see what could be wrong with my code?

The first version I posted, using an intermediate buffer with copy
callback, is the only one that ever worked, though it only works with
aplay.

Here's my current implementation, which incorporates your suggestions:

/* transfer the given size of data to the hardware */
static void dream_playback_copy(snd_pcm_substream_t *substream,
                                snd_pcm_indirect_t *rec, size_t bytes)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
        snd_pcm_runtime_t *runtime = substream->runtime;
        struct snd_card_dream_pcm *dpcm = runtime->private_data;
        unsigned char *src = runtime->dma_area + rec->sw_data;

        unsigned short * pcm_word = (unsigned short *) src; 
        int words = bytes / 2; 
        int res; 

        if (! dpcm->running) {
                printk("dream_playback_copy: not running!\n");
                /* Send PCM_START */
                dream_pcm_start(dream, dpcm->channel);
                dpcm->running = 1; 
        }

        printk("in dream_playback_copy: 0x%x bytes\n", (int) bytes);
     
        if (dpcm->stopping)
                words--;

        res = dream_get_mpu_data_poll_status_byte(dream, 
                                                  &dream->midi2, 
                                                  MPU401_IT_MASK, 
                                                  MPU401_IT_VALUE, 100); 
        if (res < 0) {     
                printk("dream_playback_copy: polling status byte returned %i\n", res);
                return;
        }

        for (; words > 0; words--) {
                mpu_write16(dream, &dream->midi2, cpu_to_le16(*pcm_word++), 0); /* TBD: don't swap for 8 bits WAV */
                dpcm->playback_chunk_left--;
                if (! dpcm->playback_chunk_left) {
                        dpcm->playback_chunk_left = 0x2000;
                        dream_pcm_end_xfer(dpcm->dream, dpcm->channel);
                }
        }

        if (dpcm->stopping) {
                mdelay(100);
                dream_pcm_close(dream, dpcm->channel);
                dpcm->running = 0;
        }
}

static void dream_work_transfer(void *data)
{
        struct snd_card_dream *dream = data;
        snd_pcm_substream_t *substream = dream->playback_substream;
        if (!substream)
                return;

        snd_pcm_indirect_playback_transfer(substream, &dream->playback_rec, dream_playback_copy);
}

/* ack callback - just schedule work */
static int dream_playback_ack(snd_pcm_substream_t *substream)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

        schedule_work(&dream->playback_work);

        return 0;
}

/* trigger callback */
static int dream_playback_trigger(snd_pcm_substream_t *substream, int cmd)
{
        snd_pcm_runtime_t *runtime = substream->runtime;
        struct snd_card_dream_pcm *dpcm = runtime->private_data;

        switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
                dream_playback_ack(substream); /* fill the data */
                snd_card_dream_pcm_timer_start(substream);
                break;
        case SNDRV_PCM_TRIGGER_STOP:
                dpcm->stopping = 1;
                dream_playback_ack(substream); /* send final incomplete 1/2 bufffer and close */
                snd_card_dream_pcm_timer_stop(substream);
                //dream_playback_cancel(substream);
                break;
        default:
                return -EINVAL;
        }
        return 0;
}

static snd_pcm_uframes_t dream_playback_pointer(snd_pcm_substream_t *substream)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
        snd_pcm_uframes_t pointer;

        pointer = snd_pcm_indirect_playback_pointer(substream, &dream->playback_rec, dream->playback_hw_ptr);
        //printk("dream_playback_pointer: 0x%x\n", (unsigned int) pointer);
        return pointer;
}

static int snd_card_dream_pcm_prepare(snd_pcm_substream_t * substream)
{
        snd_pcm_runtime_t *runtime = substream->runtime;
        struct snd_card_dream_pcm *dpcm = runtime->private_data;

        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
        dpcm->frames_per_period = runtime->rate / HZ;
        dpcm->frac_per_period = runtime->rate % HZ;
        dpcm->playback_chunk_left = 0x2000;

        memset(&dream->playback_rec, 0, sizeof(snd_pcm_indirect_t));
        dream->playback_rec.hw_buffer_size = 0x4000; /* byte size */
        dream->playback_rec.sw_buffer_size = snd_pcm_lib_buffer_bytes(substream);
        dream->playback_hw_ptr = 0;
        dream->playback_hw_ptr_frac = 0;

        return 0;
}

static int snd_card_dream_playback_prepare(snd_pcm_substream_t * substream)
{
        snd_pcm_runtime_t *runtime = substream->runtime;
        struct snd_card_dream_pcm *dpcm = runtime->private_data;
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
        printk("dream_pcm_open: channel 0x%x eight_bit 0x%x stereo 0x%x rate 0x%x\n",
                dpcm->channel, dpcm->eight_bit, dpcm->stereo, dpcm->rate);

        dream_pcm_open(dream, dpcm->channel, dpcm->eight_bit, dpcm->stereo, dpcm->rate);
        // dbg(dream, "prepare: PCM playback\n");
        return snd_card_dream_pcm_prepare(substream);
}

static void snd_card_dream_pcm_timer_function(unsigned long data)
{
        struct snd_card_dream_pcm *dpcm = (struct snd_card_dream_pcm *)data;
        struct snd_card_dream *dream = snd_pcm_substream_chip(dpcm->substream);
        snd_pcm_runtime_t *runtime = dpcm->substream->runtime;
        unsigned int size;
        dream->playback_hw_ptr += dpcm->frames_per_period;
        dream->playback_hw_ptr_frac += dpcm->frac_per_period;
        if (dream->playback_hw_ptr_frac >= HZ) {
                dream->playback_hw_ptr++;
                dream->playback_hw_ptr_frac -= HZ;
        }
        dream->playback_hw_ptr %= runtime->buffer_size;

        if (dream->playback_hw_ptr < dream->playback_last_hw_ptr)
                size = runtime->buffer_size + dream->playback_hw_ptr - dream->playback_last_hw_ptr;
        else
                size = dream->playback_hw_ptr - dream->playback_last_hw_ptr;
        dream->playback_last_hw_ptr = dream->playback_hw_ptr;
        dream->playback_size += size;
        if (dream->playback_size >= runtime->period_size) {
                dream->playback_size %= runtime->period_size;
                snd_pcm_period_elapsed(dpcm->substream);
        }

        dpcm->timer.expires = 1 + jiffies;
        add_timer(&dpcm->timer);
}

static snd_pcm_ops_t dream_playback_ops = {
        .open = snd_card_dream_playback_open,
        .close = snd_card_dream_playback_close,
        .ioctl = snd_pcm_lib_ioctl,
        .hw_params = snd_card_dream_hw_params,
        .hw_free = snd_card_dream_hw_free,
        .prepare = snd_card_dream_playback_prepare,
        .pointer = dream_playback_pointer,
        .trigger = dream_playback_trigger,
        .ack = dream_playback_ack,
};



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
