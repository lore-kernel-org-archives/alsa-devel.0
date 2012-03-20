From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] sound:asoc: Add support for SPEAr ASoC
	pcm layer.
Date: Tue, 20 Mar 2012 15:50:37 +0000
Message-ID: <20120320155036.GF3445@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<45c0240f9e6f9632a28c3ad17fd8132254815295.1332242166.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4804861404348058116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 835571042B8
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 16:50:43 +0100 (CET)
In-Reply-To: <45c0240f9e6f9632a28c3ad17fd8132254815295.1332242166.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org


--===============4804861404348058116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 05:03:47PM +0530, Rajeev Kumar wrote:
> This patch add support for the SPEAr ASoC pcm layer in ASoC framework.

This should really be rewritten in terms of the dmaengine helper library
which Lars-Peter contributed for 3.4.  It looks like you're not using
cyclic mode here which is currently a requirement for the library - if
your hardware doesn't have cyclic support then that'll need to be added.

We've already got too many independant implementations of an ALSA to
dmaengine mapping, we should be cutting down on the amount of code as
much as possible in order to avoid code duplication and make sure that
we're able to roll out good practice and new features as easily as
possible.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKdFAAoJEBus8iNuMP3dMEEP/0WPPEIWZCErMgascYFbd407
squm5FfAH9U8UwYhCWNjVFJ6yCI0tQePdhoMXg0eYrW82xZrxDSHCSH4/HAkXiAL
XThE6IeAjcVyTCVjMncGD2dQOkEPJOFq1VYiOLBwcLk0mT0xU7y0G2+hM6jPL319
Vnocbmpd3pzuYbSk2aUMwHWNvH5Hfsadh/CiCCud826qfCzeZJMQsv8p1EhgZ173
/M4qHLBVphW6B2vxtyLdGSpLZLonmd4urJEQpo8B64F6uVLOaxYK3X/tee6v8x3e
fPRWj72xvwdS+9DIUJQ51eUlybkBG835lqBNzEXFUmc2mbPOt4Gdo48UHhi1SLGc
wocMc0VZx/6H9yG+Ds7Pt5wJibPXYQDR/Gy+/8dfTjf0Ge3gI3g1NNtmeueMtQeJ
06jmaJvX+iuL7etj09So5Js/un0TZtlEYd5qHPwSVmteDAg9zEv7DmhiDlAJZ7+h
44nujrsTpYDJLJ9Zl2dcbgxNIdpzYzbabg8S5KCfo26QVRxz9et2dcaw94yaJ3K4
V+l0zMP+oRSjPUq7xocdwEg2Z7g6H/DmlmoAMieyCK+Dpjtznrx4IP786nPj70nP
Rwd2/HisWMpvkoiMi6eSRV+noWSuUMAFzGj+393dwgVc4OozSO5BBx/afroOTD24
LDkF0kk4MLoRmUmXa007
=XjgI
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--

--===============4804861404348058116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4804861404348058116==--
