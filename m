From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98925: Constify regmap config and other codec
 data
Date: Fri, 20 Mar 2015 11:51:09 +0000
Message-ID: <20150320115109.GH2869@sirena.org.uk>
References: <1426851345-24930-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7GFA+bvAY1vP//DC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426851345-24930-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7GFA+bvAY1vP//DC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 12:35:45PM +0100, Krzysztof Kozlowski wrote:
> Constify local structures (snd_soc_dai_ops, snd_soc_codec_driver,
> regmap_config) and array (reg_defaults) which are not modified by the
> driver and passed to core as pointer to const.

Applied, thanks.

--7GFA+bvAY1vP//DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDAmsAAoJECTWi3JdVIfQmvYH/0qVr9wbP6xbyptgqPlVazpj
oNgoQPLSuSKk/PUj85Q0UMmw2f9iq7w6ioX368loNFlKtG5gnV+e2bnzldxss5vY
4aHo8dpGjFSukmLvd7JfnnwfkT1pK/pa0O7cUi4R+NN6OgayGWYKlKAzHQ6qulf9
s6lQuG7XjZSO18Q+YYylRrj3fG0jSPUzrrirKOOYu9gKxUsNq6PKE5e2XmV+AmLA
nBY4IazHIjeX5Z9ehuQK4Uk9U6tmU+J0fkhPUiLfFAEzzwCdm5YPFxjxgFcpjG/A
sYqEaO7+6QS78LwJ9pdyPTOnDFpVwR3+OramBqHIRyyt5EcpsXRKKdkG6sMucL4=
=6xf0
-----END PGP SIGNATURE-----

--7GFA+bvAY1vP//DC--
