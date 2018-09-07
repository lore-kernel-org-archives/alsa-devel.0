From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Fri, 7 Sep 2018 18:56:20 +0100
Message-ID: <20180907175620.GL17459@sirena.org.uk>
References: <20180907002728.112770-1-grundler@chromium.org>
 <20180907121128.GH17459@sirena.org.uk>
 <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANEJEGv0A8LO1znHToYOkddzr_JmHpogvYewVrMpK+ZB6SJX5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: ryans.lee@maximintegrated.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 10:52:24AM -0700, Grant Grundler wrote:
> On Fri, Sep 7, 2018 at 5:11 AM Mark Brown <broonie@kernel.org> wrote:

> > Note that this isn't causing a warning upstream, presumably due to an
> > implicit inclusion that isn't present in the v4.4 kernel that you appear
> > to be using, or gets missed due to config differences.

> Ok. Is this just an observation or are these reasons to not accept the
> change?

An observation, you should already have a mail about it being applied. =20

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSu8MACgkQJNaLcl1U
h9Da1Qf/av+NNGne88nxbWrscrd10NjysRVgLpRfdYyyU3iPXln43RiTKN0+Wqxk
DM/K9kXyRW/5vbm0KYK6O5obBPnWfWB5rUI/QVKNLzObfUIni+Zj53otfo1giJCF
MkApUDrhUwCOf8V1A8tgwFO91Qg62QWMzs04bq2mrpw7quHQAXcBQjp/vBWldtAn
fSUaurW7o/fpWD3C1o4dTPqayqf43/m5T/k0c1QJ/pKDwGtL5QBdGucyrRjULORR
rD2jgaGoxwMMcySfcPvqVzM0EM286Vi0vh62oBojRns4zOAxf9owbBnpAAf1MBqY
Evgn2+d60flDCXXVhVxPSTNzgcppHw==
=ETFg
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
