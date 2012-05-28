From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Mon, 28 May 2012 11:59:03 +0100
Message-ID: <20120528105902.GB4032@opensource.wolfsonmicro.com>
References: <1337865985-26077-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9100653660141091306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4E852448D
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 12:59:04 +0200 (CEST)
In-Reply-To: <1337865985-26077-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============9100653660141091306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2012 at 03:26:25PM +0200, Ola Lilja wrote:
> Adds a supply-widget variant for connection to the clock-framework.
> This widget-type corresponds to the variant for regulators.

I'll apply this but...

> +	case snd_soc_dapm_clock_supply:
> +		w->clk = clk_get(dapm->dev, w->name);
> +		if (IS_ERR(w->clk)) {
> +			ret = PTR_ERR(w->clk);
> +			dev_err(dapm->dev, "Failed to request %s: %d\n",
> +				w->name, ret);
> +			return NULL;

Should be devm_clk_get() (which will be there after the merge window)
but I'll fix that up once the merge window sorts itself out.

We'll also need to work out how this works with the clk API not being
generally available but that'll partly depend on the clk API stubs - if
they're in -rc1 there should be no problem otherwise we'll need ifdefs
or something.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw1pvAAoJEBus8iNuMP3dHaoP/2tLBndBy1BBwHS+k+Nqzrlf
Yi1XQ3aweJ2JgUghWY3ZwFVES23SigNVhYtAlFPgb8d4yZnT2uYVfKeyY7iETIys
eZi/a17l7jQzsOeo17BbMvor33qU5Gi9wm/hh9Fo5OVlWQRGPmS8nlrDo/Gm179X
nmdBQfpE72jRsHJav4GhrQVVbFWJzbCxFnBQ9NZ5mY4Y/BM22qBPOtm6bUk8Zf1V
wTyMKoSM8fQOVV6Yw9U0mi/QXXiw7UCeEibkRo4Wx0fnDIP07p7ir0qa3x+vWM3h
0xxQsaYYSHkrsqpzmJNyb9dq67xutUaqKF6mO8wgjL7hdw/wo0tqrtLSdFWO07TR
4VTlNZ6SPI/XaBzLSb4/wCEgh2IHrHLj+ZFSClEjOQHCOJsxjH+rEiWNcVHjeZnF
JXuoF5X/AmEvH399YPFClY+Pp6XrYcOkgs1Y96YGF6DMHIclY2gNOqV4PL+0KUkW
N9fw+YqQ8jvdUXHm21O5+pq0VZNJcbtVCnNhN2uVBgD+447zIlDbl+drK30lGcsw
s/RQ27hkkeu4HPheP2wYixEktKhNKokbw/3LZnRrsw+QlL4+sNF83DoFgh8eRtR3
acSjD2v4xzRTi/5QGbJBz0W/Sbej7qnSMaaS1FzWnWUKN8GRscom42x/k/DvHVc5
MFTMq+1Fb2SKZGlcDoYj
=krbr
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--===============9100653660141091306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9100653660141091306==--
