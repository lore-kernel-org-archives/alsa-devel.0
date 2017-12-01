From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 15/19] ASoC: tlv320aic31xx: Reset registers during
 power up
Date: Fri, 1 Dec 2017 15:55:52 +0000
Message-ID: <20171201155552.jj3mwb7sp645u2ud@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-16-afd@ti.com>
 <20171201133723.vlxqci4paw7szjce@sirena.org.uk>
 <f8b03c59-c7c5-da32-c0fb-de366e931bc9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5iu6nc6tottybtb6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f8b03c59-c7c5-da32-c0fb-de366e931bc9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5iu6nc6tottybtb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 09:04:41AM -0600, Andrew F. Davis wrote:
> On 12/01/2017 07:37 AM, Mark Brown wrote:
> > On Wed, Nov 29, 2017 at 03:32:56PM -0600, Andrew F. Davis wrote:

> >> +	} else {
> >> +		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
> >> +		if (ret < 0)
> >> +			dev_err(aic31xx->dev, "Could not reset device\n");

> > Print the error to help people doing debug.

> Do you mean by adding the ret code to the print?

Yes.

--5iu6nc6tottybtb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohe4cACgkQJNaLcl1U
h9BYBQf/dRj2BtdVJ9dgKmkWIIYBdTDLZ8th7j+LPSW/W9fRZ1Z+aGefWICGvXXw
vTdvml0NJRVj9yMf1+pVMQg7DgcKzJUOAoYl86tvibcZjmJZ/4+hDb/NvAGKibRX
WrerVrlgqf6itIHKqJJ2/gRteL9Zti1z7xrFBF63zRQV811DWSHDIa8RDW5+7IM2
HrWBu5xRXwcLP4/yV1jwNIER6L67WxMkflh0BP8uHVqcuLq24thvGGHZVDBjiWu6
iv9N0VNgQIkgkA2PhtfEG34mRnF2olhmNLXKydC0xWvfArFlLGFevVU1ZDwsDlHj
8HE4wm9jLPse/esEtEIx/83T7GKUJA==
=BPHe
-----END PGP SIGNATURE-----

--5iu6nc6tottybtb6--
