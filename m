From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] ASoC: tlv320aic32x4: Support for master clock
Date: Tue, 18 Feb 2014 10:23:29 +0900
Message-ID: <20140218012329.GR2669@sirena.org.uk>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-1-git-send-email-mpa@pengutronix.de>
 <1392631460-32002-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+S4DbcR7QPeSsP0V"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392631460-32002-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--+S4DbcR7QPeSsP0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 11:04:17AM +0100, Markus Pargmann wrote:

>  Optional properties:
>   - reset-gpios: Reset-GPIO phandle with args as described in gpio/gpio.txt
> + - clocks/clock-names: Clock named 'mclk' for the master clock of the codec.
> +   See clock/clock-bindings.txt for information about the detailed format.

Looking at the code the clock isn't physically optional, why not make it
mandatory?  There's only one mainline user, it looks like it should be
straightforward to update with a fixed clock.

> +	aic32x4->mclk = devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(aic32x4->mclk))
> +		dev_info(&i2c->dev, "No mclk found, continuing without clock\n");

This is going to break with deferred probe, we need to handle that at
least.

--+S4DbcR7QPeSsP0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArYOAAoJELSic+t+oim9LVsP/jw5bK6KAx6H7RdNkvjaWMeh
xpmGWHNAkbMms3XEO4/uxep729Z6xp0ZmMPfVmoiZISGqqngF19wjDSDwY39Lj1V
Swkig/CmxNTNPKbNk1lHNGZLKIbpDXnxVlZZ5bh/KNj1Icmg3oGBJEGYAxrsIF/M
An0e9+h4oDg7bTMbLSynpDhhKq2Php7qj/BqXuC/j7sU1eixzmRGJ70RcFCm2NIK
l9+uzYSt6FnOLGElzDp6ivWmkDv0SoA/Jp2wsCiV+hhEnLnNGcjg/U2vjjYFp0W0
RivJFnJT5vVDaymZ1bkaiNeOXbMtqf0eXsW1549XowBmDMwUKA+n7PZblnAsI2M5
Hrbtegnb6meEDfxbCuVA3SgvGZALnVGEwlbzxlvfkdyDIOOwEipajLut5235GjdY
MBxVTMrA2KKeIu0I5qBMst968zUZajSUrleXiOFLKlhuAq55y0Xy66fMvgVeL3FU
khRgkwVRKF7/ubFazih3BoBiHfA4UHuuh8gNGcsqdwH3DlDbKb+QVR0PInXFdrCK
RTSJEpqYBYe+gQm1s+L/eNMmFyyZeycPZgE+qp57ExaffAMsNv3vmGB7BidzjYFU
DPuCWIvPo2igpAfloKLoQFH0+tMlVNIINEUI0oGE8xwtnrdSXT2fYe7xNVgKEkEG
cx1knn15N9DFtxSjYlzl
=lQgp
-----END PGP SIGNATURE-----

--+S4DbcR7QPeSsP0V--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
