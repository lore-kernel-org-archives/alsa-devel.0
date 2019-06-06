From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Add sidetone support
Date: Thu, 6 Jun 2019 12:54:42 +0100
Message-ID: <20190606115441.GB2456@sirena.org.uk>
References: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Ox1BgGQfTDeiDFL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190606114002.17251-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9Ox1BgGQfTDeiDFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 12:40:02PM +0100, Srinivas Kandagatla wrote:

> +	default:
> +		pr_err("%s: event = %d not expected\n", __func__, event);
> +	}

dev_err() please (and a break; as well, it isn't strictly needed but
stops people having to check that it isn't needed).

> +	SOC_SINGLE_EXT("IIR1 Enable Band1", IIR1, BAND1, 1, 0,
> +	msm8x16_wcd_get_iir_enable_audio_mixer,
> +	msm8x16_wcd_put_iir_enable_audio_mixer),

The indentation here is *really* messed up.  What are these controls,
with names like "Enable" they sound like on/off controls in which case
they should be standard Switch controls.

--9Ox1BgGQfTDeiDFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4/wEACgkQJNaLcl1U
h9CHXgf9ELgAnvcZKwTjonidDRb4OSre9kePfh4H+mFw7tR6ZR9tmBAT2jbsVbGZ
WvScbpmCOfn++MhbvUy/EPYBm2WKdhiVRzT7K4m40Z/FJI3ZsZcKmR6WXaQnml9u
xkTXA6na7ohZkJ4lpkmN1GMo/3pE0XjQudzjSEUBlY3/ZbLhEf1uOke3Fphilxb7
y2QF6JumJj9Zb1SBYIy30NV738gGDGmQY4A4Dtj1nm1Z4beiB079IxOXTRCoZ15+
fzJ61eL4qFymDuuJ0NTNsvos01adD0vGWVLhR+ngBDILwNatpwJ0gP+gK7XhxKWQ
9JDBbNRSzsgduDJnCk4IIC+A38m0HA==
=3Tnd
-----END PGP SIGNATURE-----

--9Ox1BgGQfTDeiDFL--
