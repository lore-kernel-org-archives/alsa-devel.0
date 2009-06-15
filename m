From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance
	I2S and add	Left_J support)
Date: Mon, 15 Jun 2009 19:00:16 +0100
Message-ID: <20090615180016.GA20456@rakim.wolfsonmicro.main>
References: <20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10EE3103805
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 20:00:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245086420.24109.159.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 02:20:20PM -0300, Daniel Ribeiro wrote:

> But you have to consider that a codec that _requires_ 64 bits frames for
> 2*16bits I2S audio is not exactly I2S compliant.

Implementors in "not having fully read standard" shocker!  :)

Actually, I suspect what's happened here is that whoever was designing
the chip needed a synced clock at 64fs for their DAC or ADC, noticed
that they could run the bitclock over speed to get that clock and
decided to use that.  Most devices use a separate MCLK.

> Anyway, my interpretation of the I2S specifications, is that we don't
> need to do this enveloping thing at all. Codecs that requires this are
> simply broken, and are _not_ considering LRCLK edges as they are
> supposed to.

Broken and nonexistant are unfortunately not synonyms.  Like I say,
they're just using a subset of TDM mode configuration so it's not like
there's no possible use for this outside of workarounds anyway.

> But...

> Transmitter is sending 16 bits samples, and the receiver expecting 32
> bits samples. This is perfectly valid according to I2S, the receiver
> would append zeros to the LSBs of each sample.

> Now, what if the transmitter is using network mode? The receiver would
> interpret the 16 MSBs of the second slot as the 16 LSBs of the second
> channel on the first slot. This would be noisy. ;)

> I prefer to just not support network mode with I2S. I2S was designed to
> have a single transmitter and N receivers on the bus, or, in case of an
> I2S network have LRCLK assertion on all slots, which the PXA-SSP port
> can't do.

There's plenty of ways to mess up your audio if you do something broken,
I'm not overly concerned about this particular one over any of the
others so preserving the option to set it up seems useful.  As far as
your patch goes I think so long as it's clear how one would implement
I2S TDM it's fine, I don't think it's essential to implement it in your
patch since we don't have anything in-tree which needs it.

Personally I don't need this mode, the systems I'm working with all have
very much standards compliant CODECs which can be configured to use DSP
modes if desired.
