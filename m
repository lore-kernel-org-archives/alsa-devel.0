From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: fix unbalanced of_node_get()/of_node_put()
Date: Fri, 28 Jul 2017 11:07:35 +0100
Message-ID: <20170728100735.enwrl7whjkmnicd7@sirena.org.uk>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
 <20170727232612.23543-1-antonio.borneo@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5etejeag7cal4cwq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727232612.23543-1-antonio.borneo@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Tony Lindgren <tony@atomide.com>
List-Id: alsa-devel@alsa-project.org


--5etejeag7cal4cwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 01:26:09AM +0200, Antonio Borneo wrote:
> From: Antonio Borneo <borneo.antonio@gmail.com>
>=20
> On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
> errors at kernel boot, like
> OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0
> OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0/endpoint
> each followed by stack dump.

Please take a look at the patches that Tony Lindgren has posted in the
past day for this issue which go into the of_graph API to make it less
error prone.

--5etejeag7cal4cwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7DOYACgkQJNaLcl1U
h9AvOgf/YCIm1njtJNCH7TlI6gDoLVrw8HKswOanut+kVc1u3hJ6c2dHoL166nCg
3ip5kE9plZ8oMzQuEITithiMU4tHGXgg4tJDlpmSoZ5h64Kq18/PtIB4YNX30HX6
4uAJFWZD4ByQjZqmQCVd5G+/a2/bg2aQHSQddHEVOIXVrbKzCkJOgYWIRVcM4iBP
i2t0apk3JFby6hZj+WYiz2Uf7qT++026sNX93cvCronz0O2yml/HOYjzPyB/gdpK
x36WEjCszSO5ppeD/AjJ4jLV9jAUzpGO9FLNPWpWH7ulGPvWfEioEna3c6ctietx
ZnFk1ku5n4F8cN1ZHwhKijXfyth5Qg==
=7Dmx
-----END PGP SIGNATURE-----

--5etejeag7cal4cwq--
