From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 19:24:27 +0100
Message-ID: <4B32605B.6020909@gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
	<4B31D184.3020300@gmail.com>
	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
	<4B31FC67.2090201@gmail.com> <4B3247B4.4000506@kiilerich.com>
	<4B324E76.7040003@gmail.com> <20091223174009.GB21444@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 718382446C
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 19:24:37 +0100 (CET)
In-Reply-To: <20091223174009.GB21444@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mads Kiilerich <mads@kiilerich.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Dec 23, 2009 at 06:08:06PM +0100, Stefan Schoenleitner wrote:
> 
>> However, right now I found out that there seems to be no way
>> to execute *anything* each 20ms +/- 1ms.
>> [..]
> 
> I'd be somewhat surprised if any of them do any better to be honest.  A
> brief glance at the AT91 RTC drivers suggests they don't implement any
> sort of high resolution tick, HPET is an x86 thing and the others are
> likely to be implemented in terms of the same underlying constructs as
> the things you've tried already.

Thats not good.
I guess I will have to find a whole different approach then ?

>> I don't understand why all the function I have tried
>> so far have microsecond or even nanosecond precision and in the
>> end I'm off not for some nano- or microseconds, but for a full 15ms !
>> This is really bad :(
> 
> These APIs are all standards based ones.  The time units they use are
> deliberately chosen to be much smaller than might have realistically
> been used on systems when they were specified to allow room for systems
> with highly accurate timers that might come along, but they're all
> specified in terms of a minimum requested delay rather than a guaranteed
> accuracy.

I see, thanks for explaining.

> Much of the timing in Linux is based of HZ, which is often set quite low
> for power reasons.  As well as the scheduler it's probably also worth
> asking the AT91 port people how to get the best out of the hardware.  It
> may be that some work is needed to hook the port into the kernel time
> framework to better use the capabilities of the hardware, for example.

In your earlier post you mentioned that it might be a good idea to
reduce the accurate timing dependency (as the speech codec chip requires
160 samples each 20ms).

I found out that the chip can also be used in a "best effort" kind of
way in the sense that one just sends packets as fast as possible and it
will de-/compress them on the fly.
This way I would no longer need accurate timing for this, right ?
The data flow could be controlled by hardware handshaking as the chip
signals to the UART when it is ready to receive the next packet.

(Another way would be to just wait until a packet has been received from
the chip and then send the next one. The chip has a FIFO for 2x 160
samples.)

At a first glance this seems to solve my problems to some amount I guess.


However, in the end, for example when decompressing, I will end up with
lots of PCM samples that need to be played back.
Can I just send all these samples to ALSA (using the alsa io plugin) and
it will automatically play them correctly if the sampling rate and
format has been set up ?

I guess the framework will just wait until the PCM sample count
threshold has been reached and then start playing back the samples ?


Thanks for taking me in the right direction ;)

cheers,
stefan
