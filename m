From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 07/14] ASoC: qcom: add no osr clk flag to lpass
 variant
Date: Mon, 4 May 2015 13:26:19 +0100
Message-ID: <20150504122619.GS15510@sirena.org.uk>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414244-11168-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mln0rGgUGuXEqmuI"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414244-11168-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--mln0rGgUGuXEqmuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 06:17:24PM +0100, Srinivas Kandagatla wrote:

> +	if (!drvdata->variant->no_osr_clk) {
> +		ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->id]);

Can we do this by checking to see if the clock is set to IS_ERR()
instead?  That's what we're doing elsewhere for possibly optional
clocks.

--mln0rGgUGuXEqmuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2VqAAoJECTWi3JdVIfQe9AH/RWaolT9nl6TTzAwhZWC9I/B
nRqOQhDLNcO8gUWKGxHB/6UVVEECb74nMHUvsgyeLDRJ9D6ZBL5Mdkks4lG4N2hJ
2F8PJPkJDXIQroRlUL2IN5zEgk+1hEp/XCG3HzaZQ5+gV7+2LO8OS7jkIYC/FsMX
m1bM4hk5kWCsLNzcBg09+MTxIBDt8EUGSL6VMcsGZgAHywh9+QP1beEiqPLJqtYv
sVvsV3fwLrDV45W3CGz7kEOSNp6mwPdgd/OtcBs5cXXKgij0CRYNIlJAi9jTo188
yGLSIQ8hOOSYq2iZymNT/WeAKFwp9Eu6tVTpYpmroBk0SYTj3Ks1laRFTm46Q98=
=eE4i
-----END PGP SIGNATURE-----

--mln0rGgUGuXEqmuI--
