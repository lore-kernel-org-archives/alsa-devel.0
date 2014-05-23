From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Fri, 23 May 2014 12:14:46 +0100
Message-ID: <20140523111446.GA12304@sirena.org.uk>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
 <1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
 <20140522103039.GD12304@sirena.org.uk>
 <CAHbNUh2QHv8n7Y19qfO7BagX5AWe0i17MjDvr7yOpHf6YNGW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cC4h1+cE06VMYj7i"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHbNUh2QHv8n7Y19qfO7BagX5AWe0i17MjDvr7yOpHf6YNGW4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "jerry.wong" <jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--cC4h1+cE06VMYj7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 11:05:17AM +0530, Tushar Behera wrote:

> I tested with moving clk_enable/clk_disable calls to set_bias_level():
> SND_SOC_BIAS_PREPARE. That works well for me. Does it look okay?

> +               if (!IS_ERR(max98090->mclk)) {
> +                       if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
> +                               clk_disable(max98090->mclk);
> +                       else
> +                               clk_enable(max98090->mclk);
> +               }
>                 break;

Should be clk_prepare_enable() and similarly for the disable and you
should check the error codes but yes, that looks good.

--cC4h1+cE06VMYj7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfy2jAAoJELSic+t+oim9EScQAId4ylu5WnC4PFlibbNP+1Rd
ZG6HtzrZWrVP+N1rW4Pw9tKF+k9OTsZat8fQz+VETYLzSeagnlZQo/eAQ+LdFLyk
pnfHioHHj25wY3wBbFkFQESwTBWUJw7sEo0V3jXK+H9rzt8RiXis2x6O2pCYxVJZ
fQXgvpcAQK+DAF0lHo8q2c0Aw9MUpfRq/bjve72SD/sVq1MGeNvzsIXv0o+Cwjap
7HXdEEawe9/CQD4WbAJjtf26OgCFFkjYueiJM0iUSW4BKJi8TuWOK1keCM+DWM3N
IR9X/awtayzllf5OLqOXsa+41u3VaJ37zcgAFT3dvxkOpj1hJg13hIJZL8US4Um+
/ibHBWM8nqUaoXozFfdOS+995kpSzlk/uv83YtKy/i6TLoDN1/hp8XjjjQ2Zrir3
RCacF8L4qGwchLc4UH4BeMfrUtDxuNaDEr2QPIEwS3zMfzA8pcYwjKDBowhpgnpo
RMTb1wsR7zzWjWKSXj60Brm2jQg82w77maELKjjOn3cOAHebSF3ITBIKY7X9ZLoQ
ArjX+mEZ85zC1BPH4FkcdB4kYWxCCMf9pehSRV20Rv1SUVIY0toERbm4wi92STtr
aa7RUV9pPBODrgv4m4HW2m8MsarOb3t4chiW2L4DaRfJmg5/3lJtDgesbCEAJC7b
zNq4cEVXfy5MSgJG5UA4
=a8pE
-----END PGP SIGNATURE-----

--cC4h1+cE06VMYj7i--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
