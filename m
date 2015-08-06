From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/12] ASoC: AMD: add ACP PCM driver
	runtime PM
Date: Thu, 6 Aug 2015 20:26:46 +0100
Message-ID: <20150806192646.GJ20873@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-12-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2375241247996513585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8BA260560
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 21:26:51 +0200 (CEST)
In-Reply-To: <1438871112-25946-12-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2375241247996513585==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mbtKdsM2WfxuaK8C"
Content-Disposition: inline


--mbtKdsM2WfxuaK8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 10:25:12AM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> Added runtime PM functionality to AMD I2S driver. This uses
> functionality from ACP IP methods.

Just add this (and the previous patch) in the driver.  The patches are
so tiny it's not adding much to split them out like this and it's
actually harder to review this one when it's split from the system
suspend code.

--mbtKdsM2WfxuaK8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw7T1AAoJECTWi3JdVIfQPnkH/2QGJ3WOjQIH2jHoLfxd1bW2
PwXQ4+weB+jUKZHvgRN/RuU8eUNlBCCLWIeNjhqeHnqQOgJFImyODubAQYUca9if
uf8iSm7eEjzyxs9Y7owcbQzlJhL78BdgrO5pOPiZkA7kyMxn4kjauz29sqX6CFHE
li1+XYil88sN4YFonQYBVTz0aUdT1IqY2dUBzadjUVPhzXrovL43N+1e408JOjZx
d3jUf7y9ZTy0vSb8l2lVrxs3AKHnhGRn7pcXF+kXET9vzmfBwajQAgqB4c6xyjiF
SA5LgbVrNAmvjyYB6q23R4L1TEqIMYWWbjhxchVSQ+qdYkfyIygIMsEJYqSpgpk=
=WE4q
-----END PGP SIGNATURE-----

--mbtKdsM2WfxuaK8C--

--===============2375241247996513585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2375241247996513585==--
