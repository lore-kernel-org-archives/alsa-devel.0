From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 23 Aug 2004 13:54:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408231349520.1801@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
 <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
 <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
 <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
 <4129D6A2.7020801@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E64F82C6
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 14:03:08 +0200 (MEST)
In-Reply-To: <4129D6A2.7020801@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Aug 2004, Adam Tla=B3ka wrote:

> > On Thu, 19 Aug 2004, Takashi Iwai wrote:
> >>Can "network sound device" work with the mmap, too?
> > I think yes, it can, but the real output will be more delayd. So, it wo=
n't=20
> > be much useable for the strict real-time applications.
> But old quake and new quake3 and some OSS apps use mmap mode for better=
=20
> timing and accurate mixing so will it be usable if done that way?

I already stated: If you want to use real-time applications, buy real-time=
=20
hardware.

> As talking about network transparency it is a good idea but what about=20
> more system independent solution - look at MASS for example
> (link from www.x.org).
> I personally think that local sound should be done as effective as it=20
> can be so doing it through network layer is not a nice idea - maybe IPC
> and non swappable shared memory should be used to transfer data
> between kernel and user space to used ALSA mix/asym advantages.

We can do a similar extension like xshm in X-window in the network sound=20
driver. You need always a "control" channel between kernel and user space.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
