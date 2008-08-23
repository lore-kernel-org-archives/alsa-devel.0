From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz support to
	SPDIF	and	playback	format & rate constraints
Date: Sun, 24 Aug 2008 00:37:04 +1000
Message-ID: <1219502224.15980.32.camel@localhost>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lsMZJ4IxY7skpnVaSzUT"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id B2DD4246F2
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Aug 2008 16:37:09 +0200 (CEST)
In-Reply-To: <s5h63ptf48b.wl%tiwai@suse.de>
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


--=-lsMZJ4IxY7skpnVaSzUT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Takashi,

I have tried to address all of your concerns regarding formatting,
initialisers and printk/snd_printd/snd_printdd. I have a new patch
attached addressing these points.

However, you also raised three mutex issues, which I have not yet
addressed. I would like some more comments from you before I proceed.

hw_rule_playback_rate:
> +		for (chi = 0; chi < 4; ++chi) {
> > +			chp = &(chip->playback_channels[chi]);
> 
> I'm afraid it's racy.  The chip->playback_channels[] can be changed at
> any time.  Try to put a mutex to protect this check.

hw_rule_playback_format:
> +	for (chi = 0; chi < 4; ++chi) {
> > +		chp = &(chip->playback_channels[chi]);
> 
> This also needs a mutex as well.

snd_ca0106_pcm_prepare_playback:
> +	for (chi = 0; chi < 4; ++chi) {
> > +		chp = &(emu->playback_channels[chi]);
> 
> Use a mutex in this function, too.

It seems you want to guard against interference to the members of
snd_ca0106_channel (and also the associated snd_ca0106_pcm). So far I
have detected that the following routines make use of these data
structures:
hw_rule_playback_rate (new)
hw_rule_playback_format (new)
snd_ca0106_pcm_open_playback_channel
snd_ca0106_pcm_close_playback
snd_ca0106_pcm_prepare_playback
snd_ca0106_interrupt
snd_ca0106_pcm_hw_free_playback
I don't yet claim that this list is exhaustive.
I'm not sure yet how I should do the mutex. Here is what I'm thinking
about:
1) introduce a new spinlock_t pcm_lock within snd_ca0106 to cover access
to *all* the pcm data (snd_ca0106_channel *4 + snd_ca0106_pcm * 4)
2) introduce a new spinlock_t pcm_lock within snd_ca0106_channel to
cover access to the snd_ca0106_channel *1 + snd_ca0106_pcm *1

Option 2 makes it difficult to make sure that hw_rule_playback_rate and
hw_rule_playback_format will work correctly when a channel is opened or
closed while the hw_rule_* call is in progress, so that suggests option
1) might be better.

Introducing the pcm_lock means that all the abovenamed functions will
have to hold the lock while doing their work.

(I'm not familiar with mutexes vs spinlocks in the kernel - point me to
a documentation url if you want me to switch.)

But, it seems to me that a race condition remains after all this. The
client code can do the hw_rule check on a channel, but another program
can prepare another channel using (using parameters which will change
the hw_rule result) before the first client gets back to prepare and
open its channel. In fact, I should change
snd_ca0106_pcm_prepare_playback so that it repeats the hardware check
(within a mutex) and returns -EINVAL if it fails. Unless there is
another mutex around that whole system to prevent this mess from
happening...

I presume that I should leave the existing emu_lock alone and leave it
to protect the register twiddling code exclusively.

I'll work on the mutex stuff after receiving feedback on the above.

Thanks for being encouraging about my first non-trivial patch here :-)

Ben Stanley.


