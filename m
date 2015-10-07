From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.3
Date: Wed, 7 Oct 2015 16:17:52 +0100
Message-ID: <20151007151752.GP12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3173167004280070814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BC4A2614A7
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 17:18:26 +0200 (CEST)
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


--===============3173167004280070814==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5a/gwqvMGypQC9CX"
Content-Disposition: inline


--5a/gwqvMGypQC9CX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-fix-v4.3-rc4

for you to fetch changes up to e4fc141d2a022a63c87a4851b3c688eca6a1647b:

  Merge remote-tracking branches 'asoc/fix/tlv320aic3x' and 'asoc/fix/wm896=
2' into asoc-linus (2015-10-07 16:07:50 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.3

Quite a few fixes here but they're all very small and driver specific,
none of them really stand out if you aren't using the relevant hardware
but they're all useful if you do happen to have an affected device.

----------------------------------------------------------------
Andreas Dannenberg (1):
      ASoC: tas2552: fix dBscale-min declaration

Beno=EEt Th=E9baudeau (1):
      ASoC: imx-ssi: Fix DAI hardware signal inversions

Gianluca Renzi (2):
      ASoC: sgtl5000: fix error message output for MicBias voltage
      ASoC: sgtl5000: fix wrong register MIC_BIAS_VOLTAGE setup on probe

Jiada Wang (1):
      ASoC: wm8962: balance pm_runtime_enable

Lars-Peter Clausen (1):
      ASoC: db1200: Fix DAI link format for db1300 and db1550

Mark Brown (3):
      MAINTAINERS: Remove wm97xx entry
      Merge remote-tracking branches 'asoc/fix/db1200', 'asoc/fix/dwc', 'as=
oc/fix/imx-ssi', 'asoc/fix/maintainers', 'asoc/fix/rt5645', 'asoc/fix/sgtl5=
000' and 'asoc/fix/tas2552' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/tlv320aic3x' and 'asoc/fix/w=
m8962' into asoc-linus

Oder Chiou (1):
      ASoC: rt5645: Correct the naming and setting of ADC Boost Volume Cont=
rol

Rick Mann (1):
      ASoC: tlv320aic3x: Prevent writing reserved registers on tlv320aic310=
4 CODECs

Yitian Bu (1):
      ASoC: dwc: correct irq clear method

yitian (1):
      ASoC: dwc: fix dma stop transferring issue

 MAINTAINERS                    |  9 ---------
 sound/soc/au1x/db1200.c        |  4 ++++
 sound/soc/codecs/rt5645.c      |  6 +++---
 sound/soc/codecs/rt5645.h      | 16 +++++++++-------
 sound/soc/codecs/sgtl5000.c    |  6 +++---
 sound/soc/codecs/tas2552.c     |  2 +-
 sound/soc/codecs/tlv320aic3x.c | 19 +++++++++++--------
 sound/soc/codecs/wm8962.c      |  5 ++++-
 sound/soc/dwc/designware_i2s.c | 19 ++++++++++++++-----
 sound/soc/fsl/imx-ssi.c        | 19 +++++++++----------
 10 files changed, 58 insertions(+), 47 deletions(-)

--5a/gwqvMGypQC9CX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFTefAAoJECTWi3JdVIfQ7GoH+wStEBBHAVL7nQITElYQOIBJ
5VKiKQoxH62G2Nf/6FbEhVhuXmJQpLIe1+3x4/BBCKORmoKXPNisiZrhAb1AXwhS
VmzcQdTyHJQHmGwcYkGKDqoLWOlSdaw1j+fYYnKh9WyixLxqW0vW+2fEQwY71aPh
BK29XGw9gkKBz14mBTWEqFbkNV8VLgfzyH7KdF1zEZ0LFkWFIl4MDOf3Zefc7AFJ
8ICQYiSqcvUjiWtPLWucfITQIJU61pzHltB5W5OOHDLCuVxHEvaoMFigyw08KbtX
cAGom6K124vjhRCQHFVyuOJU54hKuDzXtxG0D0cGtUcxYp8Q8A+YujGrxJjGywk=
=nrth
-----END PGP SIGNATURE-----

--5a/gwqvMGypQC9CX--

--===============3173167004280070814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3173167004280070814==--
