From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: ab8500-codec: Add missing ad_to_slot
 definitions
Date: Wed, 8 May 2013 09:47:22 +0100
Message-ID: <20130508084722.GA3459@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-2-git-send-email-fabio.baltieri@linaro.org>
 <20130508075328.GF3102@gmail.com>
 <20130508083017.GB1526@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508083017.GB1526@balto.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Fabio Baltieri wrote:

> On Wed, May 08, 2013 at 08:53:28AM +0100, Lee Jones wrote:
> > I'm sure this is just me, but:
> >=20
> > >    0 to  7 corresponds to AD_OUTx slots
> > > char * const enum_ad_to_slot_map[] =3D {"AD_OUT1",    0
> >                                                       1..5 ???
> > >  					"AD_OUT7",    6
> > >  					"AD_OUT8",    7
>=20
> I'm a bit confused... the first one was from the diff header, while O=
UT7 and
> OUT8 are context lines, so 1 to 5 are already there but not shown in =
the
> patch.  The final array is like:
>=20
> static const char * const enum_ad_to_slot_map[] =3D {"AD_OUT1",
>                                         "AD_OUT2",
>                                         "AD_OUT3",
>                                         "AD_OUT4",
>                                         "AD_OUT5",
>                                         "AD_OUT6",
>                                         "AD_OUT7",
>                                         "AD_OUT8",
>                                         "zeroes",
>                                         "zeroes",
>                                         "zeroes",
>                                         "zeroes",
>                                         "tristate",
>                                         "tristate",
>                                         "tristate",
>                                         "tristate"};
>=20
> Is it ok?

Yes, I see that now.

Acked-by: Lee Jones <lee.jones@linaro.org>

> > >    8 to 11 corresponds to zero output
> > >  					"zeroes",     8
> > > +					"zeroes",     9
> > > +					"zeroes",     10
> > > +					"zeroes",     11
> > >   12 to 15 sets the output in tristate mode
> > > +					"tristate",   12
> > > +					"tristate",   13
> > > +					"tristate",   14
> > >  					"tristate"};  15
> >=20
> >=20
>=20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
