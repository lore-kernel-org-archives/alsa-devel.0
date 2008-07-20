From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 15:51:20 -0400
Message-ID: <9e4733910807201251j47757657o2dde7f71ebf9a5e@mail.gmail.com>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
	<9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
	<20080720175631.GA6719@sirena.org.uk>
	<9e4733910807201147s4179adfbse34e56f2abe2541d@mail.gmail.com>
	<20080720191902.GB6719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C41124492
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 21:51:21 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so407970ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2008 12:51:20 -0700 (PDT)
In-Reply-To: <20080720191902.GB6719@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/20/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 20, 2008 at 02:47:31PM -0400, Jon Smirl wrote:
>  > On 7/20/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>
> > >  also possible that the combination of large registers and high
>  > >  resolution fields within them may mean that special treatment is
>  > >  warranted in order to avoid blocking user applications too much with
>  > >  high volume register writes, but I'm not sure if that's a real issue or
>  > >  not.
>
>  > These chips are capable of processing 192K 24b HD quality audio.
>  > Datasheet http://www.ti.com/lit/gpn/tas5504
>  > Do the Intel HD audio chips have similar controls?
>
> A brief look suggests that there's nothing over 32 bits in the register
>  map.

Many of the registers are over 32 bits. They vary from 8 bits up to
1024 bits. Most of the large registers (1024 bit) contain multiple 32
bit fields. For example a 8x4 crossbar register is 1024 bits, it has 8
fields, each field is a 5.23 gain.

A the beginning of section 5 there is a table of  the registers and
their length in bytes.

>  > I believe the TI codecs are implemented with a combination of an 8051
>  > core controlling a DSP.  The i2c interface is talking to the 8051
>  > core, not real hardware registers. The 8051 takes the incoming i2c
>  > messages and stores them in RAM and uses the info to manipulate the
>  > DSP.
>
>
> The issue is the time taken to do the I/O via the I2C bus, not the
>  implementation in the chip - if anything I'd expect this to be slower
>  than a direct hardware implementation but not perceptibly.  If
>  applications try to step through all the values for a control with
>  anything approaching the available resolution then that'd be a lot of
>  data being written.  Like I say, it may not be a practical issue (I'd
>  expect applications to be smarter) but it raised my eyebrows.

Yes, stepping through 4096 volume levels individually would be a pain.
A UI would need to initially move in larger increments.

I have thought about building a pseudo interface for the chip that
would be compatible with the existing ASLA controls, and then using an
IOCTL to bypass for finer control. But isn't this problem going to
reoccur as we encounter more HD audio level hardware?

>  > > Are any of these 28 bit controls not in 32 byte registers?
>
> > 0x49-0x50, bass management
>  > 4 bytes, contain 5.23 coefficients
>
> > The chip supports DRC (compression and expansion), some of the DRC
>  > parameters are 48bits in 25.23 format. Loudness is 25.23 too.
>  > 0x92 and 0x94 are examples of 64 bit registers.
>
> OK, so the bass management looks like it should be able to fit in a
>  processor word?

If the word is 64 bits.

To support this chip you could add the concept of fields to ALSA
registers. Fields would be 32 bit. For backward compatibility the
existing chips would just set field to 0.

To change a mixer gain, would write a 32b value to field 4 of register
0x41. I can use my register cache inside the driver to update field 4
of the 1024b register and then rewrite the entire register.

There also needs to be the ability to read/write 64 bit values for DRC
and loudness.

-- 
Jon Smirl
jonsmirl@gmail.com
