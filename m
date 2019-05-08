From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.2
Date: Wed, 8 May 2019 18:19:46 +0900
Message-ID: <20190508091946.GI14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2978147015738684841=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E609F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:19:56 +0200 (CEST)
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


--===============2978147015738684841==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjqXxLgfq8Ns5vfG"
Content-Disposition: inline


--gjqXxLgfq8Ns5vfG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ce38a75089f70f6380fc63a5478a7659b4eb3f47:

  ASoC: SOF: core: fix undefined nocodec reference (2019-05-08 15:42:00 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v5.2-3

for you to fetch changes up to ecc425f06c19a296622c827cde54735ebc5320b8:

  spi: rockchip: turn down tx dma bursts (2019-05-08 18:04:32 +0900)

----------------------------------------------------------------
ASoC: Even more fixes

Yet more stuff that came in through the day.

----------------------------------------------------------------
Emil Renner Berthing (1):
      spi: rockchip: turn down tx dma bursts

Libin Yang (1):
      ASoC: codec: hdac_hdmi: no checking monitor in hw_params

Olivier Moysan (1):
      ASoC: stm32: i2s: update pcm hardware constraints

Tzung-Bi Shih (3):
      ASoC: mediatek: mt6358: initialize setting when ramping volume
      ASoC: mediatek: mt6358: save output volume for mixer controls
      ASoC: mediatek: mt6358: save PGA for mixer control

 drivers/spi/spi-rockchip.c   |   4 +-
 sound/soc/codecs/hdac_hdmi.c |  13 -----
 sound/soc/codecs/mt6358.c    | 131 +++++++++++++++++++++++++++----------------
 sound/soc/stm/stm32_i2s.c    |   3 +-
 4 files changed, 87 insertions(+), 64 deletions(-)

--gjqXxLgfq8Ns5vfG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSnzEACgkQJNaLcl1U
h9DH4wgAhdeod7OXekmNgY3OgUBvvsb4bbxYbIF1BkO+EvHh02xhovE+egkYXfWe
EIqP9wwizi8XX90aG3AroeQe6ZICNhAdq9Ns09fVIOWW/xNyOq2UtJiAWF9qy3y3
7yJp5rMmoDSDgGgLO424XkoZ/R/HuMLmvFO4M3ICDjdBIwg7CjFFCm3YO831EXn4
vuKYYlwPkYQWDYRpQmFIZGCSlhBzaWlGU9x2uNIqscfZQ9p6yY+PGzw8r72SAmkQ
zTEH8MXBwLtr3oA0r20VVOaU+e8JBJEj65CMiXqiYWh/y3ce3ks9vSr9e7pP/UTu
YDpJ7vIjM1jioaovv6Z+5fbsLYYCSQ==
=vz6A
-----END PGP SIGNATURE-----

--gjqXxLgfq8Ns5vfG--

--===============2978147015738684841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2978147015738684841==--
