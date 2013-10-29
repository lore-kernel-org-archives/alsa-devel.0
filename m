From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/6] ASoC: sirf-inner: add mach driver
 for SiRFSoC internal codec
Date: Tue, 29 Oct 2013 15:09:53 -0700
Message-ID: <20131029220953.GA11424@sirena.org.uk>
References: <1383002159-29273-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2320212400503171425=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A66302615F7
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 23:10:05 +0100 (CET)
In-Reply-To: <1383002159-29273-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2320212400503171425==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 07:15:59AM +0800, Barry Song wrote:

> +	if (sinner_card->extcon_info.state_changed) {
> +		sinner_card->extcon_info.state_changed = 0;
> +		if (!sinner_card->extcon_info.last_state)
> +			gpio_direction_output(sinner_card->gpio_spk_pa, 0);
> +		else
> +			gpio_direction_output(sinner_card->gpio_spk_pa, 1);

What's this extcon stuff all about?

> +	sinner_card->sirf_inner_device = platform_device_alloc("soc-audio", -1);
> +	if (!sinner_card->sirf_inner_device)
> +		return -ENOMEM;

You shouldn't be using soc-audio - use devm_snd_soc_register_card() for
new drivers.

> +	sirf_inner_dai_links[0].cpu_of_node =
> +		of_parse_phandle(pdev->dev.of_node, "sirf,inner-platform", 0);

You need to add binding documents for new bindings.

> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_request(sinner_card->gpio_spk_pa, "SPA_PA_SD");
> +	if (gpio_is_valid(sinner_card->gpio_hp_pa))
> +		gpio_request(sinner_card->gpio_hp_pa, "HP_PA_SD");

devm_gpio_request_one().

> +	sinner_card->extcon_info.pdev.name = "extcon-gpio";
> +	sinner_card->extcon_info.pdev.id = pdev->id;
> +	sinner_card->extcon_info.pdev.dev.platform_data =
> +		&sinner_card->extcon_info.extcon_data;

Use the ASoC jack support so this behaves like other cards.  Hooking the
ALSA core jack support into extcon would be a good idea but it should be
done there.

> +#ifdef CONFIG_PM_SLEEP
> +static int sirf_inner_resume(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +	struct extcon_dev *edev;
> +	int state;
> +
> +	edev = extcon_get_extcon_dev(sinner_card->extcon_info.extcon_data.name);
> +	state = gpio_get_value(sinner_card->extcon_info.extcon_data.gpio);
> +	if (state != sinner_card->extcon_info.last_state) {
> +		sinner_card->extcon_info.state_changed = 1;
> +		sinner_card->extcon_info.last_state = state;
> +		extcon_set_state(edev, state);

Even if you're using extcon this looks like something that extcon-gpio
ought to be handling...

> +static int sirf_inner_suspend(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sirf_inner_card *sinner_card = snd_soc_card_get_drvdata(card);
> +	sinner_card->extcon_info.last_state = gpio_get_value(sinner_card->extcon_info.extcon_data.gpio);
> +	if (gpio_is_valid(sinner_card->gpio_spk_pa))
> +		gpio_direction_output(sinner_card->gpio_spk_pa, 0);

DAPM will do this for you.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScDIbAAoJELSic+t+oim9BScP/08pDudMVxUeHiDFbLGOVnPK
qyBwciFw19amx6edXu3ANP6pxOG/hmpTUhfn28Q9PM6nsGzo8VNtGxri9+c+TSGI
VXe/58J/TaCJuV786q4JCEkDXPDAuAU+qPInClt/T+3UfR1ehwADC6hJr/bIGbP8
vXhm9HAslo9VJN94KHi8R+NqJi0MzNVaNFs0KoNmzjgI4KkwpjrVJODnUxTllYp5
+WzouSaWiT1+lKJ0GGZU7uxfTMyaS73Tt9vdV+ITA6foIyHTlockDsxPKm/2Rq71
HFa4YiU+pPq0SLHCRpt/f6MmYEjzY93GMn4FWfnTIWV2t/ncJJHAGFOiykUaeN4r
FAph8MK1ULnclARFWhJe3wFGZAG7GLdnTDlWQhYBvtT+wMTqAKr4oqcftcTS5DnL
tM1Swo6uL+/HPkxGf/TVqnL4ifdnSeMnmRDvPBLRFw1VvKwCni7xFtxEbHT7ElZt
eIsRO0EmxFubf2ddEWm8wMEUmWTz3dFgM2FQyEPOdBXgT3wtDukaUa7QF+5CmW5u
fYT6dZRf844eaX8HBZppWXY6RqKt+rzmaGlJ1GcMX6Y+RjBLN3o9yiSx7fzKQtIK
dIPeqsC2En3FBcvrKP+MdphCv+MSXliYpZVExAmX+a22JcrBwVKznJrtUGqL8dZM
AsCNd79IYm63JHcWJIz8
=1dB3
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

--===============2320212400503171425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2320212400503171425==--
