From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ssm2518: Add explicit device tree
	support
Date: Fri, 14 Aug 2015 16:53:04 +0100
Message-ID: <20150814155304.GP10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8636234215128572405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB2DE266488
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:17 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131456110.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8636234215128572405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TJXgsAvz6ds/es3G"
Content-Disposition: inline


--TJXgsAvz6ds/es3G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 03:10:19PM +0200, Ricard Wanderlof wrote:
>=20
> Add OF match table to SSM2518 to allow direct matching without going
> through I2C subsystem.
>=20
> Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
>=20
> ---
>  sound/soc/codecs/ssm2518.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

You should document all new DT bindings (even if they did implicitly
happen to work before).

--TJXgsAvz6ds/es3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzg7fAAoJECTWi3JdVIfQNG4H/3aytwUjELFlQyn16/iHkgV7
v0+tR2ylkuofem3Ymr0nwLHjixD9Zq16Mk/ftiC3EWhJxX+VvxuQihV5w7oQIkj0
vGpRYddWwRHlXrf5GqUq/jdASEaUwkD2HacOYdTzuT2+hZ0cnFsrWNWWIbQkT/d6
1ennWbR9zXwro/WCIITa4jNQ8u7O8JKlnkXOdcmexzBe4+Bg5tgRudFEGV/0gUcy
VAmr3XqDmxOzNFMUiw/aLR7Q/3jNas6g+YSDt4OTZctB1hMU1NlDI3IoYIHxkLvL
5W7agw+E3rNgNo8Iyfq0XbTARAUzVAxXfINGdeV5keZ1AE3KrgvDzqc6oKtOc3s=
=EgDT
-----END PGP SIGNATURE-----

--TJXgsAvz6ds/es3G--

--===============8636234215128572405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8636234215128572405==--
