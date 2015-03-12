From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8994: Manage wm8994's MCLK in codec
 driver
Date: Thu, 12 Mar 2015 11:39:45 +0000
Message-ID: <20150312113945.GO28806@sirena.org.uk>
References: <1426128580-18320-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+PRXPAOP3MYWro6n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426128580-18320-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com, nikesh@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, Li.Xiubo@freescale.com, sachin.kamat@samsung.com, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org


--+PRXPAOP3MYWro6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 11:49:39AM +0900, Inha Song wrote:

> -		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
> +			for (i = 0; i < ARRAY_SIZE(wm8994->clk_mclk); i++) {
> +				if (!IS_ERR(wm8994->clk_mclk[i]))
> +					clk_prepare_enable(wm8994->clk_mclk[i]);
> +			}

This isn't checking return values.  It's also enabling both clocks all
the time which isn't always going to be what's desired - it may result
in an expensive high frequency reference clock being enabled when only
a 32kHz clock is needed for example.  That doesn't seem desirable.

>  			active_reference(codec);

Should this perhaps be being done in active_reference instead?

--+PRXPAOP3MYWro6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAXsAAAoJECTWi3JdVIfQrzcIAIT9IQzpRbgZkHGj/ja/giYM
S0g16WvvbKd2s0zk9TGu8MvC5OvcATv8nzXQIJWMb/39N7fCxTPJCPZHkwv11GBf
uqVHFl12PU3XfbQ8uLMDpQIrg3y7W/dblCOJZSmu9EsKcRT8NjZOvIpJCaioLcZc
Yg9sNurm1FjgtDWRU6zT3ZLIM9/r6CLhymmQ+VjAl9OVKv29LkicgK1l0CFZISWK
3Cplkl19ZHOqZhtjeH1LMoF14atPdlkgd1zUcYpLuHw0QRdsEIt4XqTA3iIOE4Fv
b66z9Fqc9Uo5R/OVzc1nhOPgL81F/dDbxAQnhT+5j1h5nOV+c197fNBHM1aCme4=
=MHkl
-----END PGP SIGNATURE-----

--+PRXPAOP3MYWro6n--
