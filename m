From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: msm8916: Add codec Device Tree bindings.
Date: Tue, 14 Jun 2016 16:23:18 +0100
Message-ID: <20160614152318.GR2282@sirena.org.uk>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="htVlOAOs/VIaEhiC"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465582725-30183-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--htVlOAOs/VIaEhiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2016 at 07:18:44PM +0100, Srinivas Kandagatla wrote:

> +Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
> +and secondly digital part which is integrated into application processor. Codec register
> +controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.

Please keep things wrapped at less than 80 columns.

> + - interrupt-parent : The parent interrupt controller.
> + - interrupts: List of interrupts in given SPMI peripheral.
> + - interrupt-names: Names specified to above list of interrupts in same
> +		    order. List of supported interrupt names are:
> +  "spk_cnp_int" - Speaker click and pop interrupt

Please format this more clearly so these don't look like properties,
more indentation would be good.

> + - vddio-supply: phandle to VDD_CDC_IO regulator device tree node.
> + - vdd-tx-rx-supply: phandle to VDD_CDC_TX/RX/CX regulator device tree node.

You should name the supplies with the same name as the datasheet uses.

--htVlOAOs/VIaEhiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYCFiAAoJECTWi3JdVIfQtQwH/iCnUxV1XkjcxF/Z3UQv1Y5Z
h2EG3PriI+QcxTMZw6dMj63DLsR61voL+RScWtAUmW6kx4qDjaSCU7qpurxJ2eCO
YtM0oyygIAJER52ReFK8U36AwlGbz+q8w2tKtqFxJve5FAD6EV1Jz/RRWesc094C
RHbB69Ibu2dEEWgZaDTiQdnPd5kHqTvXFV2ztjTMeXllhZWHLgA14UWpZ2+MNkAH
bS0UDcy6QPs7FIZbCQT2X/Eipi5Q478k2E7MN2Yzi1sFsjtf9TAzlFCpfoyxdM3w
/5uMT5xO6Pj367z/kIN/9XEXMYzFZ2iHbiiS54YwBjE3I5ae2RBjJ76d3EvX6Ac=
=Vr3l
-----END PGP SIGNATURE-----

--htVlOAOs/VIaEhiC--
