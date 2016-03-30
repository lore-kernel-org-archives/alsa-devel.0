From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add support for TAS5720 digital
 amplifier
Date: Tue, 29 Mar 2016 21:53:18 -0500
Message-ID: <20160330025318.GB2073@borg.dal.design.ti.com>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
 <1458580107-4632-3-git-send-email-dannenberg@ti.com>
 <20160328190143.GC2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160328190143.GC2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
thanks for taking time reviewing the driver. Some comments below...

On Mon, Mar 28, 2016 at 08:01:43PM +0100, Mark Brown wrote:
> On Mon, Mar 21, 2016 at 12:08:27PM -0500, Andreas Dannenberg wrote:
> 
> > +static int tas5720_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> > +				  unsigned int freq, int dir)
> > +{
> > +	/*
> > +	 * Nothing to configure here for TAS5720. It's a simple codec slave.
> > +	 * However we need to keep this function in here otherwise the ASoC
> > +	 * platform driver will throw an ENOTSUPP at us when trying to play
> > +	 * audio.
> > +	 */
> > +
> > +	return 0;
> > +}
> 
> Remove empty funnctions, -ENOTSUPP is expected behaviour for anything
> that isn't explicitly supported by a driver.

Ok will double-check. Very early during my driver development I was not
able to play audio through aplay if this function was not provided. I
don't recall what specific Kernel version that was but it may have been
something like 4.1.

> 
> > +	if (unlikely(!tx_mask)) {
> 
> unlikely() is for optimising hot paths, just write the logic clearly
> unless there's a reason for it.

Got it. This was plagiarized from a similar driver but I agree this
is not a performance critical loop or something.

> > +static irqreturn_t tas5720_irq_handler(int irq, void *_dev)
> > +{
> > +	/*
> > +	 * Immediately disable TAS5720 FAULTZ interrupts inside the low-level
> > +	 * handler to prevent the system getting saturated or even overrun
> > +	 * by interrupt requests. Normally the fact that we create a threaded
> > +	 * interrupt with IRQF_ONESHOT should take care of this as by design
> > +	 * it masks interrupts while the thread is processed however testing
> > +	 * has shown that at the high frequency the FAULTZ signal triggers
> > +	 * (every 300us!) occasionally the system would lock up even with a
> > +	 * threaded handler that's completely empty until the Kernel breaks the
> > +	 * cycle, disables that interrupt, and reports a "nobody cared" error.
> > +	 *
> > +	 * Disabling the interrupt here combined with a deferred re-enabling
> > +	 * after the thread has run not only prevents this lock condition but
> > +	 * also helps to rate-limit the processing of FAULTZ interrupts.
> > +	 */
> > +	disable_irq_nosync(irq);
> 
> No, this is completely broken.  Whatever is going on in your system with
> the interrupt core you need to address that at the appropriate level not
> by putting a nonsensical bodge in here.  The interrupt is disabled while
> the threaded handler is running, if that's not having the desired effect
> then whatever causes that needs to be fixed.

Good feedback, I needed some outside guidance here. Definitely will dig
into this again but I'll be on vacation for a bit starting tomorrow so I
won't get to it right away.

As explained in the code comment even with a boiled-down test code that
has an empty threaded handler the system would come to a grinding halt
when bombarded with interrupts every 300us which I found odd but not
completely unexpected (from my MCU background POV that is). And while
digging I had seen that the interrupts do get disabled just like you
mention during threaded handling to operate in a more graceful manner.
But I wasn't sure at this point if the additional (high priority, I
suppose) overhead of creating/starting the thread (even an empty one)
every 300us was just too much for my poor single-core SoC to handle so
my assumption was that it never got cycles to process stuff other than
interrupts, and disabling interrupts in the low-level handler fixed just
that. But I'm going to spend some extra cycles trying to re-digest the
realtime behavior of my particular SoC/setup to understand why exactly
this is happening.

> 
> > +static int tas5720_dapm_post_event(struct snd_soc_dapm_widget *w,
> > +				   struct snd_kcontrol *kcontrol, int event)
> > +{
> > +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> > +	int ret;
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		/*
> > +		 * Check if the codec is still powered up in which case exit
> > +		 * right away also skipping the shutdown-to-active wait time.
> > +		 */
> > +		ret = snd_soc_test_bits(codec, TAS5720_POWER_CTRL_REG,
> > +					TAS5720_SDZ, 0);
> 
> I don't understand this.  Why on earth would we be calling the PMU
> handler if the widget was not previously powered? 
> 
> > +		/*
> > +		 * Take TAS5720 out of shutdown mode in preparation for widget
> > +		 * power up.
> > +		 */
> > +		ret = snd_soc_update_bits(codec, TAS5720_POWER_CTRL_REG,
> > +					  TAS5720_SDZ, TAS5720_SDZ);
> > +		if (ret < 0) {
> > +			dev_err(codec->dev, "error waking codec: %d\n", ret);
> > +			return ret;
> > +		}
> 
> This is a _POST_PMU handler not a pre-PMU handler...
> 
> > +	/* Events used to control the TAS5720 SHUTDOWN state */
> > +	SND_SOC_DAPM_PRE("Pre Event", tas5720_dapm_pre_event),
> > +	SND_SOC_DAPM_POST("Post Event", tas5720_dapm_post_event),
> 
> Oh, we're using _PRE() and _POST() events...  this almost certainly
> indicates a problem, there are very few circumstances where these are a
> good idea and I'm not seeing anything in this driver which indicates
> that this is going on.  Please just use normal DAPM widgets (I'm
> guessing a PGA) to represent the device and work within DAPM, don't
> shoehorn some bodge around the side.

I'm currently using these handlers to essentially tame the TAS5720 error
reporting. Only when the device is in shutdown mode it will seize
bombarding the host with 300us-spaced FAULT interrupts (that will come
as soon as the SAIF stream stops).  Unfortunately that's the way the
TAS5720 was designed and I've already provided feedback internally that
this makes an elegant / low-overhead SW implementation quite
challenging. Anyways I did see several places where this shutdown mode
handling could get added so I simply picked the one that was not directly
associated with the audio stream itself to make it more explicit what
this is about but this can certainly be changed.


Regards,

--
Andreas Dannenberg
Texas Instruments Inc

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
