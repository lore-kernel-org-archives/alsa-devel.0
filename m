From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
Date: Sat, 18 Apr 2015 18:37:40 +0100
Message-ID: <20150418173740.GF26185@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8BcnzLwh3ipgLRM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428653649-38200-3-git-send-email-koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--p8BcnzLwh3ipgLRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 10, 2015 at 04:14:08PM +0800, Koro Chen wrote:

> +/*
> + * The MTK AFE unit has a audio interconnect with MTK_AFE_INTERCONN_NUM_INPUT
> + * inputs and MTK_AFE_INTERCONN_NUM_OUTPUT outputs. Below table holds the
> + * register/bits to set to connect an input with an output.
> + */
> +static const struct mtk_afe_connection
> +	connections[MTK_AFE_INTERCONN_NUM_INPUT][MTK_AFE_INTERCONN_NUM_OUTPUT] = {
> +	[0][0] =   { .creg = 0x020, .cshift =  0, .sreg = 0x020, .sshift = 10},
> +	[0][1] =   { .creg = 0x020, .cshift = 16, .sreg = 0x020, .sshift = 26},

What are the constraints on using this - is it one input to one output
only or can we do mixing or duplication?  The register interface
definitely does look like something asking for runtime configuration.

It'd also be nice to have less magic numbers in the table, at least for
the indexes (which I guess correspond to some of the defines in the
headers)?

--p8BcnzLwh3ipgLRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpZjAAoJECTWi3JdVIfQF5kH/0dICMWCfhiIwSQjNwp4sqKp
b+FKyTCeNM4/1ZJ3Nw/O9jSv+WkXriBbXrMVD7gvpZv4GOaDpcMJg1WI94L5nkdZ
uuktldTz8H0QeAtxGvJKHrWlNoLNABrD8a0AlCMM9JUY720RYmum1TIn30HxkYWO
t1i0WoI49lrOVwLCGXqtdprPQnnsoS4HkxSLlFUeAFoBJi9ZaiwW17HiCUv2quon
spB2KOFqvU4V1oiucLYDqEdWgUiwaQDDVT6Oe4kpIDsJMIo1C1sOul7NspupfXmY
SV83UA9RTcYZN3h+Pan4dbTFcIfGjb+dhqEXR6LMN9kkteBrgCUckqSZbb9+eYM=
=2Peo
-----END PGP SIGNATURE-----

--p8BcnzLwh3ipgLRM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
