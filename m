From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: ep93xx-i2s: Staticize non
	exported struct
Date: Wed, 15 May 2013 08:46:54 +0400
Message-ID: <20130515044654.GB24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0431786078394938989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C6E26109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:47:00 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <ryan@bluewatersys.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0431786078394938989==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:47PM +0200, Lars-Peter Clausen wrote:
> The ep93xx_i2s_dma_data struct is not used outside of ep93xx-i2s.c, so make it
> static.

Applied, thanks.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxM7AAoJELSic+t+oim9gMoP/3vZxBGIizGza/JxWsBmLO1j
Hs9jMQCNuEnvTWofu7ZZEJf2jdNNCZFESbP+Pk7JW8Ryle17VCC0AmtV9k/pA7Cj
/n8yW9+q/rDqrNhPlbiapPBwa8bBRGmERe3RxJnUwLN7f9TxB6GDnIu37dHh1TvV
ezFXAI9jLJ7Vj8jMy0zvmPmuZ7myaQLyVUnbtFl20lvIQ9Qv0p9kIU389rU2Fy9s
2svg0Zw27bTHzO2nE8O4EQMQ0qEgelQdLjVuZ/FWalcPW5qk3hF1VGLA9C8dflwJ
EIhLv3VLrAG7G1i0J+slRz0LS7LBVyIE15tPiubJ9sCWpTyVKveUuQrn25KuEIYj
dsK3aVI/nxtRT+KfhzPcQRJ3GQHYsXI87rtEUeqqhy0DkoNs11bs1YkvQpVJsry/
loZoXXFU1+AIcjNFQZHwY+lUBgirwcViMqrZ7EG0tdmal9dCq4V/zLw3mB8DoXZ4
wa65lCCArtocLq2L0sLqn0p5s7LzZcaMuNIJZ3FePxlFucJJXMkmb5O1FOpqjYPB
9me8grBVTR7F8yFjvjMcEgRloXleHkSBWX01fDHgkiiICjMTw5apIkcUfqKqIUpp
AGrNfjM8X2fG+ylC3Ghp39/c839pUXdloA/zc8W9yw4JrYsV8wSl4PtDsjZBkQjn
tTOoBY6Bke6oABhoGoqu
=rusi
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--===============0431786078394938989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0431786078394938989==--
