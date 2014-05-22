From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Thu, 22 May 2014 18:34:03 +0100
Message-ID: <20140522173403.GL12304@sirena.org.uk>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
 <1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
 <537E1D0A.6020303@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6fORYReWn2mc50W"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537E1D0A.6020303-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--G6fORYReWn2mc50W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 09:51:38AM -0600, Stephen Warren wrote:
> On 05/22/2014 03:17 AM, Tushar Behera wrote:

> > +	if (!IS_ERR(max98090->mclk)) {
> > +		freq = clk_round_rate(max98090->mclk, freq);
> > +		clk_set_rate(max98090->mclk, freq);
> > +	}

> What are the intended semantics of set_sysclk()?
> sound/soc/tegra/tegra_wm98090.c assumes that set_sysclk() is a
> notification to the CODEC driver to tell it what rate the MCLK input is
> set to (the rate is set before calling set_sysclk), whereas the code
> above assumes that this function is to tell the CODEC to somehow
> configure its input clock to be a particular rate. I have a feeling the
> code above might fail on Tegra.

It's a bit of both.  Since we've never had a generic clock API (and
still don't really due to everything being a shambles) it's generally
just a notification to the CODEC that it's at the specified rate,
however if the CODEC knows about its dependencies it seems sensible for
it to tell the clock API about what was asked.  Ideally we want to
remove all the ASoC specific clock control and use the clock API.

The Tegra driver will presumably succeed unless someone does the
appropriate clock hookup in DT, at which point clk_set_rate() for the
rate the clock is already at really ought to succeed so things should
continue to work.

--G6fORYReWn2mc50W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfjUIAAoJELSic+t+oim97igQAJrfT18/HczMy7h37CO8JPj3
yVJfaI0t/2IBxmEpJIYzuNiULEUT2GcLvplK0j7HcudEX4h4qsVure3oTOGcZWtI
Aa9xMOe51G6x8Uw68NKLWq9+tU1uKN5NPJHdSpg6tDQLPY315JyZ/i99RsMJKei/
73Ad2AGmqyZt4mfB8jICdJ4ngsSMj+aM6HXdlev/LqvlTEiFWMj8SOwrU9spePim
3WORM7kY+MLrbNjGO3ShLJJS8Yi4w5wazbSAKZbnvIHofPozC+jxCnvAyT2L0y1H
XYrvnenStu7Exx0/hPMOXXLg5QIRO41+EN7BmjWAXPHzATJnbuMe4S9GPDiFMgF/
rfKqEMgL6fiPScLQUusUdwuySbSuWOERQjAKVODu69PE+neQ1WtrmlirMlTVhkN3
Uo6HCm28HIavIeYJM+grD7/9/UudvPZDVNczhs/CLjZjKLm3ojQzPta/2qis+FqR
VM8RcjZIu/0lYV9atvKXH5Y+GBBeB4C6ki8hD7c3qmmK6uNQk+8cMmjlsGTvkQQ5
2jf5dF9wyveG7XP19ZaV6izPYNsekM8qc0feOuDVsCLpCom4Xr+blSxLk5dL2eWl
1r3xIGpE/8sreHTo+z7NzRk++9ECBSGjxPU3Q3jJLnpNVQAiGzPzS6voL9Ojp3lU
PW6v6f5fa+P4xDVliRIM
=hAyV
-----END PGP SIGNATURE-----

--G6fORYReWn2mc50W--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
