From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Analog Devices AD193X I2S
	codec	family driver.
Date: Fri, 19 Sep 2008 13:36:53 +0100
Message-ID: <20080919123652.GA24700@sirena.org.uk>
References: <20080918130309.GA14895@roarinelk.homelinux.net>
	<20080918145445.GE4203@sirena.org.uk>
	<20080918160820.GA15917@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1945C244E2
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Sep 2008 14:36:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080918160820.GA15917@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2008 at 06:08:20PM +0200, Manuel Lauss wrote:

> > It'd be worth updating this comment to mention what you're doing with
> > the chip power in the standby state - it's unusual for the codec to be
> > held with so little power in standby mode that register writes don't
> > work, which is why this is a driver-specific thing.  I guess if DAPM
> > support were implemented then this wouldn't be required any more?

> The platform I developed this driver for can cut power to the codec
> and amplifiers (customer requirement: no audio is playing -- save as
> much power as possible, which the hardware engineer interpreted as
> cutting all electrical power to the whole audio subsystem).  To be
> honest I somewhat expect the I2S codec drivers to be able to cope with
> a situation such as this.

This is actually very unusual.  Most audio subsystems take a relatively
long time to power on cleanly, much longer than is generally considered
acceptable for doing on the start of every playback - things like
charging capacitors and stabalising reference voltages without
generating pops in the output can take hundreds of miliseconds which is
much longer thean the sort of latency people normally expect from direct
interaction with a device.  Similarly, fully powering down can also take
a noticable amount of time.  Even writing the registers back over a slow
bus like I2C can take longer than is desirable.  Maintaining the audio
subsystem in a steady state usually consumes very little power and
allows rapid startup of playback streams.

If this were being supported by the core it'd be done with something
like explicit calls to the codec drivers, probably the existing suspend
and resume callbacks since they already fulfil essentially this purpose.  
This would need to be requested by the machine driver in order to avoid
impacting machines that don't need it (not to mention those that don't
have appropriate power switches).

> The other thing is, I tried to implement finer-grained PM, but to be
> honest, after staring at the DAPM defines, it is still a mystery to
> me how that stuff is supposed to be hooked up.

Broadly speaking, you define a series of controls for the power switches
for elements of the codec that have power in much the same way as you
define other controls.  You then specify which 

Perhaps looking at an existing driver in conjunction with the datasheet
would help make things a bit clearer?  Most of the Wolfson devices have
public datasheets - off the top of my head the WM8900 is reasonably
complex and has a public datasheet.  As well as register information and
so on there's pictures of how things are connected together which are
useful to refer to along with the code.

> > This and some of the other code will force the ADC and DAC to have the
> > same configuration - is that needed by the codec?  If not then it'd be
> > better to check which substream it is operating on and only configure
> > the ADC or DAC as appropriate (you could save lots of conditionals by
> > only checking when actually writing the configuration out at the end of
> > the function).

> It's not mandated by the chip but rather my development platform (ADC and
> DAC have separate I2S lines; my test hardware has bit- and frameclock of
> both tied together).

Surely in that case the interfaces you have provided for configuring
non-shared LRCLK don't currently work?

> > With the code as it currently stands the codec should impose constraints
> > to let user space know that the playback and capture streams have to be
> > in the same mode.  There's examples of how to do that in cs4270,
> > ssm2602, wm8903 and possibly other drivers.

> In my case, the constraints should be imposed by the machine driver ;-)
> The codec doesn't really care.

The codec hardware looks like it doesn't but the current codec driver
will program both DAC and ADC clocks whenever a stream is configured so
the requirement is going to affect anyone using the codec driver
currently.

> > In general if the codec has clocking which can be configured as flexibly
> > as this one appears to then it's normally better to allow the machine
> > driver to configure the clocking manually via the clock configuration
> > APIs.

> Agreed; I didn't know I can actually do that with ASoCv1.

Quite a few of the existing drivers implement this model - most of the
WM89xx series except WM8903, for example.

> > > +#define AD1939_RATES	\
> > > +	(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
> > > +	 SNDRV_PCM_RATE_192000)

> > Your code appeared to support rather more rates than this?

> Theoretically it supports anything coming from the I2S frameclk line.
> How can I express that?

Currently ASoC can't cope with continuous rates so the best thing to do
would be use SNDDRV_PCM_RATE_8000_192000 which will add all the fixed
rates in that range.  TBH, it's very rare to see 

> > It's probably worth complaining if someone tries to set ad->mixpairs to
> > something more than 4.  It may be better to just not do this and leave
> > the controls exposed - why is this being done?

> Customer kept asking why alsa shows 4 stereo output mixer controls when
> actually only 2 are connected.

You might want to look at Takashi's recent patch to add a new API call
snd_ctl_activate_id() which provides a generic way of doing this without
requiring specific code like this be added to individual codec drivers
- it's in his unstable git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git

Your machine driver could use this rather than add it in the audio
driver.
