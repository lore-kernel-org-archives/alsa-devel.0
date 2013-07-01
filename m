From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.11
Date: Mon, 1 Jul 2013 10:15:25 +0100
Message-ID: <20130701091525.GX27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3784008853262354019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B99C2265054
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 11:15:30 +0200 (CEST)
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


--===============3784008853262354019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fTYva0sObOukM7+w"
Content-Disposition: inline


--fTYva0sObOukM7+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a975873a9acc0788c1aee5ca183deb420b5c00e5:

  ASoC: tas5086: fix Mid-Z implementation (2013-06-28 12:15:30 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.11-3

for you to fetch changes up to 370887f105025ed52acc9cbb0a15b6567d1550ff:

  Merge remote-tracking branch 'asoc/topic/x86' into asoc-next (2013-06-30 12:42:25 +0100)

----------------------------------------------------------------

ASoC: Final updates for v3.11

A few final updates:

 - A couple of additional bug fixes for the AC'97 refactoring.
 - Some fixes for the ADAU1701 driver.

----------------------------------------------------------------
Daniel Mack (2):
      ASoC: adau1701: more direct regmap usage
      ASoC: adau1701: remove control_data assignment

Kevin Hilman (2):
      ASoC: pxa2xx: fixup multi-platform AC'97 build failures
      ASoC: ac97: fixup multi-platform AC'97 module build failure

Mark Brown (6):
      Merge remote-tracking branch 'asoc/topic/adau1701' into asoc-next
      Merge remote-tracking branch 'asoc/topic/adsp' into asoc-next
      Merge remote-tracking branch 'asoc/topic/ext' into asoc-next
      Merge remote-tracking branch 'asoc/topic/tas5086' into asoc-next
      Merge remote-tracking branch 'asoc/topic/twl6040' into asoc-next
      Merge remote-tracking branch 'asoc/topic/x86' into asoc-next

Thierry Reding (2):
      ASoC: tegra20-ac97: Remove duplicate error message
      ASoC: tegra20-ac97: Remove unused variable

 .../devicetree/bindings/sound/adi,adau1701.txt     |  35 ++
 include/linux/mfd/twl6040.h                        |   7 +
 include/sound/soc.h                                |   4 +-
 sound/soc/au1x/ac97c.c                             |  21 +-
 sound/soc/au1x/psc-ac97.c                          |  33 +-
 sound/soc/blackfin/bf5xx-ac97.c                    |  29 +-
 sound/soc/cirrus/ep93xx-ac97.c                     |  12 +-
 sound/soc/codecs/88pm860x-codec.c                  |   6 +-
 sound/soc/codecs/ac97.c                            |   7 +-
 sound/soc/codecs/ad1980.c                          |  12 +-
 sound/soc/codecs/adau1701.c                        | 321 +++++++++++---
 sound/soc/codecs/stac9766.c                        |  26 +-
 sound/soc/codecs/tlv320aic3x.c                     |   6 +-
 sound/soc/codecs/twl6040.c                         | 109 ++++-
 sound/soc/codecs/wm8400.c                          |   9 +-
 sound/soc/codecs/wm8903.c                          |   6 +-
 sound/soc/codecs/wm8904.c                          |   9 +-
 sound/soc/codecs/wm8990.c                          |  11 +-
 sound/soc/codecs/wm8991.h                          |   9 +-
 sound/soc/codecs/wm8994.c                          |  12 +-
 sound/soc/codecs/wm8995.h                          |   7 +-
 sound/soc/codecs/wm9705.c                          |  16 +-
 sound/soc/codecs/wm9712.c                          |  18 +-
 sound/soc/codecs/wm9713.c                          |  18 +-
 sound/soc/codecs/wm_adsp.c                         | 459 ++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h                         |  13 +-
 sound/soc/codecs/wm_hubs.c                         |   6 +-
 sound/soc/fsl/imx-ssi.c                            |  11 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |  10 +-
 sound/soc/mid-x86/mfld_machine.c                   |  32 +-
 sound/soc/nuc900/nuc900-ac97.c                     |  60 +--
 sound/soc/pxa/pxa2xx-ac97.c                        |  10 +-
 sound/soc/pxa/pxa2xx-ac97.h                        |   3 -
 sound/soc/samsung/ac97.c                           |  42 +-
 sound/soc/sh/hac.c                                 |   8 +-
 sound/soc/soc-core.c                               |  17 +
 sound/soc/tegra/tegra20_ac97.c                     |  67 ++-
 sound/soc/txx9/txx9aclc-ac97.c                     |  17 +-
 38 files changed, 1124 insertions(+), 374 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1701.txt

--fTYva0sObOukM7+w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0UiqAAoJELSic+t+oim92XsP/jcWO5Sm4eOciWAO7isUQ5Kt
uUXIlpzAaZfw/38zyZhS+fzKzJNerr0omSf4PbPFOfx6d/PHIO6rYQnGH+XVBIe6
zldazPZwfG3iSXo/RCmbUlHzdm5+nF/fbtVsMzW9fZEpcXQVRpHHNmxigz+zGiCr
nPg4mFUi4OTj5Tj3zqOBmAhh+csWKA9CDRkuTYMo61Y3bpCes0YisREiLYg8JoZx
gHyVd2avk0c0NJRajVNBlZ7WucB291+32e26CFnSBjpMtDhNCj/0YUZ2VNpldgNi
DfzTQAWiUXH+zwbYOXcICLJ6XqomFce0l4Aifp7BDD/a/8YSCRGhARfJkioGBDBO
mdzM08cDdxVW2UNgABM6eMyxdetOIt0E5TyVVC8aHWR3vq005FeyeAcvQZTI2wRF
bXqTMSraOFNwxtrgW+w1RZcMZ9FWeDioHFshuAhlY5rpVZnrUG65PCraq3p93m4R
Vq6q124UglmxSY8AyKnQCMTThrYDxiW3pOUB9sQeHdWwW6InUVhLqkmbKv4nyl+4
36QPJLHebApltQn108V2ahoQKMLLlkkiFBMUqH5OK6NbjU3RhR5U7u6mMhJ6d7TU
Hk/hSKbcRihCRTnL/TTjEUNgqdt+7ycSJuCOLySr9iLSOdaF6IfpjK0ssdP0oeid
QjhxYYjCCD35qVV0Gdfz
=FCne
-----END PGP SIGNATURE-----

--fTYva0sObOukM7+w--

--===============3784008853262354019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3784008853262354019==--
