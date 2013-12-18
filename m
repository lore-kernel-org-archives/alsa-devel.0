From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 5/7] ASoC: fsl: Add SGTL5000 based audio machine driver.
Date: Wed, 18 Dec 2013 18:37:43 +0000
Message-ID: <20131218183743.GG31886@sirena.org.uk>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 11:24:42AM +0800, Xiubo Li wrote:

> This is the SGTL5000 codec based audio driver supported with both
> playback and capture dai link implemention.

> This implementation is only compatible with device tree definition.

It looks like these cards should be supportable using the generic simple
card bindings that Morimoto-san implemented, you can see these in -next
as "ASoC: simple-card: add Device Tree support".  Can you check to see
if that's the case?  If it is you'll still need Kconfig to enable
building the SoC and CODEC drivers.
=20
> +menuconfig SND_FSL_SOC
> +	tristate "SoC Audio for Freescale VF610 CPUs"
> +	help
> +	  Say Y or M if you want to add support for codecs attached to
> +	  the VF610 CPUs.
> +
> +	  This will enable Freeacale SAI and SGTL5000 codec, and an extra
> +	  TWR-AUDIO-SGTL sub-board is needed for SGTL5000.

This should select the dmaengine helpers (and should really have been
split out as part of the first patch).

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsetzAAoJELSic+t+oim9cO4P/jg9yDHoYxa8Ua0LQThK0258
o4E8uD798kNnlP43iOfu1L4RPemIoDTrRG3+y10hfOy8kZLHuevIhh/aohoGCJQc
6yME+8z76rEtwO1qszQBFQSmZRCyhNp2X6RxuzQy9a5GVJ5gqA5etE+BCVYSTKeZ
iKjE3CmVPjJusTFR8QnGFrTorFppl4sYAQoyXDCU5cWgbGp219mzvKlXBlMFDQ3d
XI5Mh+qGPlagbvpCVku0JMWanwleWWyG0F2xehGW/hBhs+enzQLzSDiyigX5yjDh
Nmih+WFK6gegEhqdTNocf0g1KQvVkop5LQdZM4GB0E953LYxurOgMFgAPX4Jpw2H
2vSgxpI/kl1mOxBR9o9vnPEIAAkPuXo27cizJNCxuAjydXN6WwIUM8N3w+jFYLRZ
whDio6RPSzGxPv9+3UqyQ/A5+t74+GffUsd/tOQaHIvR3NefJ92JngKYD0ecEEzi
AAeYso9bkf1yErw1f6zJO/cU9T1WDajLBk2WuI8LZTAcPYWKHhlpAkj9veEfoCgU
Asvjx+r8ETwqXfcBnxAKj5O131L/US5+u4KzT8n13glVjmKPwhxbhgzlKPJZEKfw
kUzn9Rm5BQQ1whZa1b+r2+rU1pd7ps+SycYafGSDkfNYgh4QGMQ+3zoggQwYiEcp
E8ZhAt8Q5Dy1MxiepDGY
=dJju
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
