From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Store codec capabilites in alsa
Date: Tue, 30 Oct 2012 18:42:15 +0000
Message-ID: <20121030184215.GZ4511@opensource.wolfsonmicro.com>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com> <508DD824.3040600@codeaurora.org>
 <20121029170732.GF4511@opensource.wolfsonmicro.com>
 <508F4830.4010600@codeaurora.org>
 <20121030151303.GS4511@opensource.wolfsonmicro.com>
 <50901A11.80503@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8624870519225016055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CCB626036E
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 19:42:17 +0100 (CET)
In-Reply-To: <50901A11.80503@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8624870519225016055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjNtGRvLZqzR8wa5"
Content-Disposition: inline


--JjNtGRvLZqzR8wa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2012 at 11:18:57AM -0700, Patrick Lai wrote:

> configuration. However, CPU driver does not normally manage CODEC
> register. In my case, CPU algorithm module needs to know what CODEC
> registers to program in order to update the filters.

Why does the CPU driver want to update the filters in the CODEC?  Can't
the application do this?

--JjNtGRvLZqzR8wa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkB9nAAoJELSic+t+oim9edsP/1EYScf0gYTG70bHt4jzTIWT
3bH8Re1sisXjRLWwsrleE6bZIa+xavIZl8N9JhyhKaVexdQgUTvn7KiKDrLaPV1p
VSP8B9ygPbbRAjpBqaxmQlww1lzwCkw79NzQSAHJiZnf53/jD5L7uKxTQkhOyOj7
gEKnoOVYQUvW1jZaY7+nWSieadnnCKd77aQmcsDu+If8TQd3M5l6vADz/4mv6aBe
KwvO9lrsgWR0X9/E3a656DZUwB+a3rnSbV0SDsCX9nbFQ//WgMIcxxqWm4uzuYt1
jB5AFOw1ByUpkUpGOuBUFYv2cSjGD7pdPdsfQTYd9Zn1nBWkCDQgjGyT4X9KJrmw
yLIVxn9aSW7GU9IyNEVsTFdKyX64X0PEj/5txSIohj0iH0cuKPOPHVft78VBvqML
Du9+muBEVS/uqQzmAHbkDhY6ltBmfInoDkDEMH4Z44e40hJuIW+Q9w4ht9iTLO4v
7SZ54kWLg0QgyhyZjUTRErKJikn1r2ie+Ksk1KtFaKrlmA7kQ9glIuXFyVSJ4NL1
qAT3bzZs3yALbXL/yOYaEEkNVN/gBQBuEztyGUrKRRa4Mggf1ppr51WYwuloMC2s
+u/5V6Tazm14ydHvUfve++hhnono3M5XqqVOzkLWD/zAhsHNFYoDO7aukjKuNn71
LUGIx6WGjXpo3dgE4kkB
=lcqr
-----END PGP SIGNATURE-----

--JjNtGRvLZqzR8wa5--

--===============8624870519225016055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8624870519225016055==--
