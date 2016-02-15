From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max9867 codec driver
Date: Mon, 15 Feb 2016 19:47:18 +0000
Message-ID: <20160215194718.GB18327@sirena.org.uk>
References: <1455215539-3594-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7772186782868461652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1C026085B
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:54:23 +0100 (CET)
In-Reply-To: <1455215539-3594-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============7772186782868461652==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 11, 2016 at 10:32:19AM -0800, anish kumar wrote:

A few small issues but otherwise this looks good:

> +	SOC_SINGLE("DAC Attenuation", MAX9867_DACLEVEL, 0, 15, 1),
> +	SOC_DOUBLE("ADC Left Gain", MAX9867_ADCLEVEL, 4, 0, 15, 1),
> +	SOC_DOUBLE("ADC Right Gain", MAX9867_ADCLEVEL, 0, 0, 15, 1),

All volume controls should be called "... Volume" regardless of physical
implementation as per ControlNames.txt in order to help userspace figure
out how to handle them.  Please also try to provide a mapping to dB via
TLV.

> +	SOC_SINGLE("Volume Smoothing", MAX9867_MODECONFIG, 6, 1, 0),

On/off switches should have names ending "...Switch" again for similar
reasons to the ones behind Volume.

> +static int max9867_resume(struct device *dev)
> +{
> +	struct max9867_priv *max9867 = dev_get_drvdata(dev);
> +
> +	msleep(20);
> +	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
> +		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
> +	return 0;

This is very strange - we have a sleep before we ever interact with the
device.  A sleep in a register write sequence would make sense but this
doesn't seem like it should.

> +static int max9867_probe(struct snd_soc_codec *codec)
> +{
> +	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
> +
> +	max9867->codec = codec;
> +	codec->control_data = max9867->regmap;
> +	return 0;
> +}

The core will figure this out, you don't need to explicitly do it.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwitFAAoJECTWi3JdVIfQhigH/2iM/Ak4AqVQJjAcVHrzIHL6
d+KCB9Hkc2+zLtEQwzX/3Bm5ehHdcejgrlhBdAwVo+6SCJ523QOR/A2j5sqIqB7f
fIYKjIC1nxdFln/J9u+IM2+H1dA3sMpffcVKqs4iwuxC/kSwTXzVh1Ov9JPyrVfg
i7bk75IAi8LhCt6phszLWr+nLfm3JUa2sq8Gua6JsXjtMi3s0RDYa2Ob+rLGQ58I
pKNIK9xLfq3/xfa1CiFLOhQynHcyWbBRTh+qZKb/hJhSmklkRCbK/09pCt4MU5qb
Qz4oUbYOwHpX8JoqnI8woBsv0Z0VEKqYE9PKfLCePIGjgVtbI9Q2+GOlLsuekaY=
=JZlS
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

--===============7772186782868461652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7772186782868461652==--
