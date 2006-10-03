From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Tue, 03 Oct 2006 11:35:22 -0400
Message-ID: <1159889722.20801.59.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe>  <s5hhcytp6sy.wl%tiwai@suse.de>
	<1159581790.7086.141.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1159581790.7086.141.camel@mindpipe>
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

On Fri, 2006-09-29 at 22:03 -0400, Lee Revell wrote:
> pcm-indirect.h:
> 
>  90  */
>  91 static inline snd_pcm_uframes_t
>  92 snd_pcm_indirect_playback_pointer(snd_pcm_substream_t *substream,
>  93                                   snd_pcm_indirect_t *rec,
> unsigned int ptr)
>  94 {
> 
> [ ... ]
> 
> 103         if (substream->ops->ack)
> 104                 substream->ops->ack(substream);
> 
> But, this cannot work with our hardware, if the ack callback always
> transfers 0x2000 words from the hardware, because the pointer callback
> is invoked many times per period.

If the ack callback is called many times per period, but our hardware
only supports writing in chunks of 0x2000 words, how can we copy to the
hardware from the ack callback as you recommend without using an
intermediate buffer?

Is it OK to continue to use the scheme from the dummy driver for calling
snd_pcm_period_elapsed()?  I tried calling snd_pcm_period_elapsed() from
the ack callback or from the workqueue whenever the pointer crosses the
period boundary, but playback just hangs after the first period.

Here is the (still not working) PCM implementation based on your
pseudo-code:

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
     
        dream->playback_hw_ptr += bytes;
        dream->playback_hw_ptr %= snd_pcm_lib_buffer_bytes(substream);

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
        while (words--)
                mpu_write16(dream, &dream->midi2, cpu_to_le16(*pcm_word++), 0); /* TBD: don't swap for 8 bits WAV */

        dream_pcm_end_xfer(dpcm->dream, dpcm->channel);

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
                snd_card_dream_pcm_timer_stop(substream);
                dpcm->stopping = 1;
                dream_playback_ack(substream); /* send final incomplete 1/2 bufffer and close */
                //dream_playback_cancel(substream);
                break;
        default:
                return -EINVAL;
        }
        return 0;
}

/* pointer callback -
 * playback_hw_ptr is the current byte position in the ring buffer,
 * which is updated in the timer handler
 */
static snd_pcm_uframes_t dream_playback_pointer(snd_pcm_substream_t *substream)
{
        struct snd_card_dream *dream = snd_pcm_substream_chip(substream);
        snd_pcm_uframes_t pointer;

        pointer = snd_pcm_indirect_playback_pointer(substream, &dream->playback_rec, dream->playback_hw_ptr);
        printk("dream_playback_pointer: 0x%x\n", (unsigned int) pointer);
        return pointer;
}

#endif

Lee



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
