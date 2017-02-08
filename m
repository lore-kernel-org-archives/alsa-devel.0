From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835: Add 8 channel (multitrack)
	capability
Date: Wed, 8 Feb 2017 18:28:35 +0000
Message-ID: <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2649915759401715381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A37E266AB2
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 19:28:50 +0100 (CET)
In-Reply-To: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2649915759401715381==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jpxdj7u7cq4ndw5y"
Content-Disposition: inline


--jpxdj7u7cq4ndw5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:

>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
> +	case SND_SOC_DAIFMT_CBM_CFS:

Is this fall through deliberate?

> +	/* Default data delay to 1 bit.
> +	   In I2S mode, we must have 2 channels */
>  	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>  	case SND_SOC_DAIFMT_I2S:
> +		if (params_channels(params) != 2)
> +			return -EINVAL;
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
>  		data_delay = 1;
>  		break;
>  	default:

Same here.  This is also buggy in that it treats DSP A and DSP B
identically, they are different so the configuration must be incorrect
for one of them.  I suspect this is configuring for DSP A.

You should also really have a setup() function that imposes a channel
constraint when in I2S mode, wm8988 is one example here.

--jpxdj7u7cq4ndw5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlibY1IACgkQJNaLcl1U
h9DdKgf+M4g0iq3QrYlZgP33ChGMEQJL/JRtInuON8YvKspa18Xsc6cx3wYZQmRF
7atZSqu3tJMXab7R/QkastwckSftWmlXf5RQDfFuEUyXYtXBJ0JgNqgxh3iGWiW+
MJoBjQ/fOt1gpbyi9dKX8z6CxDoMZOrtLhddCdyIYAOZmtBUvro5+RjWcd4ww0oR
mZ4cv0C2WpNy5+aDVRzXm5GdOois6olLamQgAtpKa0JGLzStnZlQMcvKbWEsnZnb
nkDPiaHJj2UuIWEeRx89ubODTUR7KS/nrHJNXhqXfKAAgVums/Ym3qvm3+D2hmeJ
pk4WcJNcjP1dQM0W7F5ym7+wZjynZw==
=wkXN
-----END PGP SIGNATURE-----

--jpxdj7u7cq4ndw5y--

--===============2649915759401715381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2649915759401715381==--
