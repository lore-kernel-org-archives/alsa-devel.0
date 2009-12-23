From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: need help with io plugin programming: how to
	add	delay ?
Date: Wed, 23 Dec 2009 17:40:10 +0000
Message-ID: <20091223174009.GB21444@sirena.org.uk>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
	<4B31D184.3020300@gmail.com>
	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
	<4B31FC67.2090201@gmail.com> <4B3247B4.4000506@kiilerich.com>
	<4B324E76.7040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D96AC1038B5
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 18:40:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B324E76.7040003@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: Mads Kiilerich <mads@kiilerich.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 23, 2009 at 06:08:06PM +0100, Stefan Schoenleitner wrote:

> However, right now I found out that there seems to be no way
> to execute *anything* each 20ms +/- 1ms.

> So far I tried

> 	* nanosleep()
> 	* pthread_cond_timed_wait()
> 	* usleep()

> I'm looking forward to try

> 	* HPET
> 	* RTC
> 	* setitimer()
> 	* alsa timers ?
> 	* anything else ?

I'd be somewhat surprised if any of them do any better to be honest.  A
brief glance at the AT91 RTC drivers suggests they don't implement any
sort of high resolution tick, HPET is an x86 thing and the others are
likely to be implemented in terms of the same underlying constructs as
the things you've tried already.

> I don't understand why all the function I have tried
> so far have microsecond or even nanosecond precision and in the
> end I'm off not for some nano- or microseconds, but for a full 15ms !
> This is really bad :(

These APIs are all standards based ones.  The time units they use are
deliberately chosen to be much smaller than might have realistically
been used on systems when they were specified to allow room for systems
with highly accurate timers that might come along, but they're all
specified in terms of a minimum requested delay rather than a guaranteed
accuracy.

Much of the timing in Linux is based of HZ, which is often set quite low
for power reasons.  As well as the scheduler it's probably also worth
asking the AT91 port people how to get the best out of the hardware.  It
may be that some work is needed to hook the port into the kernel time
framework to better use the capabilities of the hardware, for example.
