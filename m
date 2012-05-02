From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 09:41:04 +0100
Message-ID: <20120502084104.GB4075@opensource.wolfsonmicro.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
	<4FA0EBF7.2090903@stericsson.com>
	<20120502081709.GA4075@opensource.wolfsonmicro.com>
	<4FA0F008.4020108@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7230931754042339036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3478524402
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 10:41:07 +0200 (CEST)
In-Reply-To: <4FA0F008.4020108@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7230931754042339036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2012 at 10:27:52AM +0200, Ola Lilja wrote:

> I'm actually no fan of ifdefs, but let's say that the HDMI-driver is not
> activated in menuconfig. This would lead to the point where the ASoC-driver
> cannot be activated at all, although there is two codecs in the driver which
> could have been used fine.
> If this is the way forwards then I'll rewrite it this way.

The actual CODECs are supposed to be selected by the machine driver
anyway so there should be no possibility of them not being there.

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoPMWAAoJEBus8iNuMP3dFfAP/RjarrG3MOPTT0Mk7utZKuAe
F44ja4KcIpMN8YNOrUtZ7kJImhxVf+9oFXHREgcE+v5ISV5EakUvuxY0+C95sskP
6ZHGTDjf2GMukoI07siLbJ46TURI8N8vTX1/1RZkwyLDcii5p8Hc7XsWPNjenTfX
KBCaiYZejX9jfOriN6aa3p+TwCJOZ6E3pHVt0JdrDlK1WckXuAZaJZxh107MLAV9
fBc9GV84/JQqYHFpkCUsxSyFPbhSewZ24T/eg0Iy0NAZ3wmm8GRvwimwhcz7h2Uz
mikmBR6xa3pvk8VYvRj/GZr3nOL505A1ULK7GjBIrCafjvZnkvoVmz8JdCmkeqwa
SXChe+odZrBIxFhv/vG1Ruz524atmSXW9iHUmCQ/0QzO3jP0YrGma+bYeoHnJ2lb
WlpXF5HUYpV21gpP9E/Uaexxe0HlUMotOI1xqjsPlPvDaOwTCOlKt7DPzHmEe9bG
CT9aNleCv/i94Uve8hkuMB7lGAkPLw5GE7s9rnNWaHaeedr/49jvSPgKSVauAdAQ
esTiBLZy5Qs7bCnD6UpzZ8cTmXLx2DqBBVpmp0NDaaZ5R/jZmwBixxINhdHGD5OB
LgInFWF9VLWVHhYMTtssI2OxlNoFAW8oVfYqJeuqL9ZBvSPp/7PpG9JRHMLHi3bd
2lqyuV/2RebDMpN60qg8
=4Pu9
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

--===============7230931754042339036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7230931754042339036==--
