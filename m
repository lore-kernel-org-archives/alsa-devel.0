From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 12:14:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309261614.h8QGEQ3X011667@oud>
References: <3F746479.5040805@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 26 Sep 2003 18:08:25 +0200."
             <3F746479.5040805@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, James Courtier-Dutton <James@superbug.demon.co.uk>, =?ISO-8859-1?Q?=22Dr=2E_med=2E_G=FCnther_Montag=22?= <Safari.Doktor@addcom.de>, alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Paul Davis ha scritto:
>>>By the way, does JACK still rely on the float samples internally? Then it
>>>is not a good solution for the soft-modem application (driver) where
>>>everything should be highly optimized.
>> 
>> 
>> it does. on most modern CPUs, the FPU is as fast or faster than the
>> integer unit for arithmetic. the optimized float<->int/short
>
>According to my measurement your belief is definitely false for add/sub, 
>sometimes true for mul and very likely true for div.

my belief is based on measurements done by tomshardware, arstechnica
and others. that doesn't mean it can't be wrong.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
