From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: omap-abe-twl6040: Introduce
 driver data for runtime parameters
Date: Tue, 8 May 2012 19:31:01 +0100
Message-ID: <20120508183101.GL15893@opensource.wolfsonmicro.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7543172991281839666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 873061044AD
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 20:31:03 +0200 (CEST)
In-Reply-To: <1336479314-27766-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7543172991281839666==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xp2nimoPFnvF0aLh"
Content-Disposition: inline


--Xp2nimoPFnvF0aLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:15:13PM +0300, Peter Ujfalusi wrote:
> In preparation to Device Tree support.
> With DT booted kernel we can not rely on pdata which used to
> hold information needed for the driver at runtime.
> Use the card's driver data to hold these informations from now on.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--Xp2nimoPFnvF0aLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqWZeAAoJEBus8iNuMP3dqFcP/3Z+VZCalwd3zyNb2d0JI0AQ
00iw4ZPYk13BlVgLmmR5DJr8Qc9BAnevVjhlyHAPz/ACYrFqsiw7ySj+PtdZ75E/
xy4PMYXwEel50V0ftX6qq3JV0VuW5jJ4gQxdCXG2hqOjSnB3ff3gxFv81MWLECzV
89tdIwIlSyjxVb4fDnBic6AP5TM7EaLoiGspjSCKv5HQlWMd/+rmsgaeriIAMomB
QRrbdmPRqlS7WwvnVbMJrIAasEnMYMKaF1mNC8CbuMfh1r/WkKjOeYX8W50K+1Um
ej7iWlGr+5SN+DRRTwhObIDvwa3TF8AIQBwTePNUbUeyx+G/7fV8XppcGeSu2ta7
Z1seqHvMNvIy5Uw5H/USDpJU5eMM3zoKOw/AkUGlc3fNOAV5iWNEyhG8EGz/cBfz
4xdStbsJcBdyQKS31apB1ONzwt5TktReZwhlb23N6QXHOImsaRRrw78QobFpiegW
fyqT2Fydh9Cv/CX/LcPY7TAmnsL5FVbYB1WqHhu8R0RfbeDu4+LszEBgCZTXT60i
FvPh7lwk/2WE1lv/3US4q4rNWse9uXbD1aBW+l8+agRo/MvpY/VbDOBxCnSBBfrn
2SNI5NOB6FKbtiByur38drign0E83Lm1fMooRvSeTEnyeSQegkukArtWJ79xQlg8
qFzKZZwsJGggjbql1q+q
=mar0
-----END PGP SIGNATURE-----

--Xp2nimoPFnvF0aLh--

--===============7543172991281839666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7543172991281839666==--
