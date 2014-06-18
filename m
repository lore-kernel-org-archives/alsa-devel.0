From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ASoC: add es8328 codec driver
Date: Wed, 18 Jun 2014 10:45:05 +0100
Message-ID: <20140618094505.GD5099@sirena.org.uk>
References: <1403063242-20840-1-git-send-email-xobs@kosagi.com>
 <1403063242-20840-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3IUuVPBxFdaU0JwQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403063242-20840-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--3IUuVPBxFdaU0JwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2014 at 11:47:20AM +0800, Sean Cross wrote:

> +Required properties:
> +
> +  - compatible : "es8328"

This needs the prefix, as does the example.

> +static int es8328_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap_config config;
> +
> +	config = es8328_regmap_config;
> +	return es8328_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
> +}

config appears to serve no purpose here.

> +/* Run the codec at 22.5792 MHz to support these rates */
> +enum es8328_rate {
> +	ES8328_RATE_8019,
> +	ES8328_RATE_11025,
> +	ES8328_RATE_22050,
> +	ES8328_RATE_44100,
> +};

The driver should be enforcing constraints based on the clock it's got
then.  Not everything does though so it's a bit optional.

> +static int es8328_put_deemph(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct es8328_priv *es8328 = snd_soc_codec_get_drvdata(codec);
> +	int deemph = ucontrol->value.enumerated.item[0];
> +
> +	if (deemph > 1)
> +		return -EINVAL;
> +
> +	es8328->deemph = deemph;
> +
> +	return es8328_set_deemph(codec);
> +}

This will unconditionally store the new deemphasis setting even if we
failed to set it.  That should never happen but still...

> +	SOC_DOUBLE_TLV("Mic PGA Gain", ES8328_ADCCONTROL1, 4, 0, 8, 0, mic_tlv),

Mic PGA Volume.

> +	SND_SOC_DAPM_MICBIAS("Mic Bias", ES8328_ADCPOWER,
> +			ES8328_ADCPOWER_MIC_BIAS_OFF, 1),

Represent this as a suply, MICBIAS widgets are legacy.

> +	case SND_SOC_BIAS_PREPARE:
> +		/* VREF, VMID=2x50k, digital enabled */
> +		snd_soc_write(codec, ES8328_CHIPPOWER, pwr_reg);
> +		snd_soc_write(codec, ES8328_CONTROL1,
> +				cc1_reg |
> +				ES8328_CONTROL1_VMIDSEL_50k |
> +				ES8328_CONTROL1_ENREF);

snd_soc_update_bits().

> +const struct regmap_config es8328_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ES8328_REG_MAX,
> +	.cache_type = REGCACHE_NONE,
> +};
> +EXPORT_SYMBOL_GPL(es8328_regmap_config);

No need to specify no cache, it's the default - though a cache is
better, it's faster and allows for suspend/resume.

--3IUuVPBxFdaU0JwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToV+eAAoJELSic+t+oim9DkgP/juZs/PCVZL39ecU5kQtafwW
lamYA72xdWX0TOQ/gHDpc80H4U9lK0ObpHwhbBK3cNIoZuBluGdIiZaB0E6qxUOQ
VpD9v0C9eZYVTKSQ1RIO3cylrx4O/nAaWcUd1fHnGygZBBvNOJmt4pzLaTTlL72s
acs5UYL9PpQG9vyr6hkLaoFSWFvgxbWHYwMvf501LJpSMMLtE712xx4cZgH2q6Do
oYEz7aT96Yr7AGdxCNnH8Yx5ho10iKVHEjQKHNzm4d9aJP/gTNB163sPeZ64zz9d
M6y6F25nUHtNyhGBtDn4zvi2u2j3tU+dklC693ug+5ZjHbSrmZ/PEIGr8O4sGPJv
05D/xtJWKVxQA31Swlq+rNhiY1/wFgBcFgyYFeGucZBJ/1NEpd/5QJi1RzQsEiYx
pMqDsVvrb7/zJtPQrKiHRvoZlC9m1bUWi+LM+OkW4hx+nnH2un8mlCzqKuvte1kx
zue8tTtw6V5O9nmjucjxvvUAhxqVAtryvBugCMJcddNLiKlt71oW7fMVsk9xuLK2
hGINFCNqSJXzzDRMj0ogbB77DfHYrEZaPbQMHAiFQ+8di51jE8QB2UZJPpul1owR
7v9GMgZP3hS1scfG7hntyzpoUrVurimnlPtvhF8l1xzvqZaEfK/0kSpiwSsB3Gkk
CMcFeeC65JOnQ+iZSq/H
=v9HQ
-----END PGP SIGNATURE-----

--3IUuVPBxFdaU0JwQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
