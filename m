From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Wed, 5 Jun 2013 12:55:44 +0100
Message-ID: <20130605115544.GX31367@sirena.org.uk>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2539582731339105326=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370420501-8410-1-git-send-email-b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2539582731339105326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CgyvWwj/llZsteoZ"
Content-Disposition: inline


--CgyvWwj/llZsteoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 04:21:41PM +0800, Nicolin Chen wrote:

Looks pretty good, a few comments but they're all fairly minor.

> +  WM8962 pins:
> +  * HPOUTL
> +  * HPOUTR
> +  * SPKOUTL
> +  * SPKOUTR
> +  * MICBIAS
> +  * IN3R
> +  * DMIC
> +  * DMICDAT

No need to list all these, just reference the CODEC (and add them to the
CODEC binding documentation if they're not there which they probably
aren't).  This is generally good practice if there's a family of devices
sharing a driver and means that you don't have to worry about missing
all the other input pins as you've done here.  :)

> +- hp-det-gpios : The gpio port of Headphone detection.
> +- mic-det-gpios: The gpio port of Micphone detection.

I'd say a bit more about these - obviously the CODEC has its own
accessory detection here, and I rather suspect that in fact the HP
detection you have there is really jack detection.

> +static int check_hw_params(struct snd_pcm_substream *substream,
> +		snd_pcm_format_t sample_format, unsigned int sample_rate)
> +{
> +	struct imx_priv *priv = &card_priv;
> +	struct device *dev = substream->pcm->card->dev;
> +
> +	substream->runtime->sample_bits =
> +		snd_pcm_format_physical_width(sample_format);
> +	substream->runtime->rate = sample_rate;
> +	substream->runtime->format = sample_format;
> +
> +	if (!priv->first_stream) {
> +		priv->first_stream = substream;
> +	} else {
> +		priv->second_stream = substream;
> +
> +		if (priv->first_stream->runtime->rate !=
> +				priv->second_stream->runtime->rate) {
> +			dev_err(dev, "KEEP THE SAME SAMPLE RATE: %d!\n",
> +					priv->first_stream->runtime->rate);
> +			return -EINVAL;
> +		}
> +		if (priv->first_stream->runtime->sample_bits !=
> +				priv->second_stream->runtime->sample_bits) {
> +			snd_pcm_format_t first_format =
> +				priv->first_stream->runtime->format;
> +
> +			dev_err(dev, "KEEP THE SAME FORMAT: %s!\n",
> +					snd_pcm_format_name(first_format));
> +			return -EINVAL;
> +		}
> +	}

The sample rate checking can be done with the symmmetric_rates feature
in the core.  The sample_bits check can't be but it's something that a
lot of systems probably ought to have so it ought to be factored out
into the core too rather than open coded in the driver.

> +		/*
> +		 * SYSCLK of wm8962's not disabled yet. If we wanna close FLL,

No '.

> +		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
> +				data->clk_frequency, SND_SOC_CLOCK_IN);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to set SYSCLK: %d\n", ret);
> +			return ret;
> +		}
> +
> +		/* Disable FLL and let codec do pm_runtime_put() */
> +		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL, 0, 0, 0);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to disable FLL: %d\n", ret);
> +			return ret;

You're enabling and disabling the CODEC only while there's an audio
stream active.  This means that it's not possible to support analogue
bypass paths (which the device can do) - you should probably also
support enabling the FLL via set_bias_level() and use set_bias_level()
to turn it off (which works in all cases).

> +	data->codec_clk = clk_get(&codec_dev->dev, NULL);
> +	if (IS_ERR(data->codec_clk)) {

devm_clk_get().

> +		/* assuming clock enabled by default */
> +		data->codec_clk = NULL;
> +		ret = of_property_read_u32(codec_np, "clock-frequency",
> +					&data->clk_frequency);
> +		if (ret) {
> +			dev_err(&codec_dev->dev,
> +				"clock-frequency missing or invalid\n");
> +			goto fail;
> +		}

Since it's easy to define a fixed rate clock (there's a generic driver
for that) I'd just require the user to provide a clock API clock and fix
the rate using that.  This is going to be less error prone and makes the
code simpler.

> +	} else {
> +		data->clk_frequency = clk_get_rate(data->codec_clk);
> +		clk_prepare_enable(data->codec_clk);

Not needed immediately but if there is actually a clock we have control
of we might want to vary the frequency...

--CgyvWwj/llZsteoZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRryc9AAoJELSic+t+oim9uAsP/2S+ZaCjaFQO6wrpb1EZhDCF
3cDAczO582aEPe5L+bzBFzfghV3J9O1DnpugUe9hV3Wx2zpcaNDXe+g4GLQSv0gV
yiNiSGtEJiWIWGPP4QW7Buta/eg6746+VPuqVioX6AwaF8X93sJN0jRLxws2L0yq
dWTt8mTwmd9jSbV1jkxIOkHN3UsM/RvbfjnwNqt8zRVjQM236fGAm7i35qFsIVCD
RXhtheLUPnefyCuTwgSEseSaXK3tsCS/dc/wC52p4Ug1OcEwJCxTheYBeGtjkVfB
4S05s9oZsiWyWEtOlD5lwXALVTcwR+/wGtyBxmdlquIYnQ/Dje8SF2xJUwDh7frl
hJC5b63qNyTNNQ5PKErf/HLTNR7su5q51Ru5puGTah8Ai8lS5VMk3GM7B3KQXOpL
5iRTJJl6fRwTv7QU7Z8gPWD1t2CE/HYZu1b0MNfnrFwMXaRpCuCTSDsS1rV3iTJL
jVn/qUnNiOJLJW+JZakEpBHNfT+BblJy3gsrk6v0bZgWBnPOqfGVnSjsWdAn6Skb
m2DUxaJQkKP8iX1Y5jQ0cMFFtxX+UBEbY2LTZrTj4IFICUwK4zeBxV+Trgd3citq
+XpNmcum6pDcvVDxrlbofZ2wmozZFeiYKL6Yr+W8DtuQusT579xImHHSoUDpLgur
6wAwzek6KJfYohujBXVb
=gS3b
-----END PGP SIGNATURE-----

--CgyvWwj/llZsteoZ--

--===============2539582731339105326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2539582731339105326==--
