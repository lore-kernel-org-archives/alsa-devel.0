From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: samsung: s3c24{xx,
 12}-i2s: port to use generic dmaengine API
Date: Tue, 20 May 2014 23:19:18 +0100
Message-ID: <20140520221918.GI12304@sirena.org.uk>
References: <1400617569-7187-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1046446324313860851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC882654B3
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:19:33 +0200 (CEST)
In-Reply-To: <1400617569-7187-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============1046446324313860851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h6kVQ4zI7GYcAMfB"
Content-Disposition: inline


--h6kVQ4zI7GYcAMfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 20, 2014 at 11:26:08PM +0300, Vasily Khoruzhick wrote:
> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412

Do these depend on any other code or can they just be applied
immediately?

--h6kVQ4zI7GYcAMfB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9TiAAoJELSic+t+oim9nD8QAI9m2GFVTuf/2vmaFvkMoxkt
B/tEUvNf01/OI+I1vDKWStpchaenDKDeqrBXJbpeTSmSIntJ3dKroDTS+4Tpksnu
8rYgXoAvgWPqbRyeJ7lMstpJC+aoAGA2DOW/3iF3Nj6nuWUDuEIqcYD6afwhvIWq
ATx0T2egokBh3KhftyX8cLuUggm3MtSntCNTevpntH2ewGBYk0wV0nMow3zScn6x
O0PFz//Okjb/6tYsUUHq9X/4wFd2BO2GaPe0Y4fg0NQfBtDkiCCUKN58DOG5Cpxi
6akGsnayeQpLQVXW1iBi0W3CQJPPGdhXHfeCQLEJbGreWi1E96+XaK/YoA+c96xk
X+MQPdyT+o1YBDnD0sdERJWxBC36Ggs6NBbM2hKmzf6K4ZyLuPmgA8p4wkei+6Yb
V4z+Afe2ry39Fn/bk3livbMUgjENWmNq7kNNq36rVGcYhl4V0t9o7omSW1cQNSpt
HVL+Ci+usmOHsvwWenG1rTEb92iSnJvqEFHGv1jRC0U8Tr92bIOfDE4Rm2ejhb6r
OqFa3ZMOAaEAxoz6FnkV6TA1dVzXBju1U4pjhS60gV+26Di4gnJivlacCAUDXe/H
dNCr6I49ZU/t8Olrq9w4/BODrLqBM4O+sTd37O6djNsHuZHLZ1JvD8qrAJrDkwak
koIbq5/+ZTArXjnDqoQr
=GMog
-----END PGP SIGNATURE-----

--h6kVQ4zI7GYcAMfB--

--===============1046446324313860851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1046446324313860851==--
