From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v6 2/3] ASoC: sun4i-i2s: Add regmap field to sign extend
 sample
Date: Tue, 27 Aug 2019 11:34:29 +0200
Message-ID: <20190827093429.fkh4cqbygxxyvkk3@flea>
References: <20190826180734.15801-1-codekipper@gmail.com>
 <20190826180734.15801-3-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akegy5smhxynsxc7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190826180734.15801-3-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: codekipper@gmail.com
Cc: wens@csie.org, linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org


--akegy5smhxynsxc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 08:07:33PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>
> This isn't a problem whilst we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

If anything, I'd like to have less regmap_fields rather than more of
them. This is pretty easy to add to one of the callbacks, especially
since the field itself has been completely reworked from one
generation to the other.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--akegy5smhxynsxc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWT5JQAKCRDj7w1vZxhR
xe50AQC8TXvNs/xG05yTE5nduFlJSviusolNw2OzT+nU7+RGNQEAnLeDCfdAFcFV
+5qESFVCyahAR0NhHqHtWgxldOTPwgw=
=hUzD
-----END PGP SIGNATURE-----

--akegy5smhxynsxc7--
