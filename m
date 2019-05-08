From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fix for v5.2
Date: Wed, 8 May 2019 18:45:54 +0900
Message-ID: <20190508094554.GK14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746055777735181107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 881F7F8075E
 for <alsa-devel@Alsa-project.org>; Wed,  8 May 2019 11:46:00 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1746055777735181107==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L7HOq7zyYWLAwxxS"
Content-Disposition: inline


--L7HOq7zyYWLAwxxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ce38a75089f70f6380fc63a5478a7659b4eb3f47:

  ASoC: SOF: core: fix undefined nocodec reference (2019-05-08 15:42:00 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v5.2-4

for you to fetch changes up to 2a79e3d342e4b8883ff7fe2cf1b3e9192c26f61a:

  ASoC: SOF: Fix unused variable warnings (2019-05-08 18:33:34 +0900)

----------------------------------------------------------------
ASoC: ...and one more

This didn't get applied as quickly as expected due to a missing list CC
and I didn't notice my scripts delaying it.

----------------------------------------------------------------
Emil Renner Berthing (1):
      spi: rockchip: turn down tx dma bursts

Libin Yang (1):
      ASoC: codec: hdac_hdmi: no checking monitor in hw_params

Olivier Moysan (1):
      ASoC: stm32: i2s: update pcm hardware constraints

Takashi Iwai (1):
      ASoC: SOF: Fix unused variable warnings

Tzung-Bi Shih (3):
      ASoC: mediatek: mt6358: initialize setting when ramping volume
      ASoC: mediatek: mt6358: save output volume for mixer controls
      ASoC: mediatek: mt6358: save PGA for mixer control

 drivers/spi/spi-rockchip.c   |   4 +-
 sound/soc/codecs/hdac_hdmi.c |  13 -----
 sound/soc/codecs/mt6358.c    | 131 +++++++++++++++++++++++++++----------------
 sound/soc/sof/core.c         |   2 +
 sound/soc/stm/stm32_i2s.c    |   3 +-
 5 files changed, 89 insertions(+), 64 deletions(-)

--L7HOq7zyYWLAwxxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSpVEACgkQJNaLcl1U
h9CSEwf/TvTK7ZydmEd/YTZkM8eR17lsI4pKq1LKjXED7zKmH2PmhIsuIbORe6GN
RkjdvCDI39DN98oA3MRUEBDhNskeOfCXGCTsBjar4oamFioZH94MEyIgWjmc0WLx
cRImjrPfhDLHIDfdD6qEJ+ABhZrSA73vVGeb2+Gx53vhkGCFDmZPUiUiHZbmtBZG
inCCv7IN96x2lC8zV/BuYaKIF89gEQM+IN4zeaM31qgTtzFaCfshRGppa06I1NfM
SSiCLwJoVWYAr6JbuJGAqZgl/VnmY9GscdWvMh09yKWaWeQMIC8f5OYvPCIGB1Xz
VDNa57Xqb2HQvGb4yrfm/OnSygeZ6Q==
=1Nrj
-----END PGP SIGNATURE-----

--L7HOq7zyYWLAwxxS--

--===============1746055777735181107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1746055777735181107==--
