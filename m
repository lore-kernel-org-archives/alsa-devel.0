From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Monotonic timestamps
Date: Thu, 10 Apr 2008 16:26:45 +0200
Message-ID: <20080410142645.GB5852@tango.0pointer.de>
References: <20080409213602.GA2589@tango.0pointer.de>
	<Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 97A1A243B2
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 16:26:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10.04.08 09:48, Jaroslav Kysela (perex@perex.cz) wrote:

Hi,

> > The problem with this is that there seems to be no way to determine
> > from an application if monotonic timestamps are enabled in an
> > snd_pcm_t or not, ALSA just switches over to them, making the
> > timestamps relatively useless, because we cannot reliable relate them
> > to timestamps we query from the kernel ourselves -- because we just
> > don't know if we need to use CLOCK_MONOTONIC or CLOCK_REALTIME.
> 
> Application can just do a simple comparsion between ALSA timestamp and 
> gettimeofday() output. The gettimeofday() returns value since the Epoch, 
> but CLOCK_MONOTONIC returns time since start of system. Thus, it's really 
> easy to see if time matches or not (difference will be very big) to 
> detect the time source. Value from gettimeofday() does not make much sense 
> in audio (real time) environment.

Uh, this is a really ugly heuristic and is not compatible with the
CLOCK_MONOTONIC docs. Quoting from http://www.opengroup.org/onlinepubs/000095399/functions/clock_getres.html:

<snip>
If the Monotonic Clock option is supported, all implementations shall
support a clock_id of CLOCK_MONOTONIC defined in <time.h>. This clock
represents the monotonic clock for the system. For this clock, the
value returned by clock_gettime() represents the amount of time (in
seconds and nanoseconds) since an unspecified point in the past (for
example, system start-up time, or the Epoch). This point does not
change after system start-up time.
</snip>

i.e. it is not mandated by the standard that CLOCK_MONOTONIC is
measured from system bootup. Even more: it is suggested that it might
be relative to the epoch! In that case, distuingishing values returned
by CLOCK_MONOTONIC from CLOCK_REALTIME just by looking on them is
simply not possible.

Yes, I do fully agree that gettimeofday()/CLOCK_REALTIME is not a good
choice for audio programming. But still, the same way as the ALSA libs
fall back to CLOCK_REALTIME when CLOCK_MONOTONIC is not available I
need to do the same in PA. And I have to do it in the exact same
cases. However, I currently can't, since the decision is hidden
inside of ALSA, and the conditions (like the alsa kernel version) are
not really accessible from outside.

> > I find it very strange that ALSA just switches to monotonic timestamps
> > just like that, anyway. Programs written for wallclack timestamps will
> > break if they run on a system where ALSA uses monotonic timestamps!
> 
> It's true, but so far - I don't know about any program using timestamps in 
> serious way. Also, timestamps from gettimeofday() are not reliable (for 
> example when NTP time synchronization is used in system).

PA would use them in a serious way (to implement timer-based sched).

> > Could anybody please explain the difference between status->tstamp and
> > status->trigger_tstamp for me, please? The doxygen docs are bit too
> > terse on this, I fear.
> 
> I added just these words to trigger tstamp:
> 
> + * Trigger means a PCM state transition (from stopped to running or
> + * versa vice). It applies also to pause and suspend. In other words,
> + * timestamp contains time when stream started or when it was stopped.

Awesome, thanks a lot! This helped!

> The "now" tstamp is obvious, or not? It's just timestamp related to 
> current stream position reported in other ALSA functions.

Yes, that was clear to me.

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
