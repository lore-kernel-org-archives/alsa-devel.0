From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver for Cirrus
 Logic Madera codecs
Date: Tue, 11 Apr 2017 21:03:31 +0100
Message-ID: <20170411200331.nv7bhwglrc7peggu@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170410174917.dlklrvw2sraeq6xs@rob-hp-laptop>
 <20170410181136.btpvcat2ijwiebvm@sirena.org.uk>
 <CAL_JsqLYi8txm2xb5emGvbC0P2cvtW2wXLdA=2qCO-wt_4JXXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ju7rq4pk2b5yh6ah"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLYi8txm2xb5emGvbC0P2cvtW2wXLdA=2qCO-wt_4JXXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ju7rq4pk2b5yh6ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2017 at 02:20:31PM -0500, Rob Herring wrote:
> On Mon, Apr 10, 2017 at 1:11 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > In what way?  Other than the -gpios stuff (which would just be a trivial
> > thing if we wanted to change it)?

> That's mainly it.

I don't see that as meaningful or a good reason to duplicate the driver
or the binding, it'd be better to just add the new property and
deprecate the old.

>                   It's not clear which node wlf,ldoena goes in either.
> In the parent? ldo1?

Parent since it's looked up in device context, this is also something
that it seems better to fix in one binding rather than duplicate.

--ju7rq4pk2b5yh6ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljtNpIACgkQJNaLcl1U
h9A0Vgf9G9MsNcnST0EhK+nIH9UisqZhfYnkOGa0lR7m31xbaqxhSyg8Mv5G+Nv2
OeE+wL3czTi1+xTdV3RqmJifaatrRIWecDHZLaKArtnUnvcvIHC6PPM9awpHqPS4
OOSBRZ2jTGF6TREmjkXl9VhLjVgBoYmLSCVmvHThO4ewatuJS8hSDMN4fwZWdqRh
TAUZC5pW7sTY3g7xFygDej1wGJlxZkxh6auSZlLHMuL3auIP8WB5RRGpuB/Dvc48
XLfSNn477rbE2jKh9uJDWnfqG7UWclFmvnEmZgb5/fi3TGbacHyX9sYYekoCWsGY
uvWQKb5lq9TZURIWSa9fx7sjRmxf5g==
=RCcr
-----END PGP SIGNATURE-----

--ju7rq4pk2b5yh6ah--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
