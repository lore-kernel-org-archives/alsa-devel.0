From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5651: Convert rt5651 micbias1 to a
	supply widget
Date: Sat, 21 Oct 2017 11:09:48 +0100
Message-ID: <20171021100948.xsjekidnls6ookoo@sirena.org.uk>
References: <20171018170631.9189-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0344529645589843128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FEE266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:09:56 +0200 (CEST)
In-Reply-To: <20171018170631.9189-1-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>
Cc: oder_chiou@realtek.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, bardliao@realtek.com, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org


--===============0344529645589843128==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ekcvjlgybopslcj"
Content-Disposition: inline


--7ekcvjlgybopslcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 06:06:31PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>=20
> MICBIAS widget type has been deprecated. Convert it to a SUPPLY widget.

Do we have any machine drivers using this?  If it was just a simple
substitution then we'd have just done the conversion but the routing for
MICBIAS was funky, requiring that it be looped into the path.

--7ekcvjlgybopslcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrHOsACgkQJNaLcl1U
h9AEHAf/Z0txjBlcCHLJ/h55FIa19UzbSoNKlloj9WKXNFYQpPhuiEUTXae8GhI+
Pz/cabHQh5jt9XqawXglSj8P+PT+aD1GyGgC5fQHgGgRLD2v8qCh1xwjM36xTU+6
FPo1fF0jUqa4Nyv1zPjHnAtTrMJ6dMGkALVM3PM45JFi973867Cg7oauK5+5Q2QI
vimQ+nwRMQeaE9i+WK7XN2Q0o/GvWZpSFa5RWSw1S8izQlzoKiRfszmsA0ajJukK
ghWR7e6R2wy+hf7fvS0tgoTom1iUIQJIG6MsIOI61bTstn3SzIHlC8CaSgDzPx5l
xbGAkAGS8m00RF8K+d+j3cgxb4bzgQ==
=XNM+
-----END PGP SIGNATURE-----

--7ekcvjlgybopslcj--

--===============0344529645589843128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0344529645589843128==--
