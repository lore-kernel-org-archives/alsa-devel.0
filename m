From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: sgtl5000: add avc support
Date: Tue, 13 Jun 2017 19:00:01 +0100
Message-ID: <20170613180001.uh6mfhr55vgquvps@sirena.org.uk>
References: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3nzu7tob46rndg5j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, eric@nelint.com, fabio.estevam@nxp.com, kalle.kankare@vincit.fi, dev@g0hl1n.net
List-Id: alsa-devel@alsa-project.org


--3nzu7tob46rndg5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2017 at 08:57:34AM +0200, Richard Leitner wrote:

> +static int avc_put_threshold(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	int db;
> +	u16 reg;
> +
> +	db = clamp((int)ucontrol->value.integer.value[0], 0, 96);
> +	reg = avc_thr_db2reg[db];
> +	snd_soc_write(codec, SGTL5000_DAP_AVC_THRESHOLD, reg);

This should reject rather than silently accept out of bounds values,
otherwise this looks good.

--3nzu7tob46rndg5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAKCAACgkQJNaLcl1U
h9A4BAf/bZp4nyOwr7DfB97gJGcTj6Ac1x8+7Lz90dO2IWFMKov0N0uzjgqT+KU8
Npi2Bl3dUKHOcryg6V3q0ooPuiBRnxf/TXIpZiws1M+us2oa91ex3x8c7u2dD4Aq
NhejssXgOX6fwIB8D0zTi+75mGLgstK9oanANp9FnfDVwMMh9bZlgwdHkgF5cCyg
tQQhnf+RwSPLmwfJBde3wagGqt8QLl/+rTw4VDXBDJNV+OrSOawSz/fJ1pWhGYOo
SdnnidaEDIP4+9eW/GbtxYIANXjw5dI80LE1oXrgqhJpy0DVvZb3ZPa3b1ULLluQ
pWvLVWZvDV++c0zjZ0oJ9kfd+oRpOA==
=vvRO
-----END PGP SIGNATURE-----

--3nzu7tob46rndg5j--
