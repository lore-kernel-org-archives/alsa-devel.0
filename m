From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 16:07:29 +0100
Message-ID: <20130508150729.GK3459@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
 <20130508123225.GK7478@sirena.org.uk>
 <20130508131020.GA30503@balto.lan>
 <20130508135413.GR7478@sirena.org.uk>
 <20130508141723.GA12155@balto.lan>
 <20130508142734.GB12155@balto.lan>
 <20130508144958.GT7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508144958.GT7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Mark Brown wrote:

> On Wed, May 08, 2013 at 04:27:34PM +0200, Fabio Baltieri wrote:
> > On Wed, May 08, 2013 at 04:17:23PM +0200, Fabio Baltieri wrote:
>=20
> > > Ok, what I'm trying to say is that the codec used in this platfor=
m
> > > should be able to handle sleep modes without requiring any
> > > reconfiguration of the digital interface on the SoC side.  In sup=
port of
> > > this the fact that the STE fork of the driver does not do that, a=
nd the
> > > same goes for all other ASoC drivers currently in mainline.
>=20
> > And by the way, if the current code is *really* setting the digital
> > audio bus pins in hi-z mode (without any pull-up/down/keeper) as it
> > claims, this is not just usless, it's plain wrong.  The bus should =
never
> > be left floating on both sides, right?
>=20
> Probably not, no.

Why don't we wait and see what LinusW says?

If anyone would know, it's him.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
