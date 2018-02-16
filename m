From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] Use of shared resource in designware
Date: Fri, 16 Feb 2018 11:47:54 +0000
Message-ID: <20180216114754.GD5886@sirena.org.uk>
References: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319715640333296588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B837267761
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 12:47:56 +0100 (CET)
In-Reply-To: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0319715640333296588==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 01:13:28PM +0530, Akshu Agrawal wrote:
> This patch will allow the driver to map same registers
> to multiple instances of driver.
>=20
> It is useful when playback and capture have same regsiters
> and are required to be present on separate cpu dais.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGxOoACgkQJNaLcl1U
h9DSrAf+KpSF+O+8ZPwzM7BG4jBdOKM/QKij8LqTJpjfKVLe6kcYT8mWNqjg5mmJ
MKRXdv8vsK2g2MRBiCrGPYu7w8umQ+IDznIdVGDmJyPN9GLCHHwiKCW0SZQJQ55y
sjpVuXWbk1wMcRo5K1apkHsSmeb0v9jAjE89oRVDlfEk68/aXXSK6269EWG7IexR
QHvMQ0ZTnBreUHCopl9y/vj65OB4R29Asg5mKoUrENgd5UU/YGnV8ZiJLxpgCotO
3Np2/d+mikTOxPS+PfUjORFS/RymO5W3xW0cqr1AGEm2FuY5vXYk8d4VEurggvkk
/7O0FDduVvCtwst6by8ipCW1CVmNbg==
=RGMV
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--

--===============0319715640333296588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0319715640333296588==--
