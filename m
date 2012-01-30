From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Mon, 30 Jan 2012 13:34:05 +0000
Message-ID: <20120130133405.GF4882@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5128191521902523230=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C680924605
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 14:34:07 +0100 (CET)
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


--===============5128191521902523230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c83f1d7e71625801c72f4013291194e09b6f0a6e:

  ASoC: wm2000: Fix use-after-free - don't release_firmware() twice on error (2012-01-24 11:34:19 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-3.3

for you to fetch changes up to 1ae5cbc52e7c6619a3f44b87809fd25370df31bb:

  ASoC: neo1973_wm8753: remove references to the neo1973-gta01 machine (2012-01-30 13:22:13 +0000)

----------------------------------------------------------------
A bunch of small driver specific fixes - nothing terribly exciting here,
all of this will only affect people using particular devices and then
usually only in some use cases.
----------------------------------------------------------------

Denis 'GNUtoo' Carikli (1):
      ASoC: neo1973_wm8753: remove references to the neo1973-gta01 machine

Mark Brown (6):
      ASoC: wm5100: Make sure we switch to button reporting mode
      ASoC: wm5100: Fix microphone configuration
      ASoC: wm8996: Mark register cache as dirty when regulators are disabled
      ASoC: wm8962: Mark register cache as dirty when regulators are disabled
      ASoC: wm5100: Mark register cache as dirty when regulators are disabled
      ASoC: wm_hubs: Enable line out VMID buffer for single ended line outputs

UK KIM (1):
      ASoC: wm_hubs: fix wrong bits for LINEOUT2 N/P mixer

 sound/soc/codecs/wm5100.c          |   12 ++++++-
 sound/soc/codecs/wm8962.c          |    2 +-
 sound/soc/codecs/wm8996.c          |    2 +-
 sound/soc/codecs/wm_hubs.c         |   10 ++++-
 sound/soc/samsung/neo1973_wm8753.c |   65 +-----------------------------------
 5 files changed, 22 insertions(+), 69 deletions(-)

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJpxFAAoJEBus8iNuMP3dKFEP/1FX8PGymRGMpvsZBhf8w8Gz
bc3/J9cEDZTilqXvzKNfkyDmeCm6UMReIjnWrbtPfbT7CSwnqhBs4PR5ZgSzsm+y
oqUvGnVgfr5Wnq/tu2h57/fjvfcZzOoPqxi4G3U+BaiXWj54orlhZmwz/ewgPzt0
27FTHq8bKgFWrJsQq+4dYBZzWLgQgXMiHYRgA+nOnmt2+2Ci6PExYR015I+SD9M8
8NiG9onfJGMXoTNlOv5ReZ2649VzGpmFzM01lAkemKLZmTAeJWDFtWjXDGXbKDsq
LomUgdH/H36LpmOPW3Qq0gJ+4T+H5hB2Dy0a2nImOFO/iqtIam6FYn+I6kOp6Mnf
hETHKfUyZqGJYgzSGYGt/h/xTES3jV4bKy8F+g2oSt8w/T1tj03FLQDKm13WPjQT
3Lxa2BiCMyB6FSqfQ6VE5zLPgQFeRe7ROdEi0k4RBw8dycqNN39K+IKIR6Rci95Z
Xal502rmBmXKgT3nOoXDApbCE7Rrz69a2LWghhq2ciDXOxLZhYPDhddQm3GG5tan
4umHTvXEBqpmOZUmvb/neO4pClHo2TOrJuUkGr98/NGa1b/KedaMwpyZEMtr83kJ
SjGz6FWxdnE2g/wulLr6X/DPoBHNdgSQ03BhKuTpRij/3UC3ngQlxy4I6c2JepwJ
SPT1lumL/i/9EAfVxa6e
=lKlD
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

--===============5128191521902523230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5128191521902523230==--
