From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 07 Aug 2003 09:22:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308071323.h77DMvQm027776@localhost.localdomain>
References: <Pine.LNX.4.44.0308070933030.861-100000@ecabase.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 07 Aug 2003 09:41:54 +0300."
             <Pine.LNX.4.44.0308070933030.861-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Do you get lockups if you use snd-dummy as the lowlevel driver? How about
>without ardour (just jackd and some example clients running)?

i'll have to try snd-dummy. and yes, it will happen with just jackd
alone. 

however, it will not happen unless jackd is run with SCHED_FIFO. my
system has been running for several days now with jackd there the
whole time. with SCHED_FIFO, i can't get more than about 10-15
minutes, or so it seemed.

the worrying thing here is that the problem may go back further in
time, because until qjackctl came along, my default was to run without
SCHED_FIFO, whereas with it the "default" is with SCHED_FIFO. this
means that SCHED_FIFO operation may not have been tested well enough
for quite a while (on my system, i mean). i do know that in further
back (months), i've run jackd+ardour with SCHED_FIFO for hours without
problems on this system.

--p



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
