From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 3/4] ASoC: bcm2835: Support additional
	samplerates up to 384kHz
Date: Wed, 08 Nov 2017 12:26:01 -0800
Message-ID: <87h8u4bjqe.fsf@anholt.net>
References: <20171108200332.28949-1-hias@horus.com>
 <20171108200332.28949-4-hias@horus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8023657824343806782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7F4266EDF
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 21:26:06 +0100 (CET)
In-Reply-To: <20171108200332.28949-4-hias@horus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============8023657824343806782==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Matthias Reichl <hias@horus.com> writes:

> Sample rates are only restricted by the capabilities of the
> clock driver, so use SNDRV_PCM_RATE_CONTINUOUS instead of
> SNDRV_PCM_RATE_8000_192000.
>
> Tests (eg with pcm5122) have shown that bcm2835 works fine
> in 384kHz/32bit stereo mode, so change the maximum allowed
> rate from 192kHz to 384kHz.

The docs I've got say the maximum PCM clock freq is 25Mhz, so if my math
is right then 384kHz should be fine.  This patch is:

Reviewed-by: Eric Anholt <eric@anholt.net>

(There's a note about needing to be careful that the mash filter doesn't
give you frequencies over 25mhz, but we should be doing limits like that
in the clock driver)

I'm going to give the alsa folks a chance to look at the modes patches
first, since I know they've got strong opinions about them and I don't
at all.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAloDaFkACgkQtdYpNtH8
nuhmNA/+NWP6lgO8VPHOvaV7H27NNSRFF1HmmPYRHf3J6T0IWiJFtQXAqfKvVvBj
AqQJDM1mzIIvSk8/UT4AtxXg39cE33mmA1Lh1lkCtUg+YEuAkPtujZIbAU3c6uE3
J8Hw9jdBAsclWxVAzU5+Vs3Zj3r5muICwaId9TaywKkwGe9vqZg+U3YZjLDjC6Z4
5vyjAgiI/vAjihyz4GX3/2oK8vgrfTRSyuaJK9VUv8o+1j+jx68Uv+FiEjWXQVv4
EOS9kjiJhRGMPgNU2TWUxpf6NSfJd1NcZvBgW/H3oi7MqUQxvPnwJsPCxcvNixUo
1QolsYwZmxucKFVoLzL6v0Rr6u1QD6L+hSDbAg75ugRxNsrYETT+cA7A3LT/gJaA
Q8c16W2HAuta3NRh0DrvG1crahty1epG+E9UWfQpWlkNo5qzo0aHfTlWKa7vaOjD
Bs8Wf3veAlgnPfT9EYAIzbnPEG//AUxSu5rxb6O/wrnjP3gv/60gTa6AuXlHQT0F
HJSyB+TcJL67OoigDfsnhEcPyASc7lv3Iw8lM/eBCK7TZ3KAyjAQg2AfOtHOQ3G1
r+QMWjB35GS/5gmnj7qDvxD4CZCUg8NQJXacqAJ6GWyylXGKHbUdNxJm0O7Hlkbw
vbry37Qv2OUQ5hgWry1edtdYP7fwptSpWziZ76qyt8SBoYbBD7w=
=kRP1
-----END PGP SIGNATURE-----
--=-=-=--

--===============8023657824343806782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8023657824343806782==--
