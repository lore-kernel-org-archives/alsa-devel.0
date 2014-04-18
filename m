From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Convert to use
	devm_gpio_request_one
Date: Fri, 18 Apr 2014 15:14:52 +0100
Message-ID: <20140418141452.GO12304@sirena.org.uk>
References: <1396966233.14167.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5701088315335616865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D79926089A
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:15:07 +0200 (CEST)
In-Reply-To: <1396966233.14167.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============5701088315335616865==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YuH2+EQ0WWexKFLN"
Content-Disposition: inline


--YuH2+EQ0WWexKFLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 10:10:33PM +0800, Axel Lin wrote:
> Current code missed a gpio_free() call in cs42l52_i2c_remove().
> Convert to use devm_gpio_request_one() to fix it.

Applied, thanks.

--YuH2+EQ0WWexKFLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTNZAAoJELSic+t+oim9FLwQAI5iPNRooO0f1yPTqBBt5TZv
xl7kjSwYnqQrv4Izbx1gvc3XJtvDAzkezpyP9nPzJhtNFqy3Lla7k4uDxZ/nj7xm
BrkyDK6zeMyaC2hgSfOZUu+/2E3aMHpwndP1D7rMO3COsz4gLPirX1ErliZYA7om
hx6xPNOOOv7e79eiBX3mUrpKzVvtqTQ4237HSPrJciY+uDEEbYcgYgWqfTzFDjlw
GuoQvV+GKKmRujvCkdamp7XEs02MkFeZR3vRPqRQBahoPHCcIr7qym1NeaOT1fOk
viykBgOSvvo8ZPibXZ2MmFsrIPC+Ckk1T3VzDr6JHDzWiwW2Awaip6NMLLj/Z9wa
Cjz5zGMQ6Pz3GE+TYCty8IX+21gkScxxUrJ8CcEQBjPiFu2P3U7ZIw1OhYdYK+a+
EDa3kO7jEN8jz3ufw+q1mScy4qi4cuuXI1FuPlAt7lCepseQ/ahrxmwSs9EXyzt6
/S3Dz9Ij9btu8kSBQ6pHqlRFW7CkdnnvvLeHQ1lQX5KbxFbbGyRZFETEFH7zHrzH
Vu7KKRh+mIPRnSH7ZCtROYOLRW+syFDRgHRsB9hcA6edOSNiCwZMT03+VjcWFLmV
EdJGkhI+ps9fS98K8ZuC1XYO2pHb0Mrzl1O2LGAnx/lcaE4RuBXHb2Wio7WLDRRf
ynDnObH+Z+C3jNirAQNE
=fR2V
-----END PGP SIGNATURE-----

--YuH2+EQ0WWexKFLN--

--===============5701088315335616865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5701088315335616865==--
