From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Thu, 29 Mar 2012 13:08:43 +0100
Message-ID: <20120329120842.GO3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5729519766713066309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D670103B6F
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 14:08:46 +0200 (CEST)
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


--===============5729519766713066309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L5nTHegdhbHhzmSD"
Content-Disposition: inline


--L5nTHegdhbHhzmSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 22f8d055350066b4a87de4adea8c5213cac54534:

  ASoC: wm8994: Provide VMID mode control and fix default sequence (2012-03-19 19:08:17 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to 41ba6b711a40b83a877ae8242a4b3e692de91f97:

  ASoC: dmaengine_pcm: use dmaengine cyclic wrapper (2012-03-26 18:28:11 +0100)

Not sure where your current ASoC branch is - topic/asoc and fix/asoc are
both behind Linus' tree (which is what this pull request was generated
against).

----------------------------------------------------------------
ASoC: A few more updates for 3.4

The cleanup of the dmaengine parameter messup and a tweak to some
callibration values for WM1811.

----------------------------------------------------------------
Fabio Estevam (1):
      ASoC: Add extra parameter to device_prep_dma_cyclic

Mark Brown (1):
      ASoC: wm8994: Update WM8994 DCS calibration

Vinod Koul (1):
      ASoC: dmaengine_pcm: use dmaengine cyclic wrapper

 sound/soc/codecs/wm8994.c     |    2 +-
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--L5nTHegdhbHhzmSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdFDCAAoJEBus8iNuMP3ddBIP/iPeVExJt+IFo6dv+vMfKrba
ceWKLyQ3OsEdxHnAdAiFesbxKp9WpYi10qoxqxH1E+xJ2WTbz6UEudrDtFdpp3Bg
gl7khZe6/cOJl5WTTqJSLJfU7NV7erP2j5z0QSUa3DSYJ5WZhDyB3psHFbCueei4
t/agj/dL2z6QRBtsglex2wl1ydauxiFHlCebYBBxKPJf5TpqfuOWjOBifpHhkDFm
G3On1y2rE2N7cf10pCico3LQq/d6iC7+CZ3mJczH+svvfPq+dQMO5Zf0grP6NglG
ULgwMbjt1UbDGIVHgENtiMCsW0aiumW/QYMI7bN7BSoD8krd6RLhpd4J1OxrsM64
eTeC2ZzH13nvHPlrU/y+PIpjzrITClUeQtHjAs0tFthzumzWB4MOENo/f20FYmZ7
zpP7NXirYEAYLo/x1P37qwtuv39STDtd7hqmOuGRCJj1rnIa7xKjFIjROEXvDzPq
1DttmxOX34fyDi5G7xk/NVVV5H8Wu8d16Q/ktcbeHcSHt5vVh6cmOPRjqC/siii4
xvkz99nrjMlKeNqCVVTY8U5/TBNuxcAfRoustNTdVwJgnQjduzT0HNFQtKJr2gaU
pRu3MDRhtQJyp7ElKyoVi0vV/txarlY8J867d/a6XPXeLlt9gJpbw/RzykO7PhTq
IkUuxUOS8DlRv7gAp9Sq
=eELC
-----END PGP SIGNATURE-----

--L5nTHegdhbHhzmSD--

--===============5729519766713066309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5729519766713066309==--
