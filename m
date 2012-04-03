From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix warning due to the
 lack of REGULATOR_CHANGE_VOLTAGE
Date: Tue, 3 Apr 2012 21:37:46 +0100
Message-ID: <20120403203746.GB11910@opensource.wolfsonmicro.com>
References: <1333483353-12273-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1110054813960868482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4B0310427D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 22:37:50 +0200 (CEST)
In-Reply-To: <1333483353-12273-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1110054813960868482==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 05:02:33PM -0300, Fabio Estevam wrote:
> Fix the following warning during kernel boot:
>=20
> 0-000a: 850 <--> 1600 mV at 1200 mV normal=20
> 0-000a: Voltage range but no REGULATOR_CHANGE_VOLTAGE

Are you sure this is the best fix?  There's no set_voltage() call in the
driver.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPe1+NAAoJEBus8iNuMP3dCX4P/jybB1IxF2mPrimANzZJRevl
Dc/wL35GjMXknWVyLMU7gtJe8sKYWZOvB15JQ+BQ+9YiDet1srBHvF/+wLvrA6+X
ygEYIyHIuXeRiB04TH34/Z+p4dt5lw2FSrnz1PPX0WA1y94biTAAG0nHGWoR+E7t
OQAKL7chD3GWT0SMpcN1NxgGc74xAs2NTWH5RtP8epSpOIa2y10v+rRTBNrWG9Vm
fx8MMdgDIw4GvmME3KQ6XpiRjSBJ0LAaXVl1UWwDa0Q1IpJk/OyFdcDG4qanZTYf
ZlNT0QWXujmGk/Y+RJispb4ew9PRIeeegtBRxTGmvKJsVARuk1zC0e2OLcWUOlrG
0jWea/mSGAreSo4bGtJm2AdZr3v4J9gesIeR+vxmPZ5698YlC2NdI7P3EkSRjqyp
Rna8qjxUw9aADp4sHd3EjjrbrcQuqyYVWHQ3Ge5Cb1aGqAgnyIr98Ctg4HHPWCh8
wrqfJzcfJKc4weMNLfKN3mJtUGqC94zVdSzrpujvkbzcgu9a0D6Xtl41X2Eg7wSu
AWw/DZ9UMEfW7cWKiGh44KxidT6bGoBG2a2oae2SK3muJE894gS7r7QgkwilnYzL
qi3J3izcpQ1C6XWjfeHYZSL3+mIhFsXPEIEHR6zQMu4uO0pX+9Pkj4eufMIo43Ca
ihddctaWTwo9/GNT/KjC
=DhXm
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============1110054813960868482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1110054813960868482==--
