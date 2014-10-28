From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Tue, 28 Oct 2014 16:48:22 +0000
Message-ID: <20141028164822.GB18557@sirena.org.uk>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0825142393537033025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B35F2260603
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:48:44 +0100 (CET)
In-Reply-To: <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0825142393537033025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bDKzcj6YHRdh76QF"
Content-Disposition: inline


--bDKzcj6YHRdh76QF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 07:30:32PM +0800, mengdong.lin@intel.com wrote:

> +config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
> +        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
> +        depends on X86_INTEL_LPSS
> +        select SND_SOC_RT5670
> +        select SND_SST_MFLD_PLATFORM
> +        select SND_SOC_INTEL_SST
> +        select SND_SST_IPC
> +        select SND_SST_MACHINE
> +        default n

n is the default anyway.

> +obj-$(CONFIG_SND_SST_MACHINE) += board/

It's a bit weird to have the Kconfig in the root Intel directory if the
boards are getting moved into a subdirectory - why not just source a
Kconfig in the board directory?

> +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	if (strncmp(codec_dai->name, "rt5670-aif1", 11))
> +		return 0;

11 is a magic number!  Why not use strlen() here (and why do we do
nothing in the AIF1 hw_params() if we're working with AIF1)?

> +	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5670_PLL1_S_MCLK,
> +				  CHT_PLAT_CLK_3_HZ, params_rate(params) * 512);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_PLL1,
> +				     params_rate(params) * 512,
> +				     SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
> +		return ret;
> +	}

Nothing ever stops the PLL - a set_bias_level() callback with a handler
for _OFF.  Otherwise we're wasting power.

> +	snd_soc_card_cht.dev = &pdev->dev;
> +	ret_val = snd_soc_register_card(&snd_soc_card_cht);
> +	if (ret_val) {

devm_snd_soc_register_card() and the removal function can go entirely.

--bDKzcj6YHRdh76QF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT8jVAAoJECTWi3JdVIfQ6xEH/2YxpcZmFki60+3b/h3Z14cp
P+aXY9jDi1gyMY7po3fWvQv/AGLGEFPL75q+6NaoznL5vndo44qMyXCngqnvZ+mL
uiT7KMNVOOPgdmXIcwHgCAjnZuzdE/H5ShZ+pqeXKI9n4QBWeym6fnUL14ryDMFF
me83DrW71/A3iQPrD7IOIDa2M/GZxcRztBOG3IVJewDonLmEgqAiP6qxLZFLtvY3
MyuqojtXiSlOGqyVUbzBABCjwNoE44dnyklpBLKl6RP/XuZK5BFuMoDglbLLtTWF
zj2QJ6PiKXTeZF5HpjQa8b+issLzCF4pMfJzxdM2psk+PxXrex3HBjmfI5DJQEI=
=yDHk
-----END PGP SIGNATURE-----

--bDKzcj6YHRdh76QF--

--===============0825142393537033025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0825142393537033025==--
