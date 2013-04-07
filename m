From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] ASoC: ux500_pcm: Use the same
 snd_pcm_hardware for playback and capture
Date: Sun, 7 Apr 2013 20:24:37 +0100
Message-ID: <20130407192437.GR6597@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298355530207468397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E575265141
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 21:24:42 +0200 (CEST)
In-Reply-To: <1364979780-15364-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============0298355530207468397==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Content-Disposition: inline


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:02:55AM +0200, Lars-Peter Clausen wrote:
> The snd_pcm_hardware structs for playback and capture in the ux500 PCM are
> identical, so remove one of them and use the same snd_pcm_hardware struct for
> both playback and capture. Also move the defines used to initialize the
> snd_pcm_hardware fields from ux500_pcm.h to ux500_pcm.c since that's the only
> place where they are used.

Applied, thanks.

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYcfsAAoJELSic+t+oim9qkIP/2wn/M9ExoJ+ldGy0df2AAFy
bowkY1c8lbQcBlbBbyA3k4Ui/gEooPZJhhJOL2vc/3JO6CPB7XcZEH+7hz5gAMqy
5MMdpbYZ8oJGW7RczRs/hYpxhhQwEGbE5VJqT7AC3v+tfqPKKJ6N2tfg2pRuSM3Z
0QEev032zp4lhobEjT7w6JR0OcMwo6f6v9yNA/ZudKfOjA8hBtwWpczEtgOLbjz0
1F+9gQZawN92zHwYu2wVuCFrN6z09CuZCWswVnjLmwPWIwTWRmrj8YUsdODsB1XG
3nDqmkK7NGtH7be4flzzNVg8DuUE7HTJZkD7Zn2kN0BbDN2GLrnEMpz6D6wozSzT
b9gz/ZTFN79B/JgTslcTlTjpT4T1QoFTk3NahrCpBoJGe9SJw2ABlDOk8+jFVv2V
tJAd6cGblalXdda30O1/xELc2Y47lb3Bl5TdLxOg3Wc3nTpJQydp8r7qUFaMkfL1
+HibJqQD1wW6iTEJNgECwSSFFycc5BiJVprmfvUUq3jRCH+KCiNixAKvSS56+aqU
8K9iMaI4k5tIB41fJ8MYRnVrj2KDo/+QosilNqNeU7vm8X/Md9OPxSg+CZnTN9l+
EWB5ixihMNXNoID2iXt9aGaXtlylVS4QQDzgjE/43Y0p/rN18s+ajs0+YVnF4IuY
g6JnBBMkiHZyBx1VhXBT
=EDxF
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--

--===============0298355530207468397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0298355530207468397==--
