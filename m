From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 23 Aug 2004 16:39:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408231633260.1801@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de>
 <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de>
 <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz>
 <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz>
 <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz>
 <4129D6A2.7020801@pg.gda.pl> <Pine.LNX.4.58.0408231349520.1801@pnote.perex-int.cz>
 <4129E473.6070702@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3F561AF
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 16:48:04 +0200 (MEST)
In-Reply-To: <4129E473.6070702@pg.gda.pl>
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

On Mon, 23 Aug 2004, Adam Tla=B3ka wrote:

> > I already stated: If you want to use real-time applications, buy real-t=
ime=20
> > hardware.
> They are rather normal user applications then specialized RT apps - I=20
> don't want to buy specialized hardware just to play some games
> or mix system sounds with browser and communicator apps sounds.

Quake is special case. For standard applications, the mixing should be=20
provided, but there're not latency issues.

I still think that the aoss library can be fixed so that quake will work.
I think that OSS/Commercial also adds some delay on their "virtual"=20
devices mixed together.

> Also switching two, 4 or 5.1 mode and headphone mode should be done
> just by one click without application restarting. So down/up mixing
> should be in a driver. I think it can't be done with todays ALSA in lib=
=20
> functionality approach and never will be.

Why not? Most today's hardware can reroute samples or analog paths in=20
hardware. So it's only about right mixer setup.

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
