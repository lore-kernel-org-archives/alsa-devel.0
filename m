From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: Intel: Add Haswell Machine
	support
Date: Fri, 21 Feb 2014 14:22:47 +0900
Message-ID: <20140221052247.GF25940@sirena.org.uk>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-6-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0310484014631961083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F72F26172B
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 06:22:58 +0100 (CET)
In-Reply-To: <1392932927-9725-6-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0310484014631961083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:48:47PM +0000, Liam Girdwood wrote:
> Add support for Haswell based machines with SST DSP audio.

Applied, thanks.

> +config SND_SOC_INTEL_HASWELL_MACH
> +        tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
> +        depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
> +	select SND_SOC_INTEL_HASWELL
> +	select SND_SOC_RT5640
> +	help
> +          This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
> +	  Ultrabook platforms.
> +          Say Y if you have such a device
> +          If unsure select "N".

Looks like there's formatting issues here again - tab/space probably.

> +static const struct snd_soc_dapm_route haswell_rt5640_map[] = {
> +
> +	{"Headphones", NULL, "HPOR"},
> +	{"Headphones", NULL, "HPOL"},
> +	{"IN2P", NULL, "Mic"},
> +
> +	/* CODEC BE connections */
> +	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
> +	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
> +};

A DPCM system in mainline!  Yay!

> +static int haswell_rt5640_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	/* Set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec DAI configuration\n");
> +		return ret;
> +	}

Set .dai_fmt in the dai_link?

> +	/* set correct codec filter for DAI format and clock config */
> +	snd_soc_update_bits(rtd->codec, 0x83, 0xffff, 0x8000);

The CODEC driver ought to be figuring out the magic numbers for itself
really.

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBuKkAAoJELSic+t+oim9Vl0P/0sgCoLKwjKBOD1qY3TjNOMk
70frdOuBQC8oPAwRnOnLCfQuFMjwqw0IaXz+l/PM7eLRlPJawoUrziHTK3STEfU+
9fmisU2w/tD4fyk5YyV/nVJFS39ghoGRm0honFTbvVeFWOTOA+1ys4GDo7z5MbWb
u82Xgqs5qAF5HAD/3iiSNbNEKNTzcoPLbFn2jEHsTrRPsJtsOV5BXm1n8IFdFQtH
RGz9D0pIel3iHzhCL9+QVQG35Ua0M/oIUP43HTZPL1hCDHqx9J69Pm9kvVl4VPXM
JZCF/IvC2lcamfnmrZjGKBDsg3ovYDjmw/5Pge7OwHxyG7fMmqTR4F4fmGRnbZ+L
TSKee8WteiIIC9A0MjwEHze8v/Oa+Nja3b9i6/dxhdPZnqakmO4q7gJ0i+OzsdrQ
5Y/aO+DvoKIaFpcOnaVbFw1QTAK82WhNajlNQlW4stDhEmtTcS8LtHQ21sEnQXNV
6Xu1xJCkOvgpMYlsS+apGR93+tpm5dt3r5hRXCoQzxKkiK+M1MqnC2BnvTeymTn0
eSIs/WgZeS9fcRJj4Eql1DSA9o0WqqcooNreM8E6aN8yNquOgX8dF+5ejlMkjRko
9Fv9KKVjF/FOmMI4/cpjtfNqji75NX+Cm2mHcZCMdHOIAi6fqXlGfophsBMoMybP
D62o445Tjk9ptVSbS7Ch
=CXs0
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--

--===============0310484014631961083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0310484014631961083==--
