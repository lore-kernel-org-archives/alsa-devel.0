From: Mark Brown <broonie@kernel.org>
Subject: ASoC fix for v3.19
Date: Thu, 5 Feb 2015 20:24:06 +0000
Message-ID: <20150205202406.GQ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4248927352595878175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C8E26052B
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 21:24:11 +0100 (CET)
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


--===============4248927352595878175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C0pYgGMKibsb9PEb"
Content-Disposition: inline


--C0pYgGMKibsb9PEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 97fa99a3b8aa83c8ff17ef380dd377efac373812:

  MAINTAINERS: ASoC: add maintainer for Intel BDW/HSW ASoC driver (2015-02-02 12:00:20 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-intel-v3.19-rc7

for you to fetch changes up to 5c2b06369dafd796ebb4f17dab543d3da500245e:

  ASoC: Intel: fix sst firmware path for cht-bsw-rt5672 (2015-02-05 20:16:21 +0000)

----------------------------------------------------------------
ASoC: Fix for Intel firmware name

Another one liner that arrived after the earlier pull request.  There's
a trivial conflict with my -next branch, I'll send a pull request with
that resolution and some other new stuff before Monday.

----------------------------------------------------------------
Kevin Strasser (1):
      ASoC: Intel: fix sst firmware path for cht-bsw-rt5672

 sound/soc/intel/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--C0pYgGMKibsb9PEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU09FlAAoJECTWi3JdVIfQr5IH/AhRv5+AjjFNnhjRGFIat7WJ
C7JtOndnXtLhENAQMVV/kBXFhecBrP8BTnlzphTTI112yoQNCs2ivBH+VN3aT3MB
au3DKvZtRK2EA4NZbCjnD7rLGXqraDPuhAHQ22ZyY3g5mzkaEdb/n7wOSVhKf/Pc
Ws3x/5r69dUeOb3+7+OoRqKRfL9/jafHh9z6Bjs8qg9Ee1h8fVVgGsss/PNMF5dz
NM84+l3B6EeAOZHL0iPCuDRl5GAQ20vjqFHGD8kAzNtBz0F6qIqRegrxX6r/GqfE
Uc7Buo4I2tM1dAwFhbbQYHDh3n29IyiX4Bzl+7j8hjX7aWd/STfledgtY8eCegc=
=r9bI
-----END PGP SIGNATURE-----

--C0pYgGMKibsb9PEb--

--===============4248927352595878175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4248927352595878175==--
