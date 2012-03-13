From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/16] ASoC: core: Add range of reg control
	accessors
Date: Tue, 13 Mar 2012 21:23:54 +0000
Message-ID: <20120313212353.GC3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-4-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0910578054772346363=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63A0F104162
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:23:55 +0100 (CET)
In-Reply-To: <1331651503-16917-4-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0910578054772346363==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 04:11:30PM +0100, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added get/put accessors for controls that maps a range of
> consecutive registers exposed as a multiple value control.
>=20
> This is specifically useful for hardware that exposes for instance
> a range of filter parameters as a range of registers that with
> this could be written and read back in one single ioctl operation.

This is SND_SOC_BYTES.

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX7rjAAoJEBus8iNuMP3dBpEP/18AdHfNOmzXBRMUFLa6B6lw
ho2lg8qReLPUt8NUSGWcbHC4Y05IaUfp2aF//nlTN+Q6eSDmbXmBCNBixbq2M+n8
eE1mVBSd/w/ZwoMP5fZrKSmFiYUgnRiWXhuDCKXvOcgMNE+vlSI3wMOY2oft79DM
8JLG/J7Q3pW+u2kTFuwSERFUjHUmEI0D0Cy3kFZwf8Gl48VGK2rCDKAKh9Hz1hEj
MbntTtMvshgXBRnHFzb80l+psaz9htsaveNT4BXPp1QOFlP2gQBZoT4yCb3B0iDZ
r3Wmn6Os1AnG619n3odQjjRdEPt4vSnDCVk8pKnhhVJrByW7dOWxZ6Y0YCDKoz+d
ymxECtbQuUAaM2ZM93reoXuXiIaV4FKNZGW/f2aJn37USyBoww5czij7upFyUTdn
RXsH+vi5X8QMXP7crDGuW7UZfaDCGHPSmeBV1QDfzaLHGP9Zo1XtLG3SHRTXXJrt
evDwRED/L7npjpsHHLG/vcnsaWbeZAHIOyYjZJPsJP1ArrD/TOutPuhJ7qnWY0Vz
YX5euqpUGjIL4I6yxqT4FTj+buWV0GNb2CGuDcB0Ot7GWGvz4lS/mlTOAFIhzLTU
3cNGYYhpul0Nme1hxCNEZDE6GTUb6VSxSu9LifWfxIp3I4sB3iokbQQbmSgfGHBK
YKyBpmYs5m7P4LvnbjAO
=banB
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

--===============0910578054772346363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0910578054772346363==--
