From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 07 Aug 2003 14:30:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308071830.h77IUqLX028995@localhost.localdomain>
References: <1060280740.16467.24.camel@cmn37.stanford.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "07 Aug 2003 11:25:40 PDT."
             <1060280740.16467.24.camel@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: John Anderson <ardour@semiosix.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>There was a small program posted by Roger Larsson that monitored
>processes running with SCHED_FIFO and if one of them hogged cpu for more
>than a number of seconds it would get downgraded to SCHED_OTHER. If the
>bug is a lockup due to SCHED_FIFO this may revive the machine after it
>hangs (it did that for me when I was poking around trying to find the
>cause of lockups that latter were solved by Andrew Morton). 

true, but JACK almost does this by itself. when run with -R, a highpri
SCHED_FIFO task runs every 5 (?) seconds, and requires that the engine
has checked in since the last time. this prevents loops within JACK
from stalling the entire system.

anyway, the fact that ctrl-alt-sysrq doesn't work either is a good
indication of a deeper problem than a runaway SCHED_FIFO task. i think.

--p


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
