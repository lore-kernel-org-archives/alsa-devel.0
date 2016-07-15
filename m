From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] qcom: ipq4019: Add ASoC driver modules
Date: Fri, 15 Jul 2016 13:52:26 +0100
Message-ID: <20160715125226.GJ30372@sirena.org.uk>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
 <1468566426-19598-5-git-send-email-njaigane@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468566426-19598-5-git-send-email-njaigane@codeaurora.org>
Sender: linux-gpio-owner@vger.kernel.org
To: njaigane@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux@qca.qualcomm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, twp@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, linus.walleij@linaro.org, plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, bjorn.andersson@linaro.org, varada@codeaurora.org, pradeepb@codeaurora.org, snlakshm@codeaurora.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, bselvara@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 15, 2016 at 12:37:06PM +0530, njaigane@codeaurora.org wrote:

>  sound/soc/qcom/Kconfig                     |  47 ++
>  sound/soc/qcom/Makefile                    |   1 +
>  sound/soc/qcom/ipq4019/Makefile            |  16 +
>  sound/soc/qcom/ipq4019/ipq4019-adss.c      | 407 ++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-adss.h      | 432 +++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-codec.c     | 475 +++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-codec.h     |  91 ++++
>  sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c   | 687 ++++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-mbox.c      | 825 +++++++++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-mbox.h      | 146 +++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c   | 609 +++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c | 664 +++++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c   | 609 +++++++++++++++++++++
>  sound/soc/qcom/ipq4019/ipq4019-pcm.h       |  37 ++
>  sound/soc/qcom/ipq4019/ipq4019-stereo.c    | 313 +++++++++++
>  sound/soc/qcom/ipq4019/ipq4019.c           | 121 +++++

This is *far* too big to be a single patch.  Please at the very least
split this up into one patch per driver, look at the git history of
other drivers for examples of splitting things up.

--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXiNyKAAoJECTWi3JdVIfQMYkH/0ki4MdD67FXcwTsarosZpd5
71++4YiUIZBWKq7M1/CDhSggI3Eycdik4cMzazRma7VwCloFmSkQwkV7V+Yu4A2x
cIK+5TI03ATEP1WRVq8dzlCTiH/KCmpNsCtyMzyTUwUhoEKZc/dvqVFEQdoWAfCq
Fra9AXMCnJ/LVbvzqLGLLMGRTWgBWPYik9H+HQLw9frdC4+nXW5nc0gvDMt0gtTn
cbsy493NL4ziMGhJMJIePEp3gGbMob83EOCqrqFrO1DUXy/rNPLzqt11aprWHHWr
aIDlYMrHvC72K0UX6M7ZrBx3pPAO2Hbvp41+d9hx8xHtTKQ55oGpn/9+4SZArqM=
=2Aie
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
