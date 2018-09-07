From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Fri, 7 Sep 2018 13:11:28 +0100
Message-ID: <20180907121128.GH17459@sirena.org.uk>
References: <20180907002728.112770-1-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180907002728.112770-1-grundler@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Ryan Lee <ryans.lee@maximintegrated.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 06, 2018 at 05:27:28PM -0700, Grant Grundler wrote:
> Commit ca917f9fe1a0fab added use of usleep_range() but not
> the corresponding "include <linux/delay.h>". The result is
> with Chrome OS won't build because warnings are forced
> to be errors:
> mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
>         usleep_range(10000, 11000);
>         ^

Note that this isn't causing a warning upstream, presumably due to an
implicit inclusion that isn't present in the v4.4 kernel that you appear
to be using, or gets missed due to config differences.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSau8ACgkQJNaLcl1U
h9AIfgf/eBKyahPC3KprtZfUSebDBqPYW/eaxZhAHW8tyHkAW2csHeATrxoxVXJl
rov2bCkWYqeFZ3yrVS8snqsBcB/43VYbceDgxt9o8c99dQUc5LUpcu6h9H48B3GF
7T4sw8aiLrTcW9jVGoArcIBeEW1LeX8wajm3As5PDzRLqbMrYUfcHVeCPgETQhXN
GOlcuzoideXQWyn5saBIZywJCida2WsJJmvKPbW4YlgJ+NdXJQl6MlobnrJg6J94
iShfA+D93hEd1GW8PFAAw1i9r9cs6OKa4AwiUpuJN0gZbIPvFEoMHwjgYI/v9JzY
QcFxIze87XrhoQSyjKunUc8cZT+hyw==
=jeZ+
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
