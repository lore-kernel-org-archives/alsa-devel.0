From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/19] ASoC: Intel: add COMPILE_TEST to
	mfld machine
Date: Sat, 21 Jun 2014 16:34:53 +0100
Message-ID: <20140621153453.GI5099@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-2-git-send-email-vinod.koul@intel.com>
 <20140621104241.GB5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6483962487719042004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F7226546B
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 17:35:16 +0200 (CEST)
In-Reply-To: <20140621104241.GB5099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6483962487719042004==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ny1L16MQneaJ3Er"
Content-Disposition: inline


--7ny1L16MQneaJ3Er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2014 at 11:42:41AM +0100, Mark Brown wrote:
> On Fri, Jun 13, 2014 at 06:03:50PM +0530, Vinod Koul wrote:
> > Allows driver to be built on wider configs
>=20
> Applied, thanks.

=2E..and dropped since it causes build failures all over the place
especially around the SCU.  I'd guess you need a dependency on at least
the SCU as well as COMPILE_TEST.

--7ny1L16MQneaJ3Er
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpaYaAAoJELSic+t+oim96XwP/2YTSNvIQ6H52uHySBRowrGI
5er2u3HiNII1jujNgbtAed/mulL140T5hw2evZOoVNUibu7qV2xaMsgokR3Dr5UN
eFjIQCUXchJ4wa6i7N39AhmzX1phiBMr/YldPXaV7MPjmYBob9tQ2gqzwgGcVUes
NJDd/hlh6mMEe0wqvp2iEcYh6YBhBaL4F1h1Om9WeIihyHX2cDJPk2XflUxSaH9C
t+WymXia7F8mB+kehhSiAwWCVdrYxxH8LXTDWAj0apbm0GDGH1wH0XeKLqrxbg4+
QumYHhdZvN5CijMTErWJfKb4dNdBkBCfTiIeR97UwMAE2m2eUxRzZXh3RNAx8ae4
SGuqvgHEOrR7Q2pDlmZFU169RH4gKZswDdKgnxjc+7CCDSUmzBdQ6t/WXxu8KVST
JoLGGpFNer9VNmJ+Yyv6STE+bVxNGk6lxpGbgT+TJ338JylURIrnhqtUn6NrKgaD
JHc05syVj0ll8Xxq05wC1898EptB3sUMWoAD0aOTEzemN+tZY7z4QQ/VU5a2mKhZ
IcMYo10sFEFTZ3fvtszafzXvo1hoa7yBJbxM8edCalNmTb7V0O7Zq+Jm/vv00J+G
s9p0F/j8yga+OXOpV3vwEmMWSwcUaZTPEYttJZUhygFNiKXlUEsNW2pPj4KVrGJq
GT+2tcWymqxzAF3xTrkg
=IVpK
-----END PGP SIGNATURE-----

--7ny1L16MQneaJ3Er--

--===============6483962487719042004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6483962487719042004==--
