From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: tas5086: add regulator consumer
	support
Date: Thu, 3 Jul 2014 16:12:29 +0100
Message-ID: <20140703151229.GF410@sirena.org.uk>
References: <1404399403-6316-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6159650160946051017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30DCE2654C6
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 17:12:46 +0200 (CEST)
In-Reply-To: <1404399403-6316-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6159650160946051017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LsnByradU3Ze6UwI"
Content-Disposition: inline


--LsnByradU3Ze6UwI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 04:56:43PM +0200, Daniel Mack wrote:
> The TAS5086 has two power domains, DVDD and AVDD. Enable them both as
> long as the codec is in use.
>=20
> Also, switch on the power to identify the chip at device probe level,
> and switch it off again afterwards. The codec level will take care for
> power handling later.

Applied, thanks.  One small thing:

> +	/*
> +	 * The chip has been identified, so we can turn off the power
> +	 * again until the dai link is set up.
> +	 */
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +
> +	if (ret =3D=3D 0)
> +		ret =3D snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
> +					     &tas5086_dai, 1);

It can be slightly smoother to do the disable after registering so that
if we immediately cause a card to register and that causes the device to
become active again we don't bounce the power.  Nobody is ever likely to
notice the difference though.

--LsnByradU3Ze6UwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtXLaAAoJELSic+t+oim9dMgP/21akFsfljtOZkIp0MG9dEea
cwT4YXwb3y/SNhv+H0Qy5y5LzjVGFFWx8W6uDME4bFA+7kh0MCSYdxRsMOhQUyWq
u2qPXwBLHYxzgGOEjjHN81JYGRJHVGC3VMf0/MyM5JvfcvHRmSPwlruxFeuUYOKw
jQPNdOPGsrAAznqkYgjfYSjFWK6bG8RGZCrVoEGuv/KF9fNqsPD+T1mKeHv/rI4o
S1Pu6rPB/HZ8DIy5HR7LZlP23QR3GoyllrU8EhW+vfbe+3vAHO0crX5LaqQy0qn8
pnSneF62b1voxLs/tuEQ09YvhjvRU3PnlPXWZ4YvcBUjQsATXPrpVwvRqMttpQM3
5Av095PReV0+zAVO5dyag8a48ZWjJY5zXOOTPWSke+7OnfEFUNXaBmOjw2C6FHoU
kcA2gBqqlTqfc35Draca5QyZBsJgKzDC3jiVzrMnyoz/h3Z/XVrxOkmDV125r8Fi
ZmpskZFFnlV8mIHZ9FVcaIAlNJ1PKIXIWTnIdj0aX5qeu0KEfq6nuuUDwyQEEE6X
S8wWCevn3joyREZwBOjsnlF7kSNbookKAfhHiP4YLqvBgHbABANsuvcbd5OhWw8M
u324NAlMt5MpZnomC8PDSLCAT4CFoacvOX9upyIDfQvem5QVkUt9lvbAWAfPssas
daTtL0mynkk8Gw7xgslK
=T+aA
-----END PGP SIGNATURE-----

--LsnByradU3Ze6UwI--

--===============6159650160946051017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6159650160946051017==--
