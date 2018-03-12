From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.16
Date: Mon, 12 Mar 2018 09:25:47 -0700
Message-ID: <20180312162547.GH2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2433210459642758617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B6F9267381
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 17:25:50 +0100 (CET)
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


--===============2433210459642758617==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.16-rc5

for you to fetch changes up to a3e39ed1f40e14f24bec0f91c4fa0408fb6c4d02:

  Merge remote-tracking branches 'asoc/fix/amd', 'asoc/fix/hdmi-codec', 'asoc/fix/rt5651', 'asoc/fix/samsung', 'asoc/fix/sgtl5000', 'asoc/fix/sunxi' and 'asoc/fix/wm-adsp' into asoc-linus (2018-03-12 09:14:07 -0700)

----------------------------------------------------------------
ASoC: Fixes for v4.16

This is a fairly standard collection of fixes, there's no changes to the
core here just a bunch of small device specific changes for single
drivers plus an update to the MAINTAINERS file for the sgl5000.

----------------------------------------------------------------
Fabio Estevam (2):
      MAINTAINERS: Add myself as sgtl5000 maintainer
      ASoC: sgtl5000: Fix suspend/resume

Hans de Goede (1):
      ASoC: rt5651: Fix regcache sync errors on resume

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/amd', 'asoc/fix/hdmi-codec', 'asoc/fix/rt5651', 'asoc/fix/samsung', 'asoc/fix/sgtl5000', 'asoc/fix/sunxi' and 'asoc/fix/wm-adsp' into asoc-linus

Michal Oleszczyk (1):
      sgtl5000: change digital_mute policy

Peter Ujfalusi (1):
      ASoC: hdmi-codec: Fix module unloading caused kernel crash

Richard Fitzgerald (1):
      ASoC: wm_adsp: For TLV controls only register TLV get/set

Sylwester Nawrocki (1):
      ASoC: samsung: Add the DT binding files entry to MAINTAINERS

Vijendar Mukunda (1):
      ASoC: amd: 16bit resolution support for i2s sp instance

Yong Deng (1):
      ASoC: sun4i-i2s: Fix RX slot number of SUN8I

 MAINTAINERS                   |  8 ++++++++
 sound/soc/amd/acp-pcm-dma.c   | 16 +++++++++-------
 sound/soc/amd/acp.h           |  2 ++
 sound/soc/codecs/hdmi-codec.c |  7 +------
 sound/soc/codecs/rt5651.c     |  1 +
 sound/soc/codecs/sgtl5000.c   | 26 +++++++++++++++++++++++---
 sound/soc/codecs/wm_adsp.c    | 14 ++++++++------
 sound/soc/sunxi/sun4i-i2s.c   |  2 +-
 8 files changed, 53 insertions(+), 23 deletions(-)

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmqgoACgkQJNaLcl1U
h9B5DAf/XN59S88dldEoNDUY/tUc7D5GwwKJeMeLwhdFTSQ9nhsXM07COZp+qv/u
IXeAdgWd2VgCYRCJ5dazsHBZnBBSoarwXmuweAVEENUmXq0Zx30psrGwoho9v73b
Ydt0buCvHEoU+TrWgjVgVYp0zjfOeOGFPEojj6pxvt/X1eMiMLKHS1B2UZXq71aq
oXbEUg2939/ktw5BO985vU1PmmrKhwwC+xEfd8Yu6ZYm2c/0nr/WzKgySCkOaKET
KusP9fioXjozEONgT2pWFzsSJakfKyTTab7P6HBULKypKJD98iR+Mly8hk1JHeAA
KPOmD7CWB92oskzbg3AUWdysCPwADg==
=PoO3
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--

--===============2433210459642758617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2433210459642758617==--
