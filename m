From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 14/16] ASoC: Ux500: Add platform-driver
Date: Tue, 13 Mar 2012 22:48:41 +0000
Message-ID: <20120313224840.GM3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-15-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7576268331985248019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42475104416
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 23:48:43 +0100 (CET)
In-Reply-To: <1331651503-16917-15-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7576268331985248019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Content-Disposition: inline


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:41PM +0100, Ola Lilja wrote:

> +static const char *stream_str(struct snd_pcm_substream *substream)
> +{
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		return "Playback";
> +	else
> +		return "Capture";
> +}

You know how I was mentioning that this isn't at all driver specific...

> +	cdesc = dma_dev->device_prep_dma_cyclic(ux500_pcm_data->pipeid, dma_addr,
> +						period_cnt * period_len, period_len,
> +						direction);

You're using dmaengine here it seems.  Please refactor to use the
dmaengine helper library that was recently contributed by Lars-Peter -
it should save a bunch of code and make rolling out dmaengine framework
improvements much easier.

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJPX87BAAoJEBus8iNuMP3dpwkP9iJY0S0nuj0+gLseIJCoju1j
lHQfSCN6U9SPHq6/fYRiuNdgM0YEfLzX38eBQEp1y8n/3x06RucgCetRvBbh8dM7
LOkZNaW9/39ZZGRB2E+QVEltcdNTWmkG+Q7qZH+jV9lDebWZPpTZ8EfAnqQY9vIU
E+Wu9a7D5lIfoPT3DxoEbaGo8xWI8xtjHcV5Ro6BlsfcVRWhUjPdBBw58l/47DA2
ZuVCA1Wl9pCEb0X/RFgSHFQCT+GQzBoxFRYUwrEPxsOT/Y+es/UlM56XTg39W3i4
U73/Lxw4GFxC2A92bUQk1FItgXpajJ/jBn55iCq3WDXKH0waKrlPxwJJr34yvWxC
f6Tj2x9/wG7SfwS+Z1rerXBlTUbigh+yWh67c6f3FCxi2NDfaZFoMtFT+dEhllpf
DZRACBamBVHjdwAPDy57eGs6QsvS5lzVIdDHBKFdjiqkkuCA8Yqthv/Z01rTCLSE
Y8DV9DQpErrcVZFksShy9JjxIbQQwsDYN3y6MjI121xapAcf8Syqf2uwO2Fnn/R7
ajYpzhRmn2TtH3SjrpNOiiaJDc4O4Nghyv+WtfumqcK8rWWAPQZVY4c8YFrb/6wy
0wqSahJYrvre/tEs0Q5pVuWwgPuVUMejT1B9+rQdahnbccws9M6Jh0Np/DptIzuF
a9lBgmtEziB4dsfqgkA=
=4gfA
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--

--===============7576268331985248019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7576268331985248019==--
