From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 14/15] ASoC: rockchip/rockchip-hdmi-audio: add sound
 driver for hdmi audio
Date: Thu, 26 Mar 2015 11:16:20 -0700
Message-ID: <20150326181620.GZ3572@sirena.org.uk>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
 <1425179070-2736-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3574320421423367378=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1425179070-2736-1-git-send-email-ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel@pengut>
List-Id: alsa-devel@alsa-project.org


--===============3574320421423367378==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NJ3GtppTlf/130kA"
Content-Disposition: inline


--NJ3GtppTlf/130kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2015 at 10:04:30PM -0500, Yakir Yang wrote:

> +	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
> +	if (ret < 0) {
> +		dev_err(cpu_dai->dev, "failed to set cpu_dai fmt.\n");
> +		return ret;
> +	}

You've already set this in the dai_link, no need to do it again.

> +	dev_info(&pdev->dev, "hdmi audio init success.\n");

Please remove noisy prints like this.

> +free_cpu_of_node:
> +	hdmi_audio_dai.cpu_of_node = NULL;
> +	hdmi_audio_dai.platform_of_node = NULL;
> +free_priv_data:
> +	snd_soc_card_set_drvdata(card, NULL);
> +	platform_set_drvdata(pdev, NULL);
> +	card->dev = NULL;

If any of these assignments is doing anything there's a problem with the
code.

> +{
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_card(card);

devm_snd_soc_register_card() and you can remove this function entirely.

> +static const struct of_device_id rockchip_hdmi_audio_of_match[] = {
> +	{ .compatible = "rockchip,rk3288-hdmi-audio", },
> +	{},
> +};

There is no documentation for this binding, binding documentation is
mandatory.  Based on the compatible string this looks like it's specific
to the SoC rather than a design for a board - is the whole card part of
the SoC?

--NJ3GtppTlf/130kA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFEzzAAoJECTWi3JdVIfQDHoH/1e/8agSVnWGgaEMc0obh/dg
6AHcHMbXlJJ+df8MK4p/pIdgkq8an4KWXmSHY/tbQ0Z8ylVEImUq5eZi42ZU+P/v
PWPLwkYoant5d+QryNF61Gze0PkImIWvbI7pzEAhrXUVfyi9VAXazxTpDotCHWGl
G2A6CBMDTgRUEuz4/yIDpBxTxEm0E7ymg5OQvad1eKJvMlIdoaKoLryOeJ+tIQ7q
8D20Kj2gHJDgFT+SFLmD//XgLpnFTO3ELHdrJq8k4bMzlPVxkkPpTjTG0tvfxAOd
e4j3dDI0tDTd1IGrCeQoCLQ964wMGKiUNcvELk4DNLPPZ/MYqd+72/jFKF6z2bQ=
=ipGX
-----END PGP SIGNATURE-----

--NJ3GtppTlf/130kA--


--===============3574320421423367378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============3574320421423367378==--
