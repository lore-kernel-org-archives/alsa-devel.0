From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: AMD: Make the driver name
 consistent across files
Date: Wed, 8 Nov 2017 18:08:35 +0000
Message-ID: <20171108180835.7nl7uzxzclcxrfga@sirena.co.uk>
References: <20171108172404.19118-1-alexander.deucher@amd.com>
 <20171108172404.19118-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3122621292284232664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CF32674F8
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 19:08:37 +0100 (CET)
In-Reply-To: <20171108172404.19118-2-alexander.deucher@amd.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Akshu Agrawal <akshu.agrawal@amd.com>, amd-gfx@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============3122621292284232664==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqc7xc3mnwpe5gdf"
Content-Disposition: inline


--bqc7xc3mnwpe5gdf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 12:24:02PM -0500, Alex Deucher wrote:
> From: Akshu Agrawal <akshu.agrawal@amd.com>
>=20
> This fixes the issue of driver not getting auto loaded with
> MODULE_ALIAS.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--bqc7xc3mnwpe5gdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDSCIACgkQJNaLcl1U
h9B7jQf+LeduT0FW9x6i2wT0+BIn/NU+Yia5aIhXcH69zvp2b33vZMy+ScfoqHOp
kLpJg8kAysEuV4VGoCCoz6dg2jJ0JXNkYCx/b/WH+Q0OtxyEBAlqTDSsmbrvl+IJ
5lMvr+azcX1o7SXwY7fp4rcqbt0NSDYGyfM0yLqsJ7PeT2DM9sSad+K9w2sW0Any
Er6/jFouYfZysiC7GUr+aQdzv15S0SG6/ASVTukrg6riyxZHrgPdIEJjx8LKziOS
Tq6rEzDron5Bynu1ILRe/4CAVyNAZFmjKXBhc76q6+BqV7NutpzvMBofYOzZ+L6h
yOe6P1h0pqW909vJSoYJzgyTThzEyw==
=a5kv
-----END PGP SIGNATURE-----

--bqc7xc3mnwpe5gdf--

--===============3122621292284232664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3122621292284232664==--
