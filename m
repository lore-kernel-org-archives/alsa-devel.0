From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: max9867: Use continuous sample
	rate
Date: Thu, 1 Mar 2018 18:22:02 +0000
Message-ID: <20180301182202.GH12864@sirena.org.uk>
References: <20180301141843.GB30722@lenoch>
 <20180301142216.GH30722@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1652032816630119552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F0132672B9
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:22:03 +0100 (CET)
In-Reply-To: <20180301142216.GH30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============1652032816630119552==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 03:22:16PM +0100, Ladislav Michl wrote:

>  what is exact meaning of SNDRV_PCM_RATE_CONTINUOUS? What if codec is
>  able to set "any" rate, but there are rounding errors?
>  Shall we pick exact matches based on master clock frequency?
>  Few other drivers are also setting SNDRV_PCM_RATE_CONTINUOUS, but
>  certainly cannot set any rate exactly.

It means being able to set any rate exactly.  Many devices have hardware
which is only specified to work at specific rates but some are more
flexible.  Devices don't need to be able to do this independently, you
can have a flexible external clock tree for example.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYRMkACgkQJNaLcl1U
h9Bb5gf/UaELG0m9h6vM0UB6BdrHkZ9miq9dYUCDXTsGlxBWT9cKb4A6LCl5aqIt
6axTMfFdmPlrwNWaR3wZBsuwyy9XEWKWVEaXzz7dS2EUS0Knj67jARfg6RoeMfdm
bSxtyrAz0qP+EYBkR53P9pO2DVbgBiw4J5gH/C4B2PSTNzE9N1f43ssYDd5v7CaX
MuDwVPLjWZPC4I9Uc57VfW30Vx3PNVGr/iWwRl1Pp3lBrhuh5HzRcDGQ+VDZLTvI
Ebp07kCJZlEodrOHA8LfRkBQqWzqe7yHEGalW97Z7ILMvdrYWYe09J6E+506tuiN
G/0udkuxYPCNKUwHRMBHNhS+lIWEPg==
=IZmn
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============1652032816630119552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1652032816630119552==--
