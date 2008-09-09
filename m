From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: [PATCH 1/2] ca0106
	playback	44100Hz	support	to	SPDIF	and	playback	format & rate
	constraints
Date: Wed, 10 Sep 2008 07:13:17 +1000
Message-ID: <1220994797.7459.208.camel@localhost>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de> <1219502224.15980.32.camel@localhost>
	<s5h7ia5dpe0.wl%tiwai@suse.de> <1220375467.7459.8.camel@localhost>
	<s5hbpz5pni5.wl%tiwai@suse.de> <1220454947.7459.70.camel@localhost>
	<s5hod2yptvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 36776103871
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 23:13:23 +0200 (CEST)
In-Reply-To: <s5hod2yptvl.wl%tiwai@suse.de>
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

Just a quick note:

The current version of my patch causes kernel lockups.

I have not yet figured out how to debug this.

I will do some research, possibly compile a debug kernel with the magic
sysreq key enabled or something. I need to figure out where it is
locking up. Any hints appreciated.

For now I have reverted to an earlier version of the patch before I
included the spinlocks, and I now get no lockups. The machine is in
daily use running MythTV. However, only one of the four outputs is in
regular use. (My card only has one connection on the back, anyway.)

But perhaps you could tell by examining my locking code whether I have
broken some cardinal rule.

I already found a bug in an error path in prepare where I forgot to
unlock.

Thanks,
Ben Stanley.

On Mon, 2008-09-08 at 16:58 +0200, Takashi Iwai wrote:
> At Thu, 04 Sep 2008 01:15:47 +1000,
> Ben Stanley wrote:
> > 
> > Takashi,
> > 
> > Thankyou for your comments.
> > 
> > My modifications would be much simpler if I didn't have to re-build the
> > counts of how many channels are in each mode every time the prepare and
> > hw_free functions are called. 
> > 
> > In the case of the prepare function, I could modify the existing counts
> > if I knew what the previous state (rate, format) was before the most
> > recent change.
> > 
> > In the case of the hw_free function, I think that the rate and format
> > information is invalid for the current channel by the time the hw_free
> > function is called.
> > 
> > If I knew these pieces of information, I could completely avoid
> > re-building the counts.
> > 
> > Regarding the locking, initially I only tried to protect my count
> > fields. I have now tried to work on the locking some more (see
> > incremental untested patch at end). Each time I learn some more...
> > thanks for your patience. Perhaps there is another driver that already
> > has to do this level of locking that you could point me to look at. The
> > other drivers I have looked at so far don't have to do this much
> > locking. (I gather that means they are designed to avoid the need to
> > lock?)
> 
> There must be some, but each driver has different things :)
> 
> > Regarding atomicity, the documentation states that
> > snd_ca0106_pcm_trigger_capture, snd_ca0106_pcm_pointer_playback,
> > snd_ca0106_pcm_pointer_capture are called with a spinlock held by the
> > middle layer. What lock is that?
> 
> It's PCM substream lock.
> 
> > Do I need to hold my spinlock in
> > addition? Will that possibly cause deadlock if the spinlocks are grabbed
> > in different orders? So many questions...
> 
> Yes, you need another type of lock because PCM substream lock is
> specific to each substream, and you need a global lock over all
> substreams.  
> 
> > Regarding snd_BUG_ON, I have used it like an assert, intending that it
> > should be turned off in normal production code. Is that not the case?
> 
> The problem is that some checks should be done even for the production
> system, not only for debugging.  At least, exclusivity of
> 44.1kHz/48kHZ rates should be checked always, because the hardware
> constraint can be racy.
> 
> > > > +	spin_lock(&chip->pcm_lock);
> > > > +	if (chip->spdif_enable) {
> > > > +		if (snd_BUG_ON(chip->count_pb_44100_chan &&
> > > > +			 chip->count_pb_non_44100_chan)) {
> > > > +			spin_unlock(&chip->pcm_lock);
> > > > +			return -EINVAL;
> > > > +		}
> > > 
> > > Don't use too much snd_BUG_ON().  This would be better to be a
> > > normal check since we have anyway races in parameter constraints,
> > > and this may happen indeed.
> > 
> > This is just asserting the invariants, and it did find some problems
> > during development. This condition should not be triggered by the races
> > in parameter constraints,
> 
> ... but this could happen because of races, I'm afraid.
> 
> > > > @@ -647,6 +754,55 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
> > > >  /* hw_free callback */
> > > >  static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
> > > >  {
> > > > +	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
> > > > +	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
> > > > +	struct snd_ca0106_pcm *epcm = runtime->private_data;
> > > > +	struct snd_ca0106_channel *pchannel;
> > > > +	int channel = epcm->channel_id, chi;
> > > > +
> > > > +	spin_lock(&chip->pcm_lock);
> > > > +	epcm->hw_reserved = 0;
> > > > +	chip->count_pb_44100_chan = chip->count_pb_non_44100_chan = 0;
> > > > +	chip->count_pb_S16_chan = chip->count_pb_S32_chan = 0;
> > > > +	for (chi = 0; chi < 4; ++chi) {
> > > > +		if (chi == channel)
> > > > +			continue;
> > > > +		pchannel = &(chip->playback_channels[chi]);
> > > > +		if (!pchannel->use)
> > > > +			continue;
> > > > +		if (snd_BUG_ON(!pchannel->epcm)) {
> > > > +			spin_unlock(&chip->pcm_lock);
> > > > +			return -EINVAL;
> > > > +		}
> > > 
> > > snd_BUG_ON() is wrong here.  Note that pchannel->epcm isn't protected 
> > > at all by chip->pcm_lock in your patch because it's not used in
> > > *_open() and *_close() callbacks.  Use the lock to protect the
> > > assignment of these.
> > > 
> > 
> > Hmmm... The open callback allocates a new snd_ca0106_pcm by kmalloc, but
> > the close callback does not kfree it. Is that a leak? Oh, I see that it
> > is kfreed by snd_ca0106_pcm_free_substream.
> > 
> > I can't find any other part of the driver that writes to the epcm field.
> > Furthermore, I observe that the use field is set to 1 before epcm field
> > is assigned. So perhaps the lock should cover this case.
> 
> That's a part of the problem.  It can run between use = 1 and epcm set.
> 
> > It is not quite the same between hw_free and prepare, as the prepare
> > function takes special care to check whether what is requested fulfils
> > the constraints. If it satisfies the constraints, it is configured. The
> > check and the configuration are performed atomically.
> > 
> > So it looks very similar between the two, but is subtly different.
> > Perhaps I can code both versions in one function.
> > 
> > Incremental untested patch trying to address the locking is shown below.
> > I'm sure you'll find things you don't like :-). Please ignore the other
> > issues outlined above for the moment - I will work on addressing your
> > other comments another night. Please review the locking.
> 
> I'll check the patch later (now busy during attending conference...)
> 
> 
> Thanks!
> 
> Takashi
