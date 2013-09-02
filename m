From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: mxs-sgtl5000: Simplify probe
	function
Date: Mon, 2 Sep 2013 23:36:14 +0100
Message-ID: <20130902223614.GB3084@sirena.org.uk>
References: <1378155378-22627-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0879355202709054538=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6EB4265262
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 00:36:17 +0200 (CEST)
In-Reply-To: <1378155378-22627-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0879355202709054538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MHoG8na4IvP3G3ze"
Content-Disposition: inline


--MHoG8na4IvP3G3ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2013 at 05:56:18PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> mxs is a device tree only platform, which allows us to simplify a bit
> mxs_sgtl5000_probe(), because there is no need to check whether device tr=
ee is
> supported or not.

Applied, thanks.

--MHoG8na4IvP3G3ze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJRLaAAoJELSic+t+oim9WVYP/jvZuqkKmzMVnv5YQ0eEISKu
kFbj3RmXMIKTM8P/ZmG7QVVizwKl2cxJGNGcOGX/L2Lp6EWgwy7J0yNAFgKkcnKa
T+Kgdl7cc6ZWDJBvUP1VTMDCqYsIPVjJFHO9l/erkXbxMIf3A14Xh6428PInd+Jb
vNg3Si8xrRdRT3xH1HTj0XGigVyLM7Vomu6Ft+cujtT0thyJO49xASfBGyWoT6wm
sKOcR0rJHgasaNCFdI/pw7zBt2gGxwsaAU04E3vz0qzhthsqBzpQHbb/0FPhpFdY
7ycnpdAD/u8t8xL1oFTwRcMQNHh2wbNy9dr9xxDAnxf6aYk0NHak8k0uAn3z1GCJ
/AIHVQjAbCubE8ErATuaN6hHlFKQyyBD/pJD7VThnh72ovxfFqpgpW9XbA4neTgV
LtfSpo/NE4Wxes+QhLT4lOD65MXH94T0Uiss1jKcTr+RTZdWrl7tk4CA20hz9bIh
Jlm9PBF7TEfjI1M8PCzvhHxYN1lr45j3mowzN6Vij0umqSQ4vRw2GHwFMPc7VTR6
uC2UCdOdH6he1R3CNu7+/bTlvmOOuuMOO3G7U6iRYsdI8xngc6EfT+aZNfWMvCuD
ZJNuwQeVgSJ48JCAkdSR6lhd8UhX0v1r2QQR8nbeiH0C7EM6fSdh9c0PmGGS4wtw
HNAFwEAKcg4IfewE/N0+
=vKfG
-----END PGP SIGNATURE-----

--MHoG8na4IvP3G3ze--

--===============0879355202709054538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0879355202709054538==--
