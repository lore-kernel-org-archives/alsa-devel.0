From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset
 for stable amp reset
Date: Wed, 28 Nov 2018 09:49:55 +0000
Message-ID: <20181128094955.GG6828@sirena.org.uk>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0328310180003101719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 785FE267AF3
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 10:49:58 +0100 (CET)
In-Reply-To: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Grant Grundler <grundler@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Benson Leung <bleung@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============0328310180003101719==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

Not seeing a changelog here like I asked for :(

> Changes : Created max98373_reset function to minimize code duplication.
>           Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
>           Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
>           Revision ID is available when the amp is in the idle state which means software reset is completed.
>           Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
>           sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).

This looks like it's supposed to be a changelog but it isn't one?

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+ZMIACgkQJNaLcl1U
h9BPnQf/c8ks2E8UVNO4yepGn9jIDQYg3qVpxKroJ5lilKjrSlrkErdUESolRMj4
dp+1KqWdPQJBYFRJvpy4xihm/wgCLUBh2PIslqhT4xRDX4E6dXyjvG8mNyzDPFXs
QuQZULSPfcYYy4KjeT4zvZO5pbKFp78Zrh/dXmq5xjNsgeMJUmstBjsghHImX3BL
JV8YHSHw00hXyd+jqMKe9bmmhFmw5/fbO7ZmxnYnH944J5bVuDyvsHWmpesjjp8R
v5Q4gV1n0cV9+jQABul4qe9ruZqtaAjZhlgXmuTo/Fb21KA4pv4YCpt/6a9AXIed
gcSyEF+KwN18VAbCWw9T0j9olkUVjg==
=VVqX
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--

--===============0328310180003101719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0328310180003101719==--
