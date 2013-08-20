From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fsl_ssi: Fix the order of
	resources removal
Date: Tue, 20 Aug 2013 11:47:21 +0100
Message-ID: <20130820104721.GK30073@sirena.org.uk>
References: <1376773980-16240-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1810025313768192993=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 443D6261A98
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 12:47:26 +0200 (CEST)
In-Reply-To: <1376773980-16240-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============1810025313768192993==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1z3GODAf0autvy/P"
Content-Disposition: inline


--1z3GODAf0autvy/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2013 at 06:13:00PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> In fsl_ssi_remove() we need to remove the resources in the opposite order=
 that
> they were acquired in probe.

Applied, thanks.

--1z3GODAf0autvy/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE0k1AAoJELSic+t+oim9onIQAJpFxxeKkJVHdkgbHUJaNzEL
sYcXMh9qHnG0W8saRbrqqiTKrk20btor4qcvHC6puEOkOpQgcZAy3RPq1TrgOmdW
xuISMAKARjdTatxZkV81iicmU4lvD757f3mZ4M/vu/M2JCwBuC+Pbjs10sv3r8Lt
iEJEKAZdfZ0DmqfqjR/N7Mjrdaiwctwe+Z4/qz1H3HryOY1abYj9NheCyMhnWCoV
eMu2sDNI5+Z86RwN1h/5eoYnP10wpvcyYlQNieg27wqLTIWT5hZe7ptFmqjOsLuU
DxwwP+PV+pmZHqNkVCTRpwUUNRXlTEr0qWy8KMB3QXFcQ1xrHiW2qjQt7Gs2o4A9
dSGL4tgCpmsEmJrKgSCVeqS2qvqDeIEO8Qcdd2NDPzpti9Yq+3CktTmxdHUIgaV+
jAPpFgyAuk1obgr28RZ6eQIvMobdaX+I39QiUV4Hbk+2HEtnBMzOoPVeoA1B4WFA
FJSKzZs3bjfjQl/FgeKIdWvBMJCx/GhvliBIdu2Qg/Xn0s2fnGCQ7vQlmzHdEQ0Y
kbiWIE5adwAnlE09iq/hujMuE/CI1QAR2R+KPraCJTWLBTAzTIrJTzNlgkl64Nt2
YoMwYD+ET82GEvDJPZNDMkjpVG2k8DnRTfDGYeedSw2yh2Cn8aKL0vmVpk/ZSOi/
W2MMAVL9aWFHHcalij/0
=KWT9
-----END PGP SIGNATURE-----

--1z3GODAf0autvy/P--

--===============1810025313768192993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1810025313768192993==--
