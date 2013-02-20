From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: arizona: Tidy up SYNCCLK
 selection and cache values
Date: Wed, 20 Feb 2013 16:31:06 +0000
Message-ID: <20130220163106.GG2726@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1361376579-29051-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2070980810530324664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21DF62616DD
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:31:08 +0100 (CET)
In-Reply-To: <1361376579-29051-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2070980810530324664==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2013 at 04:09:33PM +0000, Charles Keepax wrote:

> +	if (fll->ref_src < 0 || fll->ref_src == source) {

> +	} else if (fll->ref_src != source) {

> +	}

This appears to be missing a final error checking case...

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJPpCAAoJELSic+t+oim92ZkP/R6nyZYMtUTPLMyfKEYHHZsM
fInDnmeAUU1oP5DmQ88ktiujXwMZFNFmczKuNbbGhSXLPA926+JV8A8E7sQOW8Pc
Opm951QAt3myfHDZceZtAu01DRetOG3KuhiZeVvfi36fNY3ypFn9KZ5eFCUhFhQY
2ATJz/E/KWtfzS1iQrHb4RiagEi0C4BFa8kJvudiJ2iGfkUjet+v8JEIEcBJTPpl
4AF8NBww5XC6+o9fctGtZs90MoWt2wgTOt/Jjlmuaa3a4LG051YWTOQMCa6dWcys
GGHKG92klEcJwRkqkuANQon92kzcCFV0kqGfIW5hanoFp27eAqXkbO7qaWPblm0n
Al/BY73vA0BOquu2PPh4Hzj819iIrKjdg4lEZOy/APmH4R03ymKUQ6ORoZgO75rX
fsXZ7vjasjBbANYq35YxY9BjrE34NwJ1Kb4UNqOzniLGlaRIt+epyDTTlIkllwAK
Xab1iYLdKP/CNxEXbgH9W60QEKR/SXmTt4K/25/jHYAmOKekONgwa4H4x/3tXlf5
Im8a1cfuQo/gZAD01xtvEzVuTLrZQthHRI79iSDphArE61EUqqOt19BkFPBmPG67
Q+cQ3QAvS1prbI2yk/Xm1RbZ30pzp1GBnBkz+amV74Zt7x5LLWQNVhi4F6W1OnsY
x7y3eHMm5g7e7tBZCv4V
=DVOL
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

--===============2070980810530324664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2070980810530324664==--
