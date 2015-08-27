From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm5110: Add DAPM/routing hookup for the ANC
 block
Date: Thu, 27 Aug 2015 17:11:32 +0100
Message-ID: <20150827161132.GE5313@sirena.org.uk>
References: <1440689466-7941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1440689466-7941-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440689466-7941-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2015 at 04:31:06PM +0100, Charles Keepax wrote:

> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		val = 1 << w->shift;
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		val = 1 << (w->shift + 1);
> +	default:

It looks like there's a missing break here.

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3za0AAoJECTWi3JdVIfQpA8H/2BmLGuKzzQztCGO7A1XfjA5
e6QVxQQz5QLZw52eYL9JfFP7XEqX4Lg1TwNaP8ia0/8ETgkyWOQBrB4ArB3uJgcq
XEzU7swwYNwMwTlfkuyfBVQ6lr5LD54vOj6Lo+aWHHzxr6J4NJUeVllwvU6TQvUg
iurF9AIsFFG5QzbaeWA4iDcBndcJcrvD50C60bNiIhnerzYTdA791rP4rrcTF/ql
xr7Mgd1e6DTKH6sOnrWO4rgdiXOC/Q/CpwsFbV1F1pSL6PN0va0xmSsr7Fn0QOoO
v7IlnN+RDh2gGsFXTajWOhAiduJQ0IT97pIOHfDpNAhMRylcgItkiU+sA3grXOo=
=3wax
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
