From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fix for v5.2
Date: Wed, 8 May 2019 19:33:13 +0900
Message-ID: <20190508103313.GQ14916@sirena.org.uk>
References: <20190508094554.GK14916@sirena.org.uk>
 <s5h4l65s0kr.wl-tiwai@suse.de>
 <20190508103150.GP14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1431858815053587906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F121F80796
 for <alsa-devel@Alsa-project.org>; Thu,  9 May 2019 03:50:31 +0200 (CEST)
In-Reply-To: <20190508103150.GP14916@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1431858815053587906==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LtMyRIzzNoTBiuto"
Content-Disposition: inline


--LtMyRIzzNoTBiuto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:31:50PM +0900, Mark Brown wrote:
> On Wed, May 08, 2019 at 12:27:32PM +0200, Takashi Iwai wrote:
> > On Wed, 08 May 2019 11:45:54 +0200,
> > Mark Brown wrote:
>=20
> > > Emil Renner Berthing (1):
> > >       spi: rockchip: turn down tx dma bursts
>=20
> > BTW, is this commit intended to be in sound git repo?
> > Or was it applied to a wrong branch?  Just for confirmation...
>=20
> No, that's a mistake :/

My train's almost arrived, probably the easiest thing to do is if you
rebase it out.

--LtMyRIzzNoTBiuto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSsGgACgkQJNaLcl1U
h9AObgf/TVTjcsDsAfyFbKIAowwpx5t+9pS+EGMXx34InfwVLqAxRHLDHdEbz8v0
IdV7mKqLVfpWdp1ku+GYLDIGe9OpuiGZSE0Ur91Iw2eoPcZzRLDo/GIMfyT9uUl1
8/0sM3VZ8xLIMmnq1o1vOKFAemM86FQv766oPa7/nsiQFww3CtyuCMlTfVmuMfeK
rbD41JzI4dcJFEq0Nrx6gEY1GEzk+n4pxvyDHQ7H7EtCXPItnIgLqvmub9U3QG0A
LQq4iLsx3z1Jkw8sooOzLfgBCWVCAp3rLMlj/xzugmPfW8iJmAupWP4GMtsPRIlC
6Leg2VxW/n19v1lAx8UIV910gykapQ==
=OSCB
-----END PGP SIGNATURE-----

--LtMyRIzzNoTBiuto--

--===============1431858815053587906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1431858815053587906==--
