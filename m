From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: max98090: remove 24-bit format support if RJ is
 0
Date: Mon, 17 Jun 2019 15:56:50 +0100
Message-ID: <20190617145650.GS5316@sirena.org.uk>
References: <20190617035526.85310-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EDQ/wMYGX5nr2pOQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617035526.85310-1-yuhsuan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org


--EDQ/wMYGX5nr2pOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 11:55:26AM +0800, Yu-Hsuan Hsu wrote:

> +	/*
> +	 * When TDM = 0, remove 24-bit format support if it is not in right
> +	 * justified mode.
> +	 */
> +	if (!max98090->tdm_slots &&
> +		(fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
> +		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
> +	}

Do you need both the addition of constraints and the one way
modification of the formats here?  Also the indentation is messed up
which makes things hard to read, the second line of the conditional is
aligned with the contents of the if block.

--EDQ/wMYGX5nr2pOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HqjEACgkQJNaLcl1U
h9DdJgf/bo+F60U/71HCEMfPhkQogg7oTTvWn/LCTQqrC6hilrPo9g/nkRR62SXa
weDewr+wLKzBnuF89pNEzWkLXzSjVfaNZTb33kHwufVmHasqM+6czV2N92xaPdyM
0rI39R0ruvqol6My31Xtwb/KwUfcKDD4RS7dyYnEfLsy1btrFiNXNJPYui3KjTvp
rEUskwmv8gJSyZc/BPWwkSUZJ11bm2Bge8y/0887UddrwvQDC3jNIVCIygnph8hz
INIaDDlVTiMPBJtkL8gustEiXstjZXANwnR36bTe1zWYH94tBuI76FsoXwR+n/F0
kOn+Gs+TTzzzT8YM42fIkGS4a4hQsw==
=yS7N
-----END PGP SIGNATURE-----

--EDQ/wMYGX5nr2pOQ--
