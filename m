From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: PCM_RATE: Check for KNOT and
 CONTINUOUS flags
Date: Fri, 12 Mar 2010 16:57:21 +0000
Message-ID: <20100312165721.GA22822@rakim.wolfsonmicro.main>
References: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
	<20100312111613.GA21260@rakim.wolfsonmicro.main>
	<1b68c6791003120432j26fa5c43nfb7ee34c9b7d75c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9DA21037F3
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 17:57:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003120432j26fa5c43nfb7ee34c9b7d75c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 12, 2010 at 09:32:14PM +0900, jassi brar wrote:

>  Usually even the non-standard rates, those not explicitly mentioned in the
> chip's manual, are possible to generate given a suitable source of clock and
> this source clock usually closely depends on the board/machine.

Immediately catastrophic failure at non-standard sample rates is
unusual, but that doesn't mean that it devices are going to run well or
reliably if driven out of spec.  This is especially true with modern
devices where you've got a reasonable amount of DSP going on in the
device since that tends to involve sample rate dependant coefficients
which degrade performance (often substantially, sometimes in a signal
dependant fashion) when misconfigured.

> That suggests having the MACHINE driver decide which rates would
> be supported on it (as only it knows cpu/codec dais and the source of clocks).

You've got to remember that most machine driver developers don't have
any current understanding of audio clocking requirements and often find
it's more trouble than it's worth to get up to speed with them, never
mind that without specialised test equipment or an expert ear it is hard
to assess the impact on performance of the configuation decisions that
have been taken.

Where there are constraints it's much easier for machine drivers to
specify the clocks that are being fed into the devices and have the
drivers work out their own constraints as much as possible, that's
something that's more directly visible and understandable to users than
the resulting sample rates.  Currently CODEC drivers could do more of
this, though in practice the increased flexibility of modern designs is
making the problem go away anyway.

> But functions seem overkill, the machine driver could already extract supported
> rates from cpu_dai and codec_dai members of the dai_link.

There's currently no way to express anything except either a bitmask of
the standard rates or a single continuous range so _KNOT is potentially
a bit tricky (though actually I think ALSA does the right thing with
constraints provided by function at startup so actually we're probably
OK with the existing API).

> So, imho, rates specified by dais should be used only by the machine driver
> which, after considering the design and purpose of the device, provide a list of
> supported rates to the ASoC. Of course, soc-core.c would need to be modified.

I wouldn't be completely opposed to allowing this as an option for
anybody who really wants it but I really don't think it'd be a postive
move to pull the existing support out, it would at best make more work
for machine drivers and I would expect it to increase the number of
misconfigured Linux systems out there.
