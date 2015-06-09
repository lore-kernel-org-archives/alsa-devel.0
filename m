From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/2] ASoC: qcom: document apq8016 sbc machine driver
 bindings
Date: Tue, 9 Jun 2015 17:57:18 +0100
Message-ID: <20150609165718.GH14071@sirena.org.uk>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mf8qZHy9ZtPMQ5Ky"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Mf8qZHy9ZtPMQ5Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 01:59:29PM +0100, Srinivas Kandagatla wrote:

> +Optional CPU/CODEC subnodes properties:
> +- external	: flag to indicate if the I2S is connected to external codec
> +Example:

Missing blank line between the property and the "Example:".  I'm still
not sure I understand why we need a boolean property indicating if an
external CODEC is in use - what is the consequence of setting this
property?

--Mf8qZHy9ZtPMQ5Ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdxrtAAoJECTWi3JdVIfQFkgH/i8rX5EQrQX+Rqsr+bma4qWu
F8XfKkEt+gMnJa30v2+JcUGRYOGKAW1kouBSRnXaCebw8H+2cP6KZebcQkH1KwnI
/vblMbcszIROXRt3CKxHR34cQub2eGdFvxKQ5XpCZIMnt0AbdQDPXxLZj2SC503x
8dQp8edMo6MDkG7bS/k+N16Q1dv4hfy+zOk0kKp+g2ZGeVuHubQcjBW1/TYZph7Q
ARSHlGxMVZwcUIbRb/dmSQqlYTg3vCdM0OURYtNe0abIzrcaTWDhilw3D8UpcXTI
+DFcX5jvnx4w2NV6MiWtJF0E4xUDar1U8nW4B94lusqSbmAKkREuu7XrB+njIqA=
=sYzK
-----END PGP SIGNATURE-----

--Mf8qZHy9ZtPMQ5Ky--
