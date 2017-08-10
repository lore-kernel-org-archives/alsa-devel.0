From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] ASoC: codecs: msm8916-wcd-analog:
 get micbias voltage from dt
Date: Thu, 10 Aug 2017 16:24:37 +0100
Message-ID: <20170810152437.ezfhi7cukutyabmt@sirena.org.uk>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5297846276085897116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C81F92665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 17:24:50 +0200 (CEST)
In-Reply-To: <20170809164927.19663-3-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, damien.riegel@savoirfairelinux.com, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============5297846276085897116==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6ujwgqd7l5jrigt"
Content-Disposition: inline


--z6ujwgqd7l5jrigt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2017 at 06:49:24PM +0200, srinivas.kandagatla@linaro.org wrote:

> -	snd_soc_write(codec, CDC_A_MICB_1_VAL, MICB_1_VAL_MICB_OUT_VAL_V2P70V);
> -	/*
> -	 * Special headset needs MICBIAS as 2.7V so wait for
> -	 * 50 msec for the MICBIAS to reach 2.7 volts.
> -	 */
> -	msleep(50);
> +	if (wcd->micbias_mv)

We seem to have just completely lost this ramp time handling?

--z6ujwgqd7l5jrigt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMerQACgkQJNaLcl1U
h9ANWQf/eOKmZtDl7Ev0tgUwV5RB3Rr6CkkerQlA6J0agUEYjoUim6b0nL+xQSKf
IW2sncqldb51+d3owLVFbkiUc2U7incAShScipA0JKC0PNQ8pZfUlA7nnlnkYIp7
nmXy6+fS343zJ80kKpPflCdGBqXOKH6LgTgzavyBfbgaYLOAIAESimIwPaJZTc51
zREtM4+CpyzbLIoxRWR4npLoMXLiZREsxESrrFh1RQrkTMUrvaULlQ5kvbbMWb/G
8pey4nAka3rbsRPBAwvml2tSux6mKxD/nKOpSg70pD+zvpqAIPHJiz2PzEczR30/
iFCL8a3tTyDIHnNhcfujbNpoDeSBCg==
=uTOH
-----END PGP SIGNATURE-----

--z6ujwgqd7l5jrigt--

--===============5297846276085897116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5297846276085897116==--
