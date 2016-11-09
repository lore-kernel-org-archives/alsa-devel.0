From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: axentia: tse850: add ASoC driver for the
 Axentia TSE-850
Date: Wed, 9 Nov 2016 13:38:52 +0000
Message-ID: <20161109133852.nvlyiqow2xpbc6ga@sirena.org.uk>
References: <1478622057-12426-1-git-send-email-peda@axentia.se>
 <1478622057-12426-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vozb652vuwwvcgkj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478622057-12426-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vozb652vuwwvcgkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2016 at 05:20:57PM +0100, Peter Rosin wrote:

> +++ b/sound/soc/axentia/Kconfig
> @@ -0,0 +1,10 @@
> +config SND_SOC_AXENTIA_TSE850_PCM5142
> +	tristate "ASoC driver for the Axentia TSE-850"
> +	depends on ARCH_AT91 && OF
> +	select ATMEL_SSC
> +	select SND_ATMEL_SOC
> +	select SND_ATMEL_SOC_SSC_DMA
> +	select SND_SOC_PCM512x_I2C
> +	help
> +	  Say Y if you want to add support for the ASoC driver for the
> +	  Axentia TSE-850 with a PCM5142 codec.

This just looks like a normal machine driver for an Atmel system which
would usually go in the atemel directory - why is a new directory being
created?

> +static int tse850_get_mux2(struct snd_kcontrol *kctrl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
> +	struct snd_soc_card *card = dapm->card;
> +	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
> +	int ret;
> +
> +	ret = gpiod_get_value(tse850->loop2);
> +	if (ret < 0)
> +		return ret;

We can't reliably read the value of output GPIOs (though in practice the
majority do support it) so it'd be better practice to use a state
variable to remember what we set.  I'd also expect this to use the
_cansleep() GPIO calls as it's not in a context where sleeping would be
a problem.

> +int tse850_get_ana(struct snd_kcontrol *kctrl,
> +		   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
> +	struct snd_soc_card *card = dapm->card;
> +	struct tse850_priv *tse850 = snd_soc_card_get_drvdata(card);
> +	int ret;
> +
> +	ret = regulator_get_voltage(tse850->ana);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret < 11000000)
> +		ret = 11000000;
> +	else if (ret > 20000000)
> +		ret = 20000000;

This needs some comments...

> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct device *dev = rtd->dev;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int dir = substream->stream != SNDRV_PCM_STREAM_PLAYBACK;
> +	int div_id = dir ? ATMEL_SSC_RCMR_PERIOD : ATMEL_SSC_TCMR_PERIOD;
> +	int period = snd_soc_params_to_frame_size(params) / 2 - 1;

Please write the logic out as normal if statements for legibility.  It's
a bit concerning that we even need this function, it looks like pretty
basic stuff that I'd expect the CPU DAI to just be doing - why can't
this be the default behaviour of the CPU DAI?

> +static int tse850_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
> +
> +	return snd_soc_dapm_add_routes(dapm, tse850_intercon,
> +				       ARRAY_SIZE(tse850_intercon));

Set this up in the card data structure rather than open coding the call,
you can register DAPM routes there too.

--vozb652vuwwvcgkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIybrAAoJECTWi3JdVIfQqNsH/0q5tMeDYNsvejkVbXSihzdS
8AK0jOVuXKarfXBmxHp8iYwhmfyoPAmzyXBzJlqh0fbPyCggQljWffdHSnqq324M
aGkG/WzQ8oZEloFYqtV1ILyKaJI0pqnEptZhwVWAvmeS1MaCmp3Ga1srU1biTf0S
9tU+ioe/5vm++kJ0kH0yQ5CvAM6Y/TpCRWk4G3VMs3TIfWTgZSqRZb2aFygDnLrA
QrDxR6iq27y4+YWq3iBPIwtY86i//j+L88qFDU963aGrkcTq7YvJZAQIhjgIY5Qe
TZNbzwasneHwBn42K0d2a/tyN7Om0A8m8hjUqydvDzmn8mLZaWF793cl5fxPV7s=
=5/V0
-----END PGP SIGNATURE-----

--vozb652vuwwvcgkj--
