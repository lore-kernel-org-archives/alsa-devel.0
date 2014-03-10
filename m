From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sam9g20_wm8731: Convert to table
	based DAPM setup
Date: Mon, 10 Mar 2014 10:32:25 +0000
Message-ID: <20140310103225.GV28112@sirena.org.uk>
References: <1394290042-30883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7968995952561634494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6542654C5
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 11:32:37 +0100 (CET)
In-Reply-To: <1394290042-30883-1-git-send-email-lars@metafoo.de>
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


--===============7968995952561634494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZBvHFPs1EUI0obi6"
Content-Disposition: inline


--ZBvHFPs1EUI0obi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 08, 2014 at 03:47:22PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit shorter and cleaner and on the other hand the board level
> DAPM elements get registered in the card's DAPM context rather than in the
> CODEC's DAPM context.

Applied, thanks.

--ZBvHFPs1EUI0obi6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHZS2AAoJELSic+t+oim905gP+gL/O8PmB0V+ZZnnaY5IeNVE
vktCeqKjqkRRCz/t7ta5Bmi4174AJPJabnKWnVQdDMXlWh7cN7VNwXZ9DsiHtuCV
CA92IbtJaffANm9sdeq72rptQbTPOPHPaQX56Drg1tXoG7/1vP+igiMi8MpgzwPw
EK79AS6Nu6pFgqAMc00KrANlpU5eOteg6hUm/OK1xC2HVYB5oSIjqGiCwYadXjla
DAVWjtYpSSUUmv0HVAeQ4Z55mAPjD4jgIORoSW/5y+H3LD6+qQVDKSNG0bv4mvSH
+7zSXS0so0M/AR1k4nVnMg1byoJn4Lru2Xcd1ry7Jsddm6cLN3raMk0LQ2JMFybS
ZOL9metuZWqbKp2E6Ud1/+SL+sL5bx3JRImLnnifH0QBoOKzQFHAfk8Px3ntTInr
tK6knoJm8TZG0Olh80DMVVCq3hqEsh274twHDaB0ufg9ud+oLiF8fCHmEDMXaNmM
S11dsqTNXskKKu7gbEDq3PqaWGLUMHRvhPs6WYbRTs3IPywcT5usUrNERcfHa9qQ
qxYwAkT/BKGwCi8iIZJ/ss6ev1vaSnDD4ePz3dxcvO0J7bW0XG3TXHm9dbWsaB4U
W6P/PRYo+kCKY1FVG3Vanw/nSFUUbNFgzG03jv4GpkQTJ2Z3mD61NuZMjy3M5UOA
Q3cj/V4CqIoNFYt46NR4
=Ydee
-----END PGP SIGNATURE-----

--ZBvHFPs1EUI0obi6--

--===============7968995952561634494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7968995952561634494==--
