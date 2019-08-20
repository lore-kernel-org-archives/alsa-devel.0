From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/21] ASoC: sun4i-i2s: Use the actual format width
 instead of an hardcoded one
Date: Tue, 20 Aug 2019 18:39:03 +0100
Message-ID: <20190820173903.GA5702@sirena.co.uk>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 09:25:18PM +0200, Maxime Ripard wrote:

>  		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> -				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> +				   SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));

This doesn't build for me:

In file included from sound/soc/sunxi/sun4i-i2s.c:16:
sound/soc/sunxi/sun4i-i2s.c: In function =E2=80=98sun4i_i2s_set_clk_rate=E2=
=80=99:
sound/soc/sunxi/sun4i-i2s.c:360:57: error: =E2=80=98params=E2=80=99 undecla=
red (first use in this function); did you mean =E2=80=98parameq=E2=80=99?
        SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));
                                                         ^~~~~~
=2E/include/linux/regmap.h:75:42: note: in definition of macro =E2=80=98reg=
map_update_bits=E2=80=99
  regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
                                          ^~~
sound/soc/sunxi/sun4i-i2s.c:360:8: note: in expansion of macro =E2=80=98SUN=
8I_I2S_FMT0_LRCK_PERIOD=E2=80=99
        SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1cMDYACgkQJNaLcl1U
h9A5+wf/R8kszzb6oMjGJWYnQJj4y8zrub+Ef7frMS3FakQtrfpNijxNi57HOXai
jJvL1rK1E89FeYJlt5rPq9DJGlWe8dS9dMvhuz7JhsYl5cn+8m4o1LoUbH6Inv5k
95bWW3IC9IBXhd6MiQwBZZpZ79T1UjHu9UfOF5dOEQ059wu8JCYvA0y/PzyH6kq8
w1MO/wGVaEHT/DMsAs66Mp5/3Ju8DAn9ZaE7ZhrgIsBphf/P+/BZHPU/pQjFEVag
f0ayDyQwRU1t26KvNeIRQpnUXV/N7ZF7j/uQ2mUQDTPjViBLS0uzUw/5bklcAT24
w+0X+AVImMFg+yfuBP7oOP25UCjzbQ==
=C0WO
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
