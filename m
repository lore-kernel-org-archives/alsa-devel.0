From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Sun, 29 Aug 2004 11:54:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408291135330.1778@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
 <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
 <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
 <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
 <4129D6A2.7020801@pg.gda.pl> <s5hoel1hny9.wl@alsa2.suse.de> <4130D8BF.8030502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3BC2523C
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 12:05:08 +0200 (MEST)
In-Reply-To: <4130D8BF.8030502@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 28 Aug 2004, Adam Tla=B3ka wrote:

> I imagine sound system as some layered structure:
>=20
> program
> |
> v
> dev -> redirecting, routing and up/down mixing kernel layer
>                 |                                           |
>                 v                                           v
>            kernel device driver                       net
>                 |
>                 v
>            hardware

It's kernel centristic view. I don't see much reasons to have everything=20
in kernel.

> in ALSA it looks like
>=20
> program
> |
> v
> alsalib (plugins for routing, resampling and mixing) -> kernel driver ->=
=20
> hardware
>                                                                     ->=20
> net (in the future)

What about this direct way: program -> alsa-lib -> net ?
I proposed network driver mainly to solve OSS redirecting problems.
We can implement this driver completely in user space.

> I prefer normal Unix way (device and standard functions plus ioctl) so
> if we can do a kernel module which does routing, redirecting and
> resampling on top of free OSS module we could obtain full functionality
> without any change in OSS programs.  But that's OSS not ALSA.
>=20
> In ALSA we need some kernel module which routes virtual OSS channels
> from kernel space to user space in ALSA lib emulation. I don't know how
> effective it will be but if we decided to mix in lib then this is the
> only way.
>=20
> By the way in ALSA README we read about full OSS ALSA compatibility.
> But this is not true!!!
> No mixer calls on dsp stream,

Huh, that's new for me. It does not work? It's implemented.

> no multichannel streams (4...7.1) are possible with OSS emulation,

Additional information which is moved to alsa-lib is required. Anyway,
actually almost all new applications requiring this feature support ALSA.

> DMA mode broken. I just can't abandon using OSS because of that :-(.

Could you specify which is broken with the kernel ALSA's OSS mmap=20
emulation?

> There are many sound daemons apps. I just don't want to link an app with
> all their libraries. It should just open and use sound device - kernel
> module should communicate with deamon to hide its presence before an app
> - that is the proper way IMHO. Standard Unix approach plus some message
> passing method if we can't do all in kernel.
>=20
> So what is the future of Linux sound??

Note that the direct device access is the major problem with the OSS API.
If a library which hide the direct syscalls exists, we never had such=20
problems to redirect OSS calls to our code. The library can be very=20
small. I already wrote an OSS redirector (alsa-oss/oss-redir) but it might=
=20
be that this project will be totaly ignored, because I am not able to
do much advertisements for all OSS developers to use these calls rather=20
than direct device accesses.

I feel that it's mainly about fixing bugs. Unfortunately, most of users
(including you) point me to quake binaries. I cannot run them on my
machines. The installation always fails at some point (OpenGL, missing
=2Ewad files for full quake version etc.). If you show me a little command
style code which triggers different bugs in the OSS emulation layer, I
promise, I will fix them.

Anyway, this call is to all people on this list. Could you create a Wiki
page which exact (version, source URL) OSS applications have trouble with:

1) ALSA's kernel OSS emulation
2) ALSA's aoss (libaoss)

It will also help me a lot to finish the OSS emulation and stop these=20
complains.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
