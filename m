From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/31] ASoC: max98095: Use WARN_ON()
	instead of BUG_ON()
Date: Wed, 6 Nov 2013 10:17:58 +0000
Message-ID: <20131106101758.GJ11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7506894292925678516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F185E261737
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:18:00 +0100 (CET)
In-Reply-To: <1383673218-18405-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7506894292925678516==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:50PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().

That doesn't really follow, they print out an obvious error message and
force people to pay attention to it.  Sometimes that's the desired
effect.

Anyway, applied.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehdTAAoJELSic+t+oim95e8P/iq7eOoZ15/dU4cnjXajjRbp
+GKwjExcCcqRITH0SICiGqLyRbfcnGMkLsx14BJDxj0ztEjprXxtH3YNGasLjMlm
pKFJ2bJzOxLurHb0qds9F7fdUp8mUIfdDkqEDCQciWvEXcxpk4mocnklcANxPlPE
wsz/rOKnSviAZpiM5foktx5ixopUKyPJUguzlQmu5eerVy34u9seo9gIkWIlly7L
w1YYZSFKj8cYO62HHzi2SXnMcV24grUnzmwwdiJUb6fOlruyZWVtmRVeWLbD8AHC
HCTwK8B3JXGiaVZTYFaFy/5niNICNYtc7TnHyimpaXiL48CSMo4rdfIYWlVJj5Cp
VHiRrkuDIS6Iqi6IXuWiRm2M8stZhPyxUCu1i8Wi9pJYvXLlxWlop4xDrWXnutTE
tXP0Yr9ShNpZqeMLXMWcgR0puHtbJwPSdssOFJfPdmMERN0v+viqPbQ7yvQpeF6F
JVCqT52utNwXoDXkHIciSy0dzq2lZsOtCxVQQQkAMxgN0qFTWdvZ/cO4JkHS+ZEj
SLMet/7XI3Mbcr9NpRyw/JL4lMXTht6vvREWj8H2/TgFqcg2P1xrbUiLH490JXv3
dPjEwRFE+HEgil1g8+EPFPxZ+4okgjjS1BOewPGrZcWgUYjGO6qJeGABi99dph9z
9sXNmjScx+q2Po/wr1CE
=jKW2
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--

--===============7506894292925678516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7506894292925678516==--
