From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 2/4] ASoC: tlv320aic32x4: Support for
	regulators
Date: Tue, 18 Feb 2014 22:28:28 +0100
Message-ID: <20140218212828.GD10590@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-3-git-send-email-mpa@pengutronix.de>
 <20140218012725.GS2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4778847292289976808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CD87826525B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 22:28:36 +0100 (CET)
In-Reply-To: <20140218012725.GS2669@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4778847292289976808==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 10:27:25AM +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 11:04:18AM +0100, Markus Pargmann wrote:
>=20
> > +	if (IS_ERR(aic32x4->supply_iov)) {
> > +		dev_err(dev, "Missing supply 'iov'\n");
> > +		ret =3D -EINVAL;
> > +	}
>=20
> This won't work with deferred probe and is ignoring the error value
> reported by the regualtor API.  It should pass back what it was given
> and still needs to handle deferred probe even if it's happy for a
> regulator not to be there.

Right, I added -EPROBE_DEFER checks for every regulator.
I replaced the usage of the return value to directly return the errors.
Otherwise it could be confusing to see multiple error messages and get
one error value returned.

>=20
> > +	if (!IS_ERR(aic32x4->supply_iov)) {
> > +		ret =3D regulator_enable(aic32x4->supply_iov);
> > +		if (ret) {
> > +			printk("Failed to enable regulator iov\n");
> > +			return ret;
> > +		}
> > +	}
>=20
> dev_err().  It would probably be easier to put one of the child
> regulators you did get into supply_iov instead so that outside of the
> probe you don't need to worry about which is actually there.
>=20
> I'm also not seeing any disables prior to remove.

Replaced all printk's with dev_err. I am now disabling all regulators in
the remove function and added error handling which disables the
regulators.

I will test all changes tomorrow and resend the series.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTA9B8AAoJEEpcgKtcEGQQcRUP/RXtRFy1Rdj3caiG3upo4lr8
wUyUxrbnxczLZ3Lt+aCQT73QsvclDcp6ANBS7DQiNCGG4vRP7quqf0CgOI+ZcDCY
IAg8GzEsvncJPnfuGBuvIALqcS353VqoUZDCMiiKWqpzo94bZcE1DYkUjC1pwYWR
LaPV5PmHQ/gn08szG/yfbCrq16bdFFaBndCBQFHw7JFqlynrrOh1Hp4zVGxA1eXv
MJW4pQX1ufglh6UM6mZvAzW8CNC0Hacf6uX21u/7Gh7zxmyFo5WGUY3rVnL5YQRy
zrajBJR1qmLhsp95UnLebYFPnW47UfWsr3hDnY1ZVltKX0FkBMSzsD+e9zAcsDLE
UNN4WDTKIs99MJawnyBK5LyhcpCFTsiOI7HdfZpfHGZwUgpjsUsBRb2Qxq/jQEKe
xoSSp+S4bSO803EUDhSrlgeDmEilEv9/1RQHSqawsjxKMBs0kVuZiuqnr2g0RP74
lx9BzRzwxLrgNeDSgE1eC60nf7xdSlzLkkWeUJmdoyNw9WEH+MGwCqisBaGFGTSi
O0m+WLB1cNPeoWiUKdBBX8CHsWmZYnnpsRyEvNowQbSGybX9UrpUUcXIfVRSrI1v
TwjIpZSUsweUca1BwJWH88IGa/F2N17JI0WABi2RFaLWlJFETG+Ey10vOeMc2D3a
9O/Nhd0xZJGR3uuUvsSb
=Fsu1
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

--===============4778847292289976808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4778847292289976808==--
