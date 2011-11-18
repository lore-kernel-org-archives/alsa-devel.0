From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: smatch stuff in new Cirrus Logic CS42L73 driver
Date: Fri, 18 Nov 2011 11:39:22 +0300
Message-ID: <20111118083922.GF4349@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2946552474328816981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id E8927103823
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 09:38:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2946552474328816981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

Smatch complains about some stuff in sound/soc/codecs/cs42l73.c.  I
don't know the code well enough to say what was intended.

sound/soc/codecs/cs42l73.c +1030 cs42l73_set_dai_fmt(53) error: inv is never equal to 1024 (wrong type 0 - 255).
sound/soc/codecs/cs42l73.c +1032 cs42l73_set_dai_fmt(55) error: inv is never equal to 768 (wrong type 0 - 255).
sound/soc/codecs/cs42l73.c +1036 cs42l73_set_dai_fmt(59) error: inv is never equal to 1024 (wrong type 0 - 255).
sound/soc/codecs/cs42l73.c +1105 cs42l73_pcm_hw_params(18) info: why not propagate 'mclk_coeff' from cs42l73_get_mclk_coeff() instead of -22?

regards,
dan carpenter

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOxhm5AAoJEOnZkXI/YHqRorcQAKLp7t4QPKyev/PEUiczHmxQ
McnaYMk8XdmmXDUOWZcQhXWsXNuFk1p+TAe3Tcou+rQFThSJFIJY1blVJNGbORP9
zgk4uwnCHbBghyf4cVTOnMbVA49700FU7n0nnJeUnEDSX8CaG/4IaG/Sy9XRX37v
uRZelUwOTKjPUni3aFovmaNeF+amsW3khiUeg0zq9kCqu10oM4z1GdC7WFC4+m/I
XUg+P3eeKkZcztap76dxX3sXiY57jA8oYYabhWzToH7xKzAXS9mYc4A+gyFG7NDz
wA+0eRteN8sN7cwV/whCjV20tUyBGmBUKwcTfTYr9ENKTqmYVDPfTWLjZ8QjDFNk
+mrtLU8m6qxbUmDH4N86Uv/Qn8xigGzElowwBfI+lbFGye9Xx+HLat6V7ggf4EnA
/Fbf1oflWcEuihqzRoU6k/GEV2iJVid7KTNV08d1J09CTDFBI2N4oAz+4Q0ywZCf
NNCdTatykPKVS/o9LzuDFdzNlOaZNdN5YMHT8mokIRBtY/xNuw1LHJIgy8X6ktau
HncGzomnAyiDehUjxYAHUzVXfcKpJpQzHGEQw29BohD2xwcwQvvdLEqtcBCCtcf0
nBX3VPZ+Tf8n6Pku8fQ1Xes1oMVE4n0d830UB4RS1mu9goBfyIKjYS0WzuNhhlJw
WRqQ6ONLJyLq8eTy5EHG
=WMXm
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--

--===============2946552474328816981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2946552474328816981==--
