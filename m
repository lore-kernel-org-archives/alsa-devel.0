From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] ASoC: Intel: add BYTCR machine
	driver with RT5640
Date: Thu, 6 Nov 2014 12:48:54 +0000
Message-ID: <20141106124854.GC8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4095837236083756470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F4BB265114
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:49:14 +0100 (CET)
In-Reply-To: <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4095837236083756470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iluUylAmeNVF81ZM"
Content-Disposition: inline


--iluUylAmeNVF81ZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:19PM +0530, Vinod Koul wrote:

> +static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	if (strncmp(codec_dai->name, "rt5640-aif1", 11))
> +		return 0;

This looks wrong...  fairly sure I queried this on an earlier version of
the patch and was told it wasn't required.

> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
> +				     params_rate(params) * 512,
> +				     SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
> +		return ret;
> +	}
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,

Missing blank line here and in several places throughout the file.  I'd
expect the PLL to be enabled before the sysclk is told to use it, error
checking might kick in otherwise.

> +#ifdef CONFIG_PM_SLEEP
> +static int snd_byt_prepare(struct device *dev)
> +{
> +	return snd_soc_suspend(dev);
> +}
> +
> +static void snd_byt_complete(struct device *dev)
> +{
> +	snd_soc_resume(dev);
> +}
> +
> +static int snd_byt_poweroff(struct device *dev)
> +{
> +	return snd_soc_poweroff(dev);
> +}
> +#else
> +#define snd_byt_prepare NULL
> +#define snd_byt_complete NULL
> +#define snd_byt_poweroff NULL
> +#endif

Don't bother with the wrapper functions, they're not adding anything.
Why are we using prepare() and complete() here - other machine drivers
don't need to do that?  Comments might be helpful...

--iluUylAmeNVF81ZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW241AAoJECTWi3JdVIfQsNsH/0Jm++282kmYVS3EdDZYiCJE
osM9QBCWi1dxvRZB3qxsvDnYdEvEXlfdLjDuFJFGiz5A8C6uCk1nHNyO81yTvZW7
cQDzGRaN1rWzixhFLqkPkrXnlMao6Jkfky0eEBOd/+zI3zE7V7mpRZu7ZpQXEE6P
vzV8YVqBu2rQuRl6MihY+NAgtsKLBsVYfe7pZlbckg2OMvI4GPqgiB5t5nihVIqU
JQn9tIn2JKVEWEpSuH2Hg7w6ZSn/5omtZOZO2KlNP8zona7s97IR6e/Vlt8zJbdS
4PMBi+07cPyzt1hG5PfU8vwjHQ8utE1go2EwosmnBRgx8rRSQcC5nMi+Kbe7T1I=
=+mqc
-----END PGP SIGNATURE-----

--iluUylAmeNVF81ZM--

--===============4095837236083756470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4095837236083756470==--
