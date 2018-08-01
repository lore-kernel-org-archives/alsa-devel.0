From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/4] ASoC: qcom: add sdm845 sound card
	support
Date: Wed, 1 Aug 2018 11:51:31 +0100
Message-ID: <20180801105131.GF5509@sirena.org.uk>
References: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
 <1533114069-16570-5-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2621417515088584222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C1EE92676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 12:51:34 +0200 (CEST)
In-Reply-To: <1533114069-16570-5-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2621417515088584222==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 01, 2018 at 02:31:09PM +0530, Rohit kumar wrote:

> --- /dev/null
> +++ b/sound/soc/qcom/sdm845.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

Please make the entire thing a C++ comment, it makes it look more
intentional.

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthkLIACgkQJNaLcl1U
h9BBVAf9H4oTxZ8FrcKTi+6zDylOZrUcflwy65D1oUjD/O2ojrKbjzvrLgKQF1EQ
j8DCBTuVk0FWCU+s9JjASBe//po6IWZjV3WFW0c/5F0Ao1ubyqoKjFfISJGn0D8u
K1o/mu51BlqJBv+pehniywwaZdqM2N6iGhzq6uJRorzVtnCF+tthaDJ73m9LV4dK
1PVNETgfMazdDfR8v/d++TrOvFvwDTRke2vyjaZ9H0JrIyEkRrQaF4WFIlYCe3/+
5rI/zL6H87tPHc8uvJ8Nv4YUkTZB/lopaf+sRXpCg96WKvWkEWPKGq+wGOHZejXm
EP2CUWsrZr5edEbVY57U6m6kYD1miw==
=STS5
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--

--===============2621417515088584222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2621417515088584222==--
