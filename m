From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/6] ASoC: usp-pcm: add CPU DAI driver
 for PCM simulated from USP
Date: Mon, 28 Oct 2013 14:31:05 -0700
Message-ID: <20131028213105.GB20960@sirena.org.uk>
References: <1382914576-4785-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0772803756036097311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 26BEE260320
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 22:31:15 +0100 (CET)
In-Reply-To: <1382914576-4785-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0772803756036097311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 06:56:16AM +0800, Barry Song wrote:

> +static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
> +{
> +	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
> +	u32 clk_rate, clk_div, clk_div_hi, clk_div_lo;
> +
> +	if (div_id != SIRF_USP_DIV_MCLK)
> +		return -EINVAL;

This is fine as far as it goes but why is this something that can't be
calculated automatically at runtime based on the sample rate the driver
is given?

> +	/* Congiure TX FIFO Level Check register */

Typo.

> +static int sirf_usp_pcm_runtime_resume(struct device *dev)
> +{
> +	struct sirf_usp *susp = dev_get_drvdata(dev);
> +	clk_prepare_enable(susp->clk);

Should check the return value here.

> +	clk_prepare_enable(susp->clk);

Should check the return value.

> +	ret = snd_soc_register_component(&pdev->dev, &sirf_usp_component,
> +		&sirf_usp_pcm_dai, 1);

devm_snd_soc_register_component() please.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
> +		goto err;
> +	}
> +	pm_runtime_enable(&pdev->dev);

This needs to happen prior to registration.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbtePAAoJELSic+t+oim9EAQP/1vCqGkkWaLac/AHAaZg+Xz5
xDUp4PbwzyN6xgrAm4M3xbXf4QCxxCWf0FmI//FzJ/mKeQdqsEndtjJz5U4IQm5+
X27aiPgRUIy0/tXS3aBeFUUOGIImpUPJ2SjunCXXst7so1NRq9R18BfFyCU1jKp2
lCU9HJFkhyvCJZmjXWvdYmJt3BSMJB3y6mT7YPtpyHnVfaF6QkEEr6L9g2EVRGAL
VpnDJhTbGfyO2wE6Zu8/SDYc33Tg3j1vLLgG0r6yOEl8bjsIrPQmzE7DKTb/tzfi
c5mH96ry1ka+OeKLacgzcx3GIHj9wt2oGSRXuSQgeOkPoJk5sgoZmaBeu6K55xFn
f+u6eVKfVi1/YyqBB+L0YbQdjLF8X3HyziZrPF1WXIXx089A+I173m7HzJM8Q/Q6
whtGHjRyUjpnn6qL4vfnz8dB6N2FEMyHkHZQBOvEyB21RPxo80+DKp8Cmr+5weHR
vXXpiq/EKEMrDNG7bCMO9uTZiKB/JtgSjlqlekXMM3C3sD8FHYB6Ku2I1u74zdeW
gylwuPuvRQRP+XK4yP9PdcKKHiXC/x9ZLGsMB9SUx+IPityWaXMmkuMvSvH7kN4V
VQ2zuPtqy4KARHRqmNhHXXrkuMMpk4Raw9hSytP1hwxaH4qrCedTu4d0CYgzHYwD
V6iJ52/z73nkCKfyqgaX
=SSNK
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--

--===============0772803756036097311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0772803756036097311==--
