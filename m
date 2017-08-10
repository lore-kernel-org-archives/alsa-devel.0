From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: add const to snd_soc_codec_driver
 structures
Date: Thu, 10 Aug 2017 16:31:58 +0100
Message-ID: <20170810153158.hfnzjzro7wnmc4mt@sirena.org.uk>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
 <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
 <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jxmkxxvaq2t2kvt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, support.opensource@diasemi.com, Muthumula Jaya <mr.swami.reddy@ti.com>, vishwas.a.deshpande@ti.com, peda@axentia.se, bardliao@realtek.com, baohua@kernel.org, peter.ujfalusi@ti.com, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org


--2jxmkxxvaq2t2kvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2017 at 08:56:35PM +0530, Bhumika Goyal wrote:
> On Thu, Aug 10, 2017 at 8:50 PM, Mark Brown <broonie@kernel.org> wrote:

> > This is difficult to apply against current code as it is a single commit
> > over lots of files but the ASoC tree has lots of branches.  I've figured
> > out the dependencies but it's easier to split things up (and avoids
> > collisions with other changes causing the whole thing to not apply).

> Thanks for the response.
> Should I make separate patches for each file or is there another way
> to split this patch?

Splitting per driver would've been easier, or saying exactly where it
applies if you don't split it.  Like I say I figured it out for this one.

--2jxmkxxvaq2t2kvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMfGcACgkQJNaLcl1U
h9A+igf+ItM+7PAf6KFUgWZsVQnTSOLrAZNUhNTca6Q4w7UmSqExRjce2vNhg78R
eVnSTIv8IDbajhlL5nhhbG2Y/bNo0kQWVKa5IH/0eao4Ts+nYlEpk/EIb0lYu1lp
T0+mt0NxeQ5Lueup3lnHmduWCn8ayZSB4wO2DT/Bilv34qey9vRLutbp2ccXiqZ3
xRdFpatth7QUy4vu08EbpnTpd+65NWGzq5QigS6lZfyjOznhFEXHX05fan73ymh0
xFPLL7geEmJbNVEWwlhNWIeznQBAcak/iivaFVltlLF+soJdJ1MWHST8pbOR93qF
yYjV+DAjUzsj38b9qiXJLVgCbqmbVg==
=VAP4
-----END PGP SIGNATURE-----

--2jxmkxxvaq2t2kvt--
