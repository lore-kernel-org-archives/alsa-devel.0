From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mop500_ab8500: Use card DAPM context
 to access widgets
Date: Sun, 12 Apr 2015 12:44:05 +0100
Message-ID: <20150412114405.GA6023@sirena.org.uk>
References: <1428750062-10614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8886864178258642670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71DBB26056A
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:44:13 +0200 (CEST)
In-Reply-To: <1428750062-10614-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8886864178258642670==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RoEURnPw8UqOewOr"
Content-Disposition: inline


--RoEURnPw8UqOewOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 01:01:02PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct will eventually be removed
> (replaced with the DAPM context from the component embedded inside the
> CODEC). Replace its usage with the card's DAPM context. The idea is that
> DAPM is hierarchical and with the card at the root it is possible to access
> widgets from other contexts through the card context.

Applied, thanks.

--RoEURnPw8UqOewOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlqFAAoJECTWi3JdVIfQlI4H/1j5fD8r0IcacrEASjo5rTE3
MFEmWVQSbZIRAsuxQP1rRuR7ATQEM88cHxxYbj34RJP7NYySPSVkvgv7Pu1I+Ksz
HCrJuqptZulsddAlIXw1U8i9RrAx6k372F4HF+/fK3X4Saymb4qAY04vBTKxwllO
GOdk8IA1M7cgWZoDPOcUyBuIgzbSvTCvHNz+XLKmPUnREJtMGCyIViXFTLTOVFaC
t3FM4RQAkkXxTGtxHHpKEzU+YTYS/gC6YDu0UM+p3yI+E958gtbf1C+Bvr+gwIUO
v/LB7Y6VQ1t4kwH5Ti67FCVL6E8Id/6rQhLpkwfhs7ZIy+J2rMcy+fEsf/YDpjQ=
=uVE/
-----END PGP SIGNATURE-----

--RoEURnPw8UqOewOr--

--===============8886864178258642670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8886864178258642670==--
