From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: Don't try to register debugfs
 entries if the parent does not exist
Date: Thu, 9 Apr 2015 12:24:44 +0100
Message-ID: <20150409112444.GV6023@sirena.org.uk>
References: <1428569558-15883-1-git-send-email-lars@metafoo.de>
 <1428569558-15883-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7352679217683813661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C6CF2606E7
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 13:24:53 +0200 (CEST)
In-Reply-To: <1428569558-15883-3-git-send-email-lars@metafoo.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7352679217683813661==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6lvd+yiLX1l9HjL3"
Content-Disposition: inline


--6lvd+yiLX1l9HjL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 10:52:38AM +0200, Lars-Peter Clausen wrote:
> If the registration of a debugfs directory fails this is treated as a
> non-fatal error in ASoC and operation continues as normal. This means we
> need to be careful and check if the parent debugfs directory exists if we
> try to register a debugfs file or sub-directory. Otherwise we might end up
> passing NULL for the parent and the file or directory will be registered in
> the top-level debugfs directory.

Hrm, right.  On the one hand just silently ignoring the knock on errors
feels icky on the other hand it's probably better to do something like
this providing the earlier errors got reported (and were actually
earlier, I can see us reordering things and causing further problems
later on).

--6lvd+yiLX1l9HjL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJmF7AAoJECTWi3JdVIfQpUcH/2snrXSRIzDNUggylnqS6CMP
l8coKNtq1n65pcmW3dTT2QinpPH/UuCzR8vDBoB4luVbrB4rNOAcLJhMjjlKA/d9
L4otqT9CC7J3nlgoM+gkyjeOl64IgSS0zt1n3wd9DkVg92mSTxu34Iu3XidMpHI/
lX27hkIKolo8mvmXFKcN32azS6Vco9pUVSk47hzj9qaYrwvAMmxrZ4zf2v0foKAk
6JPzodxutgYbqfS31zxHThScIDPwhnUYPhwXHfHCvmjKwJZdKEmwHKI0XTiDM1zP
KrHl6U3lz5tAgS2evTXU6Qs1EtSy3DUzbNkcuYygOCkF9uC4P4tFiKKJeH1y83k=
=0NMw
-----END PGP SIGNATURE-----

--6lvd+yiLX1l9HjL3--

--===============7352679217683813661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7352679217683813661==--
