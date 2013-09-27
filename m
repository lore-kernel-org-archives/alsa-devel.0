From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 18:02:32 +0100
Message-ID: <20130927170232.GL19304@sirena.org.uk>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
 <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6975477327170314754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DDFD5265769
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 19:02:34 +0200 (CEST)
In-Reply-To: <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6975477327170314754==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cCUF33RYdKJBOlz"
Content-Disposition: inline


--6cCUF33RYdKJBOlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2013 at 08:53:58AM -0700, Andrey Smirnov wrote:

> > OK, so if it's purely about send_command() then why is the locking not
> > being done in that function?  Surely the most obvious and robust place
> > to protect the function is within the function itself?

> Not having send_command acquire any locks allows me to have variable
> levels of granularity of locking, for example in the worker thread
> that fetches RDS data from the chip it allows me to get exclusive
> access to the chip for the duration of the FIFO draining. Also any
> band switch for that chip, like AM to FM, etc. require chip to be
> power cycled which translates to multiple calls to send_command as
> well, I think having those performed atomically simplifies the driver
> as well.

Right, so it's not just protecting send_command() but is instead
protecting higher level things.  In that case shouldn't the locking be
performed further up in this driver too rather than on each register
write?

--6cCUF33RYdKJBOlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRbokAAoJELSic+t+oim9FnkP/i/2kZapKpfpm0POxF+lPwOp
6azXe/GX/Rk3ka9Z6YvQ8SYpzvT/OlJR29RUwlajXdvvz+878xL3mkd1DjZqmDun
YB6z2cfIcZf0zMW6pgVdXHJpKdwhUQ7c4E0LPCk83nl60UayaGWWDPi99doYaA2o
oXNdOVbK0ptrjTYPFqJ8iYJtM6APwJcY9D4hLOu8VjFd2j2ofc89rNsIouu/hdT/
jp3WkeR8ponJ4W2kj5pT467Yh49CJrXAq333nhUk/DAWnrjKz8bQ/sOJX8YbSSmq
ZcN7OYDx4vk0csfIERQRx9AlD/xGiyihfTaGalyF6ZGFjXnHcbakCdx5ZsEuRM3Z
WueZBLNQu9hJJmKC7Xsqek871gJffrWgxBiMmSZBpY8p8Fqp2AS27K5haVgBrB2j
+mHUOFRdrJqijWls7SkISwQ5eNcyIkADSq2jVGHRpyKncuiyZyPpAD1FzHDgD2Dd
etrNYsEdf2F4Q8LichRhTvwEmeVimmvmAK1HAUuq0erynIUcILOF65Xh13D7yFdY
hxG+E2XK80jZoiGiUWlyPP3IetVP/4C3QRPolc/A1uIIX4o/ZvmRc4g40qXNwtSB
LqcYLni0sc+26YCT8FOsjR4FpYvCluXdPMXch9gqEjONll0WvB/k35p+etx64yyb
6DkRd6WVkiAi3oGp+0JX
=OGAe
-----END PGP SIGNATURE-----

--6cCUF33RYdKJBOlz--

--===============6975477327170314754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6975477327170314754==--
