From: GNUtoo <GNUtoo@no-log.org>
Subject: Re: [PATCH] Sound: MSM soc : imported alsa for the MSM
 from codeaurora
Date: Sun, 15 Nov 2009 21:06:40 +0100
Message-ID: <1258315600.3690.4.camel@gnutoo-desktop>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
	<20091113145050.GC30966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CDB71037F9
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 21:07:31 +0100 (CET)
In-Reply-To: <20091113145050.GC30966@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-11-13 at 14:50 +0000, Mark Brown wrote:
> On Sun, Nov 08, 2009 at 11:46:10PM +0100, Denis 'GNUtoo' Carikli wrote:
> 
> Please do try to rememeber to CC maintainers on patches...
> 
> I've read some, but not all of this since I really can't follow how the
> code is supposed to be constructed.  At the minute there doesn't feel
> like there's enough abstraction between the various parts of the code,
> with lots of things cropping up in unexpected places and making it
> harder to follow.
> 
> It would probably be useful to refactor things so that you've got a
> support layer for the DSP that deals with any resource sharing issues
> and then build more standard-looking CODEC, DAI and DMA drivers (the DAI
> driver would probably be largely empty, I guess) with a machine driver
> gluing them together.
> 
> > it still has serious runtime problems such as:
> > *Can produce kernel oops under theses conditions:
> >  start alsamixer and if the second bar is on 0 or 4,
> >  so it can play music with aplay,then increase the routing alsamixer bar
> >  to the max.
> >  Then decrease the routing bar to 4 or less
> 
> What are "the second bar" and "routing bar"?  Remember, most of the
> people reading your mail will never have seen your system running.
> 
> > +config SND_MSM_DAI_SOC
> > +	tristate "SoC CPU/CODEC DAI for the MSM chip"
> > +	depends on SND_MSM_SOC || SND_QSD_SOC
> > +	help
> > +	 To add support for ALSA PCM driver for MSM board.
> 
> No need to make this one uer visible.
> 
> > +
> > +config SND_MSM_SOC_MSM7K
> > +        tristate "SoC Audio support for MSM7K"
> > +        depends on SND_MSM_SOC
> 
> Or this.  I know some architectures do this but we should probably just
> move them to visibly select only boards.
> 
> > +	codec->name = "MSM-CARD";
> 
> Probably something like "MSM7xxx internal CODEC" or similar.
> 
> > +static int __init msm_dai_init(void)
> > +{
> > +	return snd_soc_register_dais(msm_dais, ARRAY_SIZE(msm_dais));
> > +}
> > +
> > +static void __exit msm_dai_exit(void)
> > +{
> > +	snd_soc_unregister_dais(msm_dais, ARRAY_SIZE(msm_dais));
> > +}
> 
> Your DAIs ought to be registered as platform devices under arch/arm,
> probe as normal platform devices and then register the DAIs when these
> probe.
> 
> > +#define audio_send_queue_recbs(prtd, cmd, len) \
> > +	msm_adsp_write(prtd->audrec, QDSP_uPAudRecBitStreamQueue, cmd, len)
> > +#define audio_send_queue_rec(prtd, cmd, len) \
> > +	msm_adsp_write(prtd->audrec, QDSP_uPAudRecCmdQueue, cmd, len)
> 
> Inline functions, please.
> 
> > +int msm_audio_volume_update(unsigned id,
> > +				int volume, int pan)
> > +{
> > +	unsigned vol_raw;
> > +
> > +	vol_raw = compute_db_raw(volume);
> > +	printk(KERN_INFO "volume: %8x vol_raw: %8x \n", volume, vol_raw);
> > +	return audpp_set_volume_and_pan(id, vol_raw, pan);
> > +}
> > +EXPORT_SYMBOL(msm_audio_volume_update);
> 
> Hrm?
> 
> > +			unsigned id = msg[2];
> > +			unsigned idx = msg[3] - 1;
> > +			if (id != AUDPP_MSG_HOSTPCM_ID_ARM_RX) {
> > +				printk(KERN_ERR "bogus id\n");
> > +				break;
> 
> With stuff like this displaying what the bogus IDs are would be useful.
> 
> > +			/* Update with actual sent buffer size */
> > +			if (prtd->out[idx].used != BUF_INVALID_LEN)
> > +				prtd->pcm_irq_pos += prtd->out[idx].used;
> > +
> > +			if (prtd->pcm_irq_pos > prtd->pcm_size)
> > +				prtd->pcm_irq_pos = prtd->pcm_count;
> 
> This looks suspicious - it looks like what's going on is that you're
> getting a notification from the DSP that it has consumed a data buffer
> but this might go out of bounds and get clamped.
> 
> > +			if (prtd->ops->playback)
> > +				prtd->ops->playback(prtd);
> > +
> > +			spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
> > +			if (prtd->running) {
> > +				prtd->out[idx].used = 0;
> > +				frame = prtd->out + prtd->out_tail;
> > +				if (frame->used) {
> > +					audio_dsp_send_buffer(prtd,
> > +							      prtd->out_tail,
> > +							      frame->used);
> > +					prtd->out_tail ^= 1;
> 
> I've got a feeling that this code would be a lot easier to follow if
> you used a linked list of buffers.  You could statically allocate all the
> buffers still, but it'd make it much more explicit what was going on if
> you had a list of buffers queued for transmission to the DSP and a list
> of free buffers.
> 
> Given what it looks like this is doing I'd really expect
> snd_pcm_period_elapsed to be called directly from here - the playback
> and capture code paths appear to be completely separate and the
> indirections you're using appear not to be needed.  I'd also expect
> it to be called after you've finished updating the buffers rather than
> before, especially given that you appear to call it outside the lock on
> buffer updates.
> 
> > +				} else {
> > +					prtd->out_needed++;
> > +				}
> > +				wake_up(&the_locks.write_wait);
> 
> Why this?
> 
> > +	if (prtd->dir == SNDRV_PCM_STREAM_PLAYBACK) {
> > +		prtd->out_buffer_size = PLAYBACK_DMASZ;
> > +		prtd->out_sample_rate = 44100;
> > +		prtd->out_channel_mode = AUDPP_CMD_PCM_INTF_STEREO_V;
> > +		prtd->out_weight = 100;
> 
> You're not setting any 
> 
> > +int alsa_audio_configure(struct msm_audio *prtd)
> > +{
> > +	struct audmgr_config cfg;
> > +	int rc;
> > +
> > +	if (prtd->enabled)
> > +		return 0;
> > +
> > +	/* refuse to start if we're not ready with first buffer */
> > +	if (!prtd->out[0].used)
> > +		return -EIO;
> > +
> > +	cfg.tx_rate = 0;
> > +	cfg.rx_rate = RPC_AUD_DEF_SAMPLE_RATE_48000;
> 
> Your code appears to hard code both 44.1k and 48k inconsistently.
> 
> > +		audmgr_disable(&prtd->audmgr);
> > +		return -ENODEV;
> > +	}
> > +
> > +	prtd->enabled = 1;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(alsa_audio_configure);
> 
> This looks extremely suspect...
> 
> > +ssize_t alsa_send_buffer(struct msm_audio *prtd, const char __user *buf,
> > +			  size_t count, loff_t *pos)
> > +{
> > +	unsigned long flag;
> > +	const char __user *start = buf;
> > +	struct buffer *frame;
> > +	size_t xfer;
> > +	int rc = 0;
> > +
> > +	mutex_lock(&the_locks.write_lock);
> > +	while (count > 0) {
> > +		frame = prtd->out + prtd->out_head;
> > +		rc = wait_event_interruptible(the_locks.write_wait,
> > +					      (frame->used == 0)
> > +					      || (prtd->stopped));
> > +		if (rc < 0)
> > +			break;
> > +		if (prtd->stopped) {
> > +			rc = -EBUSY;
> > +			break;
> > +		}
> > +		xfer = count > frame->size ? frame->size : count;
> > +		if (copy_from_user(frame->data, buf, xfer)) {
> > +			rc = -EFAULT;
> > +			break;
> > +		}
> > +		frame->used = xfer;
> > +		prtd->out_head ^= 1;
> > +		count -= xfer;
> > +		buf += xfer;
> > +
> > +		spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
> > +		frame = prtd->out + prtd->out_tail;
> > +		if (frame->used && prtd->out_needed) {
> > +			audio_dsp_send_buffer(prtd, prtd->out_tail,
> > +					      frame->used);
> > +			prtd->out_tail ^= 1;
> 
> These ^s really don't help legibility.
> 
> > +			prtd->out_needed--;
> > +		}
> > +		spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
> > +	}
> > +	mutex_unlock(&the_locks.write_lock);
> > +	if (buf > start)
> > +		return buf - start;
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL(alsa_send_buffer);
> 
> ...as does this.  There should be no need to export all this stuff, and
> if you are exporting it it ought to be _GPL since all the ASoC APIs are
> _GPL.
> 
> I'd also really like to see some explanation of what the locking scheme
> is supposed to be - I can't quite follow what's supposed to be protected
> against what and when but I suspect there's cases where either read or
> write lock is taken and the_locks.lock is really needed.
> 
> > +EXPORT_SYMBOL(alsa_audio_disable);
> 
> > +#include <../arch/arm/mach-msm/qdsp5/adsp.h>
> > +#include <../arch/arm/mach-msm/qdsp5/audmgr.h>
> 
> Put these in an include directory.
> 
> > +#define FRAME_NUM               (8)
> > +#define FRAME_SIZE              (2052 * 2)
> > +#define MONO_DATA_SIZE          (2048)
> > +#define STEREO_DATA_SIZE        (MONO_DATA_SIZE * 2)
> > +#define CAPTURE_DMASZ           (FRAME_SIZE * FRAME_NUM)
> > +
> > +#define BUFSZ			(960 * 5)
> > +#define PLAYBACK_DMASZ 		(BUFSZ * 2)
> 
> All this stuff needs namespacing.
> 
> > +/* Support unconventional sample rates 12000, 24000 as well */
> > +#define USE_RATE                \
> > +			(SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
> 
> Your code doesn't appear to actually cope with all these rates.  Also,
> these ought to be pushed down into the drivers rather than exported in
> the header file - there's no need for other drivers to see them.
> 
> > +static int snd_msm_volume_put(struct snd_kcontrol *kcontrol,
> > +				struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	int change;
> > +	int volume;
> > +
> > +	volume = ucontrol->value.integer.value[0];
> > +	spin_lock_irq(&the_locks.mixer_lock);
> > +	change = (msm_vol_ctl.volume != volume);
> > +	if (change) {
> > +		msm_vol_ctl.update = 1;
> > +		msm_vol_ctl.volume = volume;
> > +	}
> > +	spin_unlock_irq(&the_locks.mixer_lock);
> 
> This doesn't actually appear to do anything to propagate the changes to
> the DSP?
> 
> > +static struct snd_kcontrol_new snd_msm_controls[] = {
> > +	MSM_EXT_TLV("PCM Playback Volume", 0, snd_msm_volume_info, \
> > +	snd_msm_volume_get, snd_msm_volume_put, 0, db_scale_linear),
> > +	MSM_EXT("device", 1, snd_msm_device_info, snd_msm_device_get, \
> > +						 snd_msm_device_put, 0),
> > +};
> 
> I have no idea what "device" is supposed to be.
> 
> > +static struct snd_soc_dai_link msm_dai = {
> > +	.name = "ASOC",
> > +	.stream_name = "ASOC",
> > +	.codec_dai = &msm_dais[0],
> > +	.cpu_dai = &msm_dais[1],
> > +	.init	= msm_soc_dai_init,
> > +};
> 
> Please pick some human readable names describing the setup (eg, "MSM7k
> internal CODEC").

Thanks a lot!!!
I'll try to fix most of the problems and resend a patch,I'll also
continue the debugging...which will take some time....

About the debugging:
*I noticed that if I change the .buffer_bytes_max to 4800 aplay doesn't
work anymore...I'll try to find the good values...
*I also noticed that aplay doesn't use the SNDRV_PCM_IOCTL_STATUS which
would explain why aplay works and not mplayer... so I'll try to fix that
too...

Denis.
