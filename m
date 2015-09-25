From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix bad register MIC_BIAS_VOLTAGE setup
 on probe
Date: Fri, 25 Sep 2015 09:50:28 -0700
Message-ID: <20150925165028.GJ30445@sirena.org.uk>
References: <1443190887-18080-1-git-send-email-gianlucarenzi@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rbKG8BlqS9xyY7Uh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443190887-18080-1-git-send-email-gianlucarenzi@eurekelettronica.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--rbKG8BlqS9xyY7Uh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2015 at 04:21:27PM +0200, Gianluca Renzi wrote:

>  	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
>  			SGTL5000_BIAS_R_MASK,
> -			sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
> +			sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);

That doesn't look right...  I would expect _BIAS_R_SHIFT to shift a
value into the register masked off by _BIAS_R_MASK and therefore that
the above is saying that the definition of one of those two macros is
wrong.  I would not expect something called _BIAS_VOLT_SHIFT here.

What's going on here?

> @@ -1549,7 +1549,7 @@ static int sgtl5000_i2c_probe(struct i2c
>  			else {
>  				sgtl5000->micbias_voltage = 0;
>  				dev_err(&client->dev,
> -					"Unsuitable MicBias resistor\n");
> +					"Unsuitable MicBias voltage\n");
>  			}

This looks like a reasonable but unrelated fix and should be in a
separate patch.

--rbKG8BlqS9xyY7Uh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBXtTAAoJECTWi3JdVIfQ5CEH/3EvIqO6H7noDDN5uZePTvWm
JaLPsxzZb0mn055l31qMzPrQE+BSbfdIeTXWa9bzSWksye4kIycLPSl8U7mXL9ht
k3XI7i38oKEP/vE1v0VXFHuC60Kgi3rqvjXnGgUsc6DZFHq9h+AmenkjsNneyRKX
GwGQFcN6SdgchCeIbh51gXZ1w09sWlJMmYP5vPbBfqGlrnNJbikbRqkms3r8iyRQ
ggmADQjYXBEv3b05nL7aV3315MKQoOVETBrjI5wAnEy9lSdHfSOBeC20j69A6AwW
1/ZSxN6mQsdRyhVK6n6nbgPHYCLcUAoKuZcbAxW8JejfTA80ZJwWwrYNYrCgh60=
=7HFM
-----END PGP SIGNATURE-----

--rbKG8BlqS9xyY7Uh--
