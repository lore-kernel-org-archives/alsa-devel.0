From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Sat, 28 Aug 2004 21:10:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4130D8BF.8030502@pg.gda.pl>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>	<1092842830.13603.3.camel@localhost.localdomain>	<20040818181350.2b38e875@mango.fruits.de>	<Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>	<20040818201535.1f49a128@mango.fruits.de>	<Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>	<s5h8ycbv4s9.wl@alsa2.suse.de>	<Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>	<4129D6A2.7020801@pg.gda.pl> <s5hoel1hny9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E044523D
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2004 21:11:45 +0200 (MEST)
Received: from pg.gda.pl (host-ip149-240.crowley.pl [62.111.240.149])
	(authenticated bits=0)
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i7SJBdqO016418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2004 21:11:44 +0200 (CEST)
In-Reply-To: <s5hoel1hny9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[2004-08-23 17:30] Takashi Iwai:
>>>>Can "network sound device" work with the mmap, too?
>>>I think yes, it can, but the real output will be more delayd. So, it won't 
>>>be much useable for the strict real-time applications.
If "network" mode for OSS ALSA emulation in kernel will give us worse
results than real OSS then I prefer to use real OSS drivers :-(
- on the same machine. Playing quake or other MMAP mode games with
networked sound  is not a real target anyway.

> effects.  Hence, what I see here is only the demand of
> "compatibility".  From the performance perspective, there is no reason
> to force mmap.
Of course I agree with that. It can't be perfect because of emulation but
should be here for some old apps - and should work properly with them.


I imagine sound system as some layered structure:

program
|
v
dev -> redirecting, routing and up/down mixing kernel layer
                |                                           |
                v                                           v
           kernel device driver                       net
                |
                v
           hardware

in ALSA it looks like

program
|
v
alsalib (plugins for routing, resampling and mixing) -> kernel driver -> 
hardware
                                                                    -> 
net (in the future)

I prefer normal Unix way (device and standard functions plus ioctl) so 
if we can
do a kernel module which does routing, redirecting and resampling on top of
free OSS module we could obtain full functionality without any change
in OSS programs.  But that's OSS not ALSA.

In ALSA we need some kernel module which routes virtual OSS channels from
kernel space to user space in ALSA lib emulation. I don't know how effective
it will be but if we decided to mix in lib then this is the only way.

By the way in ALSA README we read about full OSS ALSA compatibility.
But this is not true!!!
No mixer calls on dsp stream, no multichannel streams (4...7.1)
are possible with OSS emulation, DMA mode broken.
I just can't abandon using OSS because of that :-(.

There are many sound daemons apps.
I just don't want to link an app with all their libraries. It should 
just open
and use sound device - kernel module should communicate with deamon
to hide its presence before an app - that is the proper way IMHO.
Standard Unix approach plus some message passing method if we can't
do all in kernel.

So what is the future of Linux sound??

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
