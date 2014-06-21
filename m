From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: omap-pcm: Include omap-pcm.h
Date: Sat, 21 Jun 2014 21:00:02 +0100
Message-ID: <20140621200002.GL5099@sirena.org.uk>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2995642681625817097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11ABC261B0A
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:00:13 +0200 (CEST)
In-Reply-To: <1403163631-26215-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2995642681625817097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f/xF554QgVeCF3mQ"
Content-Disposition: inline


--f/xF554QgVeCF3mQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:40:29AM +0200, Lars-Peter Clausen wrote:
> omap_pcm_platform_register() is declared in omap-pcm.h and defined in
> omap-pcm.c. To make sure that the function signature matches for both omap-pcm.c
> should include omap-pcm.h

Applied, thanks.

--f/xF554QgVeCF3mQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeQ+AAoJELSic+t+oim9kO4P/3s0zoPjTdtf52riRCOTaRHa
cIO0bqSKZR3bvgL2T3d2O/ZSD5aGpT7Rep3XiLZP0ddu5vh1qjVxgL5J5J9b0RnT
HYD9FfXiR8Crpax5Mpw8XWOVo3uPtS7+SBl4uHH+hrV6hz+0oeiBEmKqejkvyJ1a
Ppaziz7GKM3/AfUocSBrqsBfKFWSmf3kVsdTFEvFVG4s4TJWyIXlvSAlKdic7D0c
ufWrOq0OnSwRP/PY5OdYkFz5LtpGG8P4eMZbNnGhNi2ENtVCsoAODhShufkfCpL4
2LCxY9HKr1U+Mko4sMxbWIPgQexFqnrqPwRr8xFK1LLLY96TpX2BPKlQ+rCsxAnE
QK3CNl5QmEBr54FGNEVXcFZOoCl3zfB/6H9csWOjepVAtsD7bl7bEeTif5nSyN6v
J4X1eyYzYpCM/pNRnCP12Biluxm4SOFuhYaOLG3FGVx8EX64B8y7+3vS0vKC1/My
8/8+kpPsxNLtp1Z1zccR4FmyHfAiKv2gKqANFWwxYeIXBZYyzh5R1Q2Ur+GfpiL2
9jOfFw5ko72RNHfw7bwj4w5wKHn3eGTajdUNNy8wtjI/cYA96bJkL5aTyfpfebAu
abqBxH5JkNZCAr1U36rbUcxlSuECyZ9pqzcJylM7gM/fT9qo36IimsMex60kzM0y
3ugh7xn1+gk6TRZWFcmc
=iTqX
-----END PGP SIGNATURE-----

--f/xF554QgVeCF3mQ--

--===============2995642681625817097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2995642681625817097==--
