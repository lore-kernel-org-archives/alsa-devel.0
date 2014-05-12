From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] ASoC: Revert "ASoC: dapm: Fix
 double prefix addition"
Date: Mon, 12 May 2014 21:35:35 +0100
Message-ID: <20140512203535.GJ12304@sirena.org.uk>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9080641883784460332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D977A2650FE
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:35:50 +0200 (CEST)
In-Reply-To: <1399472428-11034-2-git-send-email-lars@metafoo.de>
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9080641883784460332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HjuipH1ANCbUVM1T"
Content-Disposition: inline


--HjuipH1ANCbUVM1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2014 at 04:20:25PM +0200, Lars-Peter Clausen wrote:
> This reverts commit bd23c5b661858446267f4d6b2fb4edd8eb710dda.
>=20
> The patch claims that the patch is necessary to avoid double prefix addit=
ion
> when calling snd_soc_dapm_add_route() from snd_soc_dapm_connect_dai_link_=
widgets().

Applied, thanks.  Please take care over the word wrapping in your commit
logs - they're bumping right at the 80 column limit usually.

--HjuipH1ANCbUVM1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTCUAAoJELSic+t+oim9SO4P/3Kbp0r9rmVZLAiszZ3oIJge
xacmEcLZaBTJS9OzEcI5snMtVzQ7CHHhDtZlMwaeNObx5CCEhwuDH0uVNe7YnCod
qRdeSyPhX6MliTgXn4UJzk05gRNGu7oRRcfWg57WD95mpxwcx6H7z4xN5YCuTiYy
mt1KQmDhlkBq6x3lhILDx4BcE9NtEmbEWKiyWf0qRlT+aelbgph5XVOr/jFP2+Nk
pQkERCF8HqBjNaadXJiYYsoaCJ1O5jOBq3f346TTBRnWWkRDrYzd5R9hFUo3YsW7
avE5zlezeljaCe+t/KZAGMoWvwywZ5LUW/nVlNFqx5bFYvpz+j4zXRVfEMhE3Ewy
3tUyjmTRC4Lur+VNGF++O3Ay4HOSkPV49fo2yrfKb6JzPxFerau7yQ59tB3tu4wi
bgNCVJpB9fB4KRR3AutGcDGhvsaJeE0W6O/TVDrJ6wTNKmpkgKR4y5HtKgji6BGZ
ZP6emH+GE/LdR7RPozVjveEd7Ce6KiLRuUTUuLI8StmZMTv//5PWe880Q9C7IEcI
XvMK2FG/ylLfblZRau7RwHQ3lha2Q7oRdw+2o0PsHkFB7u21+quu0DET8V+Nf1ie
F2gAgt9hrDoOazYSF8BHtME/EFA4KkvB8c4gk4DCIPSAJInMlYsuN9q9uoNdfxqf
raPOw5SUDkZqEtNFl2d4
=2KKl
-----END PGP SIGNATURE-----

--HjuipH1ANCbUVM1T--

--===============9080641883784460332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9080641883784460332==--
