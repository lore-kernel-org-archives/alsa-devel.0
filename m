From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Mon, 14 Jul 2014 19:36:24 +0100
Message-ID: <20140714183624.GV6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4494372.fAWcxQ0qku@wuerfel> <53C402C4.5090908@metafoo.de>
 <16507628.c6raaN50oI@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7801370211699809395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 86C1C261B28
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:36:44 +0200 (CEST)
In-Reply-To: <16507628.c6raaN50oI@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7801370211699809395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Avw2VvEbzfULB0h1"
Content-Disposition: inline


--Avw2VvEbzfULB0h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:

> > Yes. But now that you say it the gpiod_direction_output() call is missi=
ng=20
> > from this patch.

> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/=
board.txt
> and as Linus Walleij explained to me the other day, the lookup is supposed
> to replace devm_gpio_request_one(), which in turn replaced both the
> gpio_request and the gpio_direction_output(). Do I need to put the
> gpiod_direction_output() back or is there another interface for that when
> registering the board gpios?

Indeed.  If you *do* need an explicit _output() then that sounds to me
like we either need a gpiod_get_one() or an extension to the table,
looking at the code it seems like this is indeed the case.  We can set
if the GPIO is active high/low, or open source/drain but there's no flag
for the initial state.

--Avw2VvEbzfULB0h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxCMlAAoJELSic+t+oim9gZEP/iReY+nAPrTH6Tv/WZtmMH7/
yXnjCxJvm3N4SQmZKybJdrH5VjW8HIxzDPRXzz5Z/IfnKH+EHvvlc4oS+cvROSwv
Bg70LyiGr2zlIp4IDGV41LeApmBjOrh3xoHnDzAZjghqFRW0eHGJ7AsB6HRdXG8m
LK4g+yOCdE/pafCiZT1NFlcQf6tRcUUebNv450v+RJUDxBKnTvA1UDbYXxj3WygJ
HDiDP46alpsLmQ4NfYf6OoTqHcbXQ6A6ASlZiYQuNUq6MC4+KeZcMUDZGYnzog0t
4EOOgyEBsA1jwPpGHjtDCjody9NhvJddreZjyahC/MaINNO1v6HyeqxYnr4zkQKh
mXl4hQEoPVO3gIrAxkecy3BFZSKcpMKbIa0JEq/Hwlilisjtehcr7dAf0AQ4uxkC
2/gZ3TxreqyzrLFSA7+Qw8ixGuJAsIKHYQta63vkDziAALm4TZTuzDXD9tQ8d8NF
2e+iSNlx7qrReUoqUG33ESL2R72WV8AwClf4Rg3RnnNrqYmtUAWofe9TSqiD+vQv
y6ZjAD6xFhmbzmuEv3RiiDcdA3AwJUdmK2roJB+hOOZ//pfXrquTFdR6peQ7BPpR
7sGDYrHJReG33VRUVXsCiiPLo8xcGpFM7Q1jJ5cLMNkZ+S3F0Ce+54BPiEtRzgj5
8IS5h4rJtBKiFnhR5oWi
=ZDv6
-----END PGP SIGNATURE-----

--Avw2VvEbzfULB0h1--

--===============7801370211699809395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7801370211699809395==--
