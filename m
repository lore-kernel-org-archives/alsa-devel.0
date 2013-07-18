From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: add wm8904 based audio machine driver
Date: Thu, 18 Jul 2013 12:17:09 +0100
Message-ID: <20130718111709.GL22506@sirena.org.uk>
References: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MtLaQwm2ZGHj8IC"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--3MtLaQwm2ZGHj8IC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 03:28:03PM +0800, Bo Shen wrote:
> add wm8904 based audio machine driver
>=20
> the following ek board based on it
>   - at91sam9n12ek
>   - sama5d3xek (d31, d33, d34, d35)
>=20
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Looks pretty good, a few fairly small issues below.

The binding document should be CCed to devicetree-discuss for review.

> +	atmel,audio-routing =3D
> +		"Headphone Jack", "HPOUTL",
> +		"Headphone Jack", "HPOUTR",
> +		"IN2L", "Line In Jack",
> +		"IN2R", "Line In Jack",
> +		"Mic", "MICBIAS",
> +		"IN1L", "Mic";

The widgets defined by the board should be documented in this binding.
Those from the CODEC should be documented in the CODEC binding.

> +#define MCLK_RATE 32768
> +
> +static struct clk *mclk;

This should be in driver data for the board.  Shouldn't the clock be
referenced using the clock bindings?

> +static int atmel_asoc_wm8904_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> +	int ret;
> +
> +	ret =3D snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
> +			12000000, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		pr_err("%s -failed to set wm8904 SYSCLK\n", __func__);
> +		return ret;
> +	}

This is an odd thing to set the clock rate to and limits the sample
rates the board can play back.  It would be better to set the clock rate
based on the requested sample rate in hw_params - you're using the FLL
so may as well take advantage of the ability it offers to support all
sample rates.

> +static int atmel_asoc_wm8904_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> +	int ret;
> +
> +	ret =3D snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
> +		32768, params_rate(params) * 256);

Ah, in fact you do actually do that - it'd be clearer to put the
set_sysclk() after this.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		if (!mclk_on) {
> +			ret =3D clk_prepare_enable(mclk);
> +			if (ret =3D=3D 0)
> +				mclk_on =3D 1;
> +		}
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		if (mclk_on)
> +			clk_disable_unprepare(mclk);
> +		mclk_on =3D 0;
> +		break;
> +	}

It's better to write this using the previous state than to have the
mclk_on flag - you want to enable on the standby->prepare transition and
disable on the standby->off transition.

> +static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *codec_np, *cpu_np;
> +	struct snd_soc_card *card =3D &atmel_asoc_wm8904_card;
> +	struct snd_soc_dai_link *dailink =3D &atmel_asoc_wm8904_dailink;
> +	int ret;
> +
> +	if (!np)
> +		return -1;

Return a real error code here.

--3MtLaQwm2ZGHj8IC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR586yAAoJELSic+t+oim9CS4P/0tID9psxnIGFlj9G+4uJKED
s8t5MtrPS5bFUPaYu+4eOD+b4eao/1c8Bq9s7xt7idnjAhRfPFqydP/+z9/bM6xe
O5LWymyLNFVJzLDHCQCgKoo0P1+1XNFmhN0aviMFb/ZCcahcdFVCom2wOVMQtDSM
zkbOCNiKwXP+r6TvuwV337XdpRcUvy/J2c5PThsIzMkCZ/PDCuPI7gIMjtQ27L8R
PgvMi29yr7MlpZPETLqXRUCsDvUgiRMHyGx0YNCnnfJcFuAol0HXYjeEkWcof6dp
WXOs13+laNiLrmzgBfd9MqDg1zzlz0eQGHoxvF9tn+S8Drihh/Txm7A2E6wiEe/K
aBZPjZEbHmXQsMCNd9UjX5HUdX4PoWl0W2oFqWprzrnUWz7primO9q8y0njstbok
kCnAMJv3Dm5/q6ccU2h9COpvylbETVTXsZlt8dgQXciW67IqS6cEivd8kcIwu58M
KRMtuJAoJPIxsSQJuFhwwtfEx6Oan4TNUfUCkOExy9viqgQlOxs8DVFT0J9xCLrN
/CyWZqZnnZq04reS9Jy3ZoN6+or6fKpXw5jXVBBV/TunZvrjaMr/dvBj3kxS/pe8
kkBUaGGH3HhJVXzIS8Rf4Wa0dcMV0StciOEzk4zBRTP0G5yYAGY5AtEAc50V9BgZ
BGOpSKgzNn46ddmbyBGf
=AfJ0
-----END PGP SIGNATURE-----

--3MtLaQwm2ZGHj8IC--
