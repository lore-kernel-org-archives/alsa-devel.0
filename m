From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Fri, 31 Jul 2015 19:27:16 +0100
Message-ID: <20150731182716.GO20873@sirena.org.uk>
References: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6569521023297758108=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC7AD261738
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 23:22:18 +0200 (CEST)
In-Reply-To: <1438038837-339-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, mfelton1@nuvoton.com, kcso@nuvoton.com, ccchang12@nuvoton.com, dgreid@google.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============6569521023297758108==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFMLoheMaWcIEZAi"
Content-Disposition: inline


--UFMLoheMaWcIEZAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2015 at 04:13:57PM -0700, Anatol Pomozov wrote:

Looks mostly good, a few things below though:

> +		break;
> +	case 1:
> +		dev_info(nau8825->dev, "OMTP (micgnd1) mic connected\n");

This is far too noisy - these should be dev_dbg() at most.

> +		} else {
> +			dev_warn(nau8825->dev, "Headset completion IRQ fired but no headset connected\n");
> +			nau8825_eject_jack(nau8825);
> +		}

Things like this that aren't supposed to happen are fine but normal
operation shouild be quiet.

> +	/* VMID Enable and Tieoff */
> +	regmap_write(regmap, NAU8825_REG_BIAS_ADJ, 0x0060);

You're leavinng VMID enabled all the timme?

> +	/* Jack Detect pull up (High=eject, Low=insert) */
> +	regmap_write(regmap, NAU8825_REG_GPIO12_CTRL, 0x0800);

This seems like it should be a board setting?

> +	/* Setup SAR ADC */
> +	regmap_write(regmap, NAU8825_REG_SAR_CTRL, 0x0280);

Lots of magic numbers in these things...  some of them I can guess
what's going on but this one is a bit obscure, perhaps it should be user
controllable?

> +	/* Setup ADC x128 OSR */
> +	regmap_write(regmap, NAU8825_REG_ADC_RATE, 0x0002);
> +	/* Setup DAC x128 OSR */
> +	regmap_write(regmap, NAU8825_REG_DAC_CTRL1, 0x0082);

I'd expect this to be user controllable.

> +static int nau8825_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct nau8825 *nau8825;
> +	int ret, value;
> +
> +	nau8825 = devm_kzalloc(dev, sizeof(*nau8825), GFP_KERNEL);
> +	if (!nau8825)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, nau8825);
> +
> +	nau8825->regmap = devm_regmap_init_i2c(i2c, &nau8825_regmap_config);
> +	if (IS_ERR(nau8825->regmap))
> +		return PTR_ERR(nau8825->regmap);
> +	nau8825->irq = i2c->irq;
> +	nau8825->dev = dev;
> +
> +	nau8825_reset_chip(nau8825->regmap);
> +	ret = regmap_read(nau8825->regmap, NAU8825_REG_I2C_DEVICE_ID, &value);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read device id from the NAU8825: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	if ((value & NAU8825_SOFTWARE_ID_MASK) !=
> +			NAU8825_SOFTWARE_ID_NAU8825) {
> +		dev_err(dev, "Not a NAU8825 chip\n");
> +		return -ENODEV;
> +	}
> +
> +	return snd_soc_register_codec(&i2c->dev, &nau8825_codec_driver,
> +			&nau8825_dai, 1);
> +}

I'd expect any initial register initialistion to happen here (if only so
we save power until the card registers).

--UFMLoheMaWcIEZAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVu74EAAoJECTWi3JdVIfQxw8H/iznlUqUOPxqUP7+t54podkB
MgrOEk+WlwwAPBl9VAe+tjv82hlfoNaf923g3MbiJ5d1AXIJ9oBcy/qvn5cJNr7P
lIEzA5lMklBeivWTtoC/QqmrL6a+sF0F0/LdIX9ieBO/oLxmILDCQT5DSEzDECMK
26fcroAtaQ1cm1zw2C6eV1QRm2+woCVb7ytjoYy+l2yo7/HHgxZgh3cPyxQF9PLz
EzcS8kpejMlVtI0qa3Kf0M+gUefkYlY8jIBX+dMhYwoBRsvzVZ6gwwpxSuRgqNCm
3YjUazRKMwlz07WVogXAHEyMFgOm8GTpBKH4sWUUtWMjbqFGDZYxiGoVY7cze4E=
=pqUN
-----END PGP SIGNATURE-----

--UFMLoheMaWcIEZAi--

--===============6569521023297758108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6569521023297758108==--
