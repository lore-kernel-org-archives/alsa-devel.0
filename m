From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: sirf-soc-inner: add drivers for
 both CPU and Codec DAIs
Date: Fri, 19 Jul 2013 19:35:03 +0100
Message-ID: <20130719183503.GU9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-5-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4734529844725649555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 81EA2265759
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:35:05 +0200 (CEST)
In-Reply-To: <1374232042-26088-5-git-send-email-Baohua.Song@csr.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4734529844725649555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:07:20PM +0800, Barry Song wrote:

> there is an internal codec embedded in the SiRF SoC. this is not
> a typical user scenerios of ASoC. but we can still get benefit by
> sharing platform DMA codes instead of implementing a pure ALSA
> driver.
> This driver adds DAI drivers for this internal codec.

To be honest this shouldn't be too exciting from an ASoC point of view -
just a normal CODEC driver with some stub DAIs.  It looks like it might
benefit from regmap-mmio and DAPM.

> +static int sirf_inner_control(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol,
> +		int get, char *name)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_card *card = codec->card;
> +	int i;
> +	for (i = 0; i < card->num_controls; i++) {
> +		if (!strcmp(card->controls[i].name, name)) {
> +			if (card->controls[i].get && get)
> +				return card->controls[i].get(kcontrol, ucontrol);
> +			else if (card->controls[i].put && !get)
> +				return card->controls[i].put(kcontrol, ucontrol);
> +		}
> +	}
> +	return 0;
> +}

What is all this about?  I don't quite understand what the goal is and
there's no comments.

> +static int sirf_inner_snd_speaker_set(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct sirf_soc_inner_audio *sinner_audio = dev_get_drvdata(codec->dev);
> +
> +	spin_lock(&sinner_audio->lock);
> +	sirf_inner_control(kcontrol, ucontrol, 0, "Speaker Out");
> +
> +	if (ucontrol->value.integer.value[0]) {
> +		writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0)
> +				| IC_RDACEN | IC_SPSELR,
> +				sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
> +
> +		writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1) |
> +				(1 << sinner_audio->reg_bits->firdac_lout_en_bits),
> +				sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
> +
> +		writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) |
> +					IC_SPEN), sinner_audio->base + AUDIO_IC_CODEC_CTRL0);

Is this possibly some supplies plus a power bit?

> +static int sirf_inner_codec_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct sirf_soc_inner_audio *sinner_audio = snd_soc_dai_get_drvdata(dai);
> +	u32 adc_gain_mask = sinner_audio->reg_bits->adc_gain_mask;
> +	u32 adc_left_gain_shift = sinner_audio->reg_bits->adc_left_gain_shift;
> +	u32 adc_right_gain_shift = sinner_audio->reg_bits->adc_right_gain_shift;
> +	u32 mic_max_gain = sinner_audio->reg_bits->mic_max_gain;

Would regmap_field help here?

> +		writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1) |
> +			(1 << sinner_audio->reg_bits->codec_clk_en_bits) |
> +			(1 << sinner_audio->reg_bits->por_bits),
> +			sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
> +		msleep(50);
> +
> +		writel(readl(sinner_audio->base + AUDIO_IC_CODEC_PWR) |
> +			MICBIASEN, sinner_audio->base + AUDIO_IC_CODEC_PWR);
> +		usleep_range(300, 1000);

This all looks a lot like a normal CODEC power up sequence that's been
open coded but could use DAPM?

> +static void sirf_inner_codec_shutdown(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +}
> +
> +static int sirf_inner_codec_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Remove empty functions.

> +static int sirf_soc_inner_resume(struct platform_device *pdev)
> +{
> +	struct sirf_soc_inner_audio *sinner_audio = platform_get_drvdata(pdev);
> +
> +	clk_prepare_enable(sinner_audio->clk);
> +
> +	writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1)
> +		| (1 << sinner_audio->reg_bits->codec_clk_en_bits)),
> +		sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
> +	writel((readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL1)
> +		| (1 << sinner_audio->reg_bits->adc14b_12_bits)),
> +		sinner_audio->base + AUDIO_IC_CODEC_CTRL1);
> +	writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) | IC_CPFREQ,
> +		sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
> +	writel(readl(sinner_audio->base + AUDIO_IC_CODEC_CTRL0) | IC_CPEN,
> +		sinner_audio->base + AUDIO_IC_CODEC_CTRL0);
> +	return 0;
> +}
> +#else
> +#define sirf_soc_inner_suspend NULL
> +#define sirf_soc_inner_resume NULL
> +#endif

Standard runtime PM question and this definitely does look like
regmap-mmio will help - you've essentially open coded some of it.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6YbTAAoJELSic+t+oim9cmcP+wc8GEkxIkyzo2voPN8Ec0r1
9GKNYyX+waBSLh4DZ0aAaEF0Zzgu5jzfJVKpujwFuJ1EQrZgFkWy/eGYNyJ9MWS0
+w5jia8LS1tx/7G0sVfAgzPQmJ8kbX+tHzV0Tzo3WynQ2ahVNHDFglegD2iRunCE
72PKLkF3BZa+yG34dM8Gq5dKjq71fONGi2T3uqatva3PUdKQyI23B/D4Vmn9eP7E
lzTyucD9jnVA+ici67kSwPI3vPVqspYEnD0Ou/cfvXY8K6F5RBbFtxhwFtSJq7/2
p+4m1jbUJoIUK2e8jHgbneuHZEuj4Bjy0V194B95UWbG7Ttn/X6Md4uDGdQ8hkxd
c8mH8zKPkdappZjq67U8M37nUgvoNg36Rx9qFNhHS7jwRd3RxVOdOVN/tloru3uH
nsonmy45VwUZeI1DEkaNe+sHg/BmvIq2UY5BXrAaxrlaF6qA+bJwMcN40X3i6nHS
1kEcl6zbcBb9FNrGNhh1XgIfWNU0twR1eRMFA2NjIe9/2ChOatv5FtIgM8RKik3C
fcuElTotzPWdS7aLiqpieS0mGfVYiDy3Lyhr66FuC+y0olre8Ak5ywR2WVpmHYLN
SwuXFM9f12cW+ABXv2poxlCklqVVHIeZ1vSjY5G2utzYAh4mgMVs64UN6fxhSRgT
70+cNn6np+7HuhBWFDi3
=E+Jo
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--

--===============4734529844725649555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4734529844725649555==--
