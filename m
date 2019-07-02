From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: max98090: remove 24-bit format support if RJ is
 0
Date: Tue, 2 Jul 2019 14:55:45 +0100
Message-ID: <20190702135545.GN2793@sirena.org.uk>
References: <20190618022411.208156-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4OpS+d6oOtUQaRm1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190618022411.208156-1-yuhsuan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org


--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 10:24:11AM +0800, Yu-Hsuan Hsu wrote:

> +	/*
> +	 * When TDM = 0, remove 24-bit format support if it is not in right
> +	 * justified mode.
> +	 */
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J &&
> +			!max98090->tdm_slots)
> +		substream->runtime->hw.formats &= ~SNDRV_PCM_FMTBIT_S24_LE;

Why do this and not add a constraint (which doesn't modify any
constant data structures)?

--4OpS+d6oOtUQaRm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bYmAACgkQJNaLcl1U
h9DMTgf+PYAum94WJNy/d7fNa5ky+hsLP7iR/oIMWfHTiiNRsNfXCy/3qjz3HleI
B+VON17KVufcU6Yi6GhITx/05AB2mbtk15C8fgFrOFv+GN/bP0jklpx05wo07q81
REn5TG8B3YDD14t1akxcZxdrc63/gIHMZTuZ56g1GRTNeTEd7F3/Vyz/G2p0Csgi
V4DAb54G1b17MrAre6LG9So1NWcUQT3i/rmSIy60AswQK2Za55P2j2UHNySFpby7
I4jL4ujieJ2L3Mb8AE/U49ioJ2YIGp481ABjMxJPB3cYE/BKVZ96WzKCnCDFa9jW
RxxZhCWx051gBV63t6mJ6/UzZESDgw==
=1nES
-----END PGP SIGNATURE-----

--4OpS+d6oOtUQaRm1--
