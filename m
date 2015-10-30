From: Mark Brown <broonie@kernel.org>
Subject: Re: Different reg_default for rt5650 codec
Date: Fri, 30 Oct 2015 10:19:32 +0900
Message-ID: <20151030011932.GN28319@sirena.org.uk>
References: <ABFD875FF5FB574BA706497D987D48D7010C3663@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6794334330656895021=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A40265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:19:36 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7010C3663@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6794334330656895021==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fm6XlJPzS/ViAqAU"
Content-Disposition: inline


--Fm6XlJPzS/ViAqAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 11:17:26AM +0000, Bard Liao wrote:

> Something like
> 	case RT5650_DEVICE_ID:
> +		rt5645->regmap-> reg_defaults =3D rt5650_reg;
> +		rt5645->regmap-> num_reg_defaults =3D ARRAY_SIZE(rt5650_reg)
> 		rt5645->codec_type =3D CODEC_TYPE_RT5650;
> 		break;
>=20
> Is that ok?

No, that's not OK - the config needs to be constant and...

> Or should I use different regmap_config? There is one question if I use
> different regmap_config. We will know which codec it is by regmap_read.
> So, regmap is init before we know which codec it is. Assume rt5645_regmap
> is used and what should I do once rt5650 is detected?

=2E..you definitely can't change it after you registered the CODEC, regmap
will ignore that.  What should be happening here is that the devices
should be being registered using different identifiers so that before we
try to create the regmap we know what device is being used.

If there are buggy BIOSs out there that don't do that what I'd recommend
doing is creating a temporary regmap with no defaults or anything, just
the basic I/O.  Use that to read the identification registers from the
device and then create a second regmap with the actual configuration for
the device.

--Fm6XlJPzS/ViAqAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMsWjAAoJECTWi3JdVIfQadQH/3us0gfilzfHa5ECTiQIvA5w
BADnYlqF7eRVqpWLvkMyrkDtK2SqM3WCNyfFQPy3kx0xscedc7h2DqbVizqRlRCa
Ak70roEaFXwrJ9DUjNJzD7bh1JwqC5i5GzCa72JhbPNOUxrDA1XWaqBvBXtPBvo0
FVtEy8rpLYsO5OJXKGxKq35rIbo8tGph0OrAaC5L67gYcX+Dg0XbDVaPksp/jG8a
l5fSbIyU1EJQURdoTa/c/azar0X3TMIdRVwoZJd0BfEAGriLmBitmcJ5y/sGLSWI
NlWGDjGZBZn3TFoUY8xo4niD6ANWsHRdme228KOytOv3I8FLIpRjRaNbwr289eM=
=BglU
-----END PGP SIGNATURE-----

--Fm6XlJPzS/ViAqAU--

--===============6794334330656895021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6794334330656895021==--
