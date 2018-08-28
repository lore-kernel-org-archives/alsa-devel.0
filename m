From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: pcm3060: Add codec driver
Date: Tue, 28 Aug 2018 20:40:45 +0100
Message-ID: <20180828194045.GQ2414@sirena.org.uk>
References: <20180821165246.9479-1-kmarinushkin@birdec.tech>
 <20180821165246.9479-2-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3751043826322153721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BD02126777B
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 21:58:23 +0200 (CEST)
In-Reply-To: <20180821165246.9479-2-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3751043826322153721==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZXg5XZblsOcYBG3r"
Content-Disposition: inline


--ZXg5XZblsOcYBG3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2018 at 06:52:46PM +0200, Kirill Marinushkin wrote:

This looks good apart from a few small stylistic things so I'll apply,
please send followup patches fixing these:

> +++ b/sound/soc/codecs/pcm3060-i2c.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCM3060 I2C driver

Please make the entire comment a C++ one, it makes this look more
intentional.

> +	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);

Please rewrite this as a normal if statement to improve legibility,
there's some other ternery operator abuse in here.

--ZXg5XZblsOcYBG3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFpTwACgkQJNaLcl1U
h9Bqrwf/VVAlTVTQQ9LMt6IWYuumhMu4EROxafwtcf2gyFjOQ1jK3la4FgIHTfIB
XiEJxv0Mc5rA4vot9saBSK/WgFT8iswPV5lm4nDOOnXwPmU+JVUsL/S0fnEFCA8X
xvUm0vBkNPcLrqvJs2HknKDnuf6BPCCbeovFOulsO/mO+/2t5lDgwiXuYs6aBOwT
yTv+uOfBI5XkIoPpyh+AA2m2/i59QWcJn+0JR45L+2o9ndMF82kqCsPmyY24lQM3
1J9Yd83MXisiVU7MJ+c74yr2b71SdkHZpLV6zBsTaiXgNMqhc4gan9omaVrqMShD
sPSS2p6SBk+fpq8fDMzA8Vlw0iOD+A==
=PyJX
-----END PGP SIGNATURE-----

--ZXg5XZblsOcYBG3r--

--===============3751043826322153721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3751043826322153721==--
