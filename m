From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 11:12:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251612.i1PGCwGJ026975@dhin.linuxaudiosystems.com>
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

have any actual use cases?

>An audio hardware interrupt can interrupt any process at any time.
>Is there already a procedure in linux so that the interrupt_handler can 
>cause the scheduler to select a particular process to run immeadiately 
>after this interrupt_handler has finished?

of course. that's what conditional_reschedule() is all about. it
checks to see if any process of higher priority than the current one
has been marked runnable, and switches to it if so.

>I can see problems with the following setup: -
>Audio interrupt occurs
>Audio interrupt_handler finishes.
>Audio user space process get control of CPU.
>Some other interrupt occurs
>Some other interrupt_handler informs the scheduler to run xyz process next.
>Question: -
>Which process should be run next?
>Continue with the audio user space process, or start the new xyz process?

its all about scheduler priority. SCHED_FIFO is top dog, ranked by
priority within that. SCHED_RR is sort-of-next, again by priority, and
then finally SCHED_OTHER. 

if you run apps under JACK with the -R option, the right thing will happen.

--p


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
