From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance
	I2S and add	Left_J support)
Date: Mon, 15 Jun 2009 19:40:37 +0200
Message-ID: <20090615174037.GH32700@buzzloop.caiaq.de>
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
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 78233103806
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 19:40:42 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 02:20:20PM -0300, Daniel Ribeiro wrote:
> But you have to consider that a codec that _requires_ 64 bits frames for
> 2*16bits I2S audio is not exactly I2S compliant.
> 
> Quoting the specifications:

[...]

Might be, but it's still up to the codec which further constrains it has
for the digital side :)

> Anyway, my interpretation of the I2S specifications, is that we don't
> need to do this enveloping thing at all. Codecs that requires this are
> simply broken, and are _not_ considering LRCLK edges as they are
> supposed to.

Quoting from the CS4270 datasheet:

5.1.2 Master/Slave Mode 
  The CS4270 supports operation in either Master Mode or Slave Mode. 

  In Master Mode, LRCK and SCLK are outputs and are synchronously
  generated on-chip. LRCK is equal to Fs and SCLK is equal to 64x Fs. 

  In Slave Mode, LRCK and SCLK are inputs, requiring external generation
  that is synchronous to MCLK. It is recommended that SCLK be 48x or 64x
  Fs to maximize system performance. 

I can only guess what really happens internally, but the most obvious
thing is that they need the additional clock cycles for internal
real-time processing.

> And finally, if the codec does this enveloping thing, it can't work if
> PXA is slave of LRCLK. The PXA-SSP port is definitely not I2S compliant,
> as it just ignores the LRCLK falling edge. We can workaround this using
> network mode with 4 slots and with slots 1|3 active, but this implies
> knowing the sample/frame width in advance, which by itself is an I2S
> spec violation.

Yes, that's true. For that very reason, we run the PXA in master mode,
but clock the whole SSP engine from the SSPEXTCLK pin. So the PXA is
master to LRCLK and BITCLK, but eventually it's still slave to an
external and tunable clock.

> I have hope that Daniel Mack's codec, which supposedly only works with
> 64 bits frames _is_ I2S compliant, and he just got to the wrong
> conclusion that it needs 64 bits frames after a lot of trial and error,
> and failing to fix the real issue. (setting 16bits frames(DataSize(16))
> for 2*16bit samples is simply wrong).

I'm willing to give that another try now that the codec is in slave
mode. But I fear there is some impact on the audio quality which I can't
quickly measure here, so I'd really vote for offering the mode I'm
currently using. Forbidding it due to API clearance even though it's
supported by the hardware is a step backwards.

Daniel
