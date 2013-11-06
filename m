From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/31] ASoC: wm8900: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:32:32 +0000
Message-ID: <20131106103232.GS11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5221143254717936719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 56DAF2618F2
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:32:34 +0100 (CET)
In-Reply-To: <1383673218-18405-11-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5221143254717936719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2ktwntdbf0dPnbx"
Content-Disposition: inline


--b2ktwntdbf0dPnbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:57PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--b2ktwntdbf0dPnbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehq8AAoJELSic+t+oim9cykP/04NpTGk4CtVTlmPglR7W+B/
LS7dnY8pZgon7ZbaiDhrCp31RI1oWzC/RPmEJHfLb87s3SDXZCYFxz6tLNnftbRr
xcJc1oKVHVHZv2hgwvPXnlOUpX1uakBcuLLVXu7QVQQE68rGgdvVslfNwib+EWOA
NKOpb68kbn4EUu99XrEaSb8pb8WPDR2isCe4L+aI4kA8TJ8a6UPNu/zyIjMUqJrd
4gV7AALIJ52QTYOjGGmJZybyS5V+E14wt9oocQwZmd2G1c8ylC7LqDOXdlf3IaVN
LvFnag2xgNBjrX7gc/KTXpu/pwGMQRX6FbbwoyaUFGzSnu4e86j5YVBlPV2xqc9i
vyhE2MlngFZK8eV2+Au1ksII8lMqdNPLzyazweagTV8OSDMvjkmGbCoXWKOjgKNV
4MfCYvjGVkhQUZVt2SEp6DEj/PQubLRRslaJ7nUJsIy1mHuzoCSvC3gwYeUzl6w0
Pf94M034UfX0R6ibTSswuALea72lbV40QmcPw5eMH+gRiQmN6Bb6E4IpngR8hKIZ
10oCOCsZqdgO7OTHV4sCzyV+3X/Mq6UtrgGvIkoKWJmUZ51NmGLoRanZyjMkttyL
adGk9oyxC8kV+VBqpR3E1uMqxvdLQXHeaamyrTakXLc6GGXQteLZWD7xYqJUczWo
D1SvdgVhfJSyok2k7zsl
=WNYj
-----END PGP SIGNATURE-----

--b2ktwntdbf0dPnbx--

--===============5221143254717936719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5221143254717936719==--
