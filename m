From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Date: Sun, 28 Apr 2019 02:19:55 +0900
Message-ID: <20190427171955.GH14916@sirena.org.uk>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 01:59:24PM +0100, Adam Thomson wrote:

> +		/*
> +		 * Rounding the rate here avoids failure trying to set a new
> +		 * rate on an already enabled wclk. In that instance this will
> +		 * just set the same rate as is currently in use, and so should
> +		 * continue without problem.
> +		 */
> +		sr = clk_round_rate(wclk, sr);
>  		ret = clk_set_rate(wclk, sr);
>  		if (ret) {
>  			dev_err(component->dev,

Don't we need to validate that the rounded rate is actually viable for
the parameters we're trying to set here?  If there's missing constraints
causing something to try to do something unsupportable then we should
return an error rather than silently accept.

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjzoACgkQJNaLcl1U
h9ALMQf+PNlF6FLSTdYpAXPOqsdtjPPZj8JtUbmOAWcn9I/uWpH1kt8CRbciXAzW
GkU6ykRQUDErfkyZzMEE//9l+OZ//LHMAJjq53SRUIMj21RCMc81bH4d5OGD5zms
2N+cAZUBqUN6xOPfQdaGTWpFoXgIjZ13lDiNnM0Jw5RkV+3CVWMPNJlnOWX8jdog
S1gdGvRGyZn0wZ8iqsTISJ+phqtlFxgsNLM5DXPs5o/4RdjhHRW1u+L4BtOz1f8H
Mso/GrYbrgPSvn/9vah4vbkkHrwAbuy68dejwyEQtAFU80BZj0sG3K4TrjBiivn5
Rlm43XIswMUKG8rx1G6jxRVYWs2y6A==
=65do
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
