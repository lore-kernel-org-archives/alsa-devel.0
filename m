From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl: imx-audmux: Do not call
 imx_audmux_parse_dt_defaults() on non-dt kernel
Date: Wed, 4 Sep 2013 00:20:29 +0100
Message-ID: <20130903232029.GM3084@sirena.org.uk>
References: <1378232052-25697-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1945267199796725569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 693A6265479
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 01:20:33 +0200 (CEST)
In-Reply-To: <1378232052-25697-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1945267199796725569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j1Wwy33+dU2Jf0xa"
Content-Disposition: inline


--j1Wwy33+dU2Jf0xa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2013 at 03:14:12PM -0300, Fabio Estevam wrote:
> Booting a mx51babbage board with a non-dt kernel leads to the following crash:

Applied, thanks.

--j1Wwy33+dU2Jf0xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJm65AAoJELSic+t+oim9hjYQAIyHo6cjgoQeiGo5PXa8V0qN
Av0yFUwNhPT999vT//Vb/79S52WXQ3ZpT/ZxLF7cwbGdidpaIk5kGLPsShq5HKIe
ml0LnB5+VQ1DtW1lxFSuncWzF07wHd5kF6PgATFY+cp5ZVjv9fHNbyerzV5k8aVE
hRLnRglO2cdnOdUQKr6sW4IDN4vcZoaDGAysVjY9Squr+4ms4z+Vo+2xYYt/9H9i
32X5Pnf/rmsQ5jJBN6VcQ5b2xRU/w0q/t0UjgSYNkHWCxRpMSs2YoBtY+Es0+2UB
4VGvYvlN+wJazQHwBAMukREkWHt2bE02FOTaKdZGhIzPJYOqVk3QyJnYvTwG+hh6
1PqvBkuwqVgkMON5hp2PUpvMUUtmlpYQsAQxXP1TV7ldOhqiA+YP7jjcSSb4U7Do
q5KsK6ZMlS48EDFnAU4phd5tqqCaP1aG/gNxYv+aRJvWmIo4IoxwGnuicmKPsPcS
b74gi150R/j+D+kXjYPPNHgSOs29WfXPl8sbDm8N1VGr6lQL6vMMo6Nel8eSharn
j74IIapxcwjnnAc9CNzITD30OiTpNC1yFL7fKGmGO9vscsay69If0LWwnjsQQar+
pjpv2jYGEFC3E19DZxdRuWz4wCflcsOCVjVCPq3/ivydDQifK/fVoubgx0OQkKPt
bluDR9GK+xG8F8j8L2jT
=+U24
-----END PGP SIGNATURE-----

--j1Wwy33+dU2Jf0xa--

--===============1945267199796725569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1945267199796725569==--
