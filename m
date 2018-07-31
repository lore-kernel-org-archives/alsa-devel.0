From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/10] ASoC: wcd9335: add basic controls
Date: Tue, 31 Jul 2018 18:16:54 +0100
Message-ID: <20180731171654.GL5719@sirena.org.uk>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-7-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 01:18:02PM +0100, Srinivas Kandagatla wrote:

> +static const char * const wcd9335_ear_pa_gain_text[] = {
> +	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB",
> +	"G_0_DB", "G_M2P5_DB", "UNDEFINED", "G_M12_DB"
> +};

This is fairly clearly a volume control so shouldn't be an enum.  I
don't think we have a standard control that enables you to skip values
in a regular volume control (we do for enums which you should've used
rather than having the undefined entry) so you'd have to have custom get
and put operators but that's better than abusing an enum.

> +static const char * const rx_hph_mode_mux_text[] = {
> +	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI"
> +};

Use a SOC_VALUE_ENUM to hide the invalid option from users.

> +	wcd->comp_enabled[comp] = value;
> +	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
> +		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;

Just write normal if statements unless there's a reason not to, it's
easier to read.

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgmYYACgkQJNaLcl1U
h9Adxgf+MFHKxg2WF8v6N+AeOWmjQ3J0XB/mq1WgTIgaPnJwCEbIPpDUhpq4DGdW
LDcrzKwVlNkeoGkubTMFqlDEGU37VKRNLKHZ5iydaNdVdnkN0AGmoY/70wfYA9Av
WN8I5pN+v5r1AlorDMLn/XwivKMOp2ekAhDYR7IC3bctHnG6yl8n/AxBCRH0vAhq
fQVg3GT4Ezd6X3GQJaFg12TLIBk5NfCJnjTD0i4M4g8oSsOywWnfaaYZ8TBhIx3g
DTX80aK69lqEDYB0tP/gW4Sqr5Hz1JmkPXG17YND/BvDBWUlFp3HunKy4m3Z+yWH
8rNVq0I2fbE2AZCNeaYb1Ck0ObH6GA==
=UnyX
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--
