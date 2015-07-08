From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/4] ASoC: Intel: add Skylake HDA
	platform driver
Date: Wed, 8 Jul 2015 19:56:55 +0100
Message-ID: <20150708185655.GD11162@sirena.org.uk>
References: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
 <1436153066-23962-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0590056819264393355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B8C72650B0
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:57:02 +0200 (CEST)
In-Reply-To: <1436153066-23962-2-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0590056819264393355==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f3uHgXesLFB1/u0Z"
Content-Disposition: inline


--f3uHgXesLFB1/u0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2015 at 08:54:23AM +0530, Vinod Koul wrote:

> +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> +	pm_runtime_get_sync(dai->dev);

Check the return value please, this can fail.

> +static int skl_get_format(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> +	struct skl_dma_params *dma_params;
> +	int format_val = 0;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
> +	dma_params  = (struct skl_dma_params *)
> +			snd_soc_dai_get_dma_data(codec_dai, substream);

Should be no need to cast away from void.

> +	if (substream->runtime->dma_area)
> +		memset(substream->runtime->dma_area, 0,
> +				params_buffer_bytes(params));

Why do we need to memset here?

> +	dma_params  = (struct skl_dma_params *)
> +			snd_soc_dai_get_dma_data(dai, substream);
> +
> +	pm_runtime_mark_last_busy(dai->dev);
> +	pm_runtime_put_autosuspend(dai->dev);
> +	kfree(dma_params);

We check elsewhere for dma_params being NULL, shouldn't we set it to be
NULL when we free?

--f3uHgXesLFB1/u0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnXJ3AAoJECTWi3JdVIfQhAUH/jFTKNf37am4zfK8Ob0z6FwJ
3UESj1CbcstU5jCvHEAPgBMM0mtNYKwmlHFgXPohFLX0BMKedR3UxD8edFdMPV1x
qdG70oXkMZOr9HgicLYDMtTlb8m7h1IP6lk5s/wqjNBa97JF6U3hfKND5AafNL4f
xy3qy2o1mH9DXRK66ij3RvOgGv0WHt/BXtOABpUGOrknVVA8zeIYEP4WRYvCAh3N
LaNElSiO6zxzF9Xi2+kOz6xHo+YC2wyBRe1nRG3EabQnYQcjgyS0adXIJIE8/sg7
RXBn3Z2q2wQVEhoV21EAWYkFLNVCKY+m5nfRXFoEySZeVqh/6X9WxsCmwonYgwU=
=8fzY
-----END PGP SIGNATURE-----

--f3uHgXesLFB1/u0Z--

--===============0590056819264393355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0590056819264393355==--
