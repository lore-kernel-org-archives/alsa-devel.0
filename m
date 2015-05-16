From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.1
Date: Sat, 16 May 2015 13:30:22 +0100
Message-ID: <20150516123022.GB1964@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5617093332972370971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D39B526084B
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 14:30:34 +0200 (CEST)
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


--===============5617093332972370971==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.1-rc3

for you to fetch changes up to 7730c0b55043f6ff1c27e9cb45e13679995b2361:

  Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/mc13783', 'asoc/fix/uda1380', 'asoc/fix/wm8960' and 'asoc/fix/wm8994' into asoc-linus (2015-05-12 20:31:33 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.1

A few more fixes for v4.1, some driver fixes plus one core fix which
fixes registration of DAI links when adding prefixes to CODECs to
deuplicate in multi-CODEC systems.

----------------------------------------------------------------
Axel Lin (2):
      ASoC: mc13783: Fix wrong mask value used in mc13xxx_reg_rmw() calls
      ASoC: rt5645: Fix mask for setting RT5645_DMIC_2_DP_GPIO12 bit

Fang, Yang A (1):
      ASoC: rt5645: Add ACPI match ID

Koro Chen (1):
      ASoC: dapm: Modify widget stream name according to prefix

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/davinci', 'asoc/fix/mc13783', 'asoc/fix/uda1380', 'asoc/fix/wm8960' and 'asoc/fix/wm8994' into asoc-linus

Peter Ujfalusi (1):
      ASoC: davinci-mcasp: Correct pm status check in suspend callback

Vasily Khoruzhick (1):
      ASoC: uda1380: Avoid accessing i2c bus when codec is disabled

Zidan Wang (2):
      ASoC: wm8960: fix "RINPUT3" audio route error
      ASoC: wm8994: correct BCLK DIV 348 to 384

 sound/soc/codecs/mc13783.c        |  4 ++--
 sound/soc/codecs/uda1380.c        |  2 +-
 sound/soc/codecs/wm8960.c         |  2 +-
 sound/soc/codecs/wm8994.c         |  2 +-
 sound/soc/davinci/davinci-mcasp.c |  2 +-
 sound/soc/soc-dapm.c              | 11 ++++++++---
 6 files changed, 14 insertions(+), 9 deletions(-)

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVzhdAAoJECTWi3JdVIfQPOQH/3cvblIL1OfIg7CbVlUiUOe/
lKnCDj0aqDQ5SXAUnTtHl1+8vD7ULtXZBMs9tDMxREjJh2z7dlFuo3+hpus4ZWyS
iUAWSTC1nXXRU+BRenBWdT/J/ec773wJ6s25Rh7lKk08xk+GVilNw9riPJ3g/06o
hP5TYcSB/040FQjyp909XUJt+ft/nnPuwklqvnuG4ZAFgkEwFArMvg7uWeAg7Grj
kq85Xqt71FiUPDfGsHGrNTEjFVWbIS4BXC3k5dxdiAChgObRM9i1x4EXpTeqEFGe
Lzd8z4F6y4gxsDjtnIN6rf4Z08uD/nceU62yLnsi7Hrl6+Xa0qwra5OFvpSVNIQ=
=he4S
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============5617093332972370971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5617093332972370971==--
