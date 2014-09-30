From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] drm/i2c:tda998x: Use the HDMI audio CODEC
Date: Tue, 30 Sep 2014 20:25:40 +0100
Message-ID: <20140930192540.GL4273@sirena.org.uk>
References: <cover.1411547014.git.moinejf@free.fr>
 <4b3d35a14461ed164956b7f5aa77b29170bc393d.1411547014.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gmhhrsDozM2n+uz5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4b3d35a14461ed164956b7f5aa77b29170bc393d.1411547014.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--gmhhrsDozM2n+uz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2014 at 10:11:21AM +0200, Jean-Francois Moine wrote:
> This patch interfaces the HDMI transmitter with the audio system.

Please use subject lines corresponding to the style for the subsystem.

> +	request_module("snd-soc-hdmi-codec");
> +	pdev = platform_device_register_resndata(&priv->hdmi->dev,
> +						 "hdmi-audio-codec",
> +						  PLATFORM_DEVID_NONE,
> +						  NULL, 0,
> +						  &tda998x_hdmi_data,
> +						  sizeof tda998x_hdmi_data);

Why is this request_module() needed?  If there is a good reason for it
we should have some documentation.

--gmhhrsDozM2n+uz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKwO0AAoJECTWi3JdVIfQmr0H/i7ij3vyrmU4dk7pN5qms6Th
eTxnRhHPcUD5DhZxXD82yXG+iKdWpOEPeC1ndQv5lOwOEMzPB0CVUiJ1WoxmCSez
1qqvRawae184iIy0U4wzkOax95C5LtjxkHlFuM9xw0dAcLA9g4HZZWqXEPGaCJts
ivRx8ygkPRNi9rU0EHurYS6GXr/pTU7PCTtDTbtUp8Yd9RHxqE9B0DlKzuHwt4+e
VTvkcMKRNdUgRCY9h3CxfPSEPR/FO9eeHRsGgaBTkPZMzwKRb8Wjv4Hkt4Xp59u7
4l2wSXjh4mJrPAj2FQz3svQLE3vII8+Z1JbGySjY75YSje67j2YCCoupe97WQpU=
=FSmn
-----END PGP SIGNATURE-----

--gmhhrsDozM2n+uz5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
