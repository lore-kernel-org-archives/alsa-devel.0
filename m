From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: fix headphone click/crack
 noise on Dell XPS 9343 I2S mode
Date: Thu, 16 Feb 2017 19:22:30 +0000
Message-ID: <20170216192230.mg6htsgqbu756e6y@sirena.org.uk>
References: <20170123053514.6193-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6121792286251010649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 732A1266D50
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:22:39 +0100 (CET)
In-Reply-To: <20170123053514.6193-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6121792286251010649==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzpwfkvxx5s4yjzz"
Content-Disposition: inline


--pzpwfkvxx5s4yjzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 01:35:14PM +0800, Kai-Heng Feng wrote:

> +static void dell_dino_mute_hpo(struct snd_soc_codec *codec)
> +{
> +	snd_soc_write(codec, RT286_SET_AMP_GAIN_HPO, AMP_OUT_MUTE);
> +}
> +

How does this ever get unmuted, should it be an _AUTODISABLE control
instead?

> @@ -1204,6 +1261,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
>  	mdelay(10);
> =20
>  	regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
> +
>  	/* Power down LDO, VREF */
>  	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0xc, 0x0);
>  	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL1, 0x1001, 0x1001);

Random whitespace change.

> @@ -1222,6 +1280,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
>  			RT286_SET_GPIO_DATA, 0x40, 0x40);
>  		regmap_update_bits(rt286->regmap,
>  			RT286_GPIO_CTRL, 0xc, 0x8);
> +		rt286->mute_hpo_func =3D dell_dino_mute_hpo;
>  	}

Why would we only do this on some machines, does this break others?

This change does appear to be two different changes merged into one,
there's the GPIO setup and this automute thing and they don't seem to
overlap AFAICT - they should be split into separate patches unless
there's some reason why they overlap but I'm not seeing that.

--pzpwfkvxx5s4yjzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlil+/UACgkQJNaLcl1U
h9DA2wf/ZOCCEYtdyuRd/fzWOWF6TjmVOYID4uqFuftyeQeIhsrcRS5MyM1fYx0R
aGf5dRXl5ojLjvI9pvD/51S12L7tIJSX/5cfNDi/nK0LrgwRbJJYc+f8hMPaSQLZ
eBoQKOLaT0yiL2StejaVVwHj+Y2u+AnNrliHreMntNR1F+SQVk24dHJhnpV08vaj
P0/NkphlF6G2T289ZjziJYPZsTOS9KhmKIcNu9SfkVDBgjLsG+Z3ep9m+Opv6N4t
HSzF37smtV3IDPgDyYX9B/cxVf4EkEEsNBmmY4oBNx1jHDyhTYrBmquq0YSsIzZi
oQKySK8kBg3pSoGG3sZb2j60SNMajA==
=sD+D
-----END PGP SIGNATURE-----

--pzpwfkvxx5s4yjzz--

--===============6121792286251010649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6121792286251010649==--
