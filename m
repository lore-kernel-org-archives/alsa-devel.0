From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22
	codec driver
Date: Mon, 19 Jun 2017 17:19:10 +0100
Message-ID: <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405972113116762246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20717267104
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 18:19:17 +0200 (CEST)
In-Reply-To: <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1405972113116762246==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n3da3maqi5td4n2b"
Content-Disposition: inline


--n3da3maqi5td4n2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 17, 2017 at 10:09:34PM +0800, Shawn Guo wrote:

> +	/* Mute control */
> +	SOC_DOUBLE("Playback Master Mute", AUD96P22_MUTE_2, 0, 1, 1, 0),
> +	SOC_DOUBLE("Headset Mute", AUD96P22_MUTE_2, 4, 5, 1, 0),

As covered in ControlNames.txt mute and other on/off controls should be
named ending in Switch so UIs know what to do with them.

> +static int aud96p22_startup(struct snd_pcm_substream *substream,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
> +	struct regmap *regmap = priv->regmap;
> +
> +	/* Overall power-up */
> +	regmap_update_bits(regmap, AUD96P22_PD_0, PD_0_PDZ, PD_0_PDZ);

Why is this not done with DAPM?

> +	/* Reset ADC and DAC path */
> +	regmap_write(regmap, AUD96P22_RESET, 0x0);
> +	regmap_write(regmap, AUD96P22_RESET, 0x3);

What does this mean?

--n3da3maqi5td4n2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllH+X0ACgkQJNaLcl1U
h9BgYQf+LFHePUCOQ/C3y8JD9TcFi+8mYRx3M1WVJJFOwddzrO3B/X7kNNIA8M59
bEiuwo4JtreHEh6r4QgDE1L/PYatbLcjWnppvn4ZzNuDSYCoSmC15rjwuVhOlnd0
f6fNyQfukmAsEF5JuNDiMfMbgSItn63Iwx7D2rUJk1aZsKxmQCh4m8SmcXXbEagn
b5ztTpVflCQpYg60atp3CcuBoWut5dBI7z22IysQpN0mHXUFKrCxhFzwXMk7DJWB
fnV+K3siZz4sePvN+TlitwZ6uYFAVhNnH5+0OT6HwwF7I89PAEvND4XgLFY0Ogd7
vdsLV3ty8nERpp3+YJJwaBeXlg6ncQ==
=TGdl
-----END PGP SIGNATURE-----

--n3da3maqi5td4n2b--

--===============1405972113116762246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1405972113116762246==--
