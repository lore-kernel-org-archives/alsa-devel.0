From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/11] ASoC: Allow PCMs to restrict the
 supported formats
Date: Thu, 9 Jan 2014 14:33:54 +0000
Message-ID: <20140109143354.GC31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7930534962257761666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A58A0261AEC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:34:04 +0100 (CET)
In-Reply-To: <1389014356-7014-11-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7930534962257761666==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLrYjofa11/yiJ15"
Content-Disposition: inline


--VLrYjofa11/yiJ15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:16PM +0100, Lars-Peter Clausen wrote:
> Some DMA cores might add additional restrictions on which in memory audio
> formats can be supported by the compound sound card. If the PCM component
> specifies a set of formats it supports (by setting the formats field to non 0)
> take these into account when calculating the format set for the compound sound
> card.

Applied, thanks.

--VLrYjofa11/yiJ15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrNPAAoJELSic+t+oim9C8AP/1UjnksjIlCrCizCmWLw22rj
4A+DgoA0QAKPA2jckva3RhuAd2JBf6Tf3o0WWAdknYTlPwUCzVoQ7yy4ZI2Fvy7V
wAUfXi40uvvEq09h8EgWLzanvdApBOexpZN7H7aBDQHKONh2zRyOyLi6JGfJdmas
eBBkWoeBlE4WgEb60o+9lsQC3qg3HpueAL3BZzCmfz/dPWRhStSr2HLe5TAFG3LL
oIPRRiPUMzO7PtFEo/yEnjZaezldA1+3/vmXZ9dvHR6544nHcztcHzAyMoTgBwfL
ft3KK0WjycRgsWVrarfb5w3AWP0CA08TOYFm4UKnI7CsQbK5mvqbWaWNdDGNLi9A
q4MszGyLWs2FfIBLjO+SwJjNch5J5uFriIDRyWsd9UkuNgOIRh/MmzPta6lfs26U
G2GfKbFZysSZCu/3fWRgUneiBu3pjecDOrHn1j9shBF4TS3fMmHMyOCaR8857Bi6
yvYOHD6EUcGrO3J4WA04/fGgJdpR92MkOXu7H+KuuH9xra5AT/rAjmkHPzFWMODx
LOxkuAlt9BubtHBDyeOxuQ4zoBE36o3hc1jGG56gpbhRN4lwk47haWSv2+Ds5C1j
GjfwzKgTY0+LhvoCol0oMKjBgVe2jtuVBlrHi+z/HvqH8hwAuItQBTnqXW2YofYR
oo5OfBNIjHc5AGlvGqxT
=gdhS
-----END PGP SIGNATURE-----

--VLrYjofa11/yiJ15--

--===============7930534962257761666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7930534962257761666==--
