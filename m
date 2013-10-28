From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
Date: Mon, 28 Oct 2013 09:21:08 -0700
Message-ID: <20131028162108.GD13643@sirena.org.uk>
References: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8638464920494368250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 966832616A6
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:21:21 +0100 (CET)
In-Reply-To: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
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


--===============8638464920494368250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 06:37:04AM +0800, Barry Song wrote:

> +static int sirf_i2s_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	pm_runtime_get_sync(dai->dev);
> +	return 0;
> +}

This appears to be duplicating functionality in the core?  It already
holds a runtime PM reference on the device while it's active.

> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		i2s_ctrl |= I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl &= ~I2S_MCLK_EN;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		i2s_ctrl &= ~I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl |= I2S_MCLK_EN;
> +		break;

Why is I2S_MCLK_EN being controlled here?  This looks like a clock
outside the actual DAI and it's possible someone might wnat to use the
AP to generate MCLK but still have the CODEC drive the frame and bit
clocks on the bus.

> +	default:
> +		dev_err(dai->dev, " Only normal bit clock, normal frame clock supported\n");
> +		return -EINVAL;

Extra space at the start of the log message.

> +static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	u32 val;
> +	u32 bclk_div_coefficient;
> +
> +	if (div < 2 || div % 2) {
> +		dev_err(dai->dev, "BITCLK divider must greater than 1,"
> +			"And must is a multiple of 2\n");
> +		return -EINVAL;
> +	}

Why must the user manually configure the bitclock divider?  I would
expect the driver to be able to configure this automatically.

> +static struct snd_soc_dai_driver sirf_i2s_dai = {
> +	.probe = sirf_i2s_dai_probe,
> +	.name		= "sirf-i2s",
> +	.id			= 0,

The indentation here is pretty inconsistent.

> +static int sirf_i2s_runtime_resume(struct device *dev)
> +{
> +	struct sirf_i2s *si2s = dev_get_drvdata(dev);
> +	clk_prepare_enable(si2s->clk);
> +	device_reset(dev);
> +	return 0;

You should be checking the return value here.

> +	ret = snd_soc_register_component(&pdev->dev, &sirf_i2s_component,
> +			&sirf_i2s_dai, 1);

devm_snd_soc_register_component().

> +	if (ret) {
> +		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
> +		goto err;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);

You need to enable runtime PM prior to registering otherwise something
may try to use the driver prior to it being enabled.

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbo7xAAoJELSic+t+oim9oP0P/2ERljm+ZzgxQ5Gd9oiZU8r/
vz7pc55CxovXJG1QKon3qtkXY9OHPQGUQsf5jE3hx+Mkf8K20ciCs4rqsERa0uWu
88hVpug4Z3rvFSFDtinUlMm7S0hWQZ8EIeRpdODsnXwtpyG0wqQ0T522fr173Ypq
6NBdb0Wr7mfse87NH1KUrTOYfc0t994euy4JdMkc4xN4tH8W0J30FNY5DKqLC6Xt
CptEb/x6+lrNwvk+xTuUXVeSfHQlOnJXDDr9mAERepB6bgfOwohKfxFOjei3dgVu
m/b3BYUPEnZU6aUZXR1EYTf0iIhTSCmTh2OC3Z98m/K1n1o4K/h/O2zd/B9fGiVH
aQtV0sBkd2VMdfnlmkyc8vkDLlOlN/BVDNsdaj4iO7dEKMYFKojf4IIeIZIFPqud
yLI/tGGw5UK4xamreoguEtzPy8GZS82OJe9XmD65zX9yA0EcAAn3ec6I/LdRkrcc
hEEZJuglWVLJ03mJEabBOjg6aYjyt1WK/+BIr3BiuasSBHOsbxZ7pzTk6TLfWZuD
dUrFoAIf7rmSTuhVuBoYTN+ogC1Jyg2toaI9HqEvinIkrWeWNuZdY6I6BqBcGsZ/
11K5b22qYdErW7ZLvC1XuIXLZ3Db51G/NNcB7xjF9uv+AAz7iirmHXboI8GK0rup
l/pWIVELavukUHbIsaFw
=Yj+y
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--

--===============8638464920494368250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8638464920494368250==--
