From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: improve usage of gpiod API
Date: Tue, 24 Feb 2015 17:43:16 +0900
Message-ID: <20150224084316.GA6236@finisterre.sirena.org.uk>
References: <1424532804-23789-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4666061287209447580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 417E72604F0
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 09:44:24 +0100 (CET)
In-Reply-To: <1424532804-23789-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4666061287209447580==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WbkWELb8d/6oR4nB"
Content-Disposition: inline


--WbkWELb8d/6oR4nB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2015 at 04:33:24PM +0100, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for
> output. Simplify drivers accordingly.

Applied, thanks.  However...

>  sound/soc/codecs/adau1977.c | 17 +++++------------
>  sound/soc/codecs/cs35l32.c  | 19 ++++++-------------
>  sound/soc/codecs/cs4265.c   | 19 ++++++-------------
>  sound/soc/codecs/sta350.c   | 30 +++++++++---------------------
>  sound/soc/codecs/tas2552.c  | 13 +++----------
>  5 files changed, 29 insertions(+), 69 deletions(-)

=2E..as this touches a bunch of drivers it would have been nicer to send
it as a series of changes - that minimizes the risk of collisions with
other changes as a problem with one driver won't affect the others.

--WbkWELb8d/6oR4nB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DmkAAoJECTWi3JdVIfQ/wsH/RaHjcEJ3l4vQQIu5oG9pYGX
2J+zEc4qGGu/tCiFZzOlT3mGHqEuR9K125hH0JWdLOUkeiwGVk+ErKOu6o/IENVL
wJlEHvbG1sYr2Iu/GgAoOnf2HUFTtZCIM8OOfKP93G3zF3uuqfcYDusqrA+G/786
l+cizo7OncqGFcOJ3c08SQcZ5inrCl8Z/sV+wUKJKr3R1WPCCc1dQDAiH+gmkUB7
uSATCMahPfIf6+kgF6rocOdYb/aLB+0567Qf+nGaVIvp6v9o/dlbxJIKc1n/kRAf
oo2sjSeoa9suYuCLlRqzbuOaggCTdr5UFBroyifXBtvK30xvAmpx0dfAMKvWzlg=
=0No3
-----END PGP SIGNATURE-----

--WbkWELb8d/6oR4nB--

--===============4666061287209447580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4666061287209447580==--
