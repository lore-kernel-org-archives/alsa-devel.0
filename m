From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if already idle
Date: Wed, 8 May 2013 14:05:54 +0100
Message-ID: <20130508130554.GG3459@gmail.com>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
 <20130508103401.GX7478@sirena.org.uk>
 <20130508110451.GC3459@gmail.com>
 <20130508113124.GH7478@sirena.org.uk>
 <20130508120326.GF3459@gmail.com>
 <20130508123902.GL7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508123902.GL7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Mark Brown wrote:

> On Wed, May 08, 2013 at 01:03:26PM +0100, Lee Jones wrote:
>=20
> > Besides, I was more referencing the massively increased effort
> > imparted to the developer by applying patches in an arbitrary order=
=2E
> > Forcing the developer to rearranging and rebase the patch-set causi=
ng
> > unnecessary merge conflicts. It's better if the maintainer takes th=
e
> > patch-set in the order it was written to prevent unnecessary (which=
 is
> > the key word here) such things.
>=20
> Meh, rebase takes care of all this stuff for you and you really need =
to
> be rebasing anyway to take account of changes sent by other people.

> The problem you were having was that you weren't rebasing at all.

Eh? That's just plain wrong.

Anyway, I'm not talking about any particular incident/session/period.

I'm saying, from experience, from the developer side, that if a
reviewer goes though a patch-set taking the ones s/he likes leaving
the rest behind, there are bound to be merge conflicts and semantic
issues which the developer will then have to resolve. Stuff that I
believe is added, unnecessary burden which would be easily avoided if
the set is firstly reviewed and _then_ applied after the Acks have
been awarded.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
