From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/17] ASoC: imx: move eukrea audmux
 call into ASoC machine driver
Date: Mon, 5 Mar 2012 20:36:32 +0000
Message-ID: <20120305203631.GB3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
	<20120305174612.GY3224@opensource.wolfsonmicro.com>
	<CAKGA1b=4X+ccQXjZVa1DYpRYC0NT0A9AqwgG-ApkzboRkC3sJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3127729505130666620=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D068104426
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 21:36:33 +0100 (CET)
In-Reply-To: <CAKGA1b=4X+ccQXjZVa1DYpRYC0NT0A9AqwgG-ApkzboRkC3sJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============3127729505130666620==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="exKAuxcSaZxx4B14"
Content-Disposition: inline


--exKAuxcSaZxx4B14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 11:55:07AM -0600, Matt Sealey wrote:
> How will this stand up to an machine audio fabric that, like

"This" would be a lot more meaningful if you'd included some context
in your reply so the reader could tell what you were talking about.

> imx-sgtl5000 going around BSPs and Linaro and so on since the dawn of
> time, supports multiple boards but very different audmux
> configurations? Is this just a stopgap until the DT properly describes
> it?

What are the limitations which you see in the new code?

--exKAuxcSaZxx4B14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVSPAAAoJEBus8iNuMP3drYsP/jGznrk9+MkE+2vKl7Uw7khh
ggZDYJqnjICpXMU16yCRF8YJxZVxj77zje2D9uLhNb7Jwc2dHZveN3AXne7xs6Qb
AeZcTGgprv1WylVSugqbtmm9Nxp+KR5VQYbyl61MB1CkH+d2Y5gvr3BKVtUr+PaT
ybDUHtjfG8Htm1l8G8SQt9ViyW3jMNBNjJFtzvcdpbs/6x5QCAGxjGUvJT0nf0cy
LRqcdl0O6wMOjh/1kl4yR5g32T9UuSIkc0Hyot2e9GZNivPeCrpjUK6RKuGDc9C2
Bfs2BJgBgIXBetqZB1K5/JBxpwtmxP6e/qhJtkBPVyR4xZx5UoCuCFVSXiB3acbt
1L/I4xrZIJYTlV4md9+OyU8+rBpgKGAp2w2D6Cd3bwZc9zB++x3QZ5mKoG8HEOvE
H3QRQRxoQXcv4ytdZf5YTls6oYcwfABhAEkBU71+2Y6UmvqkkajbOfy5hZJ9xpal
4DuomhuTHRxvgJwR1bHF61P0shHe79nHYQW5tsRRf9kw6oQw4ejM79Z6RYBXW09G
OOdz369m5y+FRPiGGAOec5AK2RZhkNHODBr38pnYFNQeK1e8YyHZVtYLIrj7b7qg
9rhKEkNfwgkm8mqPp0rP2Vhv1R33DwfwFD6wxqB+mQ+uJM3T9fQtBtvO8PT4v003
aI0MF7LQuv658/ZnLUCc
=7Ptu
-----END PGP SIGNATURE-----

--exKAuxcSaZxx4B14--

--===============3127729505130666620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3127729505130666620==--
