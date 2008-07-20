From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 18:19:24 -0400
Message-ID: <9e4733910807201519q5993e0e8l53a00288365ecdd6@mail.gmail.com>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
	<9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
	<20080720175631.GA6719@sirena.org.uk>
	<9e4733910807201147s4179adfbse34e56f2abe2541d@mail.gmail.com>
	<20080720191902.GB6719@sirena.org.uk>
	<9e4733910807201251j47757657o2dde7f71ebf9a5e@mail.gmail.com>
	<20080720214937.GD6719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id B9AC4244AD
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 00:19:25 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so175799yxh.2
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2008 15:19:24 -0700 (PDT)
In-Reply-To: <20080720214937.GD6719@sirena.org.uk>
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
> On Sun, Jul 20, 2008 at 03:51:20PM -0400, Jon Smirl wrote:
>
>  > > The issue is the time taken to do the I/O via the I2C bus, not the
>  > >  implementation in the chip - if anything I'd expect this to be slower
>  > >  than a direct hardware implementation but not perceptibly.  If
>  > >  applications try to step through all the values for a control with
>  > >  anything approaching the available resolution then that'd be a lot of
>  > >  data being written.  Like I say, it may not be a practical issue (I'd
>  > >  expect applications to be smarter) but it raised my eyebrows.
>
>  > Yes, stepping through 4096 volume levels individually would be a pain.
>  > A UI would need to initially move in larger increments.
>
>  > I have thought about building a pseudo interface for the chip that
>  > would be compatible with the existing ASLA controls, and then using an
>
>
> I'd just ignore it initially and if it's a problem look at doing things
>  like deferring the register writes by a short amount.  Most UIs won't be
>  able to display anything like the resolution required to cause trouble
>  in the first place - they are scaling the resolution of the control into
>  the resolution of the UI anyway.
>
>
>  > IOCTL to bypass for finer control. But isn't this problem going to
>  > reoccur as we encounter more HD audio level hardware?
>
>
> My own expectation would be that if it is a serious issue it'll be dealt
>  with in user space - my concern here was that the effects are being
>  magnified by the combination of the slow control bus and the large
>  registers that contain the controls.  As I say, it may not be a real
>  issue.
>
>
>  > > > 0x49-0x50, bass management
>  > >  > 4 bytes, contain 5.23 coefficients
>  > > OK, so the bass management looks like it should be able to fit in a
>  > >  processor word?
>
>  > If the word is 64 bits.
>
>
> Err...  you said it's 4 bytes?

>>The chip supports DRC (compression and expansion), some of the DRC
>>parameters are 48bits in 25.23 format. Loudness is 25.23 too.
>>0x92 and 0x94 are examples of 64 bit registers.

Most registers are 5.23. About eight of them are 25.23.  5.23 fits in
4 bytes, 25.23 (48bits) needs 2 words, 8 bytes.


>
>
>  > To support this chip you could add the concept of fields to ALSA
>
>
> ASoC?
>
>
>  > registers. Fields would be 32 bit. For backward compatibility the
>  > existing chips would just set field to 0.
>
>
> The use of a shift plus mask is largely a function of the fact that that
>  maps well onto how datasheets are usually written - I'm not sure that
>  using numbered fields would help there.  I'm also not sure that it's a
>  good idea to build the 32 bit assumption in - someone is bound to come
>  up with controls that are either larger that or cross a 32 bit boundary
>  within a register.
>

A better idea might be to expand the current 'shift' from 4 bits to 8
bits. And then allow masks for upto 64 bits. But this messes with the
current register interface since you would need to pass the value and
shift into the driver.

I have registers that are 256 bits. That's a 32 bit value with a shift of 224.
Another is 64 bits with a shift of zero.

The problem is encoding all of this into .private_value, it's too small.

I have to go read the control code since I don't know exactly how it
works. I haven't located any doc for it.



-- 
Jon Smirl
jonsmirl@gmail.com
