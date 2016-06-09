From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital
	Audio driver
Date: Thu, 9 Jun 2016 23:05:15 +0200
Message-ID: <20160609210515.GI5242@lukather>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7536009106642176730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 012BB26070C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 23:05:15 +0200 (CEST)
In-Reply-To: <20160602102651.GF2282@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, gianfranco@moddevices.com, Code Kipper <codekipper@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7536009106642176730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Content-Disposition: inline


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Jun 02, 2016 at 11:26:51AM +0100, Mark Brown wrote:
> > +static int sun4i_i2s_params_to_sr(struct snd_pcm_hw_params *params)
> > +{
> > +	switch (params_width(params)) {
> > +	case 16:
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
>=20
> The switch statement here and in the _wss() function look weird because
> they don't have default cases.  Since there's only one user of both
> functions it seems better to have the switch statements inline anyway.

I don't know, maybe it's just me, but I really find it cleaner that
way, and the compiler will probably inline it anyway. If you insist,
I'll change it though.


> > +	for (i =3D 0; sun4i_i2s_mclk_div[i].div; i++) {
> > +		const struct sun4i_i2s_clk_div *mdiv =3D sun4i_i2s_mclk_div + i;
>=20
> Why not just write these as normal array lookups?

By normal, you mean using ARRAY_SIZE()?

> > +	/* Enable the first output line */
> > +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> > +			   SUN4I_I2S_CTRL_SDO_EN(0));
> > +
> > +	/* Enable the first two channels */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
> > +		     SUN4I_I2S_TX_CHAN_SEL(2));
> > +
> > +	/* Map them to the two first samples coming in */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
> > +		     SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
>=20
> We don't undo these if setup fails...  do them once on probe?

Yep

> > +static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> > +{
> > +        struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> > +	u32 val;
>=20
> More tab/space damage, there seems to be quite a bit in the rest of the
> driver.

Indeed, sorry for that.

> > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > +{
> > +	struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +	/* Enable the whole hardware block */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +		     SUN4I_I2S_CTRL_GL_EN);
>=20
> Runtime PM?  It also seems like this is something that ought to be
> covered in the suspend and resume callbacks.

runtime_pm is supported, and uses the regmap cache to keep those
changes.

suspend and resume is not supported for that SoC yet, so I couldn't
test it properly (and isn't that redundant with runtime_pm?)

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdoKAAoJEBx+YmzsjxAgDH0P/iyuBCVhVKYjvNE3O818thM2
NNG8PJdB24Km6j95SeTXxWHQatOtZrptpeyAEdmH6mnFqiHEDsN5dnFfc3bltewq
DT8ftOC7dUtVPVDPeawEyUmQ7liMAiWGpFtxvbOllb33sq+ba6ulkPdgj6M94Lyz
I/A52x1gMfP+k3UmUfd6bk4frUU1KnSJ3ffKnRBwMUSGF+PI8YaNlOjtBREy+6Uj
3lADYEAwBdwgvkXkEYustcXei2TU8IDzV4P8EzgMXYjBU4Mkp9QLmf1+h/uvKaCM
KadC/bBRlNkb7S5QqRD4i9pViFWrQf+COnnQk4+/C0T7EWqb1THJ8/5RuRliGs5q
hZavlUYwyPdxsSGHvHHQRoARz30/0xW295YHZJ8B5X7XRfcK0Su99PpSeOtpJ/vb
DmRAwKnh4MbtxiAPOJi7NPg5xxhxyWefmXc2O7UZv5nPZ7DRfYwBl2e13/1C2zKR
JaU7FCBLXOtil86l/bQPBrqiDBA4l3+S9R4pqkGEtjPQmb6D9RGEup0qguVoqszC
UPBL55hDfyptydL31aaqzkof4LUzszU+VzfysyeGSWy5+b5C+1ZbKg9Uv09ASBVD
Qg+uUJdPZrpuR1jQms+v//1kItBhw/oZLAIMhiw41tMLv4ccdaAwW2eEztRpADU4
UoILQs2uCF7hDV6La/jm
=W1UT
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--

--===============7536009106642176730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7536009106642176730==--
