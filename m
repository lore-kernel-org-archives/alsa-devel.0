From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/9] ASoC: sun4i-i2s: Add compatibility
 with A64 codec I2S
Date: Mon, 15 Oct 2018 10:18:36 +0200
Message-ID: <20181015081836.onjczcsg5qwp6rbt@flea>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-2-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7013204625483334419=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 7311C2677CE
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 10:18:37 +0200 (CEST)
In-Reply-To: <20181013165329.13363-2-anarsoul@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7013204625483334419==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v77floeb2qfydaok"
Content-Disposition: inline


--v77floeb2qfydaok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2018 at 09:53:21AM -0700, Vasily Khoruzhick wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> The I2S block used for the audio codec in the A64 differs from other 3
> I2S modules in A64 and isn't compatible with H3. But it is very similar
> to what is found in A10(sun4i). However, its TX FIFO is
> located at a different address.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v77floeb2qfydaok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvETVsACgkQ0rTAlCFN
r3T2+g/+PD4bXTNjGO5w7Zsb+2Mr6WJMqXC+ONBknYYiAac1d/RDihcDgf1ibB9q
XxZV0rA6K9l1UeCDPJ8JpobqZu84wFrjbqxcp7FVzKQnGYSOjDGd5jKVUlGSGQk7
ciXg/3C2Nv7zidbr1a2LzACSO/ojrue61FGnaussIU+TcyhEvHOQLa/0sAXVw3ar
LKljsvnLUJa4hZud4T3fQ0hNWZ1Px0FS26AaY6lwf82KkP75cgoEW/a8dk0jpt0U
XJ8y9D1+36/Xnf/MwnGX7OTlNhIvTyaqHn1zPfWTcEE+AA9Ns6pjjjNkOXbvGLYV
P5bgqroJmLVk7WnW3IAjU9ebKUGf4JXmCZ/qw7HhUeKVB8goCsNtViuqEudWla4Y
ukJkdTrOxoHnXKxToDGNNVG0s8MTvALlOdz9fNIO+pZxmVl8zEVcHWzOZQCMlHnn
E3M0J/kxl/MdgEabagCYQlgoZiBNQWSat0aDKAVzd/KB1HQyCf48NbjvMQWrkKT6
0Isg0i4QA1Y2ojuc1+Vc4I76Wj/BpgP8JIz8actCf5m8kMgLFEtNPma+FSE9a7ey
Y0+qr8lCmQX/wyNhSJ4hn3dWHhe0tS4cJk6NmBKPMYN4WJun1l4pFrqsVaafVjAQ
q6WNaZLAv5W1uIHvVyhKQGQ1+NGZiZvCtWo7HStxL8QFYUX1Nfc=
=rbvd
-----END PGP SIGNATURE-----

--v77floeb2qfydaok--

--===============7013204625483334419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7013204625483334419==--
