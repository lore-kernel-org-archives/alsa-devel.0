From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 20:19:03 +0100
Message-ID: <20080720191902.GB6719@sirena.org.uk>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
	<9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
	<20080720175631.GA6719@sirena.org.uk>
	<9e4733910807201147s4179adfbse34e56f2abe2541d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F2A2A244B2
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 21:19:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807201147s4179adfbse34e56f2abe2541d@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 20, 2008 at 02:47:31PM -0400, Jon Smirl wrote:
> On 7/20/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> >  also possible that the combination of large registers and high
> >  resolution fields within them may mean that special treatment is
> >  warranted in order to avoid blocking user applications too much with
> >  high volume register writes, but I'm not sure if that's a real issue or
> >  not.

> These chips are capable of processing 192K 24b HD quality audio.
> Datasheet http://www.ti.com/lit/gpn/tas5504
> Do the Intel HD audio chips have similar controls?

A brief look suggests that there's nothing over 32 bits in the register
map.

> I believe the TI codecs are implemented with a combination of an 8051
> core controlling a DSP.  The i2c interface is talking to the 8051
> core, not real hardware registers. The 8051 takes the incoming i2c
> messages and stores them in RAM and uses the info to manipulate the
> DSP.

The issue is the time taken to do the I/O via the I2C bus, not the
implementation in the chip - if anything I'd expect this to be slower
than a direct hardware implementation but not perceptibly.  If
applications try to step through all the values for a control with
anything approaching the available resolution then that'd be a lot of
data being written.  Like I say, it may not be a practical issue (I'd
expect applications to be smarter) but it raised my eyebrows.

> > Are any of these 28 bit controls not in 32 byte registers?

> 0x49-0x50, bass management
> 4 bytes, contain 5.23 coefficients

> The chip supports DRC (compression and expansion), some of the DRC
> parameters are 48bits in 25.23 format. Loudness is 25.23 too.
> 0x92 and 0x94 are examples of 64 bit registers.

OK, so the bass management looks like it should be able to fit in a
processor word?
