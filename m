From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to
	debugfs
Date: Thu, 21 Nov 2013 14:22:08 +0000
Message-ID: <20131121142208.GU2674@sirena.org.uk>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8873175148741793461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CA19260307
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 15:22:13 +0100 (CET)
In-Reply-To: <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8873175148741793461==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="euicx1nb0cXzb+p3"
Content-Disposition: inline


--euicx1nb0cXzb+p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 10:04:16AM +0100, Markus Pargmann wrote:

> This patch moves the statistics to debugfs and disables interrupts
> completely if the kernel is build without DEBUG_FS enabled.

We can still see the error counts through /proc/interrupts even without
the debugfs file.

--euicx1nb0cXzb+p3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjhcNAAoJELSic+t+oim941wP/0oXxyYjMPh39zpzsZFPc6fv
uGDlnDgcTpR08W/FSNf65/SrWCkXfmQVi1D11bKurf0FcaiaNKVCfULmgjlHu2t2
KSuW/SMuN5ZkAmpJuZq9odRlfDxPBQyYSM2M+y74DZgOickhlr4BoLmYQNw+kYK7
dxhSJUBPAS5tHvndzoMelwD4E9sZVulpBhINXcdakTQU56Jwwi9OMmHhRUHo0afB
BALOaJT/pz05fb0QP7KU73QgUeXzH0e4v4e9bUibCvpyiuaVbHZ/01FiUsy+PlWe
mlhF9lFrxE5DUX05VjsBKupaq1X23+CVkfCH6vBQPc9XkKnHMm3CY83WPeheA+UO
7GLse4FFfdYqxbcrKGrE91kH62Wk0hc1Qxnkyg7OA7dyglh+qWl4Kd3IVomndIMz
/VksHvw/nvXiWueX17r19wb6jIdLNOWNwSsXw6mKNaLHz4Qfa4jLGN4iqDJMBrFJ
iDHXZW/UiAt4dGLLzT/MTjMiaKfIgqkmkRwcqBjYexWlDXK01VYI7pgc6WHRZ0uc
THlylLetWk+YE+p/r57lt79e3oaW8P4e3w9MEau2FspqLiSq0CkIkyU+Yow+vZD+
LjuywQOSX4CNAJ1s5CNuWgKBHxKd6U2cJX5soEJar4+1spnxsfm6UG3ipF5wv0O6
cr5tA8wbrZjtTT1Ijvjw
=QqXh
-----END PGP SIGNATURE-----

--euicx1nb0cXzb+p3--

--===============8873175148741793461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8873175148741793461==--
