From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: Kconfig: Support for
	omap5-uevm analog audio
Date: Tue, 10 Feb 2015 15:11:03 +0800
Message-ID: <20150210071103.GI2593@finisterre.sirena.org.uk>
References: <1423481161-12589-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6803295608263432022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 82390260687
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 08:50:30 +0100 (CET)
In-Reply-To: <1423481161-12589-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============6803295608263432022==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2015 at 01:26:01PM +0200, Peter Ujfalusi wrote:
> The analog audio is supported via omap-abe-twl6040 machine driver on
> omap5-uevm.
> Update the Kconfig file to reflect this and select the Palmas clock driver
> which is providing the 32K clock for audio on omap5-uevm.

Applied, thanks.

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2a8DAAoJECTWi3JdVIfQ1CgH/AuhNVHh52WqHPfK968PCIV7
v8DPak0TsSvH0Uj4tBdLfr0M5ZYQ/8QBwBDD/XhqUCieCnTpZDA/DY9ib1oeVZqq
mVQ7CYxbX0CjO7oCYroTw5yD+pwLC5qoDO+MjLoFdDpmr58eLhmE4C5kaWmRf5Ij
S4jrhXNCtVn7ZcG2jVqzjoZPl/LgXfHcFimC1p8vzff5voIkh/7PQFGtQl3qTznP
6HxyBKlutC45KERqmHkHYhAn5NLxWbUfMoZrYouq3peo9pFXgMTFJlvHzUNx/3Am
1acH9WPDga1nTmA9i+B2YZjl9HG3XcfJEXdciQIQ4Fy3OxEME8YdjOXwUpbzIxg=
=FX6Y
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--

--===============6803295608263432022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6803295608263432022==--
