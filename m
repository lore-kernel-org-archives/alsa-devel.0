From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Fri, 17 Jul 2015 19:04:02 +0100
Message-ID: <20150717180402.GS11162@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XmZLSFikexiR11mx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--XmZLSFikexiR11mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 11:15:42AM +0800, Xing Zheng wrote:

This looks pretty good, a couple of minor points below which should be
quick to fix.

> +static int rk_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	struct snd_soc_card *card = runtime->card;
> +
> +	card->dapm.idle_bias_off = true;

You shouldn't need to do this?  If you do need to do it we should make
it possible to do it from the card struct.

> +	ret = snd_soc_register_card(card);
> +	if (ret) {
> +		pr_err("snd_soc_register_card failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
> +	if (ret)
> +		return ret;

This should be devm_snd_soc_register_card() and you need to parse the
card name before registering it, otherwise the card might instantiate
before the name is set.

> +static int snd_rk_mc_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> +
> +	snd_soc_card_set_drvdata(soc_card, NULL);
> +	snd_soc_unregister_card(soc_card);
> +	platform_set_drvdata(pdev, NULL);

No need for any of the _set_drvdata() calls, the core does them and they
shouldn't make any difference anyway.

--XmZLSFikexiR11mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqUORAAoJECTWi3JdVIfQyUQH/345639K84F3Rm4/qiSeG5d4
QWl3Lq+TO58kaWj3P9em5F48qqvj/dJySmfobyF2L4iGT88wDBpLmgemdQbglxl+
SPB3ZgorWRcxEbmfP3pFP9H39/TwGQXyubNB0+ihYOEoFHjDPhfrueOxUDES/gPB
6UVxmVJrmga4+sjGtvrvz3wzeWekgEtCyGT9CXgEEvYEe5+c61pTKxnO04yKsHy5
bwySiPxRO2Nj/L50jD/LaF39QdqGrovKbS4pT2g/Xw20elZi3G7rTNAaqiscVJuW
TPcMjyfkJZebV/3A7dB2wVDZL2jApdVUpMCuKa2+Qv7pmbZRwwoo9AwtT6E+Mhw=
=027Z
-----END PGP SIGNATURE-----

--XmZLSFikexiR11mx--
