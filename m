From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 9 Mar 2009 17:44:46 +0000
Message-ID: <20090309174443.GG13593@sirena.org.uk>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 398DB1037EF
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 18:44:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090309153629.GB24787@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 04:36:29PM +0100, Daniel Mack wrote:

> Mark says he'd rather like me to use/abuse the set_clk_div() interface
> for that but IMO that's an evil hack. The next CPU would need a similar
> thing to be used with this codec, so there should be a clean way to
> achive that.

The point here is that this is already fairly widely supported with some
combination of that approach and network mode and adding a third method
only makes things more complex, especially with more flexibile devices
which are capable of supporting combinations of these options - what
happens if the DAC and ADC clocks are separate and the user wants to
use that, for example?  How exactly does it play with TDM mode?

Worst case codec devices for this sort of stuff have clocking trees of
equivalent complexity to a SoC (eg, multiple roots, ability to select
between then at various points for various functions), multiple DAIs and
support a wide range of configurations on each DAI.

In your system a big part of the problem appears to be that you've got
two devices that have fairly exacting requirements with regard to clock
configuration (the CS4270 can only support one configuration involving
unused clock cycles while the PXA needs to know *exactly* what is being
input to it due to not directly implementing I2S).

I'm also slightly concerned with the use of a bitmask here since it
limits the set of clock counts that can be supported to a predefined set
of values but that's fairly minor.

It's probably worth pointing out that originally ASoC did have much more
complete clock handling in the core but this was removed due to the
difficulty in automatically working out exactly how to set things up in
complex configurations - it proved much more practical to have machine
drivers manually set everything up rather than try to tell the core
about all the clock trees.
