From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l51: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:20:50 +0000
Message-ID: <20141121182050.GH3815@sirena.org.uk>
References: <1416513940-28717-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6077176251014855176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B3BA265EBA
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:22:23 +0100 (CET)
In-Reply-To: <1416513940-28717-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============6077176251014855176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LutunelG9JiG2YKy"
Content-Disposition: inline


--LutunelG9JiG2YKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:05:38PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--LutunelG9JiG2YKy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4KCAAoJECTWi3JdVIfQzT4H/A8zvM+pPkYgmZRXlvmPwbeC
uJrm+FaIsERw+zubt2j+wFMkgMw8VmdqFQbL8egPrTL9OxIg/FQVStajmtbTtTM+
YjzYwb2+ywnGlWKbg4GENN6ZpgdwkH9wi5Mt/Z8xd48ShErXc3TmgKcdyNVjsfTW
+jFLhF7umXk7YUke7QMbZjmfO1N7WoqqdbWQFstOiaUHU4av2HYNEKj2YBZJcYQE
DH5oF3uUFlCi9iLwfAftUeYOfBrwuLF3SBDsmWA3f/XlB/fWBnETdNu8n4I5Aocj
fbDFGKplBwVKBJIulOEx5hQby6SvCF4MrjumnkO0cSoJpgLCQgorujMu7j9DWNs=
=6BYH
-----END PGP SIGNATURE-----

--LutunelG9JiG2YKy--

--===============6077176251014855176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6077176251014855176==--
