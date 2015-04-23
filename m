From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Thu, 23 Apr 2015 18:54:55 +0100
Message-ID: <20150423175455.GY22845@sirena.org.uk>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150422110030.GQ22845@sirena.org.uk>
 <20150423142823.GB17323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TX8FgYyhBart40Z+"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150423142823.GB17323@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--TX8FgYyhBart40Z+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 03:28:23PM +0100, Richard Fitzgerald wrote:

> I'm not sure this is really a routing or widget problem. Problem is that
> if the muxed inputs are analogue we need to provide separate ALSA controls
> for the left and right mux because it is allowed to use them as two
> independant mono channels with separate muxing. But if they are
> configured as digital the mux controls are ganged so must be set the

I understand this, it's what prompted my comment.

> same. I don't feel good about registering a single mux control if its
> digital and two if its analogue because that means the codec's control
> list depends on a pdata option. I could implement the control pair

I don't see that as a problem, it's not like the disallowed options
would ever meaningfully exist for users on an affected system.  Why do
you see this as a problem?

--TX8FgYyhBart40Z+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOTHuAAoJECTWi3JdVIfQPscH/itnC07LTHlo6gvYaA46XSug
4wry1mJnZLiKa/RzlgDJ61FJ2njbelIGZ6GN5Z5Ryr5qzjjnh24SvhXIjlOTLqII
Ve4r6Ngtjxqz/fjdlNcwIxAW8+9SYcJhrWZy5Qj0ghBA+7VECR9PS1I/z+yAGGr2
Xe4IQUsUaRINY6/NdryzCp9gnKujaCHDAuTnt/t5JNB6D0H5SOLB0cp+Mvq/AeqL
cf/hlD65ZC9dXGrbGqv8uuDcySma0/AjFL+6z11OddD7ZowZbT3bH+69nyZLEtzO
YFpK6fWMKossCBw0Y1fpZwyZlZm8HlYs438S+64uA9ztyJmOUwJdRadqftK2MRk=
=y6ka
-----END PGP SIGNATURE-----

--TX8FgYyhBart40Z+--
