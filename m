From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 06/11] ASoC: ipq806x: Add I2S PCM platform driver
Date: Tue, 9 Dec 2014 16:04:56 +0000
Message-ID: <20141209160456.GE1934@sirena.org.uk>
References: <1418076073-12623-7-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-7-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:01:08PM -0800, Kenneth Westfield wrote:

> +static int lpass_pcm_mi2s_platform_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = devm_snd_soc_register_platform(&pdev->dev,
> +			&lpass_pcm_mi2s_soc_driver);
> +	if (ret)
> +		dev_err(&pdev->dev, "%s: Failed to register pcm device: %d\n",
> +				__func__, ret);
> +
> +	return ret;
> +}

> +static const struct of_device_id lpass_pcm_mi2s_dt_match[] = {
> +	{ .compatible = "qcom,lpass-pcm-mi2s", },
> +	{}
> +};

This device which is intended to appear in the device tree and accesses
hardware acquires no resources on probe.  That indicates that there's
something wrong with the way you're modelling things in device tree; my
best guess would be that it's part of the I2S controller and should be
being instantiated from the I2S DAI driver code not the DT - many other
drivers use this model, it's very standard.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhx2oAAoJECTWi3JdVIfQ43sH/iRAdzQaOigvPV+boRvE4qKZ
DoSjFidlNwqaG/K6DgdtI7FjnNpD+Fx0DNtiUqxVIk6yZYZ38WXWQNVWdtW5m1xB
k30dnfFyIYo9SxCTZGAijUMaqZmjcispGVvEXY+MJDhZLhRbC0ALq9DMrvSmI7va
nq1Bd1MBSrnGz6g889jwF5qjCO4dLEn5sCQbTnTKdPA+IuWGz9NX4G+FwyjWxUSJ
DjYWYMvMZ2kxR68hS9dzBk/ZuAX0Z7Uwx7yo0dxF7s/kWc75wD7Xt0ULjA+oaDZe
mt2NWKZg4oJ9Ka/9Fk9f9jycRyFF8k3VIcDm2g98pOMlQvSkb7RmQ3mGvg+sze0=
=yIGc
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
