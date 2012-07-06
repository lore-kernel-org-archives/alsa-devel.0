From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 6 Jul 2012 19:03:33 +0100
Message-ID: <20120706180333.GC5437@opensource.wolfsonmicro.com>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4172842768038736748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CE5C1045B3
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 20:03:34 +0200 (CEST)
In-Reply-To: <1341590225-20837-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4172842768038736748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 04:57:05PM +0100, Liam Girdwood wrote:
> Codec shutdown performs a DAPM power sequence that might cause conflicts
> and/or race conditions if another stream power event is running simultaneously.
> Use card's dapm mutex to protect any potential race condition between them.

Applied, but I do think this needs a much closer look - there must be
some other issues lurking here.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9yhrAAoJEBus8iNuMP3dPtAP/3ogW9VFSIvKTnciR9rOwhnv
BbZZryNm8xl31E8Ua9lyCVia2APpOUo4Q2NzTReD9NcU7HBFXSBKynoOh54DyblN
Uv5BFuiHE6VTqkfxicR0pk3AV4WTQ2SRL0d39mdx01YAzuac6N5efKBRxXHrs0np
OGBoyd/Z1WetjDMXwyuVEsNZzMYnwylhkd6GFo5uRji4vKOvT+BejPbD8BbMfSGM
f8zw6oadk7K9rTx0mfpcqligBK4gWqAM+C2v1p1Ktw42N098ElUVpxcauL1Qh04S
e5VZdkGXTgEQIb0UzkM7M4iy5z1nwG2zQ8NZLZYTvbC4F6/6OlI35HyipzmgMUIC
8g14blO8tikjIFnbqYLcmfqSGl/B+8xyy/gqjXCgTbm0wMbB/DnEbLWMoH9kXotT
GLUkl1nPG+hinl3+01cPlblpA9O5tz8sCmMhZaNevOpnbE3GjRdfBCqFZ1JAeI4n
y9CDYo5mn5BXJI78Pph9z0g2BFMa+KtNWjKX5ezlBzAFTNRKxGQhI5ece/GJTXXS
5IjMoL7nsDS60CzCanM0kIRnfrU3RgH+n9jImGhfAcfwP9JMNHmJv36EOWK1dXTK
cWReA1wgt2/2ufDFrkvQiKPWOfftf6WFOwKZOYBnmjmg+tcN/Yo8V6MzFBlJXuBS
Iq4kB04OgpU/e1+SYSMm
=isMz
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--

--===============4172842768038736748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4172842768038736748==--
