From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: qcom: add apq8016 sound card support
Date: Tue, 9 Jun 2015 19:04:35 +0100
Message-ID: <20150609180435.GV14071@sirena.org.uk>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150609170738.GI14071@sirena.org.uk>
 <557727BF.8040807@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OpkDJjDTRXa+mPUW"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <557727BF.8040807@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--OpkDJjDTRXa+mPUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 06:51:59PM +0100, Srinivas Kandagatla wrote:
> On 09/06/15 18:07, Mark Brown wrote:

> >Why not just do these one time at probe, we don't undo them when we shut
> >the DAI down?

> If I do that Am afraid that the driver would loose the flexibility of
> selecting different MI2S from DT level. Hardcoding which MI2S can got to
> external or internal codec is something that I wanted to avoid from the
> start.

I don't understand why we'd loose anything - we get init() callbacks on
the DAIs when they're instantiated?

> I will add the shutdown code to reset the configuration.

OK.

--OpkDJjDTRXa+mPUW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyqzAAoJECTWi3JdVIfQmz0H/ig1ESYG4BU4SB0Ctdm/affi
544StIDP7PRu5FVc7EJnWIjYLQK5vjYar7HX3P2mm/fs4BWzL6FZqjqYbMjm3iKz
iuAZlV4dYjqJ1Qm1PEdLf/t4j+16s5jTrMynPEu5D0OPXf9PLDwlNXn95bSqB3Us
MKmeMqlV9BS60FrtLTKWnRWrt1LYTqg6GkScYJs+fkIksw54on+P6OPwT8LIO4An
773z8E3FdVXWy+PofEvlyPESLXwa+lngPmOG51mtRqVREd1HtJ0t1rvhE4ys3f6S
k+T8NKMkB4u6KBnWqhSI55H1s2i1yuofI7O6MKCG3Xj8aN0ZAOVSPBEHu/WZsls=
=qgbG
-----END PGP SIGNATURE-----

--OpkDJjDTRXa+mPUW--
