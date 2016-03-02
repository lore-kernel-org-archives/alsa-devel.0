From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Wed, 2 Mar 2016 13:11:01 +0900
Message-ID: <20160302041101.GZ18327@sirena.org.uk>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1198946061654036929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32F5E2606F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:11:08 +0100 (CET)
In-Reply-To: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1198946061654036929==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S+GnIiKg56iOFcRc"
Content-Disposition: inline


--S+GnIiKg56iOFcRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 11:42:42AM +0800, Zidan Wang wrote:

> +	if (id == HIFI_DAI) {
> +		/*
> +		 * Set GPIO1 pin function to reserve, so that DAC1 and ADC1
> +		 * using shared LRCLK from DACLRCK1.
> +		 */
> +		snd_soc_update_bits(codec, WM8994_GPIO_1, 0x1f, 0x2);

No, this is broken - if you're writing directly into the register map of
a device without the driver that's just asking for breakage.

> +	} else if (id == VOICE_DAI) {
> +		/*

This looks like you're writing a switch statement...

> +		if (card->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +			/* need to enable mclk to write/read wm8958 register */
> +			for (i = 0; i < WM8958_MCLK_MAX; i++) {
> +				if (!IS_ERR(data->mclk[i])) {
> +					ret = clk_prepare_enable(data->mclk[i]);

The CODEC needs to look after its own clocks.

> +	[VOICE_DAI] =   {
> +			.name = "Voice",
> +			.stream_name = "Voice",
> +			.cpu_dai_name = "snd-soc-dummy-dai",
> +			.codec_name = "wm8994-codec",
> +			.codec_dai_name = "wm8994-aif2",
> +			.platform_name = "snd-soc-dummy",

Why are you mapping in dummy DAIs?  If these devices aren't connected
then they're not connected and you shouldn't represent them.  If they
are connected to something then describe those connections, possibly in
followup patches if you have other devices you need to support upstream
first.

--S+GnIiKg56iOFcRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1mfUAAoJECTWi3JdVIfQCQAH/1i7DsF/ibRK3S/uPpWZtZhl
Oz3Ob43qxB2naiGGNRqmysCs0BmJbFf1zt+Ml8Micbhg9ZaDR12toR/0O54KJQJD
uxNnVFKY67nxQNpXx6eJtxZ9c3cHMvmjIY+nfDCjzYxqrA5/27imwD+HAeNg7H/Z
2NQQe5zwi4xkPA2ebS6OhvXBPaeeYOHgd0Q1fqHQtfkfM3QogXN2zqDjZuoPECQw
UB2CELUIy4NhV1SUXZOMKO2sLCwbHCHaW/dxS3oeku1wUoFk0T41y3ziTMFhW2ua
OdE3YlsWRKGksLy0MdEFO2IlgRjLlSJSr/VlagofC1F9nQRUWtOnzlYhPkoYo3E=
=UAaR
-----END PGP SIGNATURE-----

--S+GnIiKg56iOFcRc--

--===============1198946061654036929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1198946061654036929==--
