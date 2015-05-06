From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 6 May 2015 12:48:49 +0100
Message-ID: <20150506114849.GM22845@sirena.org.uk>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150504113943.GB15510@sirena.org.uk>
 <20150505092411.GA15549@opensource.wolfsonmicro.com>
 <20150505105327.GZ22845@sirena.org.uk>
 <20150505133129.GA26101@opensource.wolfsonmicro.com>
 <20150505215934.GH15510@sirena.org.uk>
 <20150506092405.GA17710@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jAzuEdEubtg2kr7a"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150506092405.GA17710@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--jAzuEdEubtg2kr7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 10:24:05AM +0100, Richard Fitzgerald wrote:

> No, I'm just saying I don't see how calling the mux positions "IN1AL"
> is any clearer than calling them "A" and "B". The "IN1AL" names of the
> DAPM widgets is purely an internal detail that you wouldn't see through
> the ALSA interface anyway so they don't relate any more closely to what
> Joe user is seeing in the control list. The IN1L mux is for IN1L
> so including that information in the mux position is redundant. For me

Providing that people remember that this is what's going on here and
that they remember that for this mux this shortened name is used rather
than the full one.  We're relatively consistent in doing this for most
drivers, it's helpful that "I want to connect X to Y" usually translates
directly into one of "amixer cset X Y" or "amixer cset 'X Y' on".

> the real benefit of the "A"/"B" naming is that if you're reading through
> a configuration script and saw something like

>     'IN1L Mux' = 'B'
>     'IN1R Mux' = 'B'

> It's much more readably obvious that both channels are set the same
> rather than

Right, but as I said on the initial version in the case where you care
the user probably shouldn't have the ability to set them independently
in the first place.

--jAzuEdEubtg2kr7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSf+gAAoJECTWi3JdVIfQN68H/Ai69amRA/CHNZi3t4Vw3w9j
PJq14L93fji7fNJ+tOb3MCUkXXdiNdGDy8XnjERXcwp5n6lUidk2iUfKXwGxgf1U
bf2kg81odLK2KN1rh1Ee02MN3159Ej/HZxCfghvGa1hrYQ1v22LBKoyD3BZnGTRp
3PMr18mxMSpCjpxd/NBb/YG5cJsZ6LfMDSnw/P3LObKMBHkAUES2fxtAUZ3A4/3l
b3CF2N5piVWZEDUGtZjg+iC/PQMyMnoOE2uTXP+zLwdOYqLph2WPZBTdJo0UBy7l
bwU8m8yVuZWM7EefIn2vjvQsGfMxXB3RC912xfboTEym9CVYnQPLX3EE0p2EvhQ=
=v9fh
-----END PGP SIGNATURE-----

--jAzuEdEubtg2kr7a--
