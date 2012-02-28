From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: omap: mcbsp: Use uniform st_data
 pointer initialization
Date: Tue, 28 Feb 2012 12:40:08 +0000
Message-ID: <20120228124007.GI3683@opensource.wolfsonmicro.com>
References: <1330416452-7195-1-git-send-email-peter.ujfalusi@ti.com>
	<1330416452-7195-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2669277403204523659=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9B1C103E8E
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 13:40:10 +0100 (CET)
In-Reply-To: <1330416452-7195-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2669277403204523659==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 10:07:31AM +0200, Peter Ujfalusi wrote:
> In this way we can save few lines, and have uniform way of initializing the
> st_data in all functions.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTMryAAoJEBus8iNuMP3dmTAP/0zPRPDOWTLIvjy2TFyRp5oP
315PBfxk1UaJGUeewqrOWfx0HD1cmBzIeE6VbeFsXcKuUI5Y/rvFHNvPupRIrojR
xKNrnR17aF35AACZmeg4B9uNmrOBoPPSa/gTQd/W1PO8tKS4LPYDdy1U3CzaorcA
MK7jWQvN/sdRralte6mZkpnROWhAT+UaKcJ0N5c07Cg7p3bIbCeVRPiB6pjMlYyd
2z/Aclk0GGhGKE98rErLhj5K+S+gtNAPWgJU9zw8ZWCFg/xxZY2z3/RXMxdKFAHy
SmaeTZ3Du/x2zyJhfXVCOAA5htVUXnWHuaVFuyVfDx3UKcAz4+t2VeRIJpqw3b06
24tgxzJZ/e9AtDPoneH9dFSSP0Rirtrjbo1nqht0/F6j64lpdt8z+Z7Pg904/Iyl
YxEBZxQHJ4U42w0SnsePAQcI0ZGYGAetxQrEVBbtndAlq2onu/M9U6OPtUPRQZml
d0SZlzYzlq0ME8Io61ZyFjQIaLG/kSnwB2bEj7hIoc7bjftFqh5ZOLiT/HpP+CQd
OVOB5Nc8ifSz0WDjhgnxge7Kgx6F6qpxpEHLFRekLhFJbppVICndm6ILI8r+LSgF
rnqdyDmDOTnNx+VRU5OlHaLKAzFzcZv8xj3SgGeW4DcdimvmoD5uo/y3NixRc4F6
1rLivKC4DuHHGmYdAMfD
=d5jZ
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--

--===============2669277403204523659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2669277403204523659==--
