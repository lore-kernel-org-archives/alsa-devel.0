From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.14
Date: Thu, 27 Feb 2014 10:07:16 +0900
Message-ID: <20140227010716.GA9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6023881933418736818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 789E32657AD
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 02:07:21 +0100 (CET)
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


--===============6023881933418736818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 895be5b31e5175bef575008aadb4f0a27b850daa:

  Merge remote-tracking branch 'asoc/fix/wm8993' into asoc-linus (2014-02-19 13:13:58 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-rc4

for you to fetch changes up to 57374bb491facf716c172126b7e9b99c9e3f8b45:

  Merge remote-tracking branches 'asoc/fix/sta32x', 'asoc/fix/wm8400', 'asoc/fix/wm8770', 'asoc/fix/wm8900' and 'asoc/fix/wm8994' into asoc-linus (2014-02-23 12:20:34 +0900)

Getting a bit large but they're all actual bug fixes unfortunately.

----------------------------------------------------------------

ASoC: Fixes for v3.14

A somewhat large set of fixes here due to the identification of some
systematic problems with hard to use APIs in the subsystem.  Takashi did
a lot of work to address the enumeration API which uncovered a number of
off by one bugs caused by confusing APIs while Charles addressed issues
in the locking around DAPM.

----------------------------------------------------------------
Charles Keepax (3):
      ASoC: dapm: Correct regulator bypass error messages
      Input - arizona-haptics: Fix double lock of dapm_mutex
      ASoC: dapm: Add locking to snd_soc_dapm_xxxx_pin functions

Lars-Peter Clausen (1):
      ASoC: sta32x: Fix cache sync

Mark Brown (4):
      Merge tag 'asoc-v3.14-rc3' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/ad1980' and 'asoc/fix/isabelle' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/sta32x', 'asoc/fix/wm8400', 'asoc/fix/wm8770', 'asoc/fix/wm8900' and 'asoc/fix/wm8994' into asoc-linus

Takashi Iwai (7):
      ASoC: sta32x: Fix array access overflow
      ASoC: wm8770: Fix wrong number of enum items
      ASoC: wm8900: Fix the wrong number of enum items
      ASoC: wm8994: Fix the wrong number of enum items
      ASoC: ad1980: Fix wrong number of items for capture source
      ASoC: isabelle: Fix the wrong number of items in enum ctls
      ASoC: wm8400: Fix the wrong number of enum items

 drivers/extcon/extcon-arizona.c      |  12 ---
 drivers/input/misc/arizona-haptics.c |  19 -----
 include/sound/soc-dapm.h             |   8 ++
 sound/soc/codecs/ad1980.c            |   4 +-
 sound/soc/codecs/isabelle.c          |  52 +++++++------
 sound/soc/codecs/sta32x.c            |  74 +++++++++----------
 sound/soc/codecs/wm8400.c            |  34 +++++----
 sound/soc/codecs/wm8770.c            |   4 +-
 sound/soc/codecs/wm8900.c            |  44 +++++------
 sound/soc/codecs/wm8994.c            | 135 ++++++++++++++++++----------------
 sound/soc/soc-dapm.c                 | 139 +++++++++++++++++++++++++++++++----
 11 files changed, 317 insertions(+), 208 deletions(-)

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDo+8AAoJELSic+t+oim9MWQP/0GnrmpXLjXw8T+7Szh0+CwP
05sZLHL6+mi9vq7CqZKVOUX1K2aGutsEaTKK9oKWJowlTI4rrn2uqoe/4UFx5lc8
IFGlY3kz9TxZSUZhRc/XHURpUIvVIITZhyJkeaobRd87IUWKKWUJgT5cVhGUz6Qj
6OssYEpFEwQ0V6eHvrMfv3OKM7l9k6EoX6hK0zGSuDffUtGT+cS8Dgy3t0EY7enB
OaHxS09E2yOnkzycQGZ5Vv8NriKtcwUSsCqhOXEnwQRdVbwSqu5c6c99L3mWxR5y
94NlmTzG8Ty4X2432oMW8jdEfwgRHzPdrpkZLxr+bAg/zRiWBQ3nvND4DEV56ohn
mejP0dGwkafCCO//5UDAb1SwQju0wiOPSTabBe7DatFRjGTnV1jANuUlIM033/tY
ricL+h9Yv3ilnBwEJgFXeiXt6GCyXdlrQ4okbBO2YKSsbCzHF69Zl//dLzPju8aD
nMnJeJUm1fxE289v5fp9W2MyIxqjlsHp44f9cmk2XLO1jOK7tCPKJrfiyIfaqfr7
8sjATREa0Idd/ftUtZTSAhzNFmwudC9QZl3pw30iQftZhGL3ysi/YaLUqKQ/X4ll
pKCrPYakjC5S/ScnnNdaVC3PRybqmL4dRdgO/FT0YxPKC5o9r5Sry87CdiYiYpvO
Jqezr6Uv+kac2W1lEz4Y
=pmlp
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============6023881933418736818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6023881933418736818==--
