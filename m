From: Mark Brown <broonie@kernel.org>
Subject: Re: Is that reasonable to support pinctrl PM in ASoC
	core?
Date: Thu, 24 Oct 2013 15:15:24 +0100
Message-ID: <20131024141524.GH18506@sirena.org.uk>
References: <20131024110743.GD8385@MrMyself>
 <20131024115224.GD18506@sirena.org.uk>
 <CACRpkdYi71eKxBeutpjPKc-FzCALKiVpq3WQq07xJKgB-HDyHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4095889842875215538=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB822608A2
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 16:15:30 +0200 (CEST)
In-Reply-To: <CACRpkdYi71eKxBeutpjPKc-FzCALKiVpq3WQq07xJKgB-HDyHQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <b42378@freescale.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: alsa-devel@alsa-project.org


--===============4095889842875215538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 03:19:03PM +0200, Linus Walleij wrote:

> This makes a lot of sense, the only problem I have traditionally had
> with this is that there exist cases where you want to put pinctrl
> handles to sleep or idle aside from runtime PM.

Yeah, that was my concern.

> - I2C or SPI hosts with no devices connected to them should be
>   nailed to sleep. (It's not possible to detect an unused I2C or SPI
>   host today, but a feature we should add.)

The SPI case should be mostly handled already if this is integrated via
runtime PM - we have core support for idling controllers whenever there
is no transfer active.  That should go off for devices that aren't
connected to anything.

I should probably go and implement an I2C version of that.

> Maybe the right way to do these is also to use runtime_pm*,
> but the thing is that today these things are done also when
> CONFIG_PM_RUNTIME is not set. Which is something you
> might sometimes want.

> Or not? Should we say that unless you have
> CONFIG_PM_RUNTIME you don't deserve saving these
> microamps anyway?

Personally I tend to think that people who care probably ought to be
using runtime PM but that's not a sufficiently general view to insist
on.

As we discussed in person earlier how about we merge this on a subsystem
basis and then once we've established what the pattern really is we
think about putting it into the core.  Nicolin, do you want to write a
patch for this?

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaSt5AAoJELSic+t+oim9OJ8QAIZ3j6RqNMvbM1/61GIiv9oe
mYpYvjBZHUbnH5Jo55cA5+rXe6IJGOAnpyioR1yG4y5Hw3juR1thdXMiet7tGr2f
ZmmG7M8vyqFHyQi1CdJwsTwvoaiUuVfwJhy7uitHRZCOnmkXTn0DAX43i7yDToos
NsXGCI6b3qZA82ySUe/Z6l0gI7FJ1dhkA2oX8xcS+OMIMqvrBKFO9n2RaEDBDoFO
3seT4JfqmejCu3Hmt0WRUF5yZbedEB3fYT2yHWEtHelmPrwtRQ7Hyt9tf6lpzGVM
1LcixLEfhBCrwoCA18RZvZ72A6KS2LmUru0S5vzmADavD2zB6nDrWDPzsfaGJPiO
9vLqtWHXtXOoqSEQkcbZnJYZYDiWVZQFaxMFKgU58OceiNCI+YqL+NbSC2gHTwo9
ho8vL//iv48/+s+C33ZG8thEON9FpiQ2ItZjnzPf+9XGULF5c/OFi0fQ2MoOF0wm
QbaS/eyr41MWxHjZie8s4RVcWfpsg6zsb04ByelkdL1kdlOolit/Or+OpsvZ2N7O
PTm8s73foNDjMom7bGEYQe3I7AN7BczTabax5VgtT4CB5yb68McfciMS0+36Ksb4
leVy2v18r3gyW2phV/XWW3PafbZurNQZ8h0EWNBVO6DLcL2fwW5vxBxQ6IqvpTLA
usb4FewkJBDgHYHnOcxM
=8yv5
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--

--===============4095889842875215538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4095889842875215538==--
