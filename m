From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add PCM1681 codec driver.
Date: Wed, 26 Jun 2013 15:30:01 +0100
Message-ID: <20130626143001.GP27646@sirena.org.uk>
References: <1372251928-15706-1-git-send-email-marek.belisko@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5327948658102913132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF912654F7
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 16:30:08 +0200 (CEST)
In-Reply-To: <1372251928-15706-1-git-send-email-marek.belisko@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, lgirdwood@gmail.com, rob.herring@calxeda.com, Marek Belisko <marek.belisko@streamunlimited.com>, rob@landley.net, grant.likely@linaro.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5327948658102913132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YRPL3RJyuON7wuhd"
Content-Disposition: inline


--YRPL3RJyuON7wuhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 03:05:28PM +0200, Marek Belisko wrote:

> +#define PCM1681_ATT_CONTROL(X)	(X <= 6 ? X : X + 9) /* Attenuation level */

Write a function for this.

> +static bool pcm1681_writeable_reg(struct device *dev, unsigned register reg)
> +{
> +	return pcm1681_accessible_reg(dev, reg) &&
> +		(reg != PCM1681_ZERO_DETECT_STATUS);
> +}

> +static int pcm1681_digital_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int ret, val = 0;
> +
> +	if (mute)
> +		val = PCM1681_SOFT_MUTE_ALL;
> +

This would be clearer if written as an if .. else - otherwise it looks
like an uninitalised value might be used.

> +static int pcm1681_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int val = 0;
> +	int pcm_format = params_format(params);
> +
> +	priv->rate = params_rate(params);
> +

Shouldn't there be a call to set the deemphasis here?

> +static int pcm1681_probe(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +
> +static int pcm1681_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Remove empty functions.

--YRPL3RJyuON7wuhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyvrmAAoJELSic+t+oim96YwP/jVY6XawZvyFk61A32r6zG+L
9oyWAQ9xDCPgWUXU7p406PUDQRypT0jxhT3rOBfX/ht+6w2bgtuDiR2Pch0OZp3J
iZq+AmVwPkf8D3rwwViV371dcFG/2dL2YAgVHRLy9pkWjnImsuP7cjh7TgyqJn3A
4jVeYFeECqe2mLAnW0155de7R3oj/sMUnRwXOIAMYLFGFGiqR+ROSXAwhbGIY8Vf
n/XJn/JTxDin5V/CrUbX2m8rPJKyFrZv23R8dTGU/POjK/ATWN+Nx50nNP1WG0p9
uZpm84PXTEYzp9HdhLIy380buek0+vrB9JgjaHVCNVndEYeELqm5pEZJ/II2P1on
SFSmxX5bOkuZ6fgK+EN4Z8s9sLmnNEzeJULNitK7IOAR44Lfy52ZE6QZzJ0FeXuu
k/N4xuObGwr2oL1Uv6efHWlRmbXQh+LoOqIccFyIy3LHPZG1RaUQ6CXS4FyI12P7
ZCM4kzywC8iOIxh5ETov7bH2WONl8BKIGlgrrJISESxisULfGpEZ2JEKBsyjxNDP
IrGxrKEc1BKJdSSLNIjk6UC9fcmWjAVprNu8EvL+62cW02vbANlVkiRWUfj6d9nr
cb5TzVjlyNusxv1vfqxwn4m155XkgXp12hQlZVuF5IPpidyV4T8UE7G6o9+ehNLw
x1uxG4EUSvMnALwNxr1m
=bDv1
-----END PGP SIGNATURE-----

--YRPL3RJyuON7wuhd--

--===============5327948658102913132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5327948658102913132==--
