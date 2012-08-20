From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.6
Date: Mon, 20 Aug 2012 20:11:59 +0100
Message-ID: <20120820191159.GM26991@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6502189079346180028=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5E6F265E6F
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 21:11:59 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6502189079346180028==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Content-Disposition: inline


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.6

for you to fetch changes up to 28c42c28309244d0b15d1b385e33429d59997679:

  ASoC: wm9712: Fix inverted capture volume (2012-08-17 22:43:18 +0100)

----------------------------------------------------------------
ASoC: Additional updates for 3.6

A batch more bugfixes, all driver-specific and fairly small and
unremarkable in a global context.  The biggest batch are for the newly
added Arizona drivers.

----------------------------------------------------------------
Chris Rattray (1):
      ASoC: wm8994: Add missing dapm routes for WM8958 rev A

Fabio Estevam (2):
      ASoC: mxs: Fix the name of the SoC family
      ASoC: imx-ssi: Remove mono support

Mark Brown (10):
      Merge tag 'asoc-3.6' of git://git.kernel.org/.../broonie/sound into for-3.6
      ASoC: wm8962: Don't duplicate bias level management in resume
      ASoC: core: Upgrade the severity of probe deferral errors to dev_err()
      MAINTAINERS: Add entries for Wolfson Arizona class devices
      ASoC: wm5102: Add missing input PGA routes
      ASoC: wm5110: Add missing input PGA routes
      ASoC: jack: Always notify full jack status
      ASoC: wm5102: Remove DRC2
      ASoC: wm9712: Fix microphone source selection
      ASoC: wm9712: Fix inverted capture volume

Peter Ujfalusi (1):
      ASoC: omap-mcbsp: Fix 6pin mux configuration

Sachin Kamat (1):
      ASoC: Samsung: Fix build error

Scott Jiang (1):
      ASoC: bfin: fix memory leak in sport3 controller driver

Vaibhav Bedia (1):
      ASoC: Davinci: McASP: Flush the FIFO before enabling

 MAINTAINERS                       |    7 ++++++-
 sound/soc/blackfin/bf6xx-sport.c  |    7 +++++++
 sound/soc/codecs/ab8500-codec.c   |    4 ++++
 sound/soc/codecs/ad1980.c         |    1 +
 sound/soc/codecs/mc13783.c        |    2 ++
 sound/soc/codecs/sgtl5000.c       |    3 +--
 sound/soc/codecs/stac9766.c       |    1 +
 sound/soc/codecs/wm5102.c         |   25 +++++++++----------------
 sound/soc/codecs/wm5110.c         |   12 ++++++++++++
 sound/soc/codecs/wm8962.c         |   18 +++---------------
 sound/soc/codecs/wm8994.c         |   17 ++++++++++++++++-
 sound/soc/codecs/wm9712.c         |   22 +++++++++++++++++++---
 sound/soc/codecs/wm9713.c         |    1 +
 sound/soc/davinci/davinci-mcasp.c |   10 ++++++++--
 sound/soc/fsl/imx-ssi.c           |    5 +++--
 sound/soc/mxs/Kconfig             |    2 +-
 sound/soc/mxs/mxs-saif.c          |   24 ++++++++++++++++++++++++
 sound/soc/omap/mcbsp.c            |    2 +-
 sound/soc/omap/omap-mcbsp.c       |    1 +
 sound/soc/omap/omap-pcm.c         |    1 +
 sound/soc/samsung/pcm.c           |    2 +-
 sound/soc/soc-core.c              |   12 +++++++-----
 sound/soc/soc-jack.c              |    2 +-
 sound/soc/tegra/tegra_alc5632.c   |    2 +-
 sound/soc/tegra/tegra_wm8903.c    |   10 +++++-----
 sound/soc/ux500/ux500_msp_dai.c   |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c   |    2 +-
 sound/soc/ux500/ux500_msp_i2s.h   |    2 +-
 28 files changed, 139 insertions(+), 60 deletions(-)

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMovrAAoJEFJkBDiqVpZ4JM0P/1m8FdXAACxeolWc3Uq5FuQ/
mp7+dIBSy1oUxvIMmEGJ1gYu7cHIAdwVX7makMNV1WZZj7myg3ax34bvF0KRwVZm
K0JOInOw6Hpxd6XoRiDqQVR9CUupQL4t0nZH7v2bFw+I0MDNL7X8gT8xw3LUGG8Z
s8meH+esTA4LWbtK/yzxcYqagfQfGRKU1gyagBY+cwJ5QbkdTww1f+dG56EXTaY5
2CQkcNFUr8jReaqL5lABY72v/gWkdMcPOE7ackUznT21uWWzbIpvrSau+QUMIGC4
3a7xK0a+T1OSkLnZk4+t4MItNjURkojNYNzhXw3v4pGbptZtWNEWvM0HLf3aCnTj
JFppLsygbVPbQzcWctb0VrpGEviAqE1LPoEL3D13bJaoZqp0vwKD+Pn/oAyxf1rF
bQBQaxgxeuC1u2L3LohDHIC5mUiKFcynRknvyjeHGt63b4MlZlNWiv6lvS/ywxkB
xZ2gUXTqjC/cgumjOZMvxkwT5eKuYlI8Nl/l/ePBFp/6nutGbfiNlYITzcFDq48j
hLLLKclUcbnqEIZQC7iHbSLTJ9+uXcux8qzQBT+9PzScIPT90dlxnQChKgZpDMK+
A4cEaN7sGFU1PprKpu9t0Gl7KeKrkeybaN3dknkHjO+dgIUN0S+hJWabZ1Zvvw8N
vQ1MsMbLabtn67nLIaTk
=moa3
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--

--===============6502189079346180028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6502189079346180028==--
