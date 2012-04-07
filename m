From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Sat, 7 Apr 2012 11:21:31 +0100
Message-ID: <20120407102131.GE3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2058290361735292599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6F3A24403
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Apr 2012 12:21:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2058290361735292599==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to 8abe05c6eb358967f16bce8a02c88d57c82cfbd6:

  ASoC: tegra: fix i2s compilation when !CONFIG_DEBUG_FS (2012-04-06 12:28:49 +0100)

----------------------------------------------------------------
ASoC: fixes for 3.4

A bunch of driver-specific fixes and one generic fix for the new support
for platform DAPM contexts - we were picking the wrong default for the
idle_bias_off setting which was meaning we weren't actually achieving
any useful runtime PM on platform devices.

----------------------------------------------------------------
Fabio Estevam (2):
      ASoC: imx-audmux: Fix ssi port numbers in sysfs
      ASoC: imx-audmux: Check for NULL pointer

Jarkko Nikula (1):
      MAINTAINERS: Add missing ASoC OMAP co-maintainer

Kuninori Morimoto (1):
      ASoC: ak4642: fixup: mute needs +1 step

Mark Brown (1):
      MAINTAINERS: Don't list everyone working on Wolfson drivers

Martin Jansa (1):
      ASoC: pxa: pxa2xx-i2s: add io.h for IOMEM macro

Stephen Warren (3):
      ASoC: tegra: ensure clocks are enabled when touching registers
      ASoC: set idle_bias_off=1 for all platform DAPM contexts
      ASoC: tegra: fix i2s compilation when !CONFIG_DEBUG_FS

Zeng Zhaoming (1):
      ASoC: sgtl5000: Enable VAG when DAC/ADC up

 MAINTAINERS                   |    4 ++--
 sound/soc/codecs/ak4642.c     |    2 +-
 sound/soc/codecs/sgtl5000.c   |   25 +++++++++++++------------
 sound/soc/imx/imx-audmux.c    |    5 ++++-
 sound/soc/pxa/pxa2xx-i2s.c    |    1 +
 sound/soc/soc-core.c          |    2 ++
 sound/soc/tegra/tegra_i2s.c   |    6 +++++-
 sound/soc/tegra/tegra_spdif.c |    4 ++++
 8 files changed, 32 insertions(+), 17 deletions(-)

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPgBUkAAoJEBus8iNuMP3dOoEP/2EO5HWdpO/jBbKZXq4/iSm/
09tEoI4pRVv2ODGbPlO2Zsls+fDePLbUiC9wbiGq0Trh/dP04RpwsmPaZ2kucGvY
m+1v+LQgTvlj9uDjqLZ0PVvko+5RxtSx/jbi4beQysojCXZ0oYs8eQ6c5QoPWnTh
kyRNTct3yUFxVzbJucCrFvzV0N4CbUT07kKjh5TFGuEY8eBzALONxto8CK2GCSc+
SLZgdrbvyWGVusWAUPjGdI/53M54j48VliLQkUgqyfRHvPDuxbxtUNsuyxigCJ4z
jW2xaaXm0mpqyeNFRvXy2GAct+0fqAvvvnJscqm8gJGC1daKQr6tQHTBzhhqfq5i
DilXCRVIdjCxFWamQJJp4vRPxvK3XAT8WWToj4sXHnqHAMc/gnbVwcaJV89z0TUb
4FANpSrFjBq3l98/uFjoQv9ZHehl2yRMFw6RdPgT4ThgzVPE3oVzqv+DFhR3i8k+
QvagYZlaqcZgb7wPSZffBXdg7O4tTdgAxt6cL08JwRagbqbt3hnqIbO4Wq9ugI0Z
aIsWuIZqCV/RPITBmXX56Z4lNI/6UyD6qDo/l/AMxUQNWpwRMfGPcanszj7bad5E
P+J4eE9qXWHTHGF/sqwUTyZiEKulr7HaCbDh8Nl4NjGd+jI6FKoOMm4KpYfGvZLt
9Pc9M7C5R7s0QZeam9dg
=SbQ2
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--

--===============2058290361735292599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2058290361735292599==--
