From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Fri, 20 Oct 2006 16:12:48 -0400
Message-ID: <1161375168.15860.359.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe> <s5hhcytp6sy.wl%tiwai@suse.de>
	<1159581790.7086.141.camel@mindpipe>
	<1159889722.20801.59.camel@mindpipe>
	<s5hodssl9t4.wl%tiwai@suse.de> <1161295951.15860.255.camel@mindpipe>
	<s5hlknb2lk9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlknb2lk9.wl%tiwai@suse.de>
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

On Fri, 2006-10-20 at 14:55 +0200, Takashi Iwai wrote:
> > Anyway, I still can't make it work with the PCM indirect API.  The best
> > I've managed to produce is choppy sound that seems to underrun every
> > period.  Do you see what could be wrong with my code?
> 
> You should give a fixed period size (0x2000), i.e. set both
> period_bytes_min and period_bytes_max = 0x4000 (and periods_min = 2) in
> snd_pcm_hardware.  In this way, the ack is called at least at each
> time 0x2000 words are processed.
> 

I am doing this already.

> BTW, what does dream_get_mpu_data_poll_status_byte() do?
> Does it check whether you can another push 0x2000 words?
> 

Yes, exactly.

> If so, you should check this before claling
> snd_pcm_indirect_playback_transfer() in dream_work_transfer().
> 

OK, I've made this change.

> 
> Possibly, the block transfer patch might be not needed if you add this
> check.
> 

OK, I feel I am getting closer.  But it seems that only the first period
is played.  Upon further inspection it looks like
snd_pcm_indirect_playback_transfer only causes dream_playback_copy to be
invoked the first time:

~ # aplay /usr/share/sounds/test/phone.wav 
Playing WAVE '/usr/share/sounds/test/phone.wav': Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
hw_params: stereo yes, format 16bit, rate 44100
dream_pcm_open: channel 0x0 eight_bit 0x0 stereo 0x1 rate 0xac44
dream_playback_ack
dream_playback_copy: not running!
dream_pcm_start: channel is 0
dream_work_transfer: polling status byte returned 0
calling snd_pcm_indirect_playback_transfer
in dream_playback_copy: 0x4000 bytes DMA area 0xcdfb0000 sw_data 0x0
dream_playback_ack
dream_playback_ack
dream_work_transfer: polling status byte returned 0
calling snd_pcm_indirect_playback_transfer
dream_playback_ack
playback size is 0x1005
dream_playback_ack
playback size is 0x100a
dream_playback_ack
playback size is 0x100f
dream_playback_ack
playback size is 0x1015
dream_playback_ack
dream_playback_ack

(eventually underruns and errors are reported)

Here is the code:

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

        printk("in dream_playback_copy: 0x%x bytes DMA area 0x%p sw_data 0x%i\n", (int) bytes, runtime->dma_area, rec->sw_data);

        if (dpcm->stopping)
                words--;

        while (words--) {
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
        int res;
        snd_pcm_substream_t *substream = dream->playback_substream;
        snd_pcm_runtime_t *runtime = substream->runtime;
        struct snd_card_dream_pcm *dpcm = runtime->private_data;

        if (!substream || !runtime)
                return;

        if (! dpcm->running) {
                printk("dream_playback_copy: not running!\n");
                /* Send PCM_START */
                dream_pcm_start(dream, dpcm->channel);
                dpcm->running = 1;
        }

        res = dream_get_mpu_data_poll_status_byte(dream,
                                                  &dream->midi2,
                                                  MPU401_IT_MASK,
                                                  MPU401_IT_VALUE, 100);

        printk("dream_work_transfer: polling status byte returned %i\n", res);

        if (res < 0)
                return;

        printk("calling snd_pcm_indirect_playback_transfer\n", res);
        snd_pcm_indirect_playback_transfer(substream, &dream->playback_rec, dream_playback_copy);
}

/* ack callback - just schedule work */
static int dream_playback_ack(snd_pcm_substream_t *substream)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

        printk("dream_playback_ack\n");
        schedule_work(&dream->playback_work);

        return 0;
}

/* cancel work */
static void dream_playback_cancel(snd_pcm_substream_t *substream)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);

        cancel_delayed_work(&dream->playback_work);
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

#endif
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


static void snd_card_dream_pcm_timer_function(unsigned long data)
{
        struct snd_card_dream_pcm *dpcm = (struct snd_card_dream_pcm *)data;

        dpcm->timer.expires = 1 + jiffies;
        add_timer(&dpcm->timer);

#ifdef RLR_PCM_REPLAY
        if (!dpcm->substream) {
                printk("substream null in timer func\n");
                return;
        }
        struct snd_card_dream *dream = snd_pcm_substream_chip(dpcm->substream);
        snd_pcm_runtime_t *runtime = dpcm->substream->runtime;
        if (!runtime) {
                printk("runtime null in timer func\n");
                return;
        }
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
                printk("playback size is 0x%x\n", dream->playback_size);
                dream->playback_size %= runtime->period_size;
                snd_pcm_period_elapsed(dpcm->substream);
	}
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
