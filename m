From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add 32uS delay after
 putting FLL into freerun
Date: Fri, 27 Nov 2015 12:26:27 +0000
Message-ID: <20151127122627.GN1929@sirena.org.uk>
References: <1448546600-15596-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3086778454706553446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B21C62608ED
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:26:32 +0100 (CET)
In-Reply-To: <1448546600-15596-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3086778454706553446==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j1Wwy33+dU2Jf0xa"
Content-Disposition: inline


--j1Wwy33+dU2Jf0xa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2015 at 02:03:20PM +0000, Charles Keepax wrote:
> When switching between two clock sources using the FLL freerun to smooth
> the transition we should wait 32uS after putting the FLL into freerun
> before we proceed. In practice we appear to be getting enough delay from
> the surrounding code, but better to make it explicit.

You'll almost certainly get 32us from just setting up the I/O and
also...

> +++ b/sound/soc/codecs/arizona.c
> @@ -2215,6 +2215,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
>  		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
>  					 ARIZONA_FLL1_FREERUN,
>  					 ARIZONA_FLL1_FREERUN);
> +		udelay(32);

...this won't do what you say it will - the I/O is asynchronous so what
this will do is add a delay immediately after scheduling the I/O while
the I/O is at best in progress and most likely before it is ever begun.
You'd need to make the I/O synchronous to actually introduce the delay.

--j1Wwy33+dU2Jf0xa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWWEvyAAoJECTWi3JdVIfQhcgH/0GD7ouIVktsBr5+GdLEO+uS
ZMd4FDdj1GHJLn4fxYUvZn7ysnLGSqxZb1oUTMiA7IR6TL7kW5+A6QXK+po+Agw4
wKvXjIPqc+nFIPBPFanFb9emljbwrU7mmIgmX5Rx9PPORdHlksJQGeRkwwvpsrh4
cpjxEi3Eh6PkLhorABAVJx2CwnDWoKQFmbsy8pyOh1ywyL3tudpe9DWzSB4M36Ib
fOpEYL1CNJHmAHZTXfMwbxuNmwr4aSQgLuedvDKO/DjbUU1XKXKDhoPbBUo/9Ns6
ejHsPqVdzlLQyJ3AhrifabGNTqIHHz+AHR3qQVRPZxgffUTcnYKGcIq/PnE0ESc=
=5nMj
-----END PGP SIGNATURE-----

--j1Wwy33+dU2Jf0xa--

--===============3086778454706553446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3086778454706553446==--
