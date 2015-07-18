From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Sat, 18 Jul 2015 10:16:08 +0100
Message-ID: <20150718091608.GW11162@sirena.org.uk>
References: <1437196124-32655-1-git-send-email-zhengxing@rock-chips.com>
 <1437196124-32655-2-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SU+pDiHQETgHpG/P"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437196124-32655-2-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--SU+pDiHQETgHpG/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 18, 2015 at 01:08:43PM +0800, Xing Zheng wrote:

> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Soc register card failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int snd_rk_mc_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_card(soc_card);

The point with using devm_snd_soc_register_card() is that you don't need
to manually unregister the card - devm_ ensures that the card is freed.

--SU+pDiHQETgHpG/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqhlYAAoJECTWi3JdVIfQeeMH/RQhtnroV3QJcbWmfaUlQuZA
fOTUiJm45e43jgZsUScveDom6QrjpS+P5O8XQqtAcG7UuVUNY0LOmDB3TzWATH8O
VwAgpNBiCO3d2AW6cQMj2vdTSRc7xueCj6XGtbTJVZLpXJGaJ25h+ftmWc85R6de
BuYi1k5/F3Hu8PjdPjAWceZkYAIGGgzrJsFN6DRHdVfcyrlDAC4eT22bi8jqlK3R
bFsPwsvG1dQq8A0QbClwoeRtV0Tt2kweRE2ZZpQoneIjYyYjCZCunvmRqe3P8KPs
EJo73jIXWwxo15x94iVWwJ2qg0dSeA/9LqZqCDR7j35BZjb29vIQElTIe3xb7lE=
=Pay8
-----END PGP SIGNATURE-----

--SU+pDiHQETgHpG/P--
