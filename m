From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] ASoC: codecs: msm8916-analog: support jack
 detection
Date: Wed, 26 Jul 2017 17:21:49 +0100
Message-ID: <20170726162149.g72j5fdgtyyfrqs2@sirena.org.uk>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
 <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="feo6ukh7awfmnsgl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org


--feo6ukh7awfmnsgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 01:51:25PM -0400, Damien Riegel wrote:

> +	for (i = 0; i < ARRAY_SIZE(jack_detect_irqs); i++) {
> +		int irq;
> +
> +		irq = platform_get_irq_byname(pdev, jack_detect_irqs[i].name);
> +		if (irq < 0) {
> +			dev_warn(dev, "failed to get irq '%s', jack insertion detection disabled\n",
> +				 jack_detect_irqs[i].name);
> +			break;
> +		}
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,

Don't put the loop in when there's only one IRQ, wait till it's needed.
This is an unusual pattern and it's not clear that just bombing out of
the loop with interrupts half requested is a good idea.

--feo6ukh7awfmnsgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4wZwACgkQJNaLcl1U
h9AsVQf+Nsa9b6Pi0s3AfRvkC3DKTVV5xmGVTQop9uA/M3thssaGzmWGhYytn0Xl
fnT4Dv2VXELI4UUJVy+e9gsQRQ8CuKn6hoeYcxujuvjcacRzc98K+5DLcNTfpYw/
PPQNX0FPpi+QXhzDmucEJQa4WzU4ADxD4xVVCEpaDh9BbRX06ksB0TnHZI9KlwWV
euO5urErl8hE+TusAbcdHBDZkPMCWc92snLJCbNBRmTAQ3kYCsBL644LFcFe8SQa
SFS4Vu8vo4RC21p3j7fwLDqR3+HyyTN8tIr4ZImgbeJ6ak97M5VpHs+qSdypkP9B
8hs7R0cym6fdWPzFPaO1odJ05/0AZg==
=qfpy
-----END PGP SIGNATURE-----

--feo6ukh7awfmnsgl--
