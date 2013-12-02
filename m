From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: fsl: imx-ssi: omit ssi counter to
 avoid harm in unbalanced situation
Date: Mon, 2 Dec 2013 11:57:16 +0000
Message-ID: <20131202115716.GW27568@sirena.org.uk>
References: <1384533863-14288-1-git-send-email-oskar@scara.com>
 <1384588345-22276-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4606337239621501942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F120A2619E6
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:57:27 +0100 (CET)
In-Reply-To: <1384588345-22276-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============4606337239621501942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V1B6tgkYnQOXc079"
Content-Disposition: inline


--V1B6tgkYnQOXc079
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 16, 2013 at 07:52:25AM +0000, Oskar Schirmer wrote:
> Unbalanced calls to imx_ssi_trigger() may result in endless
> SSI activity and thus provoke eternal sound. While on the first glance,
> the switch statement looks pretty symmetric, the SUSPEND/RESUME
> pair is not: the suspend case comes along snd_pcm_suspend_all(),

Applied, thanks.

--V1B6tgkYnQOXc079
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHWZAAoJELSic+t+oim9sxQP/3qfyjkpRK8alRyZQfRCyCYe
5NWAdlgLhWGv3XjC1pDbyDJ6+AIz/foYP95HEZUXBRuEQmiizWZYwSu0PVEhIlNS
c1EftcWqRdHIixo+iBJrQFWgDBwjHghDOP4DCXPNhoCw69HVgwG6hHcEDGqW3UgA
w57x5Y7N+CWEGQPYptJVdAYzgGVYDyuzGIlscMXHyJMv467fYnOLfpQapBar2SID
xsqfCO/J+4d+Ve18IaOBvmXEVOlYIxK1DKS1WkEsqJwsBbKz3BaLBrVWUjIa6ypt
jROBeJTo459d6txySqmFbeIuf7fV6IDDJc2kvoj6cjldxI7jt4W1aXZDba0Wny7V
vZwS0ltGQLs9VYpkc1c0kGxtX+OibRlNc2vuRq7kR7ndibMbIaLasmiM/SxdvH3U
W+1McshTW8xGpeup7f6JfYI6hnGJNxk6AmDXbOANezrHZm9r46A3jlakKkc/f9rx
k3eGN1bid+j5TjUbYhuUbNKnK1hN1z2sKLHBro39MX8Y3XnY1pMDkx/xzA3reE/w
u3LH+ggpIWw+IyCNjRL45rY8JcV7W7f7CrS3yrI48llstcdHRb1GyQlIkqF5CPjb
/zQ5Ulb22XnqBt09cIvTdTCsr6dU9nC19iEIfOJoUir6Us1NPrBLvtPuF1WaEAHu
zB100pNIJrCP00alME/W
=w35d
-----END PGP SIGNATURE-----

--V1B6tgkYnQOXc079--

--===============4606337239621501942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4606337239621501942==--
