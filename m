From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH resend] ASoC: fsl-ssi: Fix bitclock
 calculation for master mode
Date: Wed, 25 Mar 2015 22:44:02 +0100
Message-ID: <55132C22.3050503@pengutronix.de>
References: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
 <20150325165814.GJ3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3324011548229775947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7F54A261AB0
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 22:44:19 +0100 (CET)
In-Reply-To: <20150325165814.GJ3572@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3324011548229775947==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AQLbtvjWV2GD4lviMGqmm6jPOm79FwAoc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AQLbtvjWV2GD4lviMGqmm6jPOm79FwAoc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/25/2015 05:58 PM, Mark Brown wrote:
> On Mon, Mar 23, 2015 at 03:46:12PM +0100, Marc Kleine-Budde wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> in fsl_ssi_set_bclk we are looking for the best divider by iterating
>> over all possible dividers. The divider is in the range 1..256, so
>=20
> This doesn't apply against current code, please check and resend.

The problem has been fixed by:

    6c8ca30eec7b ASoC: fsl_ssi: Don't try to round-up for PM divisor
                 calculation

in the meantime.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AQLbtvjWV2GD4lviMGqmm6jPOm79FwAoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVEywoAAoJECte4hHFiupUuy0P/1q9fKeSIigGmV4qO6zXDaTs
91XR4cc/+pWwZp2N9XQd1i5ZJPOUtwi7H0KvOQWCLvbapKkDkUxvTnBvfQFVnzsA
K6/d+9afVMl3VZOFw3jqF2HKMeNvKH8xXR5ayjk8tKQG6QAafcrIr7S12khwbt60
8wDkIQ9HujbafRFiVQCvIucUw4SAsltczqhKG8zegtGi+fz1y1+7WIhuXuP3GENt
soYRUrkNp8kP0ctS9NM42jxvDUfWjGJYe9J2/m0NruT1yYcmJQfkA3RgjkoA0SFU
W4c0mtbwND9dXi2XCOjTi4CLasS9FcEGLKuxOxNGcasE5COUl9L48tHIFZ7Vr45j
nulPD/HX6J9RwSAbRjUSEEVZlurB0/N+UgDo3fmjXSMDwg2weG8+xZFfw4gr+D60
K3vY2muwHa+RjMSV1BdabepraEXi7eixOrCkX2a7+M5xauxXI+2ZfQGGaSsvwhC4
ciV08ngLi0lhZuY6kTEg4cNHkETJrT0ILwgldALtA7Yp2cevW7CXcw3fBMntDNN5
2wiSeJJgV+1hJthRoHvaU9KCBivEz3vYz7Ya02IZj6BAi80K+8mAMtFm55RsR4P0
nymufNv6Pqd1+GpYoYii2up6oddFa9CVR0WQTsnyv+E00gdey/7GepE8cfXBcGQA
vR4MEQkgImV3iXaGNMaj
=2YIN
-----END PGP SIGNATURE-----

--AQLbtvjWV2GD4lviMGqmm6jPOm79FwAoc--

--===============3324011548229775947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3324011548229775947==--
