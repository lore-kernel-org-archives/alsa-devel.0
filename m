From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add delay before starting to
	capture
Date: Fri, 4 Jan 2019 12:27:41 +0000
Message-ID: <20190104122741.GA4140@sirena.org.uk>
References: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281752548722152240=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DCC267944
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 13:27:46 +0100 (CET)
In-Reply-To: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============1281752548722152240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 10:18:13AM +0000, Agrawal, Akshu wrote:
> On capture through dmic we observe a glitch at the start of record.
> This is because we start capturing even before dmic is ready to send
> out data. The glitch seen last for ~20msec.
>=20

> +	/*
> +	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
> +	 * to settle and start producing proper audio data.
> +	 */
> +	msleep(ADAU7002_DELAY_MS);

If the delay is required for external components to start up the delay
should be going in the drivers for those components rather than in the
driver for the CPU side, that way other systems using those components
get the benefit and non-affected boards don't pay the cost.  There's
already some support for this in the DMIC driver at least.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwvUT0ACgkQJNaLcl1U
h9DpZgf+IJjt3vPexs0YNutFifnYllPmQgc3jjLPJ2c7qVzdft2hyBlM+4Gz0Wrt
qG+DXIj6n50m+bhzp2QC2cjMTeZIUqzdmkmx1dqeuShTvulOx7TpSz5DIJIQkuWo
3u7SGlUmBnUhEsjxMfG8N3grGU89h/dRjtuvqgBUhmgm/+9fRqw5YTRel1TPY0cj
d4li0Jnlhn9KyiWZQxd7MKMMjB0PTpvXTbRT5lZrdACGdtcFlA3dUeV4MDQM/MzY
WVaOjtYhFVbpeFYChqPorMBEtuWFjbQiudZeXEgPmTvVbSx330OeH8zlDdpFx8eB
+dDYYpVvBVgIvCfUzwcjNrpFysIXqA==
=VZTZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--===============1281752548722152240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1281752548722152240==--
