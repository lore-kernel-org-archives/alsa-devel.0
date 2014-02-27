From: Mark Brown <broonie@kernel.org>
Subject: [GIT PUL] ASoC updates for v3.14
Date: Thu, 27 Feb 2014 20:44:21 +0900
Message-ID: <20140227114421.GZ9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2333220346260858151=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8882261AED
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 12:44:30 +0100 (CET)
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


--===============2333220346260858151==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y46NoIcKQuicSz3X"
Content-Disposition: inline


--Y46NoIcKQuicSz3X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 57374bb491facf716c172126b7e9b99c9e3f8b45:

  Merge remote-tracking branches 'asoc/fix/sta32x', 'asoc/fix/wm8400', 'asoc/fix/wm8770', 'asoc/fix/wm8900' and 'asoc/fix/wm8994' into asoc-linus (2014-02-23 12:20:34 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-rc4-2

for you to fetch changes up to 23308e88201c2c0036da23450f7fed6fd64ae1ef:

  Merge remote-tracking branch 'asoc/fix/wm8958' into asoc-linus (2014-02-27 20:26:10 +0900)

----------------------------------------------------------------

ASoC: Updates for v3.14

A few more driver specific bug fixes, all driver specific things that
only affect users of those devices.

----------------------------------------------------------------
Lars-Peter Clausen (1):
      ASoC: wm8958-dsp: Fix firmware block loading

Mark Brown (5):
      ASoC: da732x: Mark DC offset control registers volatile
      Merge tag 'asoc-v3.14-rc3' into asoc-linus
      Merge tag 'asoc-v3.14-rc4' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/da732x' and 'asoc/fix/sta32x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8958' into asoc-linus

Takashi Iwai (1):
      ASoC: sta32x: Fix wrong enum for limiter2 release rate

 sound/soc/codecs/da732x.c      | 12 ++++++++++++
 sound/soc/codecs/sta32x.c      |  2 +-
 sound/soc/codecs/wm8958-dsp2.c |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

--Y46NoIcKQuicSz3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDyUSAAoJELSic+t+oim9zQQP/AmOQzo+Q6LvszgTLBBnjSwx
C4o4rrnx5Nzfv09ckjLAxLyRVJyo/LaAbwvZIulIQHN0xGA1EcJM12+15CrlkE01
QPgSd5dPfECRebijp3yT9+NejEdIp3pwGO9qfe8vbhi+y18kMzbUINrdAeOXCkDN
USTAegotr9CeJoDDrKSAdBGIDHM1Bn5cOrcKFeib170s89o7GDrJm9KuTJHDSGqr
nP8GzRyx+5l4L7JITFtpQws8h7qsurVX/OPmMobp3qa7NBQAyIDcioZpxOM1jrkW
JE9t6ff1Pd6//utRC6Jwgr/B0gCDeic/HPKsucBkConXqruzpQ6PuPcfOU1ulGNe
017mJ60tUcBLuEW/t9asfNb8dpoqwf6ZsS4e7xH6OFPBBYd01Z0fPB2X9YApZFrm
dXYkg9UjEfNaEm5ZQ5xL9mDLsy1OPluFi2hb1LnzoTANjrZU49i9Sb11TSfsiVGT
79bLA5p3B2hIye9J675RxlJ0JJQf2B1Cu56aOvM4Jl7NcVvmt8Y9DRpzok1nGdIY
NCkLBiqS/hlu49MiHs7ILJN84T6CTtlhsk005D7xJtu+htVOPg3OOsg9ial9kQad
E1SkQ9+UGDYM9+M8d+eduDm8fqcMR30KXyqRCRwb0v4GFlG+p2EXNs+vajybiw3T
cv5V3D8h8Gi2Miy3Kpvq
=7TH5
-----END PGP SIGNATURE-----

--Y46NoIcKQuicSz3X--

--===============2333220346260858151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2333220346260858151==--
