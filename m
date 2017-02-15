From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4] ASoC: bcm2835: Add 8 channel
	(multitrack) capability
Date: Wed, 15 Feb 2017 11:26:56 -0800
Message-ID: <87a89ns1a7.fsf@eliezer.anholt.net>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2389056366711622140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A36265142
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 20:27:00 +0100 (CET)
In-Reply-To: <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, florian.meier@koalo.de, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, swarren@wwwdotorg.org, lee@kernel.org, phil@raspberrypi.org, ckeepax@opensource.wolfsonmicro.com
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

--===============2389056366711622140==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Matt Flax <flatmax@flatmax.org> writes:

> This patch adds multitrack capability if in DSP mode A and the
> codec is master.
>
> In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
> channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and SND_SOC_DAIFMT_DSP_A
> are set. Otherwise, channels are set to 2. These settings are
> accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.
>
> In bcm2835_i2s_shutdown the channels are set to 2 by default.
>
> In bcm2835_i2s_hw_params, DSP mode A format is now an option.
> Before replicating the format variable (from ch2 to ch1) for
> register loading, requested channels are checked to be either 2 or 8.
> This can be expanded later to accomodate other channel counts if
> supported by the sound card hardware.
>
> Signed-off-by: Matt Flax <flatmax@flatmax.org>

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlikq4AACgkQtdYpNtH8
nuhU9RAAnLRU9QnMsVbmcH9OrkzfBZLIZQ8KpQLmSfSUGD9MlMsDIACBZPsGUUlQ
nrOeJNfcUmxwMUgaohllMJS7pBrDZvNvV7zRhkoUQ1GYokdZ1O/ztyg5gCdZGil7
YGyUKLMxjOGbHJOUTv7n5IesSjbHl0V/krbobrA2Kafv1AGKZz8NmNxqyB36Rpir
g3suNroePwCwB5a3AJaga8Jw7890gVDJPNuV47jnZzQDaXIX2kEU7HQeXzlSDozD
zm1V7Y3nY9FVHFXnha6qbpWrpIQSP+LLo7kIX6wDNxxIhvQwrL2xk033eLdetdG0
83B3y3kKGYhy66J+tqsF9gLZ15wOpoHilgU8fUOiRdFdVWin0Vyb42iiFe4/GuLi
xuUTs4AxuzUfPIEwAgu3kZzrF30GcJey+qelZqm2J3kwnlKUf91nx18Ob78HL7UN
PchhiAHkoYJIJHGpCvL/befTTFi+wWjQDqyKY3w4uqI1mQd5U7cdRJTGo8Hcep8j
SXDKJn2/JzCSEnhtgHLuKv/XLj9W2eAJ0si6gTd/u3lu5jcsWPliwXrKqVtQiAra
Ji8k5nHJb3rZPzD/QGF7YwL/dLmYPo09pNJhXDLNunI8LqJAfcoUci1MZ2Wa9ykL
M6NyAGWS+2rR1gJM/0x/KC3NsBjy5Avk7HQnSZnp5QPN07Yt3cQ=
=7sLc
-----END PGP SIGNATURE-----
--=-=-=--

--===============2389056366711622140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2389056366711622140==--
