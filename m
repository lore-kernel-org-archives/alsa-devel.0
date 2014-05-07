From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Remove unused 'list' field form
	card
Date: Wed, 7 May 2014 10:21:49 +0100
Message-ID: <20140507092149.GF22111@sirena.org.uk>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
 <1399361981-18518-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2738734371501017723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79B5626109C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:22:00 +0200 (CEST)
In-Reply-To: <1399361981-18518-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============2738734371501017723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E7UzyiO3cWVgLa0z"
Content-Disposition: inline


--E7UzyiO3cWVgLa0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 09:39:38AM +0200, Lars-Peter Clausen wrote:
> The global card list was removed in commit b19e6e7b7 ("ASoC: core: Use driver
> core probe deferral"). The 'list' field of the snd_soc_card struct has been
> unused since then. This patch removes the field.

Applied, thanks.

--E7UzyiO3cWVgLa0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTafsqAAoJELSic+t+oim9ibIP/jhbPFCl8ZNa5aZFE6Kl1veH
B1TXLh8l5JVZmoG/V8tHnYDjoghLUSVozCMWQ29DWrY/ocPXTzhe3tsQT+YPrr/7
pPsAoyVF6Ek9+nA+XJSev2PZzFrI6zIe2NiBRYRRSzx0awFA7N/E+9jU0ReEK7v8
zm4pbN9Cw45NdZ7W5cn7Yfdn1D2pyit2YtTUm6mfZ1SzKxoyCsoUDry8hT33N9mR
FEqB27DMkg9jzmPJ5TwueyAhCuQKG1niKMzXhncpTg0SlGzV1MhUUQ5qdlzu0pUa
ePEqGzPIBTy9j8UyT9GA8FqELHEmhE1wqMUSwz7knwg+jSVq3a+kC9pzHD9ozDoR
Q442ZYqq5apcejqDKMg+Ui1L5r7Am1uioKf2EgwhGp5ecWz0IRqK+dFgznTgdu0Q
m/als1KI4yiFz3Zm/Daafuy/PUkCkvH6ubylxNwTHT6cuCDmqMVGUnypqkhKsZMG
BjCGOUWXvrxG/1REER6Rk4IN9P+aLIx9fSHtcMAy81FrQ9jfBSxt1XDRoq+goMSt
mbR8AQiRSdEVqxUchhUV3PN2eRdA8C6qCNhWncRDwiK0ox/Z9mXMjGxMBBSZVwFD
m6aV+WvjgCJp0BAlskimMGm6rgjMeP/dwq4/RSJbYh9uE2f2/mrbinDqbLLvLSoi
Vwcjn8JxyH4SHfAi+rQl
=F2zh
-----END PGP SIGNATURE-----

--E7UzyiO3cWVgLa0z--

--===============2738734371501017723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738734371501017723==--
