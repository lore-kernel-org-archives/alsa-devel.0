From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 12:59:44 -0400
Message-ID: <9e4733910806130959m5cfbefbbo747642789190c285@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
	<48528E81.2050901@freescale.com>
	<9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
	<20080613155712.GA9955@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 66D262448D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 18:59:51 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2186810ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 09:59:44 -0700 (PDT)
In-Reply-To: <20080613155712.GA9955@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 13, 2008 at 11:26:57AM -0400, Jon Smirl wrote:
>
>  [Dynamic clocking.]
>
> > Intel HDA has a much better scheme for handling that via a fixed clock
>  > and skipping slots. I suspect I'll have to do some work on alsa to
>  > make this work.
>
>
> As well adjusting things to support the widest range of sample rates you
>  also see this used in order to reduce power consumption.
>
>
>  > On 6/13/08, Timur Tabi <timur@freescale.com> wrote:
>
>
> > >  > clock back to the CPU? Timur's device tree is the one with a codec
>  > >  > clock rate. Are there other parameters the system might need to set
>  > >  > into a codec?
>
>  > > The direction of the clock.  That's why I have "i2s-slave" in the SSI nodes.
>
>
> Not just one clock, either - some devices support independent control of
>  the directions of frame and bit clocks, for example.  Other things that
>  can be configured include clock sharing, timeslot configuration for
>  buses with more than two devices, parameters for the PLLs and dividers
>  in the internal clocking tree of the codec, clock outputs not associated
>  with an audio interface and jack detection.
>
>  For added fun, consider codecs with multiple I2S interfaces.
>
>
>  > There should be a way for the ssi driver to extract the parameters
>  > from the device tree and then feed them into the codec in an arch
>  > independent manner. The codecs need to stay arch independent. I
>  > haven't tried doing this yet in the code since I haven't needed setup
>  > parameters.
>
>
> Could you explain in more detail why you want to do this in the SSI
>  driver in particular?  Trying to have a generic machine driver that
>  takes configuration from the device tree seems like a worthwhile goal
>  but I'm not clear what the gain from integrating this into the
>  controller driver is.

In the PowerPC world the ssi drivers are loaded based on the device
tree. When the ssi driver loads it gets passed in it's device tree
node and can see what codecs are on its bus.
Codecs get loaded two ways, if they are i2c based the i2c subsystem
loaded them. That's because of the PowerPC rule that the controlling
bus should load the driver. If it is an AC97/HDA codec, the ssi code
needs to trigger the loading since the AC97/HDA bus is the controlling
bus.

Note that on the mpc5200 there are separate drivers for psc chip in
the different modes. Instead of having a unified ssi driver, there are
uart, ac97, i2s, irda, etc drivers.  Each of these drivers configures
the psc in to the correct mode when they load. (I think Timur has a
unified driver, I don't work with his hardware).

After the codec is loaded it may need parameters from the device tree.
My though was to have two mechanisms. First a very simple one where
the SSI driver just copies the parameters from the device tree into
the codec. That removes the need for platform specific code from the
codec driver.  The simple copy should be enough for AC97/HDA.

In the second case the SSI would have a call out into the fabric code.
If the simple copy isn't enough the fabric code can do whatever
complicated things it needs to do. This is the case in my hardware,
the fabric driver needs to set up the external clock chip.

The basic concept is that there is one SSI driver per device and a
single global fabric driver. So anything that needs to be done on a
per ssi case needs to go into the ssi driver. Making the soc
structures and attaching the codec is a per ssi task, so the code
should go into the ssi driver. There's on a single, global fabric
driver, that's why Timur had to add a loop initializing the ssi
drivers.


>


-- 
Jon Smirl
jonsmirl@gmail.com
