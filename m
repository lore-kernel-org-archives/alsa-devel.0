From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.2
Date: Wed, 8 May 2019 16:42:18 +0900
Message-ID: <20190508074218.GU14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2960650980195246025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4455F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 09:42:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2960650980195246025==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TIr7t44h4GvinQKN"
Content-Disposition: inline


--TIr7t44h4GvinQKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1587a061ef562de0d97c82a95863e191bcd69d63:

  ASoC: sprd: Add reserved DMA memory support (2019-05-06 22:48:03 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v5.2-2

for you to fetch changes up to ce38a75089f70f6380fc63a5478a7659b4eb3f47:

  ASoC: SOF: core: fix undefined nocodec reference (2019-05-08 15:42:00 +0900)

----------------------------------------------------------------
ASoC: Fixes for v5.2

A bunch of driver specific fixes that came in since the initial pull
request for v5.2, mainly warning fixes for the newly added Sound Open
Firmware code which people appeared to only start looking at after I'd
sent the pull request.

----------------------------------------------------------------
Curtis Malainey (1):
      ASoC: RT5677-SPI: Disable 16Bit SPI Transfers

Jon Hunter (1):
      ASoC: max98090: Fix restore of DAPM Muxes

Olivier Moysan (2):
      ASoC: stm32: spdifrx: update pcm hardware constraints
      ASoC: stm32: spdifrx: change trace level on iec control

Pierre-Louis Bossart (2):
      ASoC: SOF: xtensa: fix undefined references
      ASoC: SOF: core: fix undefined nocodec reference

Randy Dunlap (1):
      ASoC: sound/soc/sof/: fix kconfig dependency warning

Takashi Iwai (4):
      ASoC: da7219: Fix a compile warning at CONFIG_COMMON_CLK=n
      ASoC: SOF: Fix a compile warning with CONFIG_PCI=n
      ASoC: rockchip: Fix an uninitialized variable compile warning
      ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly

 sound/soc/codecs/da7219.c         |  2 ++
 sound/soc/codecs/max98090.c       | 12 ++++++------
 sound/soc/codecs/rt5677-spi.c     | 35 ++++++++++++++++-------------------
 sound/soc/rockchip/rockchip_pdm.c |  2 +-
 sound/soc/sof/Kconfig             |  2 +-
 sound/soc/sof/core.c              | 10 +++++-----
 sound/soc/sof/intel/Kconfig       |  2 +-
 sound/soc/sof/ipc.c               | 10 +++++++---
 sound/soc/sof/ops.c               |  2 +-
 sound/soc/stm/stm32_spdifrx.c     |  5 +++--
 10 files changed, 43 insertions(+), 39 deletions(-)

--TIr7t44h4GvinQKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSiFkACgkQJNaLcl1U
h9ADzgf/YywBjk4cXfFUzyQy9XFAQ0MdzX0H0G6egowYaMvOXhBZ0NKX9twzC8fL
XsmwKKWeWi3hJ348GDhjvPjJCWyGjeWdqbuExUSP8Wnq2bhut6oUOjbgZyXCxlSb
3IfDAzpQfOqBwHKPKTB6nRKFRxZCrKq3RxrH3RX7mwKDm7zR981ReCEr7+6Fe5w4
LGmtnHJmaIT8u+M9d0WmclLvMieDuJssEAEScFiPxhGEINVSNoIXn3lTOHDYDgqK
Br4DvK3n42U7JDEWpQRWDG0xGCmEvf9C0+ROKeXzLtoM8D+/Cm80J2qVtOPtDqh9
6ImdxnKRvnky+1sQLyBOeS1N38O6FQ==
=aIqx
-----END PGP SIGNATURE-----

--TIr7t44h4GvinQKN--

--===============2960650980195246025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2960650980195246025==--
