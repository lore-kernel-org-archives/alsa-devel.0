From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Convert single bit wide
 bitfields into bools
Date: Wed, 8 Feb 2012 20:05:37 +0000
Message-ID: <20120208200536.GA11038@opensource.wolfsonmicro.com>
References: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CA+7tXihEOP0a-JwEw7LGEhtj3WFR30M0t9PJZ1Ykwq+G5PLE1Q@mail.gmail.com>
	<20120208191308.GA28103@opensource.wolfsonmicro.com>
	<CA+7tXij_LDDFSYM8Wkyfwb1cRDAZ4DMEDVBL-vrnXs+W-8zm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4428410605511242207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F05F8103F38
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 21:05:39 +0100 (CET)
In-Reply-To: <CA+7tXij_LDDFSYM8Wkyfwb1cRDAZ4DMEDVBL-vrnXs+W-8zm3w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4428410605511242207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 02:52:49PM -0500, Trent Piepho wrote:

> Linux defines bool as _Bool, which is a native type from C99.  _Bools
> in structs appear to be the same as unsigned char.  They each take one
> byte and have an alignment of one.

Well, that's a bit of a failure isn't it?  Let's not bother then.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMtVeAAoJEBus8iNuMP3dFiIP/iKAP2LqMxEc4TvgXsLLo1Ji
zcQxHktuTT8jq3zyGxPtOd6fbm93CoOI1CKy36nfeLf4RUKTufAPrPtOCZTutoT7
rWMicpC7LcMyNHpEaNCE8b3QBOIRb6cVVzA8GcXlXVcwCgrXRDPbedYnSklz7mdB
saSwOHW4xdagRI/IdZTwwPYoPgNTN4JjhXmVtsiKYaYg7weGRRKNZJzsW5zT9qbc
VlEBO+VxThN5dCsf6Ki07hcVZ9F6l8snY5ED0BLjvKYqzNmjjY3IJIYchkWLTGRz
A45eWg4qhXhLnpuZOQonnfPltlz0jkjxZ7uFuRYWhp4gf6fRqCRC/hDnw4QJAJWF
2NVPBFXruM3KyrYelGMFQ1pF3TKS90vqw1a3VZeDUnC+tM+k7XNzKWZSaRt46389
tjvk9mJFFQaju2aYU1S5VFZGM4+BYPoUtWUbcBDHrj/sqHSfDvJ3mpTmPPLyz/B9
RAI6AvmRZeicjfyRSpXB/0nWGK1TX2p+XjiKW9+LbBQyYIH68usp9jo7b1wdlkFX
rzWN0STxNkk1WqQB1+yRTsAAT2dQYux4Zy49D4nt+9rLl2DkerfeDTwI0vfi5kdi
ih3GBpt//o8EKmsPbGd/HjUXUwP6BRUwVbd1j0L/hSUcYfWrRMJRvbHgXOoBXsoR
wp9dtnKXfpDLS223Yt7a
=8RiU
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============4428410605511242207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4428410605511242207==--
