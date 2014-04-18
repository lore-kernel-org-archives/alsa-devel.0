From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: Intel: some incorrect sizeof() usages
Date: Fri, 18 Apr 2014 17:11:46 +0100
Message-ID: <20140418161146.GE12304@sirena.org.uk>
References: <20140413195636.32f31cb2@spike>
 <20140416153811.GB16325@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lAxbTa9qRtQJ0itf"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140416153811.GB16325@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Christian Engelmayer <cengelma@gmx.at>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--lAxbTa9qRtQJ0itf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 06:38:11PM +0300, Dan Carpenter wrote:
> The intent was to say "sizeof(*pos)" and not "sizeof(pos)".
>=20
> The sizeof(*pos) is 8 bytes so the bug won't show up on 64 bit systems.
> The sizeof(*dx) is 172 bytes so that will be a bugfix.

Applied, thanks.

--lAxbTa9qRtQJ0itf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUU6/AAoJELSic+t+oim9sf8P/jkT+6GIAJcv105xIeY8SEVT
bh7Oe+2WSa6znf87A+haAHBwCPKztt6rGkQ8iN/niZ+LKDIwAUaxRHeLzZndbO4R
a76tNtK7Dk38a3vOkO9iqKZ2UDQAzX9ZlfZvfPCgU9N5gSLfchW0lz3qwBZKaeRo
cV0ho02uiFUVcKH5SfM7318BL2sKrXsnLG6oVbMtxPVRi7Sso+uGVR7QNBGhLkEP
3yham3L/h41q5/7KXK6eU6ZcQZBxsIra1d1TjoX8FG94y5GKsdSAfAcWmbMf1bBW
iPoSB18rTGHgq1wz4U47hACjmaC/M/UkrXovQH6B9HHe6I3drdDo/i2/RV3v4yQG
iQ2Di9Z+fiI9gVjflcgIEho4SmwMWz/a/gLBRqqlj6FjkfTSBkc5LVPpspVfSVaG
MRQBAHibHrg333oUF+SAVzLetrEML2upGx/KJBjf0k83g84cVetwkVTfYitGheft
o0idFms2a0tmiR8RyfJjjmkVqyV6EAtqC3iTP1B3D6/4p2ty4V7Z6L+hk+rpOijh
znebd/zoAAj3l5Q0dfNv/yL/4pnYQReoh9gRu+RjAw7NPJShp1NH+fADrNc8tpVp
NfUNRvyKs7GQbo3OuoRy36ooZJTtTdBY+a3lX7CqlDA96gqkLupfrHFg4JC8TcS/
U1/i5mihZb5SSHyZRuO3
=prr4
-----END PGP SIGNATURE-----

--lAxbTa9qRtQJ0itf--
