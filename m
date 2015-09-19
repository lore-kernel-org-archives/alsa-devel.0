From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: da7219: Add bindings documentation for DA7219
 audio codec
Date: Sat, 19 Sep 2015 10:10:17 -0700
Message-ID: <20150919171017.GI30445@sirena.org.uk>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <381b367e0a4c6c9e00db74f1b0e91d383156ba86.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tSiBuZsJmMXpnp7T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <381b367e0a4c6c9e00db74f1b0e91d383156ba86.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--tSiBuZsJmMXpnp7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 05:01:16PM +0100, Adam Thomson wrote:

> +- dlg,io-lvl : Expected voltage level range for digital IO
> +	["2.5V_3.6V", "1.2V_2.8V"]

If the driver needs to read or set the voltage a supply is at it should
do that via the regulator API.

> +- dlg,cp-mchange : Charge pump voltage tracking mode
> +	["largest_vol", "dac_vol", "sig_mag"]
> +- dlg,cp-vol-thresh : Charge pump volume threshold value (6-bit value)
> +	[ 0 - 0x3F ]

Why are these in the device tree rather than runtime parameters?

> +Child node - 'da7219_aad':
> +
> +Required properties:
> +- interrupt-parent : Specifies the phandle of the interrupt controller to which
> +  the IRQs from DA7219 AAD block are delivered to.
> +- interrupts : IRQ line info for DA7219 AAD block.
> +  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
> +   further information relating to interrupt properties)

Why is this not specified at the device level (the device does not
appear to support other interrupts)?

--tSiBuZsJmMXpnp7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/Zb4AAoJECTWi3JdVIfQXZ0H/2QzF9LIhsz+ebp6Baydlyzh
wI69zeLswaHvVhtN0RX2SPWfFdFgNdTq00TyDX5b9L1q9eQn9SEXkgSUjiG74BpV
hl09/DWynmkpGs91vxVPHNav2AR+G14KKUJRqH+/G/5P4ZynwtATs9EosGcQw3Wq
8Yo6GORDNHt9rR0OAdwNnRTpXw9EDXgo0LwRHzQKFjxnoOwAXk5r98jPa/l+mTIy
Rtf6wPAtWAmzKMYrYHveH+TLYVhWKq4N0c5ZPQCKjqIUU6viE8Y79Y/zf1XjSYw+
1YpqWDSDGwphn6GgwliM0mtQxyKGnuDGu+lHCGP4FPx3EVENSLjB71S9qLoJm9o=
=X2Rk
-----END PGP SIGNATURE-----

--tSiBuZsJmMXpnp7T--
