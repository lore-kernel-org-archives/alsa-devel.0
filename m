From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.10
Date: Mon, 10 Jun 2013 11:16:44 +0100
Message-ID: <20130610101644.GQ31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5526165351266310777=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE022610A9
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 12:16:55 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5526165351266310777==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="flwEn+rJTNXV1z6v"
Content-Disposition: inline


--flwEn+rJTNXV1z6v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.10-rc5

for you to fetch changes up to 902a75cdc491066514aac35b40a756aaa9740173:

  Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus (2013-06-1=
0 10:28:51 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.10

As well as the usual driver specifics we've got a couple of core fixes
here, one fixing capabilities for unidirectional streams and the other
fixing suspend while audio streams are active.  The suspend fix is a
little involved but mostly as a result of removing some special casing
that was doing the wrong thing.

----------------------------------------------------------------
Andreas Irest=E5l (1):
      ASoC: tlv320aic3x: Remove deadlock from snd_soc_dapm_put_volsw_aic3x()

Charles Keepax (1):
      ASoC: arizona: Correct AEC loopback enable

Mark Brown (11):
      ASoC: wm8994: Avoid leaking pm_runtime reference on removed jack race
      ASoC: wm8994: Ensure microphone detection state is reset on removal
      MAINTAINERS: Remove myself from Wolfson maintainers
      ASoC: pcm: Require both CODEC and CPU support when declaring stream c=
aps
      ASoC: dapm: Treat DAI widgets like AIF widgets for power
      Merge remote-tracking branch 'asoc/fix/arizona' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/cs42l52' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/maintainers' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/tlv320aic3x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus

Nicolas Schichan (2):
      ASoC: cs42l52: use correct PCM mixer TLV dB scale to match datasheet.
      ASoC: cs42l52: fix hp_gain_enum shift value.

 MAINTAINERS                    |    3 +--
 include/sound/soc-dapm.h       |    3 ++-
 sound/soc/codecs/cs42l52.c     |    6 +++--
 sound/soc/codecs/tlv320aic3x.c |   10 ++++----
 sound/soc/codecs/wm5102.c      |    3 ++-
 sound/soc/codecs/wm5110.c      |    3 ++-
 sound/soc/codecs/wm8994.c      |    3 ++-
 sound/soc/soc-dapm.c           |   49 +++++++++++++++++++++---------------=
----
 sound/soc/soc-pcm.c            |   13 ++++++++---
 9 files changed, 54 insertions(+), 39 deletions(-)

--flwEn+rJTNXV1z6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtaeJAAoJELSic+t+oim9klEP/jFuEqzA+QgK8xffSd9Xbdfo
RNR68nG3aBQFKZYdBklDgDjm9rApds9oFeIYGcyJBFgS1H6yuPfGRF1WZir1p26w
DKH/fbSgmhL4INiGubsdzodC0ryWeQgNwXlpzuqxzl/nOjVOMU7cCSaUn5Fl9/F1
hiGuqOAhAETPGeZbKL04Ms18GlWh2SWkiyxp6BIvVheteVdUTIAAyteQjdK2oYNY
wuh8wEH7/KntBvKgLfs0OIt9srtHU4y7YRib0flYTkACgRTMgHaZ3Hu+VtYgPHK2
U5+BhLIj4lWF0Slvt/xTsV4Li7MSvkSDg6g4CvNePxhRlN1Js8raq3Pwrw8dlU4k
iWDF+rAMkxnh5TcYo+MW9QEbInYBB7CDs0KgkYx10XX3u29C1HpJds8KYtJGwk8L
EEMII5Hy1tMT1bgrfLwd61B1lQxWmLzOlIFHaqpdPL3bggtFzNRVFBoB8ISYaQlH
Lakxuoo8Eo5HluOLuxz10AxxKmYLnzSnPlCbJ8csvipVKNFY4FsN2us63/6/lBfe
ZvGR571uBbXKCR2nM+ZT7vXyVu73MmCPunzu5GzU65Zt29PJDYUpZG4L60jjAltp
xSD6//9SqTMU/DpwWHEbS1EuTzP7F1J2yAyQzsdtA6/StaUM2hh4uc8Rab7BD1J4
Y3wS+fG5XocwFGLaCwrD
=HKrN
-----END PGP SIGNATURE-----

--flwEn+rJTNXV1z6v--

--===============5526165351266310777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5526165351266310777==--
