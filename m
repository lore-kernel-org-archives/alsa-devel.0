From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 2/4] ASoC: rockchip: i2s: add support for i2s bclk fs
 configuration
Date: Tue, 13 Jun 2017 21:46:53 +0100
Message-ID: <20170613204653.f6yfph5ixp4s42fh@sirena.org.uk>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
 <1496998369-30556-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32scs6rvuyf6zx23"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496998369-30556-3-git-send-email-sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--32scs6rvuyf6zx23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2017 at 04:52:47PM +0800, Sugar Zhang wrote:

> +- rockchip,bclk-fs: configure the i2s bclk fs.

Rather than having a driver DT property for this the device should
implement a set_bclk_ratio() operation and let the ratio be set by the
machine driver.  The simple and graph cards may need extending for that,
I know they have MCLK configuration support already.

--32scs6rvuyf6zx23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllATz0ACgkQJNaLcl1U
h9CUsAgAgYKjrOEF+7y92AmwJKw0AVK6H0gjUt5P8GtC6Pawr49GcPcRlGGoHG63
UVCt1tcli8Uh1V0aQMpEZG2eWUyGw5E0KWn4l/C8Xx2xiByNzJrovnDWq2stUDik
MyTVh29b3zE/Wu8KdH/mqi1I1liNmsv/w5MgStyX2FVwD1xJlvJq9uufDlNb7AVz
mEXQtIP+/lQm8Fo1EIrxA2jL8wgAb9oALd6KmGeXahyk+HB02i4DV8mCpyENK8gP
i5Dieqm+Pi3ciC55I7ylERTAOV4ADvOpPMq+AeOxi9OS1exXibG4DAif3SQg+B2J
asA9eg7k+8IUpjdxNd4rv/qiyBxeUw==
=QUUW
-----END PGP SIGNATURE-----

--32scs6rvuyf6zx23--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
