From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Drop formats limitation for
	imx-pcm-dma.c
Date: Thu, 24 Apr 2014 13:14:48 +0100
Message-ID: <20140424121448.GR12304@sirena.org.uk>
References: <1398339187-12097-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3918932491135339479=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E7E2652B0
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:15:02 +0200 (CEST)
In-Reply-To: <1398339187-12097-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3918932491135339479==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="afYSId37w55bXVbu"
Content-Disposition: inline


--afYSId37w55bXVbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 07:33:07PM +0800, Nicolin Chen wrote:
> Now ASoC core is getting the intersection of supported formats not only
> from CPU and CODEC dai's but also from DMA's. However, there should be
> no specific width limitation from SDMA side.

Applied, thanks.

--afYSId37w55bXVbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWQA1AAoJELSic+t+oim9PNkP/iT8a8f76ZYhkytSwlZgPLOh
Wdc3hoSP0HDYUppFEfN4QoTBUNQouIyadib9Z+ueAob+SVOjbkR1NBlJ8oUSnum+
1df4Xje17l9F1P9gaaxhUFYHK6jPH5r5zV0IXt2PG0gjtlYH8OsLbz8EUz/nyGCR
YxLNNdHi/Mi7cTMcfwjS55l7ITRKCyn4uZyZaMcYaWdO2LCEY9/K4Nub3B27uB9O
40r4NRb3pg0HS00qVBZYt2PsGVcozzqzw4DP+hIp23yGT1tteQ/qTTBC/pkC/unH
lQ/RJ7SRIHMPBN0JAY3xQ5yn7UiP134SUVFJ0rCKcOIXjUZ+5K5dGFq+egRsznWK
QdAGVE+W3C1ccGFOweeAh2o3xCfytrV/Ph2iObgKB57cQ44NMFHwUJ93DHM7fy/J
8Ju36dAO37BTZ+WqrG9qo5iPxtJMEcSjL5gCqKcuLNRCfehy5hz3LZpMBVFx6h0s
XAU1srdvqn2cWNMg68IlIoRttIl+NvpeZfDsCZUkOLPTRXmSB819CxPwTqdR7TOb
2KeceFhkZTjATW0wtNkvtvV8k+oHS0WtvV1RGZXx0a2TuuVKsuAS5ZqSXnexlDps
OkXOESZLgWBBiSLxOLlmIFsODGBXL1WxFeMT6OJYOkgtlddN3ZCi5d1+C2FFs+XT
qajxGf7vDFcd6FO3xo0O
=YNyM
-----END PGP SIGNATURE-----

--afYSId37w55bXVbu--

--===============3918932491135339479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3918932491135339479==--
