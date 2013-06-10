From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adav80x: Select SND_SOC_ADAV80X if
 SND_SOC_I2C_AND_SPI
Date: Mon, 10 Jun 2013 15:21:24 +0100
Message-ID: <20130610142124.GB1403@sirena.org.uk>
References: <1370870444.14367.2.camel@phoenix>
 <51B5D38E.1080706@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2499763949171789130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 723242615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:21:34 +0200 (CEST)
In-Reply-To: <51B5D38E.1080706@metafoo.de>
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
Cc: Yi Li <yi.li@analog.com>, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2499763949171789130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 03:24:30PM +0200, Lars-Peter Clausen wrote:

> Yep, wanted to send the same patch sometime in the next days, since this
> actually also fixes a compile error in case of I2C=m and SPI=y.

Applied, thanks.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRteDhAAoJELSic+t+oim9/tYP/jUuWWtjP+QbzjCJ1ec4RKyy
JBKtIdbCrG5O3EkADHDvbwALEXJzUO/c/Gwmm9vtosLylxocC2lsYlaktPcE/Jkp
YdU1lDu7qUk+f8AalLtf8zhxY/FOp7jcoXFuGzuU7jNFT+UAIuqVBI5aFto11b3A
nhMxjFbtQh7dX0eUCY5+KT0HLkhZ/IEzrEgefDmcGxLP50fsqam6+RY50yhDPLze
uyqbSt4VpJeKZvIgMZT0HMExiyeCnGUat/zFpJOBHRXHDHYdGoDqu4tdWr15P9th
OYzPHUXgRmCTT+2vKjoqa7ebAU2lKylW4s9F3tPT0AdUpQ9NBwiuid93+yltnLkr
mdVlVg++IV9NHe5GamKEWyJlIcQGi8XEVfMEqcG3A6hKxzmgCIX18B7+KsnzZERV
DRjYu8JPaWhrjRAOBMjTkDIWQKzsqQFECbkblghoXB5PyNnJK10YWa2vtr9VjAJV
ccvhZN2VaikfC4Nx5Tg7C4P2XkooLSvwYYL5aJSXgq+FhWomZRGdjzK6O26S5CDP
/+QLK2xxawsLvRHt8XkFdTktve7eFySssRiv99KD7ViaJVtwHAQrQHe2wg2i00TL
W89dBYPKFeL5f4TkKNmMnk1W9ww51A5Lp9aLY6YkxdOCHhM7lelPrfjS6Spg++Tm
OMwGUHQwU2bT++8Ht/qo
=uOLD
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--===============2499763949171789130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2499763949171789130==--
