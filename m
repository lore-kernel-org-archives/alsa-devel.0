From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/3] ASoC: add es8328 codec driver
Date: Sat, 21 Jun 2014 22:02:54 +0100
Message-ID: <20140621210254.GF24291@sirena.org.uk>
References: <1403244859-22236-1-git-send-email-xobs@kosagi.com>
 <1403244859-22236-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403244859-22236-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 02:14:18PM +0800, Sean Cross wrote:

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		reg = ES8328_DACCONTROL2;
> +
> +	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		reg = ES8328_ADCCONTROL5;
> +	else
> +		return -EINVAL;

Idiomatically this is just a single if/else, if you weren't doing that
then it ought to be a switch but really there's no need to do something
non-idiomatic.

> +	/* Master serial port mode */
> +	snd_soc_write(codec, ES8328_MASTERMODE,
> +			ES8328_MASTERMODE_MCLKDIV2 |
> +			ES8328_MASTERMODE_MSC);

It seems a bit unfortunate that set_sysclk() doesn't manage MCLKDIV2 -
if that isn't badly named the driver could easily support both the
current fixed SYSCLK rate and twice that.

> +	case SND_SOC_BIAS_PREPARE:
> +		/* VREF, VMID=2x50k, digital enabled */
> +		snd_soc_write(codec, ES8328_CHIPPOWER, pwr_reg);
> +		snd_soc_write(codec, ES8328_CONTROL1,
> +				cc1_reg |
> +				ES8328_CONTROL1_VMIDSEL_50k |
> +				ES8328_CONTROL1_ENREF);

snd_soc_update_bits() as I'm fairly sure I said last time.

> +static int es8328_suspend(struct snd_soc_codec *codec)
> +{
> +       es8328_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +       return 0;
> +}

Neither this nor set_bias_level() restores the register cache after
suspend - this will mean suspend and resume is broken in systems where
power is removed from the device over suspend.

> +	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(es8328->supplies),
> +				es8328->supplies);
> +	if (ret) {
> +		dev_err(codec->dev, "!!! Unable to get regulators\n");
> +		return ret;
> +	}

Print the error code and format the messages normally - none of this
!!! stuff please.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfL7AAoJELSic+t+oim9EDMP/2KK9j+MzzcByPpJiGbZqT6b
HOZMw0fpBg6LJ2L0QtLcHnr7Ye9w6rkzlj/6LQJ9oxmQUGcwUwNh0lvOruv1K9Cy
lC0uos0WsGBpc7y/UrutoChgh/f8ZdUBvgKdWwBDuJXGEkn3L0liI3Snt0DK5Mdr
cGSIyM8i6fk+HCVEBqSrJ4kf1NF4IlkSbBwnJ6qqHACgitjlWkkeMCo9uyEGs7Et
kKCjrDW7ke8/zST/T39YGM+gvyyj7py4ozQvX7ZwlK3QYA7NrwxFnFahqd5aApsx
nHoS2sKOYF+HBKVKTsN1hkB2oYHAQIll7lpe1aBDYHDPQzpn7TQh9n+Yx1uLLufW
XLNtKOSfBSoyZwyICMU7AEfbUEykmmDnSHCHiCBvS8NTL4r3QskpHNsOIT0YH2hP
j7E1SGArqLFnQAGGPbmC5OStWiGTMi6PJQp+V4FZeCWe+aNxqwSQnEyiglHFhqQV
UUlEDoPHxJlQojBXFFjBukOvN948qyuk76RfzX3rtL/+jjMAzsHGytP2NO/tmkTg
QFm52nzC0zJXqeIBY+E7ofqKG0nkOQnSPseCUD8I0p+92NdYCL4yVkuY35lHQkSd
4zUSQAMTnuJjFIfOlzMupZ0zF4U2U818/T6AC5eEabiXfY25tkWB44jF5wzf4hm0
vqLpNE/r1RCoXIDmp6ka
=cnJf
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
