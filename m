From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: fix incorrect channels and
 sample_bits wiping off
Date: Tue, 19 Nov 2013 19:11:19 +0000
Message-ID: <20131119191119.GO2674@sirena.org.uk>
References: <1384855074-17596-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8610915247424012421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A992607D7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 20:11:23 +0100 (CET)
In-Reply-To: <1384855074-17596-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8610915247424012421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MO4t1VgQTCtsHhID"
Content-Disposition: inline


--MO4t1VgQTCtsHhID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 05:57:54PM +0800, Nicolin Chen wrote:

> Sir, I find the previous symmetry patch hasn't been merged into for-next.
> So are you willing to apply this one or let me refine the previous PATCH
> and resend that one?

I applied this but squashed it down into the previous patch which is
probably what the resend would've done.

--MO4t1VgQTCtsHhID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7fUAAoJELSic+t+oim9xVEP/0oz69iP6fzcVnHBnZpIA83B
fivYPdzTBR+TJhR7yHwPSidX4a63zLnUKBmP/XCClUHWRxbva/LMKQiO1zOag8Hw
+yov0cNNTs3l5ijlg/nM2sMVfoKinfC7fDOfAW7UQOxRTwnDl7oXNychyqYIC+mW
PGK+avwqeqAm4pNEmAJuHvl3EgmnZeyeiOQcM0ABtuYZk13aHEV9KRjyiXbe3srw
/5/gedJkuaFUtZtime0O0PIst2S02tbVjqYMb8WOYzNHJnbgrkFWKUwmNLGh7OhJ
6L8fL4Osr+BiaBOrnLR1AK018MfSZ1mpNAP8+AOu59KT2YnctGD22ZpexUIdcZeR
bIzEVNdfSa/EgAx/4t5gg7WrOJ9MXnBTsYRYezubmU/QpO50VxXrQ6F6jD4gN7Gy
3LoPiw6Cp06Ddy1A+wnuhE1O9fZ/qL8XWtMfIa3nLV33bNxZ1EZCXF/XnO9y3tFF
ycoi9knX+GDVEsvU4wPOhh033+tLM44e0S51P5+swYadH3oEqpgeX+4ws5AklaWF
tZ5UXzZImSFbyhOuVPkHdTWb5GmXcszAD45KO9v59VxQC0p3t7a2+hgeKHaiWSNn
I/EijgClRC8Xnp7xwNmCw7OHjKRRfPQSmU+QMmwLQHSqv8yzRn8y40JeiBEwgZAy
kC6DWMJse0R1QeQOpZff
=uaEO
-----END PGP SIGNATURE-----

--MO4t1VgQTCtsHhID--

--===============8610915247424012421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8610915247424012421==--
