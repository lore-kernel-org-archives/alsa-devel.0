From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/16] ASoC: core: Add 8bit multi reg
	control accessors
Date: Tue, 13 Mar 2012 21:25:12 +0000
Message-ID: <20120313212512.GD3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-3-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5554090235991660682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A4EA10416C
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:25:14 +0100 (CET)
In-Reply-To: <1331651503-16917-3-git-send-email-ola.o.lilja@stericsson.com>
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
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5554090235991660682==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 04:11:29PM +0100, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added get/put accessors for controls that span multiple 8bit registers
> which together forms a single signed value in a MSB/LSB manner.
>=20
> snd_soc_get_xr8_sx
> snd_soc_put_xr8_sx
>=20
> Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

This needs to be part of a patch adding one or more actual control
types, just adding bits like this makes things harder to review as it's
hard to see how things fit together.

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX7svAAoJEBus8iNuMP3d2YAP/jNdwwLLi+F1FyaHfvqURs6T
YEHqUgfbORfG26iw5JY8P+7+ruxwt8SJrLCCYs5g5IwI8SoLQa3/mJXpxcHeiHN1
9G3YPovbhVanvWJRMItTV9orfjUrRbXT+3lPBA+mOJ9pB3qVd983Gj13weVhknzb
q7KvDesAk62hF4y8QV3hI6NRGS4qx5mmm5STQiEqHgkCscwK/5et9LCdGfLB1cNO
kyYSq9lLlm1QOY3yjxOgbzDqthxXtVNQWdJhskQ7oM2p8E103/hVJMZq9v+i5gS0
Gkjzi5XHUZDZc9y2MGJG8gyAZ0Ag7FNgfcD8rG64v8qW+FGVr2TZYm0+29eU0YdN
d9+VwdMiQgtyki2QwOzgaM6x4x2OTpaqMuvO+gayvJZg3qaVq2BEnb8BgsQvkpsw
BM+cFoqKir9YfWqrfea61F89TjKuG0/BtGgbpfnJEVgMxvnof5bRicALp/rGVUlW
OQE5COkkdviuci1yGwG/MIkaPdFves4/nUNl8vkVhXJVRYw+69+l25X2cbQDkc8Z
fHI/1ABc61FfVlnFM+QVqmmLJNx4xbnB2kKr1QbgauYnKZ9zI7a8sYteivd3zy7x
oMVnH+s3jecVTxIchCcNOAWTl7qMax21fY8falwZ04vdA+GRhY35rEVzIRR0tctx
E0ULGSKL2C8wd6P/HEbv
=CP+y
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--

--===============5554090235991660682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5554090235991660682==--
