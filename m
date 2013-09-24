From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fsl_ssi: Fix simultaneous
	capture and playback
Date: Tue, 24 Sep 2013 11:00:28 +0100
Message-ID: <20130924100028.GP21013@sirena.org.uk>
References: <1379909305-23572-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7617878826008134029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2408C2619E7
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 12:49:00 +0200 (CEST)
In-Reply-To: <1379909305-23572-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============7617878826008134029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dyeNwb3VXvZMW7tj"
Content-Disposition: inline


--dyeNwb3VXvZMW7tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 01:08:25AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> When doing simultaneous capture and playback on a mx6 board we get the fo=
llowing
> error:

Applied, thanks.

--dyeNwb3VXvZMW7tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSQWK5AAoJELSic+t+oim91QAP/R09U0zN6dcKw3AAw8ZPyESz
W34IQfFrT68uNbx3dyJG1DgS/PCIyybzT9cVysg1nLBJjliSSQcNKGM4GreAcCMY
koWQvXk1/wLjv5YVaEoQgi2d9HYy8c8MWeY8vAlxveq/W9QJ7FwiC7YLDmO3jAxY
qSdS2fNI/o/FmL8F8o2y3DBSQp1ySvZORjPLkhGMrcfYrsBr6lDyOrtJNTHI8/Kt
cKomx+5BlYAftVGx02SiWIedyrMPQ1g0b8NtkHpHka/ibQrSRdYSaqzfbdwhzIMn
Bw7UZKeFUYGpAeGB+Sl4imT9bHauMBt+iToP+Jfbp1tm2G3NOV+fgHJOOIno0l+1
WDYIsAjyI6KCPjaPzCzERyVtfzv9FC8T3TB2A+ub3IUuDWKgexyvKvaWsg3Yg2Yu
5Y3pTDOsz4Iz8mRjkMUImWDpgKOWmu698Cfy/9WK5qtzsF3Ont88j4ymZT74G+tc
neGQDHEyQC+jnAVK0M1uSyhWVcdiclx89i8Wj4Pr7UIDzILhtgjkZeSN+fLmhzYn
r0Au+RR238Btc4FbTjq1g+zCzp5VmUadPMnxlCqarfZw28gkBpm/j14MHrqmlR1L
q5Zbl1acDmRlA9Y7p0UuEKSh6SXlFD1nO64hIQ2kFWRA3C6FIPvZ8RabLdSwDp40
Dv8SCKlIbC1ADHUb1ePb
=fNT4
-----END PGP SIGNATURE-----

--dyeNwb3VXvZMW7tj--

--===============7617878826008134029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7617878826008134029==--
