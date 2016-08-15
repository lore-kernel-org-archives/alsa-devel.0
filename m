From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Mon, 15 Aug 2016 15:06:04 +0100
Message-ID: <20160815140604.GK9347@sirena.org.uk>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7418151626421494234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF932675F6
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:06:14 +0200 (CEST)
In-Reply-To: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7418151626421494234==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7UxcOAJ07vnNm5/N"
Content-Disposition: inline


--7UxcOAJ07vnNm5/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2016 at 05:02:23PM +0800, John Hsu wrote:

This looks very good overall, a few fairly small things but nothing too
major.

> +	val =3D (u16 *)ucontrol->value.bytes.data;
> +	reg =3D NAU8810_REG_EQ1;
> +	for (i =3D 0; i < params->max / sizeof(u16); i++) {
> +		regmap_read(nau8810->regmap, reg + i, &reg_val);
> +		reg_val =3D cpu_to_be16(reg_val);
> +		memcpy(val + i, &reg_val, sizeof(reg_val));
> +	}

This looks like it's trying to do regmap_raw_read()?  Raw I/O bypasses
all the endianness conversions.

> +static int nau8810_set_clkdiv(struct snd_soc_dai *dai, int div_id, int d=
iv)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	struct nau8810 *nau8810 =3D snd_soc_codec_get_drvdata(codec);
> +	struct regmap *regmap =3D nau8810->regmap;
> +	struct nau8810_pll *pll =3D &nau8810->pll;
> +
> +	switch (nau8810->div_id) {
> +	case NAU8810_MCLK_DIV_PLL:
> +		/* master clock from PLL and enable PLL */

I'd really not expect new drivers to need to have a set_clkdiv()
operation.  Most things should just be worked out by the driver, that
means less duplicated code in machine drivers and that things like
simple-card have more chance of working for a device.  This one I'm not
really sure what the divider is so it's hard to make specific
recommendations.

> +
> +	case NAU8810_MCLK_DIV_MCLK:
> +		/* Defer the master clock prescaler configuration to DAI
> +		 * hardware parameter if master clock from MCLK because
> +		 * it needs runtime fs information to get the proper div.
> +		 */
> +		break;

This is obviously not good since it means that we just ignore anything
that's set - if the caller is trying to set a divider we shouldn't just
be silently discarding what they set.  It looks like this can just be
removed since the driver is able to calcuate=20

> +	case NAU8810_BCLK_DIV:
> +		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
> +			NAU8810_BCLKSEL_MASK, (div << NAU8810_BCLKSEL_SFT));
> +		break;

If this is really needed by anything the set_bclk_ratio() call is more
appropriate.

> +static int nau8810_probe(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Remove empty functions, if they can reasonably be empty then the
framework will handle them being missing.

> +static struct snd_soc_codec_driver soc_codec_dev_nau8810 =3D {

> +	.controls =3D nau8810_snd_controls,
> +	.num_controls =3D ARRAY_SIZE(nau8810_snd_controls),
> +	.dapm_widgets =3D nau8810_dapm_widgets,
> +	.num_dapm_widgets =3D ARRAY_SIZE(nau8810_dapm_widgets),
> +	.dapm_routes =3D nau8810_dapm_routes,
> +	.num_dapm_routes =3D ARRAY_SIZE(nau8810_dapm_routes),

Move this data into the component driver please.

--7UxcOAJ07vnNm5/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXscxKAAoJECTWi3JdVIfQVZgH/R8tpQEYyeg6P+LMeyPER+Ex
ls8ayBb0xZr37W5cYRtVVjvQfkZnBZuqKiXQJp423LBK8Z6IhQYHbgmhtrhWyas1
4spCYC1rs53O1rEaDJMupSJrqX+7hJ5ksx5i940d/aZEg3r1wIhDzrxtWD/6ZjXN
8FCkvN9cUJv78vP/XFWrvvHskQzGaU2oRQB4gzGqdNojKvUV+ErWNc+3BKsUSBhr
igy5/bv3oeDZMmT/CipzYbFbG3yaIKcQqEaQyyx3gNZbQB4vb6hxBHV3/9xbgf0V
Q/Q2O8GKYKxzzk8Sg7768gkoV3B1d3Xeq3Wu1VOUYx9WJ4V/bka7em/iKhyo4nI=
=OpQq
-----END PGP SIGNATURE-----

--7UxcOAJ07vnNm5/N--

--===============7418151626421494234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7418151626421494234==--
