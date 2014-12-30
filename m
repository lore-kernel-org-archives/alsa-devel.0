From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Fix incorrect xDC field width of xCCR
 registers
Date: Tue, 30 Dec 2014 11:28:59 +0000
Message-ID: <20141230112859.GM11764@sirena.org.uk>
References: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxsv2zsxQJemov+e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, a_bouin@yahoo.fr, timur@tabi.org, Xiubo.Lee@gmail.com, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--wxsv2zsxQJemov+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 04:13:51PM -0800, Nicolin Chen wrote:
> The xDC field should have 5 bit width according to Reference Manual.
> Thus this patch fixes it.

Applied, thanks.

--wxsv2zsxQJemov+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoox6AAoJECTWi3JdVIfQCz8H/0X2DG9RkZpqduu3gEjXZDl8
qUeuoP1nXkh3Gv9Rft+mFvycXbwmwbWXRV81H/bwQFTDOg8JrsAxiOZw+oDBAkaA
UsrpzTXTmt7oCSHcxYqB9Bt46krvktOfAj0ii7VynbdhPEqBjVg9dQ4Sm+EdZiPd
kzMKLehlqDspWhIMEMlV6Nn2Tf8j1oXfIc6hcb1m5AI+VSds9uhvF9tQ1a7iaZB8
grvP1JB9IxngnvKmmwvynfavfcVfkc+cZHVbJac0ZUeBiB0aWTLKkecO9UWq7VZ5
8bULy361+1Ii5SnqN/d2d2IdML7WA3jn75/Wf+jWPL3crVCVCaeHd+V1pV2IYCY=
=2NqB
-----END PGP SIGNATURE-----

--wxsv2zsxQJemov+e--
