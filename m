From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: da7218: Add bindings documentation for DA7218
 audio codec
Date: Thu, 5 Nov 2015 14:58:56 +0000
Message-ID: <20151105145856.GM18409@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <b7132781a4a41a20549e13b1835bb7f808f6be82.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b7132781a4a41a20549e13b1835bb7f808f6be82.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 10:43:15AM +0000, Adam Thomson wrote:

> +- dlg,ldo-lvl : Required internal LDO voltage (mV) level
> +	[<1050>, <1100>, <1200>, <1400>]

Why would this ever be anything other than the minimum voltage, and
might we not want to vary it at runtime?

> +- dlg,biquad-cfg : List of data & address pairs to configure BiQuad filters
> +	[ < {data1} {addr1} {data2} {addr2} ... >; ]
> +- dlg,st-biquad-cfg : List of data & address pairs to configure Sidetone
> +		      BiQuad filters
> +	[ < {data1} {addr1} {data2} {addr2} ... >; ]

These look like DSP coefficients which I would therefore expect to be
configurable at runtime via a binary control rather than specified in
the DT - why are they in the DT?

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO26vAAoJECTWi3JdVIfQgUwH/27Lm6jybODx2dwHVL4OYEdq
OAQjp3mOiGy4WKjudEkvdSf2exNIfYKDzMGSTyCM5xhTVGem9gZT6X6wJFbnuJ07
zPG8/q80wtepHz6Dp6CCTWam1onkP/oacIs3cNgF/+RwuaeJzxgqAytLweKtHN6R
gwZz1PuGENC2bdHAggVLT0Xwf7k68vMx/ALUaAAax1czDkZKB8r4xH+Uo+2AJmUM
cEG4k8YTboOSsBxV5FeV2V9aafBc9Y5HDKhBkGe392K9CHjpkYhdrcnXrEJYXQMs
ae4dQp8z8w3zIW11LUJJU/VPtG4UjCrxoznYCMPS5sqLvIy9fwKRjItByVqqqyg=
=deB4
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
