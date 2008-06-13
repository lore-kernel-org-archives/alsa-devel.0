From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
	MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 21:04:53 +0100
Message-ID: <1213387493.6376.28.camel@odin>
References: <9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
	<48528E81.2050901@freescale.com>
	<9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
	<20080613155712.GA9955@rakim.wolfsonmicro.main>
	<9e4733910806130959m5cfbefbbo747642789190c285@mail.gmail.com>
	<20080613185942.GB12536@opensource.wolfsonmicro.com>
	<9e4733910806131225t7b40f3ado98b648b3f6798361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C65792447C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 22:04:47 +0200 (CEST)
In-Reply-To: <9e4733910806131225t7b40f3ado98b648b3f6798361@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-06-13 at 15:25 -0400, Jon Smirl wrote:
> On 6/13/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > On Fri, Jun 13, 2008 at 12:59:44PM -0400, Jon Smirl wrote:
> >
> >  > In the PowerPC world the ssi drivers are loaded based on the device
> >  > tree. When the ssi driver loads it gets passed in it's device tree
> >  > node and can see what codecs are on its bus.
> >  > Codecs get loaded two ways, if they are i2c based the i2c subsystem
> >  > loaded them. That's because of the PowerPC rule that the controlling
> >  > bus should load the driver. If it is an AC97/HDA codec, the ssi code
> >  > needs to trigger the loading since the AC97/HDA bus is the controlling
> >  > bus.
> >
> >
> > This is no different to any other system.
> >
> >
> >  > After the codec is loaded it may need parameters from the device tree.
> >  > My though was to have two mechanisms. First a very simple one where
> >  > the SSI driver just copies the parameters from the device tree into
> >  > the codec. That removes the need for platform specific code from the
> >  > codec driver.  The simple copy should be enough for AC97/HDA.
> >
> >  > In the second case the SSI would have a call out into the fabric code.
> >  > If the simple copy isn't enough the fabric code can do whatever
> >  > complicated things it needs to do. This is the case in my hardware,
> >  > the fabric driver needs to set up the external clock chip.
> >
> >
> > I'm not seeing much substantial difference between the two cases here:
> >  in both of them you look at the system and load a machine driver, it's
> >  just that in the first case the machine driver happens to be a generic
> >  one that gets more of what it needs from the device tree.
> 
> The idea was to allow the fabric driver to be optional for very simple
> hard. For example the Efika has simple hardware. It is a STAC9766
> hooked to a PSC. No GPIOs or special clocks are involved.  AC97 has
> registers for allowing the BIOS to indicate jack presence. Efika
> shouldn't need a fabric driver.
> 
> Everything except for the most basic system will need a fabric driver.
> I think being able to run with an optional fabric driver is a good
> test of having the design right.

The fabric is still required for most SoC based AC97 configurations.
Although for AC97 (basic stereo playback & capture) it's only really
used to map the DMA channel, irq & AC97 port to the codec (so it's
possible this could be optional or minimised in the future) and to
configure unused DAPM pins (to conserve power).

The main reason for AC97 fabric is when we want to do anything special
with AC97 (which we usually do in embedded systems - it's usually an
embedded codec's selling point!). Another benefit is for workarounds
(the AC97 spec has many grey area's that have been implemented
differently by different vendors).

AC97 implements better on Laptop/PC hardware because the spec is well
defined in the basic areas (i.e stereo playback and capture, 5.1
playback). 

> >
> >
> >  > The basic concept is that there is one SSI driver per device and a
> >  > single global fabric driver. So anything that needs to be done on a
> >  > per ssi case needs to go into the ssi driver. Making the soc
> >  > structures and attaching the codec is a per ssi task, so the code
> >
> >
> > Remember that if there's more than one SSI<->codec link they may not be
> >  independant of each other.  For example, a six channel DAC could be
> >  connected to three stereo I2S ports on the SoC with shared clock
> >  signals.  You can also get codec<->codec links (for example, separate
> >  ADC and DAC parts or Bluetooth devices) which bypass the SoC entirely.
> >
> >  It may be that you just intend to wrap all these cases up in your "or
> >  load a machine driver" case, I'm not clear.
> 
> Yes, anything but the most basic configuration ends up in the loading
> a fabric driver. I suspect all i2s setups will need one. AC97 and HDA
> may not.

I agree, all I2S & PCM setups will need fabric. HDA and Mipi won't due
to well defined specs whilst AC97 is the grey area. AC97 needs fabric on
some systems but not others.

Liam
