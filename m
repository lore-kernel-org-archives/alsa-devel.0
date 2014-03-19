From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: davinci-pcm: Add empty
 functions for !CONFIG_SND_DAVINCI_SOC builds
Date: Wed, 19 Mar 2014 13:16:25 +0000
Message-ID: <20140319131625.GL11706@sirena.org.uk>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6272956280583802178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B412650AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 14:16:33 +0100 (CET)
In-Reply-To: <1395148837-20850-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6272956280583802178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uUoSg1UUjevva5DU"
Content-Disposition: inline


--uUoSg1UUjevva5DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 03:20:37PM +0200, Peter Ujfalusi wrote:
> To save drivers using davinci-pcm and edma-pcm the need to fiddle with
> !CONFIG_SND_DAVINCI_SOC in their code.

Applied, thanks.

--uUoSg1UUjevva5DU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZilAAoJELSic+t+oim9NqUP/jeYiAoCTuMGzHjvYECyDvVA
Trk5KsG5Bebj68r7tN0h2PdiZ992gpLLAWYDH+0Y0Hyax8DkokjN6UzEJV1hsCeJ
l/BZzPZrSNy6KktMRDF2922g2aill/FGM8RCUAGAVUt+IJcabS/uj4meUM+2va8P
sk870+6eO+UB7Ni302Z454DUEWzQNy5nOMsUGRFw96lnrjFnI/e7JzzWEYAA49Rm
peiB8emnteyD0AhrAPnDCUZ/s2O+q5sS9qjrskl3esXSqzDMaOTLTIbMRKL8RbWX
kHRq0NIjaHfMN6LxSGz321xYMYPL4qOh6QSrm+0gGW06kzM5z7iiCeb1m+BGHOE9
GVijxg+IcJzJKbyujpTFk0B7ipFnjgcGabQOzH9/jWFxSnpedHfugtiELCelzwNF
KeQ0IhQHgHC4paolvssHvVDI+4h+siEbgjupEjrJ3I3OvyGwCIq2hYk0Os1M3+QK
N5LaMIddliZUMt8LgrkmR2qRkKw+GigxiUduYUhB9D6BH509uuuX3SSfxdqZmwVP
McuEcs2Fw3WGimpRMbKYNv2I/Gxh9/vrTZncSkus7aUdQQVULl7FyI48qCg4UCLQ
wwZo/NfK4eydCXJ8lj/xjjg50dfm28VOpo9mSMrMnnc7R6b2j+doa7sq6wLDU94k
0FxFwKaEsLb5qrTa8Cm0
=kA13
-----END PGP SIGNATURE-----

--uUoSg1UUjevva5DU--

--===============6272956280583802178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6272956280583802178==--
