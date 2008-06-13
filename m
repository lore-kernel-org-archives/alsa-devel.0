From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
	MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 16:57:13 +0100
Message-ID: <20080613155712.GA9955@rakim.wolfsonmicro.main>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
	<48528E81.2050901@freescale.com>
	<9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAD9F1037FD
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:57:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
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

On Fri, Jun 13, 2008 at 11:26:57AM -0400, Jon Smirl wrote:

[Dynamic clocking.]
> Intel HDA has a much better scheme for handling that via a fixed clock
> and skipping slots. I suspect I'll have to do some work on alsa to
> make this work.

As well adjusting things to support the widest range of sample rates you
also see this used in order to reduce power consumption.

> On 6/13/08, Timur Tabi <timur@freescale.com> wrote:

> >  > clock back to the CPU? Timur's device tree is the one with a codec
> >  > clock rate. Are there other parameters the system might need to set
> >  > into a codec?

> > The direction of the clock.  That's why I have "i2s-slave" in the SSI nodes.

Not just one clock, either - some devices support independent control of
the directions of frame and bit clocks, for example.  Other things that
can be configured include clock sharing, timeslot configuration for
buses with more than two devices, parameters for the PLLs and dividers 
in the internal clocking tree of the codec, clock outputs not associated
with an audio interface and jack detection.

For added fun, consider codecs with multiple I2S interfaces.

> There should be a way for the ssi driver to extract the parameters
> from the device tree and then feed them into the codec in an arch
> independent manner. The codecs need to stay arch independent. I
> haven't tried doing this yet in the code since I haven't needed setup
> parameters.

Could you explain in more detail why you want to do this in the SSI
driver in particular?  Trying to have a generic machine driver that
takes configuration from the device tree seems like a worthwhile goal
but I'm not clear what the gain from integrating this into the
controller driver is.
