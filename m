From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer=8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Measuring latency on my Apple G3
Date: 22 Jul 2003 02:22:59 +0200
Sender: linux-audio-dev-admin=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <1058833379.3754.71.camel@thor.holligenstrasse29.lan>
References: <3F1BB92C.6090600@sambara.org>
	 <1058785796.28382.139.camel@thor.holligenstrasse29.lan>
	 <3F1BD2A1.7030404@sambara.org>
Reply-To: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-audio-dev-admin@music.columbia.edu>
In-Reply-To: <3F1BD2A1.7030404@sambara.org>
Errors-To: linux-audio-dev-admin@music.columbia.edu
List-Help: <mailto:linux-audio-dev-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-dev@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev/>
To: Ismael Valladolid Torres <ismael=g6NPVqWaOk1AfugRpC6u6w@public.gmane.org>
Cc: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-user=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, debian-powerpc=0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-07-21 at 13:46, Ismael Valladolid Torres wrote:=20
> Michel D=E4nzer escribio el 21/07/03 13:09:
> > First of all, you mentioned in another post that you use x11perf to
> > create X11 stress. Are there also problems with real world apps?
>=20
> "Real world" apps work properly (except for the Gnome theme manager=20
> which displays garbage).=20

Probably a GTK bug, not related to this thread. The point is real world
as opposed to synthetic throughput benchmarks like x11perf.

> I only find video performance using Linux a lot lower than using=20
> any of the Mac OS's.

Which isn't very surprising, as they can use parts of the graphics chip
that we don't have specs for, for one.


> > Also keep in mind that neither the vanilla 2.4 kernel nor the X serve=
r
> > were designed for low latency. Have you tried the low latency and/or
> > O(1) scheduler kernel patches, and not running the X server with
> > negative nice values if you are?
>=20
> Both of those patches (A. Morton and R. Love's ones) were applied to my=
=20
> kernel.=20

Beware that at least the low latency patch needs fiddling with
arch/ppc/config.in to actually be enabled (check with grep LOLAT
.config), and that the preempt patch (which I assume you mean by R.
Love's) actually made things worse for me when I tried it on PPC a while
ago. This may have been fixed in the meantime though.

> I don't know about running the X server with different nice values,=20

sudo dpkg-reconfigure xserver-common

> which advantage would I get?

The X server might take less CPU away from other processes. Or maybe the
problem is the other way around. :) YMMV.


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI develope=
r
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenze=
r
