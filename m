From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
Date: Wed, 3 Dec 2014 20:03:07 +0000
Message-ID: <20141203200307.GM7712@sirena.org.uk>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
 <20141203192024.GL7712@sirena.org.uk>
 <CAPz6YkXRmRzYpW7xuDsq69A9H-Qm2-j6t-a+B1w9+OLOPf_YnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gz7Dl29304g/DuvU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPz6YkXRmRzYpW7xuDsq69A9H-Qm2-j6t-a+B1w9+OLOPf_YnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--gz7Dl29304g/DuvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 11:38:13AM -0800, Sonny Rao wrote:
> On Wed, Dec 3, 2014 at 11:20 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I would expect that the clock for the CODEC should be managed by the
> > CODEC if at all possible - that seems more logical than having the CPU
> > I2S controller request and manage it if it's a separate clock.  Why add
> > this to the CPU side driver?

> This output clock has a mux and can either be a fixed 12Mhz output or
> can be derived from the same fractional divider which drives the i2s
> block.   I thought it was simpler to keep them all the same, but need
> to put ownership in the i2s in anticipation of the i2s driver setting
> it's own clock rate.

> If you think this is an implementation detail and this output clock
> should just be owned by the codec driver, even though I'm guessing it
> will just have to be the same as i2s, then I think we can drop this
> and make sure simple card (or whatever other codec driver) claims this
> clock.

simple-card obviously isn't a CODEC driver...  For generality I think
the clock does need to be exposed to the CODEC driver, otherwise this
will work differently to how other systems are working and we can't
substitute in a different clock on the CODEC side so easily if it
doesn't happen to use the output from the I2S block.

--gz7Dl29304g/DuvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf2x6AAoJECTWi3JdVIfQor4H/R8QlkqfCU1Ht8Ka0ICFucYS
I79180Ndm9Ulbi7VE7FusGljeVINcXw1GWWw34nkG5zjGVoFlVY3flV7ZNbfOlyM
5LQHM8j11BUqQB7WQ1AGtBJ3XTB3yO74MXMva4zCufePubbG72HNgn1CdkvgMXT5
Ty5JrgwWMBxeLZ77xrt4zVZMlGSNPgk/fKGiGxE8qb82kHMZYeodDRXnU/GR4LHC
UPGDFvzILh7eZXGUKtmG33+YRay44JLW3gfLZd27iDoPmxoVCNzvS7CIn1yUls0I
cQbklM9JMBlt/bjzWs8g9aOFeqZ8IKzwGzMlqTrWcgwEpW2PXpBhmHxFlj9hUnw=
=Bt5J
-----END PGP SIGNATURE-----

--gz7Dl29304g/DuvU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
