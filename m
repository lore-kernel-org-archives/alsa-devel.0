From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Wed, 06 Aug 2003 15:28:57 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F30F489.6010204@mindcom.fi>
References: <200308051417.h75EHwpr020319@localhost.localdomain>	<3F30156D.9060508@mindcom.fi> <s5hllu7koze.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllu7koze.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 05 Aug 2003 23:37:01 +0300,
> Antti Boman wrote:
> 
>>This seems like the problem I've always had with my single processor 
>>with JACK and SCHED_FIFO, with 2.4.20 kernel. I haven't tried the 
>>realtime setting for a while, though.
> 
> if the exactly same problem happens on UP, the cause would be
> different from what i thought originally.  my guess was spin dead
> locks or other SMP-specific issues, possibly around the linked pcm
> streams. 

It sounded as if it's the same problem, but naturally I don't know if 
it's caused by the same thing. I don't remember if it happened without X 
running, for example, so I have to test it without X, too. The 
frustrating part is that I really cannot debug anything, as the system 
completely locks up.

>>Maybe there's some other thing causing these? Should we gather a bit 
>>more in-depth information on our computers?
> 
> yes, this will help.
> at least, we need to investigate with the same driver/lib version
> (preferably with the same kernel and gcc).

Ok. I'll gather the information, do a few more tests, and post it on the 
list. I can also upgrade/downgrade the libs and programs if you think 
it's worth the while.

> btw, the dead-lock can be related to the lowlevel part, too.
> recently i found a bug in es1968 driver which can cause a dead-lock
> with linked streams and xrun (typically as jack does).  but in this
> case, it can happen regardless of SCHED_FIFO...

If you remember, I used to have huge problems with CMI8738 based 
integrated sound... "card", but they went away when installing newer 
ALSA drivers and libraries. Except from this SCHED_FIFO, of course.

Anyway, I'll first let you know about my current configuration, and you 
can tell me what to try.

Thanks,
-a



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
