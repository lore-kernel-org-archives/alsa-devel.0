From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Tue, 20 Oct 2009 10:52:41 +0100
Message-ID: <20091020095241.GA28432@opensource.wolfsonmicro.com>
References: <20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
	<20091012104849.GA7994@rakim.wolfsonmicro.main>
	<3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
	<20091012142018.GA18283@rakim.wolfsonmicro.main>
	<3c17e3570910130309r3ffed293g9cc8f9bd0c845d4@mail.gmail.com>
	<20091013101445.GA29177@rakim.wolfsonmicro.main>
	<3c17e3570910192227n286b26d9pe58008a4cb4935f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BA372466C
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 11:52:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910192227n286b26d9pe58008a4cb4935f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Cai,
	Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2009 at 01:27:14PM +0800, Barry Song wrote:
> On Tue, Oct 13, 2009 at 6:14 PM, Mark Brown

> > I've no current plan to work on multiple AC97 controllers support within
> > ASoC except in so far as it falls out of other work - I've never
> > encountered an embedded system with multiple AC97 controllers so it's a
> > somewhat academic issue. =A0Patches welcome, though I'd expect it'd be
> > sensible to wait until multi-card support is present.

> Currently,  this patch should can help people to set platform_data to
> snd_ac97, and different operation can be fulfilled based on different
> ac97_pdata even with only one ac97 ops instance.

It's possible that this would work, though it would need explicit
support in any driver that were to implement it and I'd not guarantee
that all the special cases for AC97 would cope properly.  Hopefully it'd
be relatively straightforward to fix up any issues, though.
