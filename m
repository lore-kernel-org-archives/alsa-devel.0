From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/8] ASoC: wcd9335: add support to wcd9335 codec
Date: Tue, 22 Jan 2019 18:41:46 +0000
Message-ID: <20190122184146.GF7579@sirena.org.uk>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 03:06:10PM +0000, Srinivas Kandagatla wrote:

This all looks good apart from a couple of small things that should be
easy to fix:

> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 62bdb7e333b8..1c4904940621 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1100,6 +1100,12 @@ config SND_SOC_UDA1380
>          tristate
>  	depends on I2C
> =20
> +config SND_SOC_WCD9335
> +	tristate "WCD9335 Codec"
> +	depends on SLIMBUS
> +	select REGMAP_SLIMBUS
> +        tristate
> +
>  config SND_SOC_WL1273
>  	tristate
> =20

You should add this to SND_SOC_ALL_CODECS.

> +static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
> +{
> +	struct wcd9335_codec *wcd =3D data;
> +	unsigned long status =3D 0;
> +	int i, j, port_id;
> +	unsigned int val, int_val =3D 0;
> +	bool tx;
> +	unsigned short reg =3D 0;
> +
> +	for (i =3D WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j =3D 0;
> +	     i <=3D WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
> +		regmap_read(wcd->if_regmap, i, &val);
> +		status |=3D ((u32)val << (8 * j));
> +	}
> +
> +	for_each_set_bit(j, &status, 32) {
> +		tx =3D (j >=3D 16 ? true : false);
> +		port_id =3D (tx ? j - 16 : j);

=2E..

> +	return IRQ_HANDLED;
> +}

This will report that it handled the interrupt unconditionally, this
means that if the interrupt fires in error or there's some bug the
interrupt will never be acknowledged (it looks like the chip requires
acks?) but the interrupt core won't be able to notice and handle the
problem as effectively as it could've done.  It's better to report
IRQ_NONE if nothing as handled so that the core can do error handling.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHY+kACgkQJNaLcl1U
h9CzfAf+OswX/S78qZTnvpZvhvVLvWu85Z4ncjctQIVF4XxsKHLMkRXl+Im9ZYff
48+Ol00x2bc8SCf6+5Lph6yaCV8bcSnbjSCnBgcwj2xuKrRWFkClL9A2oUKrzv7L
HCv2C2IB8QG7BiAOaEHjZFlKEk5jL+o/RCKrJsdl4gb8hafUEgbs91bd1LcnZh7v
aN94GltoAgV7Rb3pWMkIyBnLJnusEBZBKACPZ5993SRMGtOK0BDV9s61ENOYpDJg
agLlLCOaFMAB5QaB272lchyc84017fc1b0x3WIphY0q3MnV3hGsk0unLSc+qv/Ew
+jULVBImyVna0PDWOAXsG8GeVh1CAw==
=CcPS
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
