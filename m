From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz
	support	to	SPDIF	and	playback	format & rate constraints
Date: Thu, 04 Sep 2008 01:15:47 +1000
Message-ID: <1220454947.7459.70.camel@localhost>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de> <1219502224.15980.32.camel@localhost>
	<s5h7ia5dpe0.wl%tiwai@suse.de> <1220375467.7459.8.camel@localhost>
	<s5hbpz5pni5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A908C244B5
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 17:15:54 +0200 (CEST)
In-Reply-To: <s5hbpz5pni5.wl%tiwai@suse.de>
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

Takashi,

Thankyou for your comments.

My modifications would be much simpler if I didn't have to re-build the
counts of how many channels are in each mode every time the prepare and
hw_free functions are called. 

In the case of the prepare function, I could modify the existing counts
if I knew what the previous state (rate, format) was before the most
recent change.

In the case of the hw_free function, I think that the rate and format
information is invalid for the current channel by the time the hw_free
function is called.

If I knew these pieces of information, I could completely avoid
re-building the counts.

Regarding the locking, initially I only tried to protect my count
fields. I have now tried to work on the locking some more (see
incremental untested patch at end). Each time I learn some more...
thanks for your patience. Perhaps there is another driver that already
has to do this level of locking that you could point me to look at. The
other drivers I have looked at so far don't have to do this much
locking. (I gather that means they are designed to avoid the need to
lock?)

Regarding atomicity, the documentation states that
snd_ca0106_pcm_trigger_capture, snd_ca0106_pcm_pointer_playback,
snd_ca0106_pcm_pointer_capture are called with a spinlock held by the
middle layer. What lock is that? Do I need to hold my spinlock in
addition? Will that possibly cause deadlock if the spinlocks are grabbed
in different orders? So many questions...

Regarding snd_BUG_ON, I have used it like an assert, intending that it
should be turned off in normal production code. Is that not the case?

Further comments interleaved below.

On Wed, 2008-09-03 at 11:49 +0200, Takashi Iwai wrote:
> At Wed, 03 Sep 2008 03:11:07 +1000,
> Ben Stanley wrote:
> > 
> > Takashi,
> > 
> > Further to your previous comments [1], I have attempted to address the
> > locking issues. I have re-designed the code to simplify the locking
> > problems.
> > 
> > This is the patch against alsa-kmirror.
> > 
> > Signed-off-by: Ben Stanley Ben.Stanley@exemail.com.au
> 
> Thanks for the patch!
> 
> > [1] http://thread.gmane.org/gmane.linux.alsa.devel/55527/focus=55539
> > 
> > 
> > ---
> >  pci/ca0106/ca0106.h      |   13 ++-
> >  pci/ca0106/ca0106_main.c |  367 ++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 347 insertions(+), 33 deletions(-)
> > 
> > diff --git a/pci/ca0106/ca0106.h b/pci/ca0106/ca0106.h
> > index 74175fc..bf502b5 100644
> > --- a/pci/ca0106/ca0106.h
> > +++ b/pci/ca0106/ca0106.h
> > @@ -1,7 +1,7 @@
> >  /*
> >   *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
> >   *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
> > - *  Version: 0.0.22
> > + *  Version: 0.0.23
> >   *
> >   *  FEATURES currently supported:
> >   *    See ca0106_main.c for features.
> > @@ -49,6 +49,8 @@
> >   *   Implement support for Line-in capture on SB Live 24bit.
> >   *  0.0.22
> >   *    Add support for mute control on SB Live 24bit (cards w/ SPI DAC)
> > + *  0.0.23
> > + *    Add support for playback sampling rate and format constraints.
> >   *
> >   *
> >   *  This code was initally based on code from ALSA's emu10k1x.c which is:
> > @@ -644,6 +646,8 @@
> >  
> >  #include "ca_midi.h"
> >  
> > +#define DRVNAME "snd-ca0106"
> > +
> >  struct snd_ca0106;
> >  
> >  struct snd_ca0106_channel {
> > @@ -659,6 +663,7 @@ struct snd_ca0106_pcm {
> >  	struct snd_pcm_substream *substream;
> >          int channel_id;
> >  	unsigned short running;
> > +	unsigned short hw_reserved;
> >  };
> >  
> >  struct snd_ca0106_details {
> > @@ -684,6 +689,7 @@ struct snd_ca0106 {
> >  	unsigned short model;		/* subsystem id */
> >  
> >  	spinlock_t emu_lock;
> > +	spinlock_t pcm_lock;
> 
> The spinlock is needed if the lock is accessed in the IRQ handler.
> For your patch, use mutex instead.
> 
> However, the problem is that the lock is missing in some important
> places, namely, *_open(), *_close() and snd_ca0106_interrupt().
> If it's used in snd_ca0106_interrupt(), it has to be spinlock indeed.

