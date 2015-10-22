From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: DT bindings: rockchip-i2s: add
 capture property
Date: Fri, 23 Oct 2015 01:50:17 +0900
Message-ID: <20151022165017.GA8232@sirena.org.uk>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
 <1444308009-29088-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azskX66S5GHWoEK7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444308009-29088-3-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--azskX66S5GHWoEK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 08:40:08PM +0800, Sugar Zhang wrote:

> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> @@ -21,6 +21,7 @@ Required properties:
>  - clock-names: should contain followings:
>     - "i2s_hclk": clock for I2S BUS
>     - "i2s_clk" : clock for I2S controller
> +- rockchip,capture-channels: max capture channels, if not set, 2 channels default.

If this can not be set then it's an optional property, not a required
property, and should be in the optional properties section.  Please send
a followup patch fixing that.

--azskX66S5GHWoEK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKRPIAAoJECTWi3JdVIfQFawH/2WohZEj2f9LB1ZNFWeGJcv3
Q3NsU6A88hcDC69WDlKFDl3fsbPKaeos5/J7u24iefFNvuubK1D/l42QDkJLQ00U
WgWqLHnqKOfZAb5OdVP8oq115RRYr+n+V+7FrkJgCWlH/mguYQWNyRO1D/iqF16s
I+a/7d+2RC/AEM94rIpU20qpT7PFR3R2mfWnF5wHqMKwF+qscs120ljaVlmuthg+
OtzFkurCC2hLJQunU67bIyvFP7iJfvQbUugrsKdBPTCSsh6EtPrkcAaNE4k/Fz29
lytAIo0SOpg0r8K3rdQ+o9GyEiw+0IZQaaUP5WE8XlDQTlELKXML8IwnW34OOjw=
=R90i
-----END PGP SIGNATURE-----

--azskX66S5GHWoEK7--
