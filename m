From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for
 max98090
Date: Tue, 12 May 2015 20:26:36 +0100
Message-ID: <20150512192636.GA3066@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+Rb494BzBd9643b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <acgzxing@gmail.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, zhengxing <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--j+Rb494BzBd9643b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 05:26:35PM +0800, Xing Zheng wrote:

>  sound/soc/rockchip/Kconfig                   |   10 ++
>  sound/soc/rockchip/Makefile                  |    2 +
>  sound/soc/rockchip/rockchip_machine_driver.c |    6 +
>  sound/soc/rockchip/rockchip_machine_driver.h |    6 +
>  sound/soc/rockchip/rockchip_max98090.c       |  185 ++++++++++++++++++++++++++

This looks more like a normal and reasonable machine driver but then why
have you created the generic rockchip machine driver?  It seems like
this should just be a regular machine driver like other platforms have,
were it not for that this would be mostly fine apart from a couple of
nitpicks below.

> +config SND_SOC_ROCKCHIP_MAX98090
> +	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
> +	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
> +	select SND_SOC_ROCKCHIP_I2S
> +	select SND_SOC_MAX98090
> +	select SND_SOC_TS3A227E

This looks like it's a driver specific to Chromebooks (possibly even
specific Chromeooks) and so should be named as such.

> +	card->dapm.idle_bias_off = true;

Just set this when declaring the card, don't do it at runtime.

> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
> +	snd_soc_dapm_enable_pin(dapm, "Speaker");
> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");

No need to do this, all pins are enabled by default.

> +	snd_soc_dapm_sync(dapm);

This has no effect during initialization.

--j+Rb494BzBd9643b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUlPrAAoJECTWi3JdVIfQCzcH/imj7lPckGqfhnJrCL7Qzzlb
gWs9HoP8Or/8E1BOX3LYxoVaV/CfJKVTsJ0B08OIeh89vp9Rb2WL3oQM7ZwD0jPS
PI55/1zg9Rz6CQrQVLnQSZSCJp8BOXlKXi+vzuUBKHjPjl8tVWt6V7IdPL0lpksf
TpzC5K+wD1pFzEe+NTf02PyMmbbH4GyYPWQ7MkM/1tF2OlF4H46bhxtMEM5cUMk7
EiTrdlT4dx5M5LQXmgIOuTha28jiFXAKm3Rczug5QFMw3tw6BSkN6WGO27mxZI0Z
3WE3/0lrAx4/597W8ajODmCTL5fzQ4bekSmV80XfV/XOYFxa3Fc+kMsOVFLBM1E=
=TjXs
-----END PGP SIGNATURE-----

--j+Rb494BzBd9643b--
