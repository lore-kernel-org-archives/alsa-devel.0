From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: sst-haswell-pcm: don't use
 snd_soc_pcm_set_drvdata()
Date: Mon, 8 Aug 2016 14:16:20 +0100
Message-ID: <20160808131620.GG10383@sirena.org.uk>
References: <87lh0h9gh0.wl%kuninori.morimoto.gx@renesas.com>
 <87k2g19gd8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rEjiS+nMGFQ7Kkj"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k2g19gd8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0rEjiS+nMGFQ7Kkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2016 at 06:09:54AM +0000, Kuninori Morimoto wrote:
>=20
> snd_soc_pcm_set_drvdata() will set driver data to rtd->dev,
> but driver data of rtd->dev is already used as "rtd" on
> soc_post_component_init().

This doesn't apply against current code, please check and resend.

--0rEjiS+nMGFQ7Kkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqIYjAAoJECTWi3JdVIfQxBcH/RS0SnuysMzYdVV9PO6tUit+
JKgxzfUnUvQCjoshmwoRz8KiX8zRD8u6s9BLcHd42wW3VvVz+En3die2ZK87MhcQ
mxteonJZYekn4fM6RlpDeY4zA52dN3B+fevIKTgMdNhDMYwH3Xhz7iuqg9yY73W0
KMkRs0azhvLFZDtyfFyq0jBc6VVw2Q5HHKjS/FBp2xGmI28V3vK3LBewLBK/0IwU
qAKlTBXevp51Y0zEw+XYzTGqMZLZUVW4t7+lUq62HH83Y2uuoNCNhxRwewyjDN7b
dc4etCgS/2J50eNPrxIgSn+NJ93f5nlK0NtwRT7NBL9DzcJmdrJd+lupHMG+6+g=
=h0jC
-----END PGP SIGNATURE-----

--0rEjiS+nMGFQ7Kkj--
