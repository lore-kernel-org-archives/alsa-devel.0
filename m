From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Last minute ASoC updates for 3.4
Date: Wed, 21 Mar 2012 00:43:27 +0000
Message-ID: <20120321004325.GC8567@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0923933614314628249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 106DA243E8
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 01:43:35 +0100 (CET)
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


--===============0923933614314628249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5ec65ee589fdaca7298b6303fd74ad6c121a8f38:

  ASoC: mx27vis-aic32x4: Convert it to platform driver (2012-03-13 23:09:59 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to 22f8d055350066b4a87de4adea8c5213cac54534:

  ASoC: wm8994: Provide VMID mode control and fix default sequence (2012-03-19 19:08:17 +0000)

----------------------------------------------------------------
Last minute ASoC updates for 3.4

There's a couple of small features here that were added late on but have
been in -next in my tree and some bug fixes.  The wm_hubs stuff is
actually bug fixes - the stuff that's currently in 3.4 is a half way
house between the two solutions that the latest change allows the
machine to select between.

----------------------------------------------------------------
Daniel Mack (1):
      ASoC: pxa-ssp: atomically set stream active masks

Mark Brown (5):
      ASoC: wm8996: Add 44.1kHz support
      ASoC: core: Fix obscure leak of runtime array
      ASoC: wm_hubs: Don't actively manage LINEOUT_VMID_BUF
      ASoC: wm8994: Add missing break in resume
      ASoC: wm8994: Provide VMID mode control and fix default sequence

Sangsu Park (1):
      ASoC: Samsung: Added to support mono recording

Timur Tabi (1):
      ASoC: fsl: p1022ds: tell the WM8776 codec driver that it's the master

 sound/soc/codecs/wm8994.c  |  187 ++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm8994.h  |    8 ++
 sound/soc/codecs/wm8996.c  |   19 +++--
 sound/soc/codecs/wm_hubs.c |   16 +---
 sound/soc/fsl/p1022_ds.c   |   24 ++++--
 sound/soc/pxa/pxa-ssp.c    |   61 +++++++++------
 sound/soc/samsung/i2s.c    |   13 +++-
 sound/soc/soc-core.c       |    8 +-
 8 files changed, 239 insertions(+), 97 deletions(-)

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaSQmAAoJEBus8iNuMP3dFsYP/A6Dl3y8Ig5r89sv+vefo9jt
4Z3PaS7dE69lvmNJl+iOLXU0hW5NlDXLIO/rLil/ivgkZblPceyRzMIcrb0LSoQI
ZVQcIx2DkwggCBq+gMFkrEMBM3jETWUPG6ANG5kSQo04fhx3Mf5mel8Fl9odh6dB
IuZLyHajpNacBDWJz4mfPEwKCDlciKFXewjBJpuKLWq3ntn8bc0tF9ZoQn4djBNG
Ct2xgt+5mvIPDlC3CpbJpEzzguBi5WvGhG9bQvbtLE68CPT5Qj0IbQr29B9I3MG4
yZHY5u+qwwwlL1x/dTMTnQNRueTd869jDmaug+T3jymCXs5JRlGQ3CkzkEvm8dr/
OcOXEgx/ZojEoHdCd2z9fYgv+3hbV0Nbf6TPUL9+XqSmSqplVVsvJR/lZkI3JOoB
AhuD3SnDFTgwXNxrKT+dzgXavsfS/IGHsIjoG6FwN2PuJPlpH3W9icVsrmaQgHGy
OkEDqc/dkWlWl1hvUjONSt6QTzYl+ZitmBt7PywQu7jxB4xvSjm0AWhIfZR7y0Cg
YLZrkUdbvYzDkDMDe6fXsAm8Pc45jD9Q3cPHCLdnnCMw6o6LAVXAR/IeopwLHk4L
7R9wGG0AkaLSVtq2KwUAkmQx/+cdTeXre92UdraH6fxYSnwfO1eahmcfno5ZM141
7ui3zizOaMWEedIl4wkS
=sxw9
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

--===============0923933614314628249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0923933614314628249==--
