From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/11] ASoC: mop500: Staticize non exported
	struct
Date: Wed, 15 May 2013 08:52:30 +0400
Message-ID: <20130515045230.GH24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4625524847297294133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2792610A9
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:52:35 +0200 (CEST)
In-Reply-To: <1368562797-10440-9-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4625524847297294133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:55PM +0200, Lars-Peter Clausen wrote:
> The mop500_dai_links struct is not used outside of mop500.c, so make it static.

Applied, thanks.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxSLAAoJELSic+t+oim9LIIP/0WukrRtkxV2uw5447gXd7Ec
zfWBTQg32fKlsaLJ76tXN7BMyIpoLi22JO3nAn+w5dRey2o4vhXEVKvGWtMG1/qJ
Q4xmUIaGdJSp/Tcqz8IIivnN2ruWb2BpicY4zYETYFzN5h3zDrKYtIc9L4lzIUGJ
NUMnKerXvpmcZx5zno/qq0l3RrhszVoUPcwB9C8IMdo4N3QvI/vpnyMqUqNlHCSC
RRRG7E96yalXgnkBZHh7cdWkswjVj58O4iFUQBzchvLCyeH8zsYjr5s1yTaZ5S4q
GspA86zlA3Q2KujGl1TQlub3ZeYnG9j2adxR55QqQUhDDFqWi7iaNE2eHXy01ZJX
ZVFujMBgaEwTfGIY7jEys//IE8SkG71l4HbvP030Hfmo+QL5JSorK4vl4Fb4RqmZ
SSObtH4D6jrIOYyPfNEeVIFINfXSWnPGaRFzoeGIitEq4VHnTMCHEsxynBfmwKZp
WOukHVkAWCCE8QKTHKaJn+2aYNf4rsuhTYcHBpxT/mqrNHX1tMY9aPoGEP937cmV
EEu2FowCi8l3Y4KAmLlXPFx674E+zyWuoCR84OCsawpnlpd0dDd3sDS0ragk2V91
cUlROPZ8AH4nNZKrUQGfHFyg/zpgdCo2Xqc1LUDjtP90wDgKiWyG7tLyMWCp16jc
juSVM/UZiqreahu5uPj/
=kdaP
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--

--===============4625524847297294133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4625524847297294133==--
