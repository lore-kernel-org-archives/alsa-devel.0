From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Sat, 16 Aug 2014 15:06:16 +0100
Message-ID: <20140816140616.GN28623@sirena.org.uk>
References: <20140708114057.5ef3cfd0@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140708114057.5ef3cfd0@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Jackson <Andrew.Jackson@arm.com>
List-Id: alsa-devel@alsa-project.org


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 11:40:57AM +0200, Jean-Francois Moine wrote:

>  .../devicetree/bindings/drm/i2c/tda998x.txt        |  13 ++
>  drivers/gpu/drm/i2c/Makefile                       |   2 +-
>  drivers/gpu/drm/i2c/tda998x_codec.c                | 247 +++++++++++++++++++++
>  drivers/gpu/drm/i2c/tda998x_drv.c                  |  74 ++++--
>  drivers/gpu/drm/i2c/tda998x_drv.h                  |  32 +++
>  include/drm/i2c/tda998x.h                          |   1 +

I'd expect to see the ASoC parts of this appear under sound/soc (even if
just a library that the DRM driver links against rather than as a MFD).
This should help avoid cross tree issues and surprises when people do
API changes.

> +  - audio-ports: one or two values corresponding to entries in
> +	the audio-port-names property.

What are these values?

> +  - audio-port-names: must contain "i2s", "spdif" entries
> +	matching entries in the audio-ports property.

So it's mandatory that both I2S and S/PDIF be specified?

The code looks broadly sensible in so far as it

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT72VUAAoJELSic+t+oim98uAP+gPk82HZc6FQXkq2G4n0jnsK
wIu1BJGYUDZmzZfJV0UDfd3Y9v3h2OprohquiVe2hk6N7zm8wSFAOAX+qBIHUDQ1
LNjjsutE2ZMCpCai0c+rd7FdCPm9hdmxvVusBSJeRzRQUN0Fwbf9+79dUaSXUTu0
WwGiClwQ+VlRKIB1Cf1ezMut0tjUVEj4Oth+DiDOueDjuf6G/BKyF4tFOqSkcvbm
Ij9Y8wNmAbHhm1/ElN2Bbl75hxPH6NIcaJ/O3n56kATTsWtiKIVbkY5fY1PmLaRj
MEV70NIXkcjHJ3uo6wvn6es+9Xai6W9cxWF7QA78oB11aA8AxCFKsxaPMO5OsFqE
EN27i76OBK9JLXsndSUu8BO9BUSErOXiafkhSOvB9thg3ytaxxLnKwKOnUkHbe7g
SJcNSZxX9vzp2FK3WfEnSeLuSGeyxYnBWf4YkRZ0ZUNdcYB7ZGeZo3MdzuAXQT+V
XZCk/K5P+wEDWHbc00LVqLu6/T4FVuqEoGgo6sSJe1UEJkBXIKgQEE4shCZgJ0uo
kUrRixzuv6zbaCVdyBmLsZHXtqnUkA3BnAeuDaEsIMrDdd28nyC19XRLTdchkENy
Kf9UdppshdmySP1VkgN+0BPXC2PSRBNV9ZtLE6vuyeSb9gJ/fBWkDQFd2cEsBDa9
jomA8rHe0QZa0tRX5Xkk
=9pOb
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
