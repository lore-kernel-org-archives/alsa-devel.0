From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 04 Aug 2003 13:55:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308041755.h74Htgdv017691@localhost.localdomain>
References: <NDBBLGIKBJENLAMOLFHGAEFGCOAB.mknecht@controlnet.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 04 Aug 2003 10:47:30 PDT."
             <NDBBLGIKBJENLAMOLFHGAEFGCOAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>This is probably a silly question, but have you tested this driver and
>option with an HDSP 9652 card at your site?
>
>The current driver in the Alsa 0.9.6 release doesn't work very well for me:
>
>1) Mono wave files work using aplay work fine.
>2) Stereo wave files using aplay crash Alsa requiring a reboot.
>3) Mono sound for games (presumably OSS emulation) seem to work.
>4) aplaplayer (straight or using Jack) produces audio 1 out of 20 times I
>use it, and then only for about a second or two.
>5) 1 out of 10 times starting an application (games mostly) that uses sound
>results in a process called 'ksoftirq_CPU0' using 70% of the CPU cycles and
>the machine becoming very, very slow. A reboot is required.

i haven't used the hdsp9652 very much, and i certainly don't ever use
it with aplay. i don't use aplay for anything, really. i've used it
for periods of time with ardour+JACK, but i am mostly using the
hdsp+digiface that is present as well.

as a side, i must note that i have a bad feeling about ALSA on SMP
systems right now as well. running JACK with SCHED_FIFO seems to be
relatively capable of inducing system lockups at the moment. without
SCHED_FIFO, it seems OK. this is running the Planet 2.4.21 kernel on a
dual PII.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
