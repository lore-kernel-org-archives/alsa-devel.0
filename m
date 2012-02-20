From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add __devinit annotation for
	pxa2xx_ac97_probe
Date: Sun, 19 Feb 2012 18:14:34 -0800
Message-ID: <20120220021432.GG3194@opensource.wolfsonmicro.com>
References: <1329696290.16979.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4547405544577715307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21F8424408
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 03:14:48 +0100 (CET)
In-Reply-To: <1329696290.16979.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4547405544577715307==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2012 at 08:04:50AM +0800, Axel Lin wrote:
> This fixes below build warning:
> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
> The function pxa2xx_ac97_probe() references
> the function __devinit pxa2xx_ac97_hw_probe().
> This is often because pxa2xx_ac97_probe lacks a __devinit
> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

Applied, thanks.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQaxmAAoJEBus8iNuMP3dDAAP/22KJoSf403zJLJrEeoM+dXs
V6JZOlZItBro+iLqC1zYhe7fUWvSxEhv1oQt3epTBaUt/mu/34og3Q9/AceJPY9q
w0FRZw0aHcUh7p66PufS8X+IaIBbhbJoLmLQ2U5Hnzd/mhV0pPx8/P8+OztZPg0L
I24K5Pvfn1OFLW4ueFUzr8WcKbRB9bEG8X7CV/DOEg1TYhiDRwUFOIefg6DwAmoS
BVczsz7CpbXzrhFnp7syMxDpX1+/6dyB9Eq/wSFy6/bz/olJJ8F4f3I0qQv02Uwa
Aa9b3VkS+inQoIHWlz/waj+JZ5jqvxCqaDPCbuVCL9wBNt/RD8ytOlmcbg36YUGg
e+zooxpN7qkIYS3sWqxx3AuzX7vcqJ7G4rZUYkLVPl9tp5ADds8yk/03hYozZVyx
CjYz1Nof4ci4QpOmcsGlhxEyzrWxmVkkNxZsWrwQZzPZio6HI8tmKenIpPO5mUVc
mbGYtr560PIvseZsaBBWgMQciHvRcjClM6I+9iK+eQVUBItFJ34vA1UgxYUeo+Ex
JHdXhB+co2suB6YpX4KY3O9kJlmTfYSCK7Xdo1rHyClOo+peeM3prgb9S8QbdFU4
dB9dEYra4aYZ7hkJHmzEksBJ+4ppl/snjc7fhW5i8AGHAfMe5TmrF1NXcuejBFk4
Bn6dWdyysZ3RVEqbNv9E
=8Evp
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

--===============4547405544577715307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4547405544577715307==--
