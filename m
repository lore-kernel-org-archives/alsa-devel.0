From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 17:02:48 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309111623030.20181-100000@studcom.urz.uni-halle.de>
References: <200309111306.h8BD6Tfv007234@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200309111306.h8BD6Tfv007234@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Mark Knecht <mknecht@controlnet.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> >When an interrupt for MIDI input occurs, the hdsp driver disables all
> >further MIDI interrupts until the current input data has been read.
>
> the hdsp driver is one of the first alsa drivers to use tasklets to
> handle MIDI without impacting audio latency (that is, we can continue
> processing audio i/o even while MIDI i/o is pending). once we have
> launched a tasklet to handle MIDI input, there is no point handling
> more interrupts that tell us the same thing.
>
> the tasklet stuff relies on the kernel scheduler, but AFAIK, the
> tasklet effectively runs like the kernel equivalent of a SCHED_FIFO
> thread. i don't know at what priority, however.

AFAIK tasklets have higher priority than any user thread.

>From the error description I diagnose that either MIDI interrupts or
the MIDI tasklet are suppressed while jack is running. It shouldn't be
possible to prevent a tasklet from running unless the CPU usage is
100%, so I think it's somehow related to interrupts.

Maybe the hardware doesn't set (or clears) the MIDI bit when too many
PCM interrupts occur, but I'm just guessing here.


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
