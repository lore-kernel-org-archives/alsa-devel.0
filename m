From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: max98095: Replace w->codec
 snd_soc_dapm_to_codec(w->dapm)
Date: Fri, 21 Nov 2014 18:17:29 +0000
Message-ID: <20141121181729.GE3815@sirena.org.uk>
References: <1416514915-29836-1-git-send-email-lars@metafoo.de>
 <1416514915-29836-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7934368078808749186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ABDD265D9E
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:18:58 +0100 (CET)
In-Reply-To: <1416514915-29836-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7934368078808749186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j60k8TkprPtporUA"
Content-Disposition: inline


--j60k8TkprPtporUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2014 at 09:21:55PM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--j60k8TkprPtporUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4G4AAoJECTWi3JdVIfQhRkH/3GkSIa0pM5pAhXab1JOVV1t
dYK3asKr2lLhM579zFQ4Ns1M2RtvU/JvWRBZaYhoWl68hIM8zSDAeiMsjg5loTY3
WH4mGVjk4XiUBW1dNqARjCw/dEqXzp2lduWW1Bs9Qmhqa/U07FCZHrdO0h4LL2R7
+rUmlsaogzxrDJbeWNAJkg/3+/INecFUAgbqu4xeOeVPuM/YVd07U03e9oFWvfgU
1U4lhT7o6YocHhQN85Rw3/UVbd23+H95UfwabjAAcCkyLMXGxUrVee2Qp5/flzVJ
LWEllPmTEHoQJe6dF9BpCwZ2xthgXnH2WCqNK9iQ3GztjWxPAjFh+YkNzUNqW0U=
=Y7ta
-----END PGP SIGNATURE-----

--j60k8TkprPtporUA--

--===============7934368078808749186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7934368078808749186==--
