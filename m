From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 10:50:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309261450.h8QEoFGJ011344@oud>
References: <Pine.LNX.4.53.0309261631350.1362@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 26 Sep 2003 16:33:22 +0200."
             <Pine.LNX.4.53.0309261631350.1362@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, =?ISO-8859-1?Q?=22Dr=2E_med=2E_G=FCnther_Montag=22?= <Safari.Doktor@addcom.de>, alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>By the way, does JACK still rely on the float samples internally? Then it
>is not a good solution for the soft-modem application (driver) where
>everything should be highly optimized.

it does. on most modern CPUs, the FPU is as fast or faster than the
integer unit for arithmetic. the optimized float<->int/short
conversion we use consumes an infinitesimal number of cycles. and
besides, the fact that you'd probably have a context switch is a far
greater cost (though internal clients avoid this).

anyway, i don't advocate JACK for all uses - it was designed for
pro-audio primarily - but its basic design does demonstrate how to do
certain things that most people find really hard to do.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
