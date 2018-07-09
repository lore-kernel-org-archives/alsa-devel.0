From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 12:14:37 +0100
Message-ID: <20180709111437.GB16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2018 at 03:13:13PM +0530, Rohit kumar wrote:

> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

Please make the entire comment block a C++ comment, it makes it look
more intentional.

> +static const struct component_master_ops sdm845_ops = {
> +	.bind = sdm845_bind,
> +	.unbind = sdm845_unbind,
> +};

Why is this using the component stuff rather than the normal support for
finding the components of audio cards?

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDQ50ACgkQJNaLcl1U
h9C5OAf+JveqZrxXpoXe/VjhXg8RPbyzezTyG8ZWYflQEQpM1UzQpr4pSbyc7ozz
CicbBkK5P6StaY1SUURd9NNmiQXay51izpf20Gne+nhDXxeIsi98J0eDtzypAgVX
aOiAfKkFlsySKOJf79Cq1Co1BpS1HOe9ve7mauaFP6lmI8qiAtc3fuhD03WAB3ku
FYNNCHSn2bV0A3EA3q1EX1j0xyO5PA8Kt0fTHqyCkDguA+DBhvoSGHD/HXYgibcH
210gSXCQ4LwKNmHQ/QS0m2MCoS0HNgBM4xO3/PU/EbSQ/hvoS987B+xrNv/JE9SZ
ZaluCT8Yre/yyA3YicLCSF48vWYuvA==
=bYhV
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
