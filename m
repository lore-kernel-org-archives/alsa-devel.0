From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 11:10:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251610.i1PGA6qe026956@dhin.linuxaudiosystems.com>
References: <403CC75C.5070409@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 25 Feb 2004 16:03:40 GMT."
             <403CC75C.5070409@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Adam Tla/lka <atlka@pg.gda.pl>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It would still be nice to have a system clock based interval process for 
>applications that require activity at specific intervals, but are not to 
>do with sound or video.

i'd be interested to see a realistic usage case. its mostly related to
RT devices of some kind, most of which provide their own interrupt,
and they expect to be serviced ASAP wrt the interrupt.

>An audio hardware interrupt can interrupt any process at any time.
>Is there already a procedure in linux so that the interrupt_handler can 
>cause the scheduler to select a particular process to run immeadiately 
>after this interrupt_handler has finished?

of course. this is what SCHED_FIFO is all about, plus the lowlat
patches. conditional_reschedule() checks to see if a highpri process
has been marked runnable, and if so, switches to it (or rather, makes
sure that the return to user space returns to the new process).

>I can see problems with the following setup: -
>Audio interrupt occurs
>Audio interrupt_handler finishes.
>Audio user space process get control of CPU.
>Some other interrupt occurs
>Some other interrupt_handler informs the scheduler to run xyz process next.
>Question: -
>Which process should be run next?
>Continue with the audio user space process, or start the new xyz process?

its all about sched priority. SCHED_FIFO is top of the pile, and
within that, highest priority wins. SCHED_RR is next (sort of), and
then regular scheduling (SCHED_OTHER) after that.

if you run audio apps with JACK, the right thing will happen 99.9999%
of the time. the tiny percentage that it doesn't is caused by kernel
bugs (if it happens at all).

--p


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
