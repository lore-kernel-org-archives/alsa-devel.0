From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] tegraalc5632: add UCM config fromUbuntu
Date: Sat, 11 May 2013 18:26:32 +0400
Message-ID: <20130511142632.GB3200@sirena.org.uk>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
 <518D1EE3.10205@wwwdotorg.org>
 <20130510205330.GT3200@sirena.org.uk> <1786278.dYWLQAQjL2@ax5200p>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3538684632519899973=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DFE6261A42
 for <alsa-devel@alsa-project.org>; Sat, 11 May 2013 16:26:43 +0200 (CEST)
In-Reply-To: <1786278.dYWLQAQjL2@ax5200p>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Peter Robinson <pbrobinson@gmail.com>, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============3538684632519899973==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YjUCIDG0UL7zSTfa"
Content-Disposition: inline


--YjUCIDG0UL7zSTfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2013 at 04:15:49PM +0200, Marc Dietrich wrote:

> I like to help out, but I'm also unfamiliar with UCM profiles. This=20
> configuation belong to the AC100 netboot (board name paz00) and a single =
hifi=20
> use case would be sufficient for now. http://www.alsa-
> project.org/main/index.php/Use_Case_Manager doesn't give much info. Andre=
y,=20
> Leon, any idea?

The examples Marcin posted are pretty good to refer to.  The main thing
that's likely to be useful if the boards have multiple audio inputs or
outputs is to add support for them - for a "computer" type form factor
(as opposed to phone type form factor) there's probably not going to be
huge variation between use cases out of the box anyway.

--YjUCIDG0UL7zSTfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjlUVAAoJELSic+t+oim9l4sP/0fvP40TjWCe/hjgFoJNHPEQ
s+gBRlYYdyZQ4llR+idg5ExDnhHQDcUz7B5mRYHa7twPEWmd/kXdrWlRTghGr8Dv
WyWub7z806PQbal7t18PH5a+DCS0CBdpaO3N7bOLM5wqZUdG9SLO9irTbUNf6pNJ
7M76sP/0UORtnsliBGB4wXQx5FDzL5AANpODdwiJLxR1XlKDvvylIF3T00WQi7za
X1Xs+XEhEOVTKTYHDH675EhbCrblZ0JaGdV3Uop5iTxEKnTpfEPMYlYkIEpG8pyn
LKCM/GGGVqrAsKs0QeTbMHF7Vk8HFVx6a0Iva7Jp5QfLa3/nNnUdNoG3HI6E+SDr
zdEnFnmp6MUDcDbYLQZFbuzSxoa7FKZceH5qjjyPpCw+Bq7J5YlbctAq7ROszzAW
wT7BKBmcnHsOKrTsXN/BhuBopROW/3r1Nmy6WsElzyzBld0Og05eLjGV/R6jNQIA
NYduCSeAqb1KGDknvNaEw914wExEVMZ8cMFDfUTMjUqANnPiMIoLsYuFB/+AlUt1
hm5rUcPzkknCYJ8FcTQZGuRMXHGmFJyp1jlY6EcYpq+aM8CLADoUyEwcOaMUMTq9
cbkUGZb6fivHdiy219iwfxoL/etfEPnCiiiOou6ELAB8cvKjDSjKaHvMvVvbsAa4
oxEU9kUhsS6XFrXxGagk
=w+r7
-----END PGP SIGNATURE-----

--YjUCIDG0UL7zSTfa--

--===============3538684632519899973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3538684632519899973==--
