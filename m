From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8804: Remove redundant check
Date: Mon, 24 Dec 2012 15:54:54 +0000
Message-ID: <20121224155454.GK30837@opensource.wolfsonmicro.com>
References: <1355280793-23143-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4408853572111359676=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D3AC261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:54:56 +0100 (CET)
In-Reply-To: <1355280793-23143-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4408853572111359676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
Content-Disposition: inline


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 12:53:13AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The condition "if (!freq_in || !freq_out)" has already been tested previo=
usly,
> so no need to do it again.

Applied, thanks.

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2Hq6AAoJELSic+t+oim9Lm0P/3J90bYMHFX+2d5DY2tVtzs0
XSD0iJWPld1hokK5n5TRPo/WmNQ1ie+vRWRHmYVDMeiVtVuXtZ665N/oWhN9ACr1
Hii+7W+ItKwa2nwb4fWQV8Nn3iGYn6NKuPFCaRi4JE1TdoEOl48mEKJmJYEhmlD0
qLkDztQqx9cpO73B1g/HjmS0shDQFGTQfvOAKTVGvLKGK0LN/jovzfLuY3y1Ye2W
ypO1EpIIm3CfzNvBNXGP+d6feZJPU4wz99bWnpm4sPXJ6zLqa6RBToVZKeYT/V7k
Vl1PgxUPMmDuF8YMZI3JZSBS5RBlpnIfX95UI3x56IeSzWK7pzXhnRgf98yT4tOO
aliG/Z34hU5sHHrcT8SC5lfTM0SNJedc/5EKvhE04bWkEEqmu16iQ4ghr2FOVewj
3t5kjF944vYNZbZf3kd0NdRYseS6w9TP8W9AmTXpk8CqR8qWEFlplkCJVjt2fMPs
q0IIwZWKKuZSct5DswaMM8d+dF5NqDh6q8AfIhdiOPqRq5vGNVR8nsb0akni3nRy
lnUw4nLEP881Q+Z7BsgdmWcmmOKICT5SVrBVnOP2kndV6c6ohSGv6e6gct3l7QBa
9qeXttjMRTPLtkvjQhGnShu6k9FkjkMxsfxb5BOi83ZWqnoh1q5YpLgX9s3vOIfJ
YDurWMZNoaNCwRXRTqc+
=b0Vo
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--

--===============4408853572111359676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4408853572111359676==--
