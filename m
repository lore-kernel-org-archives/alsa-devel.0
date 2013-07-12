From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about WM8904 regcache
Date: Fri, 12 Jul 2013 09:42:00 +0100
Message-ID: <20130712084200.GV24508@sirena.org.uk>
References: <51DFA98A.50900@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1380898698334132934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D8423265109
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 11:13:06 +0200 (CEST)
In-Reply-To: <51DFA98A.50900@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1380898698334132934==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dIV3CY5swYZsO92m"
Content-Disposition: inline


--dIV3CY5swYZsO92m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 03:00:26PM +0800, Bo Shen wrote:

>   I try to add the following two line in wm8904_set_bias_level into
> "case SND_SOC_BIAS_ON", it doesn't work.
> ---8>---
> @@ -1832,9 +1834,12 @@ static int wm8904_set_bias_level(struct
> snd_soc_codec *codec,
>=20
>         switch (level) {
>         case SND_SOC_BIAS_ON:
> +               regcache_cache_only(wm8904->regmap, false);
> +               regcache_sync(wm8904->regmap);
>                 break;
> ---<8---

That's far too late to be doing that, the device is already supposed to
be powered and running - you can see the device is doing this already in
the transition from _OFF to _STANDBY which is where it should happen.

>   However, If I comment the regcache_cache_only(wm8904->regmap,
> true) as following, then it play OK.
> ---8>---
> @@ -2232,7 +2239,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
>                             WM8904_POBCTRL, 0);
>=20
>         /* Can leave the device powered off until we need it */
> -       regcache_cache_only(wm8904->regmap, true);
> +       // regcache_cache_only(wm8904->regmap, true);
> ---<8---

>   So, any clue for this issue?

The device is supposed to be idle_bias_off so sitting in _BIAS_OFF when
not in use, this should mean a transition to _STANDBY as part of the
power up sequence which should reenable interaction with the device.
Check to see why that is not happening - _OFF should be the default bias
level as well.

--dIV3CY5swYZsO92m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR38FVAAoJELSic+t+oim9QuQP/A7tF7+XYH81/6Mzn+OXQmGW
zxl90uAa9fKlqwwpLTrwuku9SZP+C4aNh49TKSJ+KNtwdGEOmEjdDA9ZxNPOnXtd
nhPAXxYeVHEFVfiQ19qUTtA5zuYsYUe5jd6YvwVsLHFiNqzvd8ZUTjfG46kt5I24
riHeoXcUZALElHorPbtJBvsC1nHNReJ3Rub/PbxvfdkNj1Yq8UOfH1lOdnVl7LBc
wcvPivN1jkrz9BM9wPgZWmIvNXQqUJgjMkuPN8eeTxByXg4CrBzM9VyFwlqxGzaU
fcEVNIimMBjhgAA6gHdMoA1zYVfclCRCEjScQEDclFHqF+St7Fq+Toz6dqu7TN1h
plxgraIbo5A1D3LiMh8yFzGMxDRGSmrMeSI/Gfe9d6LiNkCpPEpg7WLK/PuXUQZA
zVnpfkf3XUnkfow9CHq4qzO17iUNI/vitSIApRBlHDBtFeyuri39upys3P9BnA2B
GvJJG2afbyd2A6yIff+//OozQFKn1FoXMgxXYmntjpbLak6r0ssOHkrBj17//2Vt
RvKl+p2lvl5jhraQaCEAjzb5RyVlm1Jr4Rv6lYbJ4O745vrUa+TsFmIkPZOYLcl9
YZ4EMYbg0BP3hqCTAZiK5mVNFbPmkXXJuTAZK3cHQIm96sGNUWLRodPO/sLAxGPt
w1mm00l0l21SITogjsNQ
=gtE2
-----END PGP SIGNATURE-----

--dIV3CY5swYZsO92m--

--===============1380898698334132934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1380898698334132934==--
