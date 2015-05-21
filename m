From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mop500_ab8500: Add a NULL pointer
 check in mop500_ab8500_machine_init()
Date: Thu, 21 May 2015 12:05:55 +0100
Message-ID: <20150521110555.GY21577@sirena.org.uk>
References: <1432097454-3643-1-git-send-email-rajan.vaja@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8850962487526770940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 287142658DF
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 13:06:09 +0200 (CEST)
In-Reply-To: <1432097454-3643-1-git-send-email-rajan.vaja@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajan Vaja <rajan.vaja@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8850962487526770940==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TuzloVs6SlI5NjIZ"
Content-Disposition: inline


--TuzloVs6SlI5NjIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2015 at 10:20:54AM +0530, Rajan Vaja wrote:
> Avoid possible crash (NULL pointer dereference) by making
> sure that dem_kzalloc() is successful.

Applied, thanks.

--TuzloVs6SlI5NjIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbwSAAoJECTWi3JdVIfQtvoH/1BDLHNKc/p0+xjguvlLAG0Z
X33kR5/a1Hfnu3Fa3FTVNbCgG0SwdY/vT+sJ9+a94D9nDmhJ6PEnVbo/xJ2faJuk
PFvR9TJI9mXm7sXXuAaysIr8HISqFWiJrFBBukttwXxAigFWrUJlgIKgt4VhAnv0
a3v12oS48E5lttm8veRZE94WezpPj+b7DPwO1+x6OW+ATd/54qQT7dGVnDGUFnfB
989o6+PNIXHtSC7S1oVE50VDJKtVCWnjn0DU7RWx/H+Bsme30UfBrNls7xXjhrKf
sG+y0o0V8L5aKPGgYl0YLMpdrS7YL5cHS5Na/aUzxOahM/sztkz37y8JdOvKRIc=
=Fnj3
-----END PGP SIGNATURE-----

--TuzloVs6SlI5NjIZ--

--===============8850962487526770940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8850962487526770940==--
