From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ASoC: fsl: add imx-es8328 machine driver
Date: Sat, 21 Jun 2014 22:05:41 +0100
Message-ID: <20140621210541.GG24291@sirena.org.uk>
References: <1403244859-22236-1-git-send-email-xobs@kosagi.com>
 <1403244859-22236-4-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403244859-22236-4-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 02:14:19PM +0800, Sean Cross wrote:

> +  ES8328 pins:
> +   * LOUT1
> +   * LOUT2
> +   * ROUT1
> +   * ROUT2

These should be covered in the binding document for the CODEC.

> +	/* Setup clocks */
> +	data->codec_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(data->codec_clk)) {
> +		dev_err(dev,
> +			"codec clock missing or invalid\n");
> +		goto fail;
> +	}
> +
> +	ret = clk_prepare_enable(data->codec_clk);
> +	if (ret) {
> +		dev_err(data->dev, "unable to prepare codec clk\n");
> +		return ret;
> +	}

The CODEC driver should manage the clock for the CODEC, if it's mapped
properly attempting to look it up using the card device should fail.

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfOhAAoJELSic+t+oim9KnAP/jeO0J4uReezd9ErGoDoktBt
7c1EIzj0kGGDszn+SQfbjYwzn/J/W3ZI6++oolip0rVzs7ee/w068c/Aygkf326a
hUq3tkv0m4fLluDDiKD4Z35go+OZOTfYeq/5OeLHxefTJkO9YTAa+TgmvlsVwHZ/
PF9hzHKIfWixtejipcvQogKJ3mg0eXdei9NjCnKvwZo8Fcx2QrtYgolT1OZvJyZX
YfV7O/EQMVfAwvCIluW0JnQWeu6x1nBnrrgoDrHcrCKc2tB/xLfd2RH4msKi/oe+
lxkyLhI3gzPc63RO3LU48EDDWutBNL3rSN0g4KQVjMNum83DT7Zx3c+6wxHPjJbu
z8cU/zkASdgH4wiDKqY5U4S7tEz4cP/QNvTAjMJ73OTrVddVoxyj/lwJ8MzfmCE2
/nOf9S+rO9TZ8WWecm+M1FvOHMQwMR0inUDFd5ZMEjRObVHYb4/b14oJ88E4DKu9
xwlbJESj46XUVC0Pixv+9v0eTPbkWkL35jfvbwcSn758ueTw55yWeZQH2CNgHhEp
LvoFL82PVuybBhCk2l740KEVF83Cf+JJYKMn2dulHdoFF1fe+tJBk5y70My7Ra/U
XusqfCFL5KricMxbRWcM1UpCVD0aSD+E45ucm/iEYCBhKuZxzuBvBbohZaqIHfnV
JkqMAAZpwa6qe5RTX6fF
=iAVD
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
