From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/12] ASoC: ams-delta: Convert to table
 based DAPM and control setup
Date: Fri, 21 Mar 2014 18:03:33 +0000
Message-ID: <20140321180333.GG552@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4948306004368292852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 621B72610D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 19:03:54 +0100 (CET)
In-Reply-To: <1394634460-15889-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4948306004368292852==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:30PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes.
> This on one hand makes the code a bit shorter and cleaner and on the other
> hand the board level DAPM elements get registered in the card's DAPM context
> rather than in the CODEC's DAPM context.

Applied, thanks.

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLH7yAAoJELSic+t+oim9waIQAIADHREBw/3Oqv4LrEraJngh
HoYMWWpzA+Riuib0shJ2yen8ih0bSX3RE2hmPvKVXEDZioe0bkwxBiaMhlx9OQyo
AcWpgoA22VvYFBwqKi352oY2aGFJPlI+ebuFczao1sDcMvYCVP4Ic5LKHybHl+UF
A1tR7YdAkKtm5ys9SROXw2BtEB1SNMSMwUXHLKl5rVVftM4Ct95DMWy+foTy14p9
pzCtTQDOswXOLZW9fyfm6HspSuouR1q7CUaIko3SgB/3murv39y4SzTcjFGVrc+h
eI/2MCtG+mqpIf1AOIlN2pjP+2RrSVJzE9uy/NGUgm8MykWYuvJtcN0+fcypZqY8
Qlg8XeIquQVP6TI8PgkSit/bZTxenAJFJsak+iq0MrdeLFXergaibuj8ng6dCAeV
N3FA+VjSUr+2K/55+XHgbYRnlQ7oEr5o+WBPsTheOQM4yEvFwjK/M/fANMrSSwlH
YDawnMWDqrS9otgo//P/UZwUpqdU9UfJtNOyaqO5KOiam+JU9IwqQmwtLw9+UeAz
nMgy6Lt4r1US7B/X3ON1104Gp5QhKp0KURbE2eJMaqvmy6Om+LPKIg1QsyKIh0Jw
iTrJmazFUnkvVb+Xn9i9bdKnG2VRTJj3w3ywp1dIX3tipcfQyC8V5Xg+pkY/vG/g
FsguOuRJU1ctXNHmncKr
=C7nN
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

--===============4948306004368292852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4948306004368292852==--