I tried to address this some more in the incremental patch at the end of
this email.
> 
> >  
> >  	struct snd_ac97 *ac97;
> >  	struct snd_pcm *pcm;
> > @@ -703,6 +709,11 @@ struct snd_ca0106 {
> >  	struct snd_ca_midi midi2;
> >  
> >  	u16 spi_dac_reg[16];
> > +
> > +	unsigned short count_pb_44100_chan;
> > +	unsigned short count_pb_non_44100_chan;
> > +	unsigned short count_pb_S16_chan;
> > +	unsigned short count_pb_S32_chan;
> 
> Any reason to use short instead of char?

I could change that.

> 
> > +static unsigned int all_spdif_playback_rates[] =
> > +	{44100, 48000, 96000, 192000};
> > +
> > +static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
> > +				 struct snd_pcm_hw_rule   *rule)
> > +{
> > +	struct snd_ca0106 *chip = rule->private;
> > +	int mask;
> > +	if (snd_BUG_ON(!chip))
> > +		return -EINVAL;
> > +
> > +	spin_lock(&chip->pcm_lock);
> > +	if (chip->spdif_enable) {
> > +		if (snd_BUG_ON(chip->count_pb_44100_chan &&
> > +			 chip->count_pb_non_44100_chan)) {
> > +			spin_unlock(&chip->pcm_lock);
> > +			return -EINVAL;
> > +		}
> 
> Don't use too much snd_BUG_ON().  This would be better to be a
> normal check since we have anyway races in parameter constraints,
> and this may happen indeed.

This is just asserting the invariants, and it did find some problems
during development. This condition should not be triggered by the races
in parameter constraints, as I took special care to deal with that
problem in the prepare function. I would consider removal before
promotion to an 'error' check.
> 
> > +		if (snd_BUG_ON(chip->count_pb_44100_chan +
> > +			 chip->count_pb_non_44100_chan > 4)) {
> > +			spin_unlock(&chip->pcm_lock);
> > +			return -EINVAL;
> > +		}
> 
> This check can be dropped.  Whether it's more than 4 doesn't affect
> the behavior of this function.

Asserting invariants, same comments as above. If the total count of
channels in the 44100 and non-44100 sets is above the number of channels
on the card, there is a problem. However, this cannot happen with the
current design of the patch, so I am happy to remove it.

> 
> > +		/* Compute the mask applied to all_spdif_playback_rates */
> > +		if (chip->count_pb_44100_chan)
> > +			mask = 0x1;
> > +		else if (chip->count_pb_non_44100_chan)
> > +			mask = 0xE;
> > +		else
> > +			mask = 0xF;
> > +	} else {
> > +		/* 44100Hz is not supported for DAC (FIXME Why?) */
> 
> Remove FIXME Why, as James suggested.

Good, I'm glad James responded to clear that up :-)

> 
> > +static int hw_rule_playback_format(struct snd_pcm_hw_params *params,
> > +				   struct snd_pcm_hw_rule *rule)
> > +{
> > +	struct snd_ca0106 *chip = rule->private;
> > +	struct snd_mask fmt, *f = hw_param_mask(
> > +					params, SNDRV_PCM_HW_PARAM_FORMAT);
> 
> Better to put f = hw_params_mask() outside so that you don't need ugly
> line break here.

Can do.
> 
> > +	int result;
> > +	if (snd_BUG_ON(!chip))
> > +		return -EINVAL;
> > +	snd_mask_none(&fmt);
> > +
> > +	spin_lock(&chip->pcm_lock);
> > +	if (snd_BUG_ON(chip->count_pb_S16_chan &&
> > +		 chip->count_pb_S32_chan)) {
> > +		spin_unlock(&chip->pcm_lock);
> > +		return -EINVAL;
> > +	}
> 
> Remove snd_BUG_ON().
> 
> > +	if (snd_BUG_ON(chip->count_pb_S16_chan +
> > +		 chip->count_pb_S32_chan > 4)) {
> > +		spin_unlock(&chip->pcm_lock);
> > +		return -EINVAL;
> > +	}
> 
> This check is needless.

During development these checks were useful. Now they can be removed.

> 
> > @@ -509,10 +602,24 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
> >          //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
> >          //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
> >  	channel->epcm = epcm;
> > -	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
> > +	err = snd_pcm_hw_constraint_integer(
> > +			runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> 
> Usually runtime is in the same line of 'snd_pcm_hw_constraint_integer('

Can change.
> 
> > +	if (err < 0)
> >                  return err;
> > -	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
> > +	err = snd_pcm_hw_constraint_step(
> > +			runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
> 
> Ditto.

Can change.
> 
> > @@ -647,6 +754,55 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
> >  /* hw_free callback */
> >  static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
> >  {
> > +	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
> > +	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
> > +	struct snd_ca0106_pcm *epcm = runtime->private_data;
> > +	struct snd_ca0106_channel *pchannel;
> > +	int channel = epcm->channel_id, chi;
> > +
> > +	spin_lock(&chip->pcm_lock);
> > +	epcm->hw_reserved = 0;
> > +	chip->count_pb_44100_chan = chip->count_pb_non_44100_chan = 0;
> > +	chip->count_pb_S16_chan = chip->count_pb_S32_chan = 0;
> > +	for (chi = 0; chi < 4; ++chi) {
> > +		if (chi == channel)
> > +			continue;
> > +		pchannel = &(chip->playback_channels[chi]);
> > +		if (!pchannel->use)
> > +			continue;
> > +		if (snd_BUG_ON(!pchannel->epcm)) {
> > +			spin_unlock(&chip->pcm_lock);
> > +			return -EINVAL;
> > +		}
> 
> snd_BUG_ON() is wrong here.  Note that pchannel->epcm isn't protected 
> at all by chip->pcm_lock in your patch because it's not used in
> *_open() and *_close() callbacks.  Use the lock to protect the
> assignment of these.
> 

Hmmm... The open callback allocates a new snd_ca0106_pcm by kmalloc, but
the close callback does not kfree it. Is that a leak? Oh, I see that it
is kfreed by snd_ca0106_pcm_free_substream.

I can't find any other part of the driver that writes to the epcm field.
Furthermore, I observe that the use field is set to 1 before epcm field
is assigned. So perhaps the lock should cover this case.

> > +		if (!pchannel->epcm->hw_reserved)
> > +			continue;
> > +		if (snd_BUG_ON(!pchannel->epcm->substream)) {
> > +			spin_unlock(&chip->pcm_lock);
> > +			return -EINVAL;
> > +		}
> > +		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
> > +			spin_unlock(&chip->pcm_lock);
> > +			return -EINVAL;
> > +		}
> 
> Ditto.
Yeah, I see you don't like my defensive programming. I'll work on
understanding these better so that I can be confident of removing the
checks.
> 
> > +		runtimei = pchannel->epcm->substream->runtime;
> > +		chip->count_pb_44100_chan += runtimei->rate == 44100;
> > +		chip->count_pb_non_44100_chan += runtimei->rate != 44100;
> > +		chip->count_pb_S16_chan +=
> > +			runtimei->format == SNDRV_PCM_FORMAT_S16_LE;
> > +		chip->count_pb_S32_chan +=
> > +			runtimei->format == SNDRV_PCM_FORMAT_S32_LE;
> > +	}
> > +	snd_BUG_ON(chip->count_pb_44100_chan && chip->count_pb_non_44100_chan);
> > +	snd_BUG_ON(chip->count_pb_44100_chan +
> > +		chip->count_pb_non_44100_chan > 4);
> > +	snd_BUG_ON(chip->count_pb_S16_chan && chip->count_pb_S32_chan);
> > +	snd_BUG_ON(chip->count_pb_S16_chan + chip->count_pb_S32_chan > 4);
> 
> snd_BUG_ON() here is rather useless.

Can remove. Was useful during development.
> 
> > @@ -668,53 +824,196 @@ static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
> >  static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
> (snip)
> > +	/* We are forced to build the settings for all the channels. */
> > +	spin_lock(&emu->pcm_lock);
> > +	emu->count_pb_44100_chan = emu->count_pb_non_44100_chan = 0;
> > +	emu->count_pb_S16_chan = emu->count_pb_S32_chan = 0;
> > +	for (chi = 0; chi < 4; ++chi) {
> > +		if (chi == channel)
> > +			continue;
> > +		pchannel = &(emu->playback_channels[chi]);
> > +		if (!pchannel->use)
> > +			continue;
> > +		if (snd_BUG_ON(!pchannel->epcm)) {
> > +			spin_unlock(&emu->pcm_lock);
> > +			return -EINVAL;
> > +		}
> > +		if (!pchannel->epcm->hw_reserved)
> > +			continue;
> > +		if (snd_BUG_ON(!pchannel->epcm->substream)) {
> > +			spin_unlock(&emu->pcm_lock);
> > +			return -EINVAL;
> > +		}
> > +		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
> > +			spin_unlock(&emu->pcm_lock);
> > +			return -EINVAL;
> > +		}
> > +		runtimei = pchannel->epcm->substream->runtime;
> > +		emu->count_pb_44100_chan += runtimei->rate == 44100;
> > +		emu->count_pb_non_44100_chan += runtimei->rate != 44100;
> > +		emu->count_pb_S16_chan +=
> > +			runtimei->format == SNDRV_PCM_FORMAT_S16_LE;
> > +		emu->count_pb_S32_chan +=
> > +			runtimei->format == SNDRV_PCM_FORMAT_S32_LE;
> 
> This is as same as in *_hw_free().
> Better to split this as another function and call it from both
> appropriately.
Yes, I thought about that after my late night of hacking...

Even better would be to figure out how to avoid re-building the counts,
as discussed at the top. But, this works and seems to be robust against
my nasty test script.

It is not quite the same between hw_free and prepare, as the prepare
function takes special care to check whether what is requested fulfils
the constraints. If it satisfies the constraints, it is configured. The
check and the configuration are performed atomically.

So it looks very similar between the two, but is subtly different.
Perhaps I can code both versions in one function.

Incremental untested patch trying to address the locking is shown below.
I'm sure you'll find things you don't like :-). Please ignore the other
issues outlined above for the moment - I will work on addressing your
other comments another night. Please review the locking.

Ben Stanley.

>From c1c72cf2584c493080ddc04f9b9c36c38bb1b2bd Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Thu, 4 Sep 2008 01:00:26 +1000
Subject: [PATCH] Change locking to protect more stuff in accordance with Takashi's comments.

---
 pci/ca0106/ca0106_main.c  |   91 +++++++++++++++++++++++++++++++--------------
 pci/ca0106/ca0106_mixer.c |    3 +
 2 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/pci/ca0106/ca0106_main.c b/pci/ca0106/ca0106_main.c
index 806f34c..794de68 100644
--- a/pci/ca0106/ca0106_main.c
+++ b/pci/ca0106/ca0106_main.c
@@ -333,19 +333,20 @@ static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 {
 	struct snd_ca0106 *chip = rule->private;
 	int mask;
+	unsigned long flags;
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
-	spin_lock(&chip->pcm_lock);
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	if (chip->spdif_enable) {
 		if (snd_BUG_ON(chip->count_pb_44100_chan &&
 			 chip->count_pb_non_44100_chan)) {
-			spin_unlock(&chip->pcm_lock);
+			spin_unlock_irqrestore(&chip->pcm_lock, flags);
 			return -EINVAL;
 		}
 		if (snd_BUG_ON(chip->count_pb_44100_chan +
 			 chip->count_pb_non_44100_chan > 4)) {
-			spin_unlock(&chip->pcm_lock);
+			spin_unlock_irqrestore(&chip->pcm_lock, flags);
 			return -EINVAL;
 		}
 		/* Compute the mask applied to all_spdif_playback_rates */
@@ -364,7 +365,7 @@ static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
 		chip->count_pb_44100_chan,
 		chip->count_pb_non_44100_chan,
 		mask, chip->spdif_enable);
-	spin_unlock(&chip->pcm_lock);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 	return snd_interval_list(hw_param_interval(params,
 						   SNDRV_PCM_HW_PARAM_RATE),
 				 ARRAY_SIZE(all_spdif_playback_rates),
@@ -377,20 +378,21 @@ static int hw_rule_playback_format(struct snd_pcm_hw_params *params,
 	struct snd_ca0106 *chip = rule->private;
 	struct snd_mask fmt, *f = hw_param_mask(
 					params, SNDRV_PCM_HW_PARAM_FORMAT);
+	unsigned long flags;
 	int result;
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 	snd_mask_none(&fmt);
 
-	spin_lock(&chip->pcm_lock);
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	if (snd_BUG_ON(chip->count_pb_S16_chan &&
 		 chip->count_pb_S32_chan)) {
-		spin_unlock(&chip->pcm_lock);
+		spin_unlock_irqrestore(&chip->pcm_lock, flags);
 		return -EINVAL;
 	}
 	if (snd_BUG_ON(chip->count_pb_S16_chan +
 		 chip->count_pb_S32_chan > 4)) {
-		spin_unlock(&chip->pcm_lock);
+		spin_unlock_irqrestore(&chip->pcm_lock, flags);
 		return -EINVAL;
 	}
 	if (chip->count_pb_S16_chan)
@@ -408,7 +410,7 @@ static int hw_rule_playback_format(struct snd_pcm_hw_params *params,
 		chip->count_pb_S16_chan,
 		chip->count_pb_S32_chan, f->bits[0], fmt.bits[0],
 		result);
-	spin_unlock(&chip->pcm_lock);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 	return result;
 }
 
@@ -581,6 +583,7 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 	struct snd_ca0106_pcm *epcm;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
+	unsigned long flags;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 
@@ -589,7 +592,8 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-  
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
   
@@ -605,22 +609,23 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 	err = snd_pcm_hw_constraint_integer(
 			runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 	if (err < 0)
-                return err;
+                goto error;
 	err = snd_pcm_hw_constraint_step(
 			runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
 	if (err < 0)
-                return err;
+                goto error;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 			hw_rule_playback_rate, (void *)chip,
 			SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
-		return err;
+		goto error;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
 		       hw_rule_playback_format, (void *)chip,
 			SNDRV_PCM_HW_PARAM_FORMAT, -1);
 	if (err < 0)
-		return err;
+		goto error;
 	snd_pcm_set_sync(substream);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 
 	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
 		const int reg = spi_dacd_reg[channel_id];
@@ -632,6 +637,9 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 			return err;
 	}
 	return 0;
+error:
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+	return err;
 }
 
 /* close callback */
@@ -639,7 +647,11 @@ static int snd_ca0106_pcm_close_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-        struct snd_ca0106_pcm *epcm = runtime->private_data;
+        struct snd_ca0106_pcm *epcm;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	epcm = runtime->private_data;
 	chip->playback_channels[epcm->channel_id].use = 0;
 
 	if (chip->details->spi_dac && epcm->channel_id != PCM_FRONT_CHANNEL) {
@@ -650,6 +662,7 @@ static int snd_ca0106_pcm_close_playback(struct snd_pcm_substream *substream)
 		snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
 	}
 	/* FIXME: maybe zero others */
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 	return 0;
 }
 
@@ -681,6 +694,7 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
         struct snd_ca0106_channel *channel = &(chip->capture_channels[channel_id]);
 	struct snd_ca0106_pcm *epcm;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long flags;
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
@@ -692,6 +706,7 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
   
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
   
@@ -704,6 +719,7 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
         channel->epcm = epcm;
+	spin_unlock_irqsave(&chip->pcm_lock, flags);
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
                 return err;
 	//snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
@@ -717,9 +733,14 @@ static int snd_ca0106_pcm_close_capture(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-        struct snd_ca0106_pcm *epcm = runtime->private_data;
+        struct snd_ca0106_pcm *epcm;
+	unsigned long flags;
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	epcm = runtime->private_data;
+
 	chip->capture_channels[epcm->channel_id].use = 0;
 	/* FIXME: maybe zero others */
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 	return 0;
 }
 
@@ -759,8 +780,9 @@ static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 	struct snd_ca0106_pcm *epcm = runtime->private_data;
 	struct snd_ca0106_channel *pchannel;
 	int channel = epcm->channel_id, chi;
+	unsigned long flags;
 
-	spin_lock(&chip->pcm_lock);
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	epcm->hw_reserved = 0;
 	chip->count_pb_44100_chan = chip->count_pb_non_44100_chan = 0;
 	chip->count_pb_S16_chan = chip->count_pb_S32_chan = 0;
@@ -771,17 +793,17 @@ static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 		if (!pchannel->use)
 			continue;
 		if (snd_BUG_ON(!pchannel->epcm)) {
-			spin_unlock(&chip->pcm_lock);
+			spin_unlock_irqrestore(&chip->pcm_lock, flags);
 			return -EINVAL;
 		}
 		if (!pchannel->epcm->hw_reserved)
 			continue;
 		if (snd_BUG_ON(!pchannel->epcm->substream)) {
-			spin_unlock(&chip->pcm_lock);
+			spin_unlock_irqrestore(&chip->pcm_lock, flags);
 			return -EINVAL;
 		}
 		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
-			spin_unlock(&chip->pcm_lock);
+			spin_unlock_irqrestore(&chip->pcm_lock, flags);
 			return -EINVAL;
 		}
 		runtimei = pchannel->epcm->substream->runtime;
@@ -801,7 +823,7 @@ static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 		"any_non_44100=%d, spdif=%d.\n",
 		chip->count_pb_44100_chan, chip->count_pb_non_44100_chan,
 		emu->spdif_enable);
-	spin_unlock(&chip->pcm_lock);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 
 	return snd_pcm_lib_free_pages(substream);
 }
@@ -843,7 +865,9 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
+	unsigned long flags;
 	
+	spin_lock_irqsave(&emu->pcm_lock, flags);
 	/* FIXME CLEAN UP IF spdif_enable IS CHANGED WHILE CHANNELS ARE OPENED
 	 * OR PREVENT THIS FROM HAPPENING. */
 	if (emu->spdif_enable)
@@ -864,7 +888,6 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	/*printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",
 		emu->buffer.addr,emu->buffer.area, emu->buffer.bytes);*/
 	/* We are forced to build the settings for all the channels. */
-	spin_lock(&emu->pcm_lock);
 	emu->count_pb_44100_chan = emu->count_pb_non_44100_chan = 0;
 	emu->count_pb_S16_chan = emu->count_pb_S32_chan = 0;
 	for (chi = 0; chi < 4; ++chi) {
@@ -874,17 +897,17 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		if (!pchannel->use)
 			continue;
 		if (snd_BUG_ON(!pchannel->epcm)) {
-			spin_unlock(&emu->pcm_lock);
+			spin_unlock_irqrestore(&emu->pcm_lock, flags);
 			return -EINVAL;
 		}
 		if (!pchannel->epcm->hw_reserved)
 			continue;
 		if (snd_BUG_ON(!pchannel->epcm->substream)) {
-			spin_unlock(&emu->pcm_lock);
+			spin_unlock_irqrestore(&emu->pcm_lock, flags);
 			return -EINVAL;
 		}
 		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
-			spin_unlock(&emu->pcm_lock);
+			spin_unlock_irqrestore(&emu->pcm_lock, flags);
 			return -EINVAL;
 		}
 		runtimei = pchannel->epcm->substream->runtime;
@@ -979,14 +1002,14 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		reg71_set |= 0x3 << reg71_shift;
 		break;
 	default:
-		spin_unlock(&emu->pcm_lock);
+		spin_unlock_irqrestore(&emu->pcm_lock, flags);
 		printk(KERN_ERR DRVNAME
 			": prepare_playback: Bad sampling frequency %dHz.\n",
 			runtime->rate);
 		return -EINVAL;
 	}
 	if (count_pb_44100_chan && count_pb_non_44100_chan) {
-		spin_unlock(&emu->pcm_lock);
+		spin_unlock_irqrestore(&emu->pcm_lock, flags);
 		printk(KERN_ERR DRVNAME
 			"prepare_playback: requested sampling rate %dHz"
 			" conflicts with other selected sampling rates.\n",
@@ -994,7 +1017,7 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	}
 	if (count_pb_S16_chan && count_pb_S32_chan) {
-		spin_unlock(&emu->pcm_lock);
+		spin_unlock_irqrestore(&emu->pcm_lock, flags);
 		printk(KERN_ERR DRVNAME
 			"prepare_playback: requested sample format %d"
 			" conflicts with other selected sample formats.\n",
@@ -1025,7 +1048,7 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		hcfg_set = 0;
 		break;
 	}
-	spin_unlock(&emu->pcm_lock);
+	spin_unlock_irqrestore(&emu->pcm_lock, flags);
 	hcfg = inl(emu->port + HCFG) ;
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
@@ -1079,10 +1102,12 @@ static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
 	u32 reg71_mask = 0x0000c000 ; /* Global. Set ADC rate. */
 	u32 reg71_set = 0;
 	u32 reg71;
+	unsigned long flags;
 	
         //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
         //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
 	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+	spin_lock_irqsave(&emu->pcm_lock, flags);
 	/* reg71 controls ADC rate. */
 	switch (runtime->rate) {
 	case 44100:
@@ -1116,6 +1141,7 @@ static int snd_ca0106_pcm_prepare_capture(struct snd_pcm_substream *substream)
 		hcfg_set = 0;
 		break;
 	}
+	spin_unlock_irqrestore(&emu->pcm_lock, flags);
 	hcfg = inl(emu->port + HCFG) ;
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
@@ -1149,6 +1175,7 @@ static int snd_ca0106_pcm_trigger_playback(struct snd_pcm_substream *substream,
 	u32 basic = 0;
 	u32 extended = 0;
 	int running=0;
+	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1159,6 +1186,7 @@ static int snd_ca0106_pcm_trigger_playback(struct snd_pcm_substream *substream,
 		running=0;
 		break;
 	}
+	spin_lock_irqsave(&emu->pcm_lock, flags);
         snd_pcm_group_for_each_entry(s, substream) {
 		if (snd_pcm_substream_chip(s) != emu ||
 		    s->stream != SNDRV_PCM_STREAM_PLAYBACK)
@@ -1187,6 +1215,7 @@ static int snd_ca0106_pcm_trigger_playback(struct snd_pcm_substream *substream,
 		result = -EINVAL;
 		break;
 	}
+	spin_unlock_irqrestore(&emu->pcm_lock, flags);
 	return result;
 }
 
@@ -1199,7 +1228,9 @@ static int snd_ca0106_pcm_trigger_capture(struct snd_pcm_substream *substream,
 	struct snd_ca0106_pcm *epcm = runtime->private_data;
 	int channel = epcm->channel_id;
 	int result = 0;
+	unsigned long flags;
 
+	spin_lock_irqsave(&emu->pcm_lock, flags);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_ca0106_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_ca0106_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<channel));
@@ -1215,6 +1246,7 @@ static int snd_ca0106_pcm_trigger_capture(struct snd_pcm_substream *substream,
 		result = -EINVAL;
 		break;
 	}
+	spin_unlock_irqrestore(&emu->pcm_lock, flags);
 	return result;
 }
 
@@ -1451,6 +1483,7 @@ static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
 	int mask;
         unsigned int stat76;
 	struct snd_ca0106_channel *pchannel;
+	unsigned long flags;
 
 	status = inl(chip->port + IPR);
 	if (! status)
@@ -1460,6 +1493,7 @@ static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
 	//snd_printk("interrupt status = 0x%08x, stat76=0x%08x\n", status, stat76);
 	//snd_printk("ptr=0x%08x\n",snd_ca0106_ptr_read(chip, PLAYBACK_POINTER, 0));
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	for(i = 0; i < 4; i++) {
 		pchannel = &(chip->playback_channels[i]);
 		if (stat76 & mask) {
@@ -1487,6 +1521,7 @@ static irqreturn_t snd_ca0106_interrupt(int irq, void *dev_id)
 	        //printk(KERN_INFO "interrupt stat76[%d] = %08x, use=%d, channel=%d\n", i, stat76, pchannel->use, pchannel->number);
 		mask <<= 1;
 	}
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 
         snd_ca0106_ptr_write(chip, EXTENDED_INT, 0, stat76);
 
diff --git a/pci/ca0106/ca0106_mixer.c b/pci/ca0106/ca0106_mixer.c
index 3025ed1..6752a05 100644
--- a/pci/ca0106/ca0106_mixer.c
+++ b/pci/ca0106/ca0106_mixer.c
@@ -96,7 +96,9 @@ static int snd_ca0106_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int change = 0;
 	u32 mask;
+	unsigned long flags;
 
+	spin_lock_irqsave(&emu->pcm_lock, flags);
 	val = !!ucontrol->value.integer.value[0];
 	change = (emu->spdif_enable != val);
 	if (change) {
@@ -120,6 +122,7 @@ static int snd_ca0106_shared_spdif_put(struct snd_kcontrol *kcontrol,
 			outl(mask, emu->port + GPIO);
 		}
 	}
+	spin_unlock_irqrestore(&emu->pcm_lock, flags );
         return change;
 }
 
-- 
1.5.4.3
