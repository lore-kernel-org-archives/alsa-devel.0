From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
Date: Fri, 18 Aug 2017 12:52:23 +0100
Message-ID: <20170818115223.pyfqji5jkplt6isx@sirena.org.uk>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
 <20170817044417.22069-3-jeffy.chen@rock-chips.com>
 <20170817171152.abf3ngr6nr22jfif@sirena.org.uk>
 <599645E2.4020402@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m6wid7jysdtjmmci"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <599645E2.4020402-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--m6wid7jysdtjmmci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2017 at 09:41:54AM +0800, jeffy wrote:
> On 08/18/2017 01:11 AM, Mark Brown wrote:
> > On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:

> > > -Optional properties:
> > > -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> > > -  If this option is specified, which means it's required dmic need
> > > -  delay for DMIC to ready so that rt5514 can avoid recording before
> > > -  DMIC send valid data

> > Why would nobody ever want to use this in future?

> hmmm, check again, rt5514 fixed this issue in there driver instead in:
> a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

> so we don't need this...

You don't need it on your board for new DTs but why is it not possible
that another board might need it?

--m6wid7jysdtjmmci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW1PcACgkQJNaLcl1U
h9Ajwgf9HA9rtrdJwNVlAtEKNVupp1jzWXvXw7UIeADdamflEQ3RP9vYmENUHoLn
VinUjB0TGRRqb5hQedf/p5N8x1kuytGXrkfucoQqJ8V7YJR8NKiINQI7yTRCYW7X
OcJOj44puTm/pSlOWaexhC+rGmcDjEKpY0beZI0jHt79r+Ayv1/3FxHuNCHR498l
KXmDKHgfgI1vSNZeDpV3DisCZvp7/J6WdghOMvqnnvrtmvWWK6+umOWSaHG2PGZE
iy96mfapluf9MCfvGfCm8zFoxit2mYNcnAweHZSNQuoCe+Nh8rX4A+77SPsMEZUx
Qn303i4WoIEaXc62qr/4ewAETN+73A==
=TCfK
-----END PGP SIGNATURE-----

--m6wid7jysdtjmmci--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
