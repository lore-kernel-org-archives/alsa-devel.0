From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 10:59:17 +0100
Message-ID: <20130614095917.GG1403@sirena.org.uk>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1130730193144926957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A29BF261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 11:59:20 +0200 (CEST)
In-Reply-To: <1371199940-29803-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1130730193144926957==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5p9QWNAcIBsfgc97"
Content-Disposition: inline


--5p9QWNAcIBsfgc97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2013 at 04:52:20PM +0800, Nicolin Chen wrote:
> The analogue circuits in WM8962 require a mid-rail analogue reference
> voltage, VMID, which generator is enabled by STARTUP_BIAS_ENA bit,
> while VMID_BUF_ENA bit can enable buffered VMID to avoid audible pops.
>=20
> Besides, these circuits also need a bias current enabled by BIAS_ENA.
>=20
> Then set VMID_SEL to 2x5k divider, the fast start-up mode, to power it
> up. And let set_bias_level() handle its 2x250k for low power standby
> and 2x50k for normal operation.
>=20
> This patch might be kinda reverting operation against commit 52c0eee3
> but after testing with WM8962 CODEC, these configurations during power
> up should be essential and soc-core would not do any of them. So the
> codec drvier need to handle it.

The biases should be being managed using set_bias_level() which will get
called automatically when audio is being started and stopped.

--5p9QWNAcIBsfgc97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuulyAAoJELSic+t+oim950EP+gKIc0tMVNOr9FjM6nqO14BM
WbuMV5VUcdFVv6Nm7l30cbmkHZFc5AIoyGsEG+OSYlG5if4+bSiIqoIzY/NAlUj6
Nsr63dSNTG3E1M0wW1nkkb7iMC9y4vbS7EA6CkkoTZsfJrfI+FI1VQROK5tdOFpo
oAwovJ3TE6AUxJuvLQhW/BOwE7y20DnfzMLW8df3LkW6kUmiwmwhyWOwYwTviaS9
5NQM7xOIc8JuH+sEEG0pbZ1w/JXXW4+TD6QN9Hu2IgFRpj3ND4kB7rawyAoz6svz
FyvhACO95YlM85Q3tsLZ8KO5o4Xf2e5maUj3U1ImT5YUp6tmtBk5BXCUpJiua/Lw
seCt2bI7C8677LhCYSjtqCcgCDl/UbeFnFJkcF+rnc3q7Mbg3ez4UZolVzR8IvJy
Rs866owRPfjoeAAFO23ucCPllV3c0+qbtA4pWo+Jr3zxoctV8pTms/TO895m1tRn
alwzwp74kuCC9zZUXaTvAqjqDYIzkcp2UMTQksv9IY5PqPatsjasKVox196QhufS
Fg0O9kgtjUJkRpRJ/6BZrUcyow0nGl6fejgC4BysYhYNafzGMxYJbEXgPWXtku+C
ALE1l3Q/KzWtxyt/YftxfoSyKjYN7sjU1yCmVDoAnO39a0/y+aJHiJK+dgvTlgB9
kIylL0Oq/Uk7wkg5nsd1
=2L/h
-----END PGP SIGNATURE-----

--5p9QWNAcIBsfgc97--

--===============1130730193144926957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1130730193144926957==--