On Fri, 2008-08-22 at 17:40 +0200, Takashi Iwai wrote:
> At Sat, 23 Aug 2008 00:38:41 +1000,
> Ben Stanley wrote:
> > 
> > Dear list,
> > 
> > This patch provides the ability to play back digital audio via SPDIF at
> > a sampling rate of 44100Hz. It also implements rate constraints to
> > ensure that the hardware restrictions of the card are not violated. Note
> > that if 44100Hz is used, then all used channels must use that frequency.
> > For example, opening hw:0,0 at 48000 and then opening hw:0,1 at 44100
> > will fail due to constraints. However, you may successfully open both
> > hw:0,0 and hw:0,1 at 44100 (presume no other channels open). Further
> > details of the restriction may be found in the thread
> > http://thread.gmane.org/gmane.linux.alsa.devel/52149/focus=52345
> > 
> > This patch also implements playback format restrictions, such that only
> > one playback format may be in use at any time.
> > 
> > I tested driver playback using the attached script
> > (Test_ca0106_driver.sh). I get good audio output for all combinations of
> > sampling rates and formats except for 192kHz S16 (as noted at the end of
> > the script). Sometimes it works and sometimes it doesn't. The reason for
> > the failure is not apparent at this time. It could have something to do
> > with my receiver. I don't know.
> > 
> > The attached script also checks and validates that the rate and format
> > constraints operate as required.
> > 
> > I periodically have trouble with this driver not producing sound output.
> > This has been investigated and the cause is explained here
> > http://thread.gmane.org/gmane.linux.alsa.devel/55384/focus=55410
> > I intend to submit a new patch to address this in the future.
> > 
> > This patch has been in use for three months on my MythTV system (Ubuntu
> > 8.04). I find it works reliably for me. I also use it with xine, aplay,
> > mplayer, mame, and childsplay.
> > 
> > I have checked with checkpatch.pl . Patch is against v1.0.18rc1.
> > 
> > Signed-off-by: Ben Stanley Ben.Stanley@exemail.com.au
> 
> Thanks for the patch!
> 
> Through a quick review, I find it almost fine, but slight concerns below.
> 
> > +static int hw_rule_playback_rate(
> > +	struct snd_pcm_hw_params *params,
> > +	struct snd_pcm_hw_rule   *rule)
> 
> Put arguments right after the open parenthesis.
> It's more common style.
> 
> > +{
> > +	struct snd_ca0106 *chip = rule->private;
> > +	int chi, any_44100 = 0, any_non_44100 = 0, mask = 0;
> 
> No need to initialize here (at least for mask).
> 
> > +	struct snd_ca0106_channel *chp = 0;
> 
> Ditto.
> 
> > +	struct snd_pcm_runtime *runtime;
> > +	if (snd_BUG_ON(!chip))
> > +		return -EINVAL;
> > +
> > +	if (chip->spdif_enable) {
> > +		for (chi = 0; chi < 4; ++chi) {
> > +			chp = &(chip->playback_channels[chi]);
> 
> I'm afraid it's racy.  The chip->playback_channels[] can be changed at
> any time.  Try to put a mutex to protect this check.
> 
> > +			if (!chp->use)
> > +				continue;
> > +			if (snd_BUG_ON(!chp->epcm))
> > +				return -EINVAL;
> > +			if (!chp->epcm->hw_reserved)
> > +				continue;
> > +			if (snd_BUG_ON(!chp->epcm->substream))
> > +				return -EINVAL;
> > +			if (snd_BUG_ON(!chp->epcm->substream->runtime))
> > +				return -EINVAL;
> > +			runtime = chp->epcm->substream->runtime;
> > +			snd_printd("snd_hw_rule_playback_rate: ch=%d, "
> > +				"rate=%d.\n", chi, runtime->rate);
> 
> Use snd_printdd() instead.  CONFIG_SND_DEBUG=y on most cases, and this
> would be too annoying.
> 
> > +			any_44100 += runtime->rate == 44100;
> > +			any_non_44100 += runtime->rate != 44100;
> > +		}
> > +		if (snd_BUG_ON(any_44100 && any_non_44100))
> > +			return -EINVAL;
> > +		if (any_44100)
> > +			mask = 0x1;
> > +		else if (any_non_44100)
> > +			mask = 0xE;
> > +		else
> > +			mask = 0xF;
> 
> This mask value is a bit cryptic, but OK...
> 
> > +	} else {
> > +		/* 44100Hz is not supported for DAC (FIXME Why?) */
> > +		mask = 0xE;
> > +	}
> > +	snd_printd("snd_hw_rule_playback_rate: any_44100=%d, "
> > +		"any_non_44100=%d, mask=0x%X, spdif=%d\n",
> > +		any_44100, any_non_44100, mask, chip->spdif_enable);
> 
> Use snd_printdd().
> 
> > +	return snd_interval_list(
> > +		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE),
> > +		ARRAY_SIZE(all_spdif_playback_rates),
> > +		all_spdif_playback_rates, mask);
> 
> Put arguments after the open parenthesis.
> 
> > +}
> > +
> > +static int hw_rule_playback_format(
> > +	struct snd_pcm_hw_params *params,
> > +	struct snd_pcm_hw_rule *rule)
> 
> Ditto.
> 
> > +{
> > +	struct snd_ca0106 *chip = rule->private;
> > +	int chi, any_S16 = 0, any_S32 = 0;
> > +	struct snd_ca0106_channel *chp = 0;
> 
> No need to initialize.
> 
> > +	struct snd_pcm_runtime *runtime;
> > +	struct snd_mask fmt, *f = hw_param_mask(
> > +					params, SNDRV_PCM_HW_PARAM_FORMAT);
> > +	int result;
> > +	if (snd_BUG_ON(!chip))
> > +		return -EINVAL;
> > +	snd_mask_none(&fmt);
> > +
> > +	for (chi = 0; chi < 4; ++chi) {
> > +		chp = &(chip->playback_channels[chi]);
> 
> This also needs a mutex as well.
> 
> > +		if (!chp->use)
> > +			continue;
> > +		if (snd_BUG_ON(!chp->epcm))
> > +			return -EINVAL;
> > +		if (!chp->epcm->hw_reserved)
> > +			continue;
> > +		if (snd_BUG_ON(!chp->epcm->substream))
> > +			return -EINVAL;
> > +		if (snd_BUG_ON(!chp->epcm->substream->runtime))
> > +			return -EINVAL;
> > +		runtime = chp->epcm->substream->runtime;
> > +		snd_printd("snd_hw_rule_playback_format: ch=%d, format=%d.\n",
> > +			chi, runtime->format);
> 
> Use snd_printdd().
> 
> > +		any_S16 += runtime->format == SNDRV_PCM_FORMAT_S16_LE;
> > +		any_S32 += runtime->format == SNDRV_PCM_FORMAT_S32_LE;
> > +	}
> > +	if (snd_BUG_ON(any_S16 && any_S32))
> > +		return -EINVAL;
> > +	if (any_S16)
> > +		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
> > +	else if (any_S32)
> > +		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
> > +	else {
> > +		/* No format yet chosen, so both formats are available. */
> > +		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
> > +		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
> > +	}
> > +	result = snd_mask_refine(f, &fmt);
> > +	snd_printd("snd_hw_rule_playback_format: any_S16=%d, any_S32=%d, "
> > +		"refined_fmt=0x%X, avail_fmt=0x%X, changed=%d\n",
> > +		any_S16, any_S32, f->bits[0], fmt.bits[0], result);
> 
> Use snd_printdd().
> 
> 
> > +	return result;
> > +}
> > +
> >  unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
> >  					  unsigned int reg, 
> >  					  unsigned int chn)
> > @@ -508,10 +619,24 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
> >          //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
> >          //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
> >  	channel->epcm = epcm;
> > -	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
> > +	err = snd_pcm_hw_constraint_integer(
> > +			runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> > +	if (err < 0)
> >                  return err;
> > -	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
> > +	err = snd_pcm_hw_constraint_step(
> > +			runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
> > +	if (err < 0)
> >                  return err;
> > +	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> > +			hw_rule_playback_rate, (void *)chip,
> > +			SNDRV_PCM_HW_PARAM_RATE, -1);
> > +	if (err < 0)
> > +		return err;
> > +	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
> > +		       hw_rule_playback_format, (void *)chip,
> > +			SNDRV_PCM_HW_PARAM_FORMAT, -1);
> > +	if (err < 0)
> > +		return err;
> >  	snd_pcm_set_sync(substream);
> >  
> >  	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
> > @@ -646,6 +771,9 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
> >  /* hw_free callback */
> >  static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
> >  {
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	struct snd_ca0106_pcm *epcm = runtime->private_data;
> > +	epcm->hw_reserved = 0;
> >  	return snd_pcm_lib_free_pages(substream);
> >  }
> >  
> > @@ -667,53 +795,103 @@ static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
> >  static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
> >  {
> >  	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
> > -	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei = 0;
> 
> No need to initialize.
> 
> >  	struct snd_ca0106_pcm *epcm = runtime->private_data;
> > -	int channel = epcm->channel_id;
> > +	struct snd_ca0106_channel *chp = 0;
> 
> Ditto.
> 
> > +	int channel = epcm->channel_id, chi, any_44100 = 0, any_non_44100 = 0;
> >  	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
> >  	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
> >  	u32 hcfg_mask = HCFG_PLAYBACK_S32_LE;
> >  	u32 hcfg_set = 0x00000000;
> >  	u32 hcfg;
> > -	u32 reg40_mask = 0x30000 << (channel<<1);
> > +	u32 reg40_mask = 0xFF0000;
> >  	u32 reg40_set = 0;
> >  	u32 reg40;
> > -	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
> > -	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
> > +	u32 reg71_mask;
> > +	u32 reg71_shift;
> >  	u32 reg71_set = 0;
> >  	u32 reg71;
> >  	int i;
> >  	
> > -        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
> > -        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
> > -	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
> > -	/* Rate can be set per channel. */
> > -	/* reg40 control host to fifo */
> > -	/* reg71 controls DAC rate. */
> > -	switch (runtime->rate) {
> > -	case 44100:
> > -		reg40_set = 0x10000 << (channel<<1);
> > -		reg71_set = 0x01010000; 
> > -		break;
> > -        case 48000:
> > -		reg40_set = 0;
> > -		reg71_set = 0; 
> > -		break;
> > -	case 96000:
> > -		reg40_set = 0x20000 << (channel<<1);
> > -		reg71_set = 0x02020000; 
> > -		break;
> > -	case 192000:
> > -		reg40_set = 0x30000 << (channel<<1);
> > -		reg71_set = 0x03030000; 
> > -		break;
> > -	default:
> > -		reg40_set = 0;
> > -		reg71_set = 0; 
> > -		break;
> > +	epcm->hw_reserved = 1;
> > +	/* FIXME CLEAN UP IF spdif_enable IS CHANGED WHILE CHANNELS ARE OPENED
> > +	 * OR PREVENT THIS FROM HAPPENING. */
> > +	if (emu->spdif_enable)
> > +		reg71_shift = 24; /* SPDIF Output Rate */
> > +	else
> > +		reg71_shift = 16; /* I2S Output Rate */
> > +	reg71_mask = 0x3 << reg71_shift;
> > +
> > +	printk(KERN_DEBUG DRVNAME ": prepare_playback: "
> > +		"channel_number=%d, rate=%d, format=0x%x, channels=%d, "
> > +		"buffer_size=%ld,period_size=%ld, periods=%u, "
> > +		"frames_to_bytes=%d\n",
> > +		channel, runtime->rate, runtime->format, runtime->channels,
> > +		runtime->buffer_size, runtime->period_size, runtime->periods,
> > +		frames_to_bytes(runtime, 1));
> 
> Use snd_printdd() (if any).
> 
> > +	/*printk("dma_addr=%x, dma_area=%p, table_base=%p\n",
> > +		runtime->dma_addr,runtime->dma_area, table_base);*/
> > +	/*printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",
> > +		emu->buffer.addr,emu->buffer.area, emu->buffer.bytes);*/
> > +	/* We are forced to build the settings for all the channels. */
> > +	for (chi = 0; chi < 4; ++chi) {
> > +		chp = &(emu->playback_channels[chi]);
> 
> Use a mutex in this function, too.
> 
> > +		if (!chp->use)
> > +			continue;
> > +		if (snd_BUG_ON(!chp->epcm))
> > +			return -EINVAL;
> > +		if (chi != channel && !chp->epcm->hw_reserved)
> > +			continue;
> > +		if (snd_BUG_ON(!chp->epcm->substream))
> > +			return -EINVAL;
> > +		if (snd_BUG_ON(!chp->epcm->substream->runtime))
> > +			return -EINVAL;
> > +		runtimei = chp->epcm->substream->runtime;
> > +		any_44100 += runtimei->rate == 44100;
> > +		any_non_44100 += runtimei->rate != 44100;
> > +		/* Rate can be set per channel. */
> > +		/* reg40 control host to fifo */
> > +		/* reg71 controls DAC rate. */
> > +		switch (runtimei->rate) {
> > +		case 44100:
> > +			/* We only support 44100 to spdif, not to DAC.
> > +			   (FIXME WHY?)*/
> > +			if (emu->spdif_enable) {
> > +				/* When using 44100, *all* channels
> > +				   must be set to that rate. */
> > +				reg40_set |= 0x550000;
> > +				reg71_set |= 0x1 << reg71_shift;
> > +				break;
> > +			} else {
> > +				printk(KERN_ERR DRVNAME
> > +					"prepare_playback: "
> > +					"44100Hz is invalid for DAC.\n");
> > +			}
> > +		case 48000:
> > +			/* reg40_set &= !(0x1 << (chi<<1)); */
> > +			/* reg71_set &= !(0x1 << reg71_shift); */
> > +			break;
> > +		case 96000:
> > +			reg40_set |= 0x20000 << (chi<<1);
> > +			reg71_set |= 0x2 << reg71_shift;
> > +			break;
> > +		case 192000:
> > +			reg40_set |= 0x30000 << (chi<<1);
> > +			reg71_set |= 0x3 << reg71_shift;
> > +			break;
> > +		default:
> > +			printk(KERN_ERR DRVNAME
> > +				": prepare_playback: "
> > +				"Bad sampling frequency %d.\n",
> > +				runtimei->rate);
> > +		}
> >  	}
> > -	/* Format is a global setting */
> > -	/* FIXME: Only let the first channel accessed set this. */
> > +	printk(KERN_DEBUG DRVNAME ": prepare_playback: any_44100=%d, "
> > +		"any_non_44100=%d, spdif=%d.\n",
> > +		any_44100, any_non_44100, emu->spdif_enable);
> 
> Use snd_printdd().
> 
> > +	/* Format is a global setting. */
> > +	/* Only the first channel accessed can set this
> > +	   (enforced by constraints). */
> >  	switch (runtime->format) {
> >  	case SNDRV_PCM_FORMAT_S16_LE:
> >  		hcfg_set = 0;
> > @@ -1363,8 +1541,8 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
> >  	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
> >  	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
> >  #if 1
> > -	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
> > -	       pci->revision, chip->serial);
> > +	printk(KERN_INFO DRVNAME ": Model %04x Rev %08x Serial %08x\n",
> > +		chip->model, pci->revision, chip->serial);
> >  #endif
> >  	strcpy(card->driver, "CA0106");
> >  	strcpy(card->shortname, "CA0106");
> > @@ -1378,7 +1556,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
> >  	}
> >  	chip->details = c;
> >  	if (subsystem[dev]) {
> > -		printk(KERN_INFO "snd-ca0106: Sound card name=%s, subsystem=0x%x. Forced to subsystem=0x%x\n",
> > +		printk(KERN_INFO DRVNAME
> > +			": Sound card name=%s, subsystem=0x%x. "
> > +			"Forced to subsystem=0x%x\n",
> >                          c->name, chip->serial, subsystem[dev]);
> >  	}
> 
> 
> Could you fix these and repost?
> 
> 
> Thanks!
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-lsMZJ4IxY7skpnVaSzUT
Content-Disposition: attachment; filename*0=0001-ca0106-playback-44100Hz-support-to-SPDIF-and-playbac.pat; filename*1=ch
Content-Type: application/mbox; name=0001-ca0106-playback-44100Hz-support-to-SPDIF-and-playbac.patch
Content-Transfer-Encoding: 7bit

>From 1437172bbb9e2e3bcc0bb13e226fe43dda3a4fe2 Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Sun, 24 Aug 2008 00:01:25 +1000
Subject: [PATCH] ca0106 playback 44100Hz support to SPDIF and playback format & rate constraints

Squashed commit of the following:

commit 8bfbd000b4b602b517b5ab1edc5610ef39dced1e
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Sat Aug 23 23:19:57 2008 +1000

    Correct style and log messages according to Takashi's review comments.

commit eb973ebecfac64b6f0e60df90eef8885ccc64aaf
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Wed Aug 20 23:56:15 2008 +1000

    Annotate bug in comments.

commit df725ab6af87e1c94d1d41e31e3865437b1999e0
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Wed Aug 20 23:44:12 2008 +1000

    Checkpatch.pl round 4.

commit c277bfa1773595b98c5447a7a085f21ccead110f
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Wed Aug 20 23:39:39 2008 +1000

    Checkpatch.pl changes round 3.

commit a3f9b1faae250aa0786ef68c3c53c3915e42972b
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Wed Aug 20 23:18:36 2008 +1000

    Second round of checkpatch.pl changes.

commit 3f45e4895fc8419a4a90eddf29af4f8547aa105d
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Sun Aug 17 00:06:47 2008 +1000

    Satisfy checkpatch.pl pass 1

commit 88424052a25359aa7ffa840e0515a7a93278f931
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Sat Aug 16 22:32:25 2008 +1000

    44100Hz playback support to SPDIF and playback format & rate constraints

commit e0795c3bc756f07986eaae7c4ab54a78d3fecc80
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Sat Aug 16 22:25:38 2008 +1000

    Remove use of snd_assert.

commit 097b03e9ff07432c45a9865bd02208b20b09beb3
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Thu Jul 24 02:59:38 2008 +1000

    * fix cosmetic bug

commit 75769f154ea53b4215de37d314351c4e45bd2543
Author: Ben Stanley <Ben.Stanley@exemail.com.au>
Date:   Thu Jul 3 20:47:31 2008 +1000

    44100Hz playback support to SPDIF and playback format & rate constraints
---
 pci/ca0106/ca0106.h      |    7 +-
 pci/ca0106/ca0106_main.c |  265 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 228 insertions(+), 44 deletions(-)

diff --git a/pci/ca0106/ca0106.h b/pci/ca0106/ca0106.h
index 74175fc..376fa9c 100644
--- a/pci/ca0106/ca0106.h
+++ b/pci/ca0106/ca0106.h
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.22
+ *  Version: 0.0.23
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
@@ -49,6 +49,8 @@
  *   Implement support for Line-in capture on SB Live 24bit.
  *  0.0.22
  *    Add support for mute control on SB Live 24bit (cards w/ SPI DAC)
+ *  0.0.23
+ *    Add support for playback sampling rate and format constraints.
  *
  *
  *  This code was initally based on code from ALSA's emu10k1x.c which is:
@@ -644,6 +646,8 @@
 
 #include "ca_midi.h"
 
+#define DRVNAME "snd-ca0106"
+
 struct snd_ca0106;
 
 struct snd_ca0106_channel {
@@ -659,6 +663,7 @@ struct snd_ca0106_pcm {
 	struct snd_pcm_substream *substream;
         int channel_id;
 	unsigned short running;
+	unsigned short hw_reserved;
 };
 
 struct snd_ca0106_details {
diff --git a/pci/ca0106/ca0106_main.c b/pci/ca0106/ca0106_main.c
index 2f8b28a..b06f7a9 100644
--- a/pci/ca0106/ca0106_main.c
+++ b/pci/ca0106/ca0106_main.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.25
+ *  Version: 0.0.26
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -83,9 +83,14 @@
  *    Add support for mute control on SB Live 24bit (cards w/ SPI DAC)
  *  0.0.25
  *    Powerdown SPI DAC channels when not in use
+ *  0.0.26 Ben Stanley
+ *    Added support for output at 44100Hz rate (SPDIF only).
+ *    Implemented constraints system for output rate and format.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-ca0106 kernel module.
+ *    Some programs fail to produce sound output (tested on SPDIF). See
+ *      http://thread.gmane.org/gmane.linux.alsa.devel/55384/focus=55410
  *    --
  *
  *  TODO:
@@ -145,6 +150,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 
@@ -284,9 +290,9 @@ static struct snd_pcm_hardware snd_ca0106_playback_hw = {
 				SNDRV_PCM_INFO_MMAP_VALID |
 				SNDRV_PCM_INFO_SYNC_START,
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000),
-	.rate_min =		48000,
+	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
+	.rate_min =		44100,
 	.rate_max =		192000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
@@ -318,6 +324,110 @@ static struct snd_pcm_hardware snd_ca0106_capture_hw = {
 	.fifo_size =		0,
 };
 
+static unsigned int all_spdif_playback_rates[] =
+	{44100, 48000, 96000, 192000};
+
+static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule   *rule)
+{
+	struct snd_ca0106 *chip = rule->private;
+	int chi, any_44100 = 0, any_non_44100 = 0, mask;
+	struct snd_ca0106_channel *chp;
+	struct snd_pcm_runtime *runtime;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	if (chip->spdif_enable) {
+		for (chi = 0; chi < 4; ++chi) {
+			chp = &(chip->playback_channels[chi]);
+			if (!chp->use)
+				continue;
+			if (snd_BUG_ON(!chp->epcm))
+				return -EINVAL;
+			if (!chp->epcm->hw_reserved)
+				continue;
+			if (snd_BUG_ON(!chp->epcm->substream))
+				return -EINVAL;
+			if (snd_BUG_ON(!chp->epcm->substream->runtime))
+				return -EINVAL;
+			runtime = chp->epcm->substream->runtime;
+			snd_printdd("snd_hw_rule_playback_rate: ch=%d, "
+				"rate=%d.\n", chi, runtime->rate);
+			any_44100 += runtime->rate == 44100;
+			any_non_44100 += runtime->rate != 44100;
+		}
+		if (snd_BUG_ON(any_44100 && any_non_44100))
+			return -EINVAL;
+		/* Compute the mask applied to all_spdif_playback_rates */
+		if (any_44100)
+			mask = 0x1;
+		else if (any_non_44100)
+			mask = 0xE;
+		else
+			mask = 0xF;
+	} else {
+		/* 44100Hz is not supported for DAC (FIXME Why?) */
+		mask = 0xE;
+	}
+	snd_printdd("snd_hw_rule_playback_rate: any_44100=%d, "
+		"any_non_44100=%d, mask=0x%X, spdif=%d\n",
+		any_44100, any_non_44100, mask, chip->spdif_enable);
+	return snd_interval_list(hw_param_interval(params,
+						   SNDRV_PCM_HW_PARAM_RATE),
+				 ARRAY_SIZE(all_spdif_playback_rates),
+				 all_spdif_playback_rates, mask);
+}
+
+static int hw_rule_playback_format(struct snd_pcm_hw_params *params,
+				   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_ca0106 *chip = rule->private;
+	int chi, any_S16 = 0, any_S32 = 0;
+	struct snd_ca0106_channel *chp;
+	struct snd_pcm_runtime *runtime;
+	struct snd_mask fmt, *f = hw_param_mask(
+					params, SNDRV_PCM_HW_PARAM_FORMAT);
+	int result;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+	snd_mask_none(&fmt);
+
+	for (chi = 0; chi < 4; ++chi) {
+		chp = &(chip->playback_channels[chi]);
+		if (!chp->use)
+			continue;
+		if (snd_BUG_ON(!chp->epcm))
+			return -EINVAL;
+		if (!chp->epcm->hw_reserved)
+			continue;
+		if (snd_BUG_ON(!chp->epcm->substream))
+			return -EINVAL;
+		if (snd_BUG_ON(!chp->epcm->substream->runtime))
+			return -EINVAL;
+		runtime = chp->epcm->substream->runtime;
+		snd_printdd("snd_hw_rule_playback_format: ch=%d, format=%d.\n",
+			chi, runtime->format);
+		any_S16 += runtime->format == SNDRV_PCM_FORMAT_S16_LE;
+		any_S32 += runtime->format == SNDRV_PCM_FORMAT_S32_LE;
+	}
+	if (snd_BUG_ON(any_S16 && any_S32))
+		return -EINVAL;
+	if (any_S16)
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
+	else if (any_S32)
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
+	else {
+		/* No format yet chosen, so both formats are available. */
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
+	}
+	result = snd_mask_refine(f, &fmt);
+	snd_printdd("snd_hw_rule_playback_format: any_S16=%d, any_S32=%d, "
+		"refined_fmt=0x%X, avail_fmt=0x%X, changed=%d\n",
+		any_S16, any_S32, f->bits[0], fmt.bits[0], result);
+	return result;
+}
+
 unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
 					  unsigned int reg, 
 					  unsigned int chn)
@@ -508,10 +618,24 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
 	channel->epcm = epcm;
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+	err = snd_pcm_hw_constraint_integer(
+			runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
                 return err;
-	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+	err = snd_pcm_hw_constraint_step(
+			runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
+	if (err < 0)
                 return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			hw_rule_playback_rate, (void *)chip,
+			SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+		       hw_rule_playback_format, (void *)chip,
+			SNDRV_PCM_HW_PARAM_FORMAT, -1);
+	if (err < 0)
+		return err;
 	snd_pcm_set_sync(substream);
 
 	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
@@ -646,6 +770,9 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
 /* hw_free callback */
 static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_ca0106_pcm *epcm = runtime->private_data;
+	epcm->hw_reserved = 0;
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -667,53 +794,103 @@ static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
 static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
 	struct snd_ca0106_pcm *epcm = runtime->private_data;
-	int channel = epcm->channel_id;
+	struct snd_ca0106_channel *chp;
+	int channel = epcm->channel_id, chi, any_44100 = 0, any_non_44100 = 0;
 	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	u32 hcfg_mask = HCFG_PLAYBACK_S32_LE;
 	u32 hcfg_set = 0x00000000;
 	u32 hcfg;
-	u32 reg40_mask = 0x30000 << (channel<<1);
+	u32 reg40_mask = 0xFF0000;
 	u32 reg40_set = 0;
 	u32 reg40;
-	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
-	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	u32 reg71_mask;
+	u32 reg71_shift;
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
 	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
-	/* Rate can be set per channel. */
-	/* reg40 control host to fifo */
-	/* reg71 controls DAC rate. */
-	switch (runtime->rate) {
-	case 44100:
-		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
-		break;
-        case 48000:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
-	case 96000:
-		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
-		break;
-	case 192000:
-		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
-		break;
-	default:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
+	epcm->hw_reserved = 1;
+	/* FIXME CLEAN UP IF spdif_enable IS CHANGED WHILE CHANNELS ARE OPENED
+	 * OR PREVENT THIS FROM HAPPENING. */
+	if (emu->spdif_enable)
+		reg71_shift = 24; /* SPDIF Output Rate */
+	else
+		reg71_shift = 16; /* I2S Output Rate */
+	reg71_mask = 0x3 << reg71_shift;
+
+	/*printk(KERN_DEBUG DRVNAME ": prepare_playback: "
+		"channel_number=%d, rate=%d, format=0x%x, channels=%d, "
+		"buffer_size=%ld,period_size=%ld, periods=%u, "
+		"frames_to_bytes=%d\n",
+		channel, runtime->rate, runtime->format, runtime->channels,
+		runtime->buffer_size, runtime->period_size, runtime->periods,
+		frames_to_bytes(runtime, 1));*/
+	/*printk("dma_addr=%x, dma_area=%p, table_base=%p\n",
+		runtime->dma_addr,runtime->dma_area, table_base);*/
+	/*printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",
+		emu->buffer.addr,emu->buffer.area, emu->buffer.bytes);*/
+	/* We are forced to build the settings for all the channels. */
+	for (chi = 0; chi < 4; ++chi) {
+		chp = &(emu->playback_channels[chi]);
+		if (!chp->use)
+			continue;
+		if (snd_BUG_ON(!chp->epcm))
+			return -EINVAL;
+		if (chi != channel && !chp->epcm->hw_reserved)
+			continue;
+		if (snd_BUG_ON(!chp->epcm->substream))
+			return -EINVAL;
+		if (snd_BUG_ON(!chp->epcm->substream->runtime))
+			return -EINVAL;
+		runtimei = chp->epcm->substream->runtime;
+		any_44100 += runtimei->rate == 44100;
+		any_non_44100 += runtimei->rate != 44100;
+		/* Rate can be set per channel. */
+		/* reg40 control host to fifo */
+		/* reg71 controls DAC rate. */
+		switch (runtimei->rate) {
+		case 44100:
+			/* We only support 44100 to spdif, not to DAC.
+			   (FIXME WHY?)*/
+			if (emu->spdif_enable) {
+				/* When using 44100, *all* channels
+				   must be set to that rate. */
+				reg40_set |= 0x550000;
+				reg71_set |= 0x1 << reg71_shift;
+				break;
+			} else {
+				printk(KERN_ERR DRVNAME
+					"prepare_playback: "
+					"44100Hz is invalid for DAC.\n");
+			}
+		case 48000:
+			/* reg40_set &= !(0x1 << (chi<<1)); */
+			/* reg71_set &= !(0x1 << reg71_shift); */
+			break;
+		case 96000:
+			reg40_set |= 0x20000 << (chi<<1);
+			reg71_set |= 0x2 << reg71_shift;
+			break;
+		case 192000:
+			reg40_set |= 0x30000 << (chi<<1);
+			reg71_set |= 0x3 << reg71_shift;
+			break;
+		default:
+			printk(KERN_ERR DRVNAME
+				": prepare_playback: "
+				"Bad sampling frequency %d.\n",
+				runtimei->rate);
+		}
 	}
-	/* Format is a global setting */
-	/* FIXME: Only let the first channel accessed set this. */
+	snd_printdd(KERN_DEBUG DRVNAME ": prepare_playback: any_44100=%d, "
+		"any_non_44100=%d, spdif=%d.\n",
+		any_44100, any_non_44100, emu->spdif_enable);
+	/* Format is a global setting. */
+	/* Only the first channel accessed can set this
+	   (enforced by constraints). */
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		hcfg_set = 0;
@@ -1363,8 +1540,8 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
 #if 1
-	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
-	       pci->revision, chip->serial);
+	printk(KERN_INFO DRVNAME ": Model %04x Rev %08x Serial %08x\n",
+		chip->model, pci->revision, chip->serial);
 #endif
 	strcpy(card->driver, "CA0106");
 	strcpy(card->shortname, "CA0106");
@@ -1378,7 +1555,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	}
 	chip->details = c;
 	if (subsystem[dev]) {
-		printk(KERN_INFO "snd-ca0106: Sound card name=%s, subsystem=0x%x. Forced to subsystem=0x%x\n",
+		printk(KERN_INFO DRVNAME
+			": Sound card name=%s, subsystem=0x%x. "
+			"Forced to subsystem=0x%x\n",
                         c->name, chip->serial, subsystem[dev]);
 	}
 
-- 
1.5.4.3


--=-lsMZJ4IxY7skpnVaSzUT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-lsMZJ4IxY7skpnVaSzUT--
