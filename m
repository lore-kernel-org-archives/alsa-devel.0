From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 4 Aug 2003 10:47:30 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEFGCOAB.mknecht@controlnet.com>
References: <200308041727.h74HRV8J017302@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200308041727.h74HRV8J017302@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >Paul,
> >   Did this driver & no_mixer option get into Alsa 0.9.6?
>
> haven't submitted them yet. i've been too busy rebuilding my systems,
> recabling the studio and dealing with a nasty buyer of my old
> house. this week, for sure.
>
Thanks for the answer.

This is probably a silly question, but have you tested this driver and
option with an HDSP 9652 card at your site?

The current driver in the Alsa 0.9.6 release doesn't work very well for me:

1) Mono wave files work using aplay work fine.
2) Stereo wave files using aplay crash Alsa requiring a reboot.
3) Mono sound for games (presumably OSS emulation) seem to work.
4) aplaplayer (straight or using Jack) produces audio 1 out of 20 times I
use it, and then only for about a second or two.
5) 1 out of 10 times starting an application (games mostly) that uses sound
results in a process called 'ksoftirq_CPU0' using 70% of the CPU cycles and
the machine becoming very, very slow. A reboot is required.

I updated Alsa on Sunday via Portage under Gentoo.

As has been the case for quite a long time, the picture isn't very pretty.
Wondering if you're seeing anything like this?

Thanks,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
