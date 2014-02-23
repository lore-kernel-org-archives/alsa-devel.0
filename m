From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/4] ASoC: tlv320aic32x4: Support for
	regulators
Date: Sun, 23 Feb 2014 13:00:01 +0900
Message-ID: <20140223040001.GE25940@sirena.org.uk>
References: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
 <1392916981-9333-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1791039626601814854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E98D8261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 05:10:22 +0100 (CET)
In-Reply-To: <1392916981-9333-3-git-send-email-mpa@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1791039626601814854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20f69GCBTQuZN9jn"
Content-Disposition: inline


--20f69GCBTQuZN9jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 06:22:59PM +0100, Markus Pargmann wrote:
> Support regulators to power up the codec. This patch also enables the
> AVDD LDO if no AV regulator was found.

Applied, thanks.

--20f69GCBTQuZN9jn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXI9AAoJELSic+t+oim9NKMP/RSN2K+AYs/wbxd418kJI2/z
DJ0l6e6fVnqHAFSJrZH8fp0LZqJAJqv8E2pu0UCjKC0bfcnr/eTSRdS+DEHivwuU
WNOK5uT2jLtU3XpWevir1MAuBTAwWD7vT3MquPuX3aJK7/iR/zXDREIRcn9lw4BT
gohHQX9MgZJ76q5YaRhxtuJDU08qVHVI6VD5u15oOIcuEl9JfR2kiIzmUehichez
sfyVTRWcBKNcW8SSCONmfLfooizjSQbpeC0jRrELo/9Dky5Zu3Iq6uhg1s30HBhC
+czhAbpKIPKZfz1ibRWA8+VL8WhXBDTkzRr5wQ/wBLFZ11x3iNnxQ6+B/QHQZGRz
A5k4vfZIi/DWOIVP/xowTA3K8SD0nFsJFxO/xUiPpFXKmJVEqHQctmQyG/vpoB9O
bapLssN5qycXWHRMttXKV0bcnH2//RO94+lfuLndP1SZlNJf15lyO6/TqbJ7xyqc
Zg5Us1mYDgY4O3i+yhjuonBvibhIl5eea+AkJs7MHpENpCpj//e84DIRboIC8ulW
ANyZXnWVSDPCgQEG9d5yeU71G0lWWcJPFu49owzqoOJKlPsCBTgehxBXYeMSMqyA
LvjPqGtnuVh249RPY94wq6bpsSJlnhmYDScwJPedc3x2+aBY74jOgl6zIsXhtpEq
0bv+QTwfOlk4XYwjhGpX
=IZo/
-----END PGP SIGNATURE-----

--20f69GCBTQuZN9jn--

--===============1791039626601814854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1791039626601814854==--
