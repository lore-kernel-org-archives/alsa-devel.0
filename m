From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 6/9] ASoC: msm8x16: add codec dais
Date: Tue, 16 Feb 2016 19:36:35 +0000
Message-ID: <20160216193635.GG7544@sirena.org.uk>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455643990-1870-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455643990-1870-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:33:10PM +0000, Srinivas Kandagatla wrote:

> +static int msm8x16_wcd_set_interpolator_rate(struct snd_soc_dai *dai,
> +	u8 rx_fs_rate_reg_val, u32 sample_rate)
> +{
> +	return 0;
> +}

Don't include empty functions, just remove them.

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw3pCAAoJECTWi3JdVIfQ4GkH/2h1XaVXwATi/Rn9qs9k7XiR
ak9wq6jAvfC6JlTsOeCzvY7och+rRYg/MmEDP5iEbpc1kvoqS4DXsBgiMC0LJ0Ul
IcbMSqDjMORjehABnFxZ0swR1wT2mrLSdBNTfB1k4I4nk/N5Z832beUdB3JWgMc3
Nu316whIccrYRyO93P4yHZq/ysqUYS6zfP2Ojrkc//vYnrXm5G5zKwlpsGFan8L5
eNcoYRE7Ya9cloxZKtokXIAlbD9Wmg1isJ6+nAsRF53NlYGKE9G0vo7EFyItbcvi
s3yvrNcUfRB7KjpB+sMiiAVQjmkVkuRV59dz1KdW2INWTnFGvS71CA7MtGS8wlk=
=hnlM
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
