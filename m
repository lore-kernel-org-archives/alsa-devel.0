From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/8] ASoC: wcd9335: add basic controls
Date: Tue, 22 Jan 2019 18:52:53 +0000
Message-ID: <20190122185253.GG7579@sirena.org.uk>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110150616.2332-5-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 03:06:12PM +0000, Srinivas Kandagatla wrote:

> +static const char * const wcd9335_ear_pa_gain_text[] = {
> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
> +};

Gains should be controlled with Volume controls, not enums.  Provide
information on the levels via TLV.

> +static const char * const rx_hph_mode_mux_text[] = {
> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
> +};

Is there a strong reason not to use more human readable strings here?

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHZoQACgkQJNaLcl1U
h9BKogf/cHTbAkrXyBIsX9olDNCF8Z6O0NaQkWFjxGL+8D6Yi8ZalJDFOLw3VNtJ
Gg8c4Z7mNOuSQzSvvZ9u+P+YnZP5Tn+iCHNoe79sz0tjQyobpB1aupFTdiUXHEJn
c2FpxhLnL3jPsNeCzp6HjR6sKR4bnEdNGFVJd1b+9uYliNk3OyDTbW2/dkBuJnak
fEOLNNtJkqgBI3vL4se45mJMr4adjK8idoZyHKyGE+a9D03uwZfNEKdZoR7VBobY
QB4fNWoTqjQ0xkygqw9xsYi7tEQhZv6UaWjpECdIOEQHeylY1VINCOZ3d+cFW8hB
Fu6yB3hzUAYk6y3TOZd3rh+OAmh6yw==
=V+s0
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
