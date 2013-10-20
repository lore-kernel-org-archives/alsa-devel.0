From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Sun, 20 Oct 2013 17:38:19 +0100
Message-ID: <20131020163819.GO2443@sirena.org.uk>
References: <20131018203555.4d974251@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4375170136043405280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BCAF26167E
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 18:38:23 +0200 (CEST)
In-Reply-To: <20131018203555.4d974251@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4375170136043405280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+59tGnj4H6fvPoOj"
Content-Disposition: inline


--+59tGnj4H6fvPoOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 08:35:55PM +0200, Jean-Francois Moine wrote:
> At probe time, when the clock driver is not yet initialized, the
> external clock of the kirkwood sound device will not be usable.

This doesn't apply against -next, could you please check and resend?

  git://git.kernel.org/pub/scm/linux/kernel/git/broone/sound.git topic/kirkwood

or the for-next branch.

> It also removes the test about same internal and external clocks which
> can never occur.

It seems like reasonable defensiveness to have the test there in case
someone has a broken DT, though it'd be better to complain about the DT.

--+59tGnj4H6fvPoOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZAb4AAoJELSic+t+oim9ryYP/jmtocD7i9SyE0x+5gALYUn0
lNXpuyIiTcrzCIg82eQ0xYjMTfgwKtDOJadJo2bhlnntAnwi0EmPllfudr5Y/PP2
dnEsXi4RB028+Ar/nv5wWRFDF+X5rqIIRWDiYz7e9p0+cqc5g9pv6bYOrIcy3AwG
bZiGe216ZBShb9GUk/9R/DYVbPekRlo0U5HoxbDgavoR865L9K1m7+UQxZdbrQ6T
nugUX18mCA7nsEqiGR9V52sygp3fCj0YNlC3cBO0Akuf1GOUMmb34Bvx1L6okz73
g7GI1nCYGHQQuGtQ56yUk3U1YdkeG0AwjNo4JmfgZ/SKnXiuqmBinTzSOmudYT1W
Vkn8vtV5Jf7z90Iz+9e+kHhU62uQLi4Dwr1kvgs2RcHiEcgzTpJZ0goN8py1qoJx
1X2LHRW/smZzcaVOpEp7eypl5HSy7AyWValQv4q18QYoIW2Xb9T0wjcEt/GZF3AW
whg8TZOs0rhD17A9iicMQKKwUqcGNUxbVt/cFTSU0+iijTGV0uelRhYavAqzNrf0
OJaXIv4uXq5G6ZlvrTSwun6+4EhrbDVNzNshWWUMfrzV/wdI6Fmglcv/iwePjO2g
7yrQTNDjvQ8+b5CNuY+QwRwqPR00EjQSsMleCM3w+h/g80FTjQwuHUJltA72X+9K
Cn+yZrgo1H7v2PoyH50+
=a+DM
-----END PGP SIGNATURE-----

--+59tGnj4H6fvPoOj--

--===============4375170136043405280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4375170136043405280==--
