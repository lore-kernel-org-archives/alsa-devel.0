From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC driver fixes for v3.15
Date: Wed, 14 May 2014 12:52:14 +0100
Message-ID: <20140514115214.GY12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6097869965591516489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E18F261A89
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 13:52:26 +0200 (CEST)
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


--===============6097869965591516489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6VpeyFTtpSvPQce"
Content-Disposition: inline


--z6VpeyFTtpSvPQce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4e17d2d33abe4b523f79fec037ef66ba93643f65:

  ASoC: cs42l52: Convert to use devm_gpio_request_one (2014-04-18 15:14:39 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.15-rc5-drivers

for you to fetch changes up to f9a405961eec4ee9a71a433a473b244ae2d74c3c:

  Merge remote-tracking branches 'asoc/fix/audmux', 'asoc/fix/cs42l52', 'asoc/fix/fsl-esai', 'asoc/fix/fsl-spdif', 'asoc/fix/rcar', 'asoc/fix/tlv320aic31xx' and 'asoc/fix/wm8962' into asoc-linus (2014-05-14 12:49:10 +0100)

----------------------------------------------------------------

ASoC: Driver fixes for v3.15

A small set of driver fixes, nothing remarkable in itself or of any
relevance outside of the driver.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: wm8962: Update register CLASS_D_CONTROL_1 to be non-volatile

Joe Perches (1):
      ASoC: tlv320aic31xx: Convert /n to \n

Kuninori Morimoto (1):
      ASoC: rsnd: call rsnd_dai_pointer_update() from outside of lock

Lars-Peter Clausen (1):
      ASoC: imx-audmux: Fix section mismatch

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/audmux', 'asoc/fix/cs42l52', 'asoc/fix/fsl-esai', 'asoc/fix/fsl-spdif', 'asoc/fix/rcar', 'asoc/fix/tlv320aic31xx' and 'asoc/fix/wm8962' into asoc-linus

Nicolin Chen (3):
      ASoC: fsl_esai: Fix incorrect condition within ratio range check for FP
      ASoC: fsl_esai: Only bypass sck_div for EXTAL source
      ASoC: fsl_esai: Set PCRC and PRRC registers at the end of hw_params()

 .../devicetree/bindings/sound/tlv320aic31xx.txt    |  6 +++---
 sound/soc/codecs/tlv320aic31xx.c                   |  2 +-
 sound/soc/codecs/wm8962.c                          | 15 ++++++++++++---
 sound/soc/codecs/wm8962.h                          |  4 ++++
 sound/soc/fsl/fsl_esai.c                           | 22 ++++++++++++++--------
 sound/soc/fsl/fsl_spdif.h                          |  4 ++--
 sound/soc/fsl/imx-audmux.c                         |  2 +-
 sound/soc/sh/rcar/core.c                           |  5 ++---
 sound/soc/sh/rcar/src.c                            |  4 ++--
 sound/soc/sh/rcar/ssi.c                            |  4 ++--
 10 files changed, 43 insertions(+), 25 deletions(-)

--z6VpeyFTtpSvPQce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc1jrAAoJELSic+t+oim94IsP/3aaHAMrhtK8WGh4elPac0CN
GdKiy8kkPpMSFHdZiPuNQcI0HMHXd35+xLKJzEMnvST8ea5nyJzXLEZqTkDWcsA4
uV70+w2jwNzzI2gW368TUMu/MV20FnCqEeWEH/7WvhMUffLaHWHzvziQX4Na2WCa
oHMA9F3M/364tq3sWkxrsWGRnzSRMg70rN7rwt7SJikFL1Qc2iX5II1tIGCv1UyI
ZdT7kkLfRCbZ1PFlc5xQqCoU/SxQXQ8vovgvgrrmPTAVoG8A9zMp6bKazJGxoCQH
IXr+NkQY2lq1Tk0FZjN3VjuOvhjGc9aRKVWASbaXAy8oSw3OixjWjbfs4UgfLB0U
THWr7e78LcajGVoqPRbg+FGznX5nwt0b4cFR4OjrsE/oUP+nUuqZOQ17petmRvbf
kLe/gjEXGbjc7qCKrHRc9tWtt8T5YdOHGq+lxDMyPB9LukNZMVPOpoMn9w0LSTQd
tECqRJI6ii7XUK1FQckHfWrwDa6ITYbkf5HqMdM6X5zywv5seHc6NUeH+QOxXp+2
nEvYXFB2oGEOJLFHbMUNyGGIX6dC9ewroasWqB2Ak5Ap+LFf02VNu9oi2JsBqC3m
00IUVquhrXk+H3/MHEzEV2MOLKp+pknc/2rHXyNuqVFv3/5PZpza9Q7kvD4z8gFw
m+aCmLP+3VTewEYHhXlU
=N5Fb
-----END PGP SIGNATURE-----

--z6VpeyFTtpSvPQce--

--===============6097869965591516489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6097869965591516489==--
