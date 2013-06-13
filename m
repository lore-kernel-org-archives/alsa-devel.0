From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.10
Date: Thu, 13 Jun 2013 10:51:30 +0100
Message-ID: <20130613095130.GX1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7032889964375664352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C5E2616FE
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 11:51:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7032889964375664352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KG+zyBxh8BrwB1om"
Content-Disposition: inline


--KG+zyBxh8BrwB1om
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

Takashi is travelling at the minute and it'd be good to get the
MAINTAINERS update in here merged so sending directly.

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

--KG+zyBxh8BrwB1om
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuZYfAAoJELSic+t+oim9X2UQAICONPfTOeDZxcW4LF8LGIbc
UZqFWsx4zM3okjIvcuwfxdZTk6wv80PVOMbiG/mE/47dkLz5lpZeBdaRn/TtbH8O
40wsqqqhuceUFiZWlkNITbs2HLRwX9Ge6TwQ01ZVGycwUHl31MeDdjr373hNy6/q
0O6eCG0fKqdGx/Gf2GnOtlG3l3wOwh8Ry/5YivFY1Uqtn5JoWrkjU0GnR+RYkShH
b6Ch6cTRHrZC5CC1aRpxMaPEcfHaOv5UwTwNftFwyubnZt2L/hkrWs7igPRRPUhh
c7qtMHi3L4UHSU3UuVT2M0d081I0b1HrRZ44owbFI8ML7oiSMzsgYmsn4tufGkc9
ni0hrIYz9CJwwbcmdzxaEiSGQsObSsaqU6/+Vos14YQxg49GbKdBHmQgZ0s8jSPk
RS4w3uvci9uGl0SMP8KJVjt65thZf/J1SNiqGgCBj/WNF0rpuXHPYcDQTxY6jzvA
EVbwl/V8uhSPp1lOV3W0vy+7M/hqlB5wxrg0Rpy5NOlSr2Ip24K474zw61dUXbse
A4cVIvmU5NaLQcgc2ltO9+7xDElxkdUjJsHC3sMagGxg+mOGtZ/GM3feBzlMzfIt
e5hOZf+oSeMRVRwk3MJ7V9Ez5Dj5K517mfIPxHj/vO0QNOsRWMe9gOrRg6dwdROF
c8hn/tI6UyK1dRhfofIP
=va2T
-----END PGP SIGNATURE-----

--KG+zyBxh8BrwB1om--

--===============7032889964375664352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7032889964375664352==--
