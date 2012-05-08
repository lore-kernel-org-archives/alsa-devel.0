From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmic codec: Support for DT
Date: Tue, 8 May 2012 13:58:38 +0100
Message-ID: <20120508125837.GN15893@opensource.wolfsonmicro.com>
References: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8546629854620202913=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B02210438F
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:58:41 +0200 (CEST)
In-Reply-To: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8546629854620202913==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 02:55:57PM +0300, Peter Ujfalusi wrote:

> +dmic_codec: dmic_codec@0 { /* generic DMIC codec */
> +	compatible =3D "generic,dmic-codec";
> +};

Why is this called "dmic-codec" and not "dmic"?  We probably need to
have a think about this in the context of the handling of random
on-board passive components in general - things like jacks and so on -=20
is the most sensible thing to have a platform device for everything, or
is that getting too noisy?

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqRhkAAoJEBus8iNuMP3dGM8P/2ZnfYpKIsRskZDISh2T1zUA
lwUwmyOmkBftVNZ7NsOXCw6QsClGPFrgDfwwo4ibms5ZNtZGLvRG4MQ7COnZHDSX
CrNIkCk18JMTgB0IwwWM93AFcKMHHmsosHhi72Y/0PQrnOEdhZD0scb0Rr52eiT9
wPndQqIYnEcNOz0iOYrJtOZ3bJhd5MTPN75D4hX+wF5LCIzbm/RuhGSeNFmao3/X
aPU+ZeStDrZYNhRHkQan+mKyj7+fxEbVJWYJw+d6ESsYFNvrV2psLxIro6n50tCO
e6XrKSfQjui8IBJpwSqv60QFcIznGUAImXtE70IggnafvN9zbVT1HaljT3EAnQJt
e0+nUmIhP5jQyfshhLOiaj+enZl6Yh0BEM3qWAe9lpdRO/gpjEePCfDTjNE0y+7w
sPj4XeJ31FtyAsx7uxTqoQmOiIWoaJL7CYW1nJDxDANxKWBUHJvDBYEogCciSyvB
GYp5gcip3osJ33YQpGrFFpu1T3IlgHCI+OSccftW3iLRMH6MrZuoXnmd3FlI15b7
EAJVim/LpyYqAdSLP/EbDrCODpwTJW2VrUalBK+cy21it2JN5zAhkciDiCraxcu0
4K6zzgzB/TkegitUKgtYftuy4TJ2+5dWlT6AECoFjT9VsiGXEPXv+4xznyepymbl
Az1VuNzbbRYdvCa8CZzg
=wQ3s
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--

--===============8546629854620202913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8546629854620202913==--
