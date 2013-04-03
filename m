From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: tegra: Don't claim to support
 PCM pause and resume
Date: Wed, 3 Apr 2013 18:04:05 +0100
Message-ID: <20130403170404.GD11305@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979607-15286-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2535838197646500769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5F68265D6D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:04:06 +0200 (CEST)
In-Reply-To: <1364979607-15286-3-git-send-email-lars@metafoo.de>
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


--===============2535838197646500769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:00:01AM +0200, Lars-Peter Clausen wrote:
> The tegra dmaengine driver does not support pausing and resuming a DMA stream.

Applied, thanks.

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGD7AAoJELSic+t+oim9AtQP/1umxVHTyKenpf/BUxor6Lr7
69XowZXZ5I6Ud0sb6+5K+gzNZ3aYsfFLy0nxLuGXEUZX32xDbaqwfGgU9C4d5Qi/
LKBodWKlUqly4VYhZBgshXnuQxfzY+f3J2edPwLCzZ73xjsLgz6milCO+r7R6Ca7
YXFo1uit+1o2ifowEwEl30/2e4mU0HyUS45L/SHJTMBMFh6x4O0txuda26WL5IQC
b9zuBsCAH4bvajA4d9MK0W4hH9uIHW321MTsqgAfvajcErXrlrkbnnVyTBT9vnqW
DZ4JtYIkSdKCOVZOPGkxJpObxpaybfLa3tKZxuTmv3vX/DszeHJ09xOGQwar6yDj
aMazrJrGP51kOU299uowX8OwmQAvVnZqpTdShd6h63+eQPIfGUIvD3gU++1a5P/J
+IH0UCO+SuHME6xWnypDMtYZmjs02furiAid15ll8rwhAQmFIJFIJnBxDBlKscyU
hYrGa4+hh2JZgaC5MVrHnn4jXYEpOoozB7D+o+RbpYLr8rpnpQMAhjD+0geYjvj6
GZRb7vvate1l8O8rZpYbufw+KodAOTJGHfj9uLR4meiTWkmV28A6oWMP8uV6bIJy
PMiJeCCyyK2Old69Osy5gW0PZ0d45d5je5ImKWP7gatXxS5D0o9F7qAd/wcKsxdV
womGE3D65bVIhB1K+Q7r
=nTvv
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--

--===============2535838197646500769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2535838197646500769==--
