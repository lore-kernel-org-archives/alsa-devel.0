From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
 codec driver to ad193x supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 18:05:16 +0000
Message-ID: <20100318180516.GF6142@rakim.wolfsonmicro.main>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
	<20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
	<20100318162017.GA6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CEAC10388C
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 19:05:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 01:17:11PM -0400, Mike Frysinger wrote:

> observed, they can be unified across everyone.  subsystems rarely are
> special ... most of the time, people just think they're special and so
> can ignore the common behavior.

I really don't see much of that, to be honest.  Bitrot, lack of time and
poor advertising of new core features seem to be more the issue.

> > The subsystem dependency here come from the fact that ASoC has machine
> > drivers and relies on them selecting the CODEC drivers to get them built
> > in the first place so if you're trying to change something like this
> > you'll most likely not only have to rebuild your kernel but also have to
> > write code. =A0This isn't something that the input layer has (input lay=
er
> > drivers are pretty much standalone, usually only need platform data
> > for any per machine hookup and for I2C and SPI can even be registered
> > from user space IIRC) and it changes the considerations noticably.

> the machine driver selects the codec, it doesnt select the bus.  the
> codec worries about that.  so i dont quite follow the logic here.

That's not the case, CODEC drivers do absolutely nothing to ensure that
they have the buses they need.  Multi bus CODECs should all be perfectly
happy to build with no bus at all, though sparse and/or GCC will warn.

Kconfig will cheerfully ignore any dependencies of things that are
selected - unless it's been updated recently all a select does is force
the selected symbol on, it doesn't recurse through dependencies and
selects of that symbol.  Besides, multi bus CODEC drivers can't know
which of their possible buses are actually needed on a given system -
they just build support for any bus types that are configured and let
something else worry about the resulting configuration actually being
useful.
