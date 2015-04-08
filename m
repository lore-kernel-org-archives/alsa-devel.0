From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: add shutdown callback for max98090
Date: Wed, 8 Apr 2015 10:50:05 +0100
Message-ID: <20150408095005.GS6023@sirena.org.uk>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
 <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AEApRQ7IrnsbU9Wi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Tushar Behera <tushar.b@samsung.com>
List-Id: alsa-devel@alsa-project.org


--AEApRQ7IrnsbU9Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2015 at 04:52:08PM +0800, Caesar Wang wrote:

> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
> +
> +	dev_info(&i2c->dev, "shut down device\n");

Remove this, it's adding noise.

> +
> +	/* Enable volume smoothing, disable zero cross.  This will cause
> +	 * a quick 40ms ramp to mute on shutdown.
> +	 */
> +	regmap_write(max98090->regmap,
> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
> +	regmap_write(max98090->regmap,
> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
> +	msleep(40);
> +}

This is OK but equivalent code should be being added to the driver
remove path as the same thing should be happening there.

--AEApRQ7IrnsbU9Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJPnMAAoJECTWi3JdVIfQAyIH/1X66xgsTbr0s6cYbuWsTO7+
ldRRcN7gq1RybnEfPb+lpiwlq7Vv4wJ6FF4UTKV/pc8F4C/REk65pRdmfD2Xb78s
ZeO0nUrkH7WyUz+LKutupGj7Tya1pdhRYqwWcGlkQAAOGbbjIueV80OOwV89T0zF
jso/88v9ymy/bUlW4FTA72kezBzgt/VquYcCQwTqvnn7sGe9D8OQ3AzD4pdjeb0R
WLfNftdjYapL4SoIaa0cEN3dC2H5Bxw+PAWef8w/pMAa5b6UGLgd3Ucx7BP04PcO
0iKf4qYFPCQA2a9UqxeXwGiMU3R3xBen48ApmCKeUrf3U9m3oqco8PvjVCQYXT8=
=0GYR
-----END PGP SIGNATURE-----

--AEApRQ7IrnsbU9Wi--
