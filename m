From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fix for v5.2
Date: Thu, 9 May 2019 11:23:41 +0900
Message-ID: <20190509022341.GR14916@sirena.org.uk>
References: <20190508094554.GK14916@sirena.org.uk>
 <s5h4l65s0kr.wl-tiwai@suse.de>
 <20190508103150.GP14916@sirena.org.uk>
 <s5h1s19s06b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2365650838745988301=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDD67F807B5
 for <alsa-devel@Alsa-project.org>; Thu,  9 May 2019 04:23:47 +0200 (CEST)
In-Reply-To: <s5h1s19s06b.wl-tiwai@suse.de>
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


--===============2365650838745988301==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FmkfFOZZ61l6O/yn"
Content-Disposition: inline


--FmkfFOZZ61l6O/yn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 12:36:12PM +0200, Takashi Iwai wrote:

> OK, I can reset the repo and re-pull if you want...

The following changes since commit ce38a75089f70f6380fc63a5478a7659b4eb3f47:

  ASoC: SOF: core: fix undefined nocodec reference (2019-05-08 15:42:00 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v5.2-5

for you to fetch changes up to 7f6647ced298d56027218e47619b7f0d925fc83e:

  ASoC: SOF: Fix unused variable warnings (2019-05-09 11:18:57 +0900)

----------------------------------------------------------------
ASoC: Updates for v5.2

Redone to remove the misfiled SPI commit

----------------------------------------------------------------
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

 sound/soc/codecs/hdac_hdmi.c |  13 -----
 sound/soc/codecs/mt6358.c    | 131 +++++++++++++++++++++++++++----------------
 sound/soc/sof/core.c         |   2 +
 sound/soc/stm/stm32_i2s.c    |   3 +-
 4 files changed, 87 insertions(+), 62 deletions(-)

--FmkfFOZZ61l6O/yn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzTjywACgkQJNaLcl1U
h9D0OQf/Wa1L+SEqVhURUB8LiiNkewc4IL5lo2grIL0ZcElC4DSq09uFnvRPDdDY
HQ2Uoo/m6GB4hVvZmaSBroPbj8J67zHS216O46HBD0z818Pr/ZmFNzQq/MSRLHT1
FYcfHpwJ/s4Qv2zB610AUDPFa863E4uGGAHJB15jkLugDebZl6kxs9HJhEuHkl/G
VYPND/JjkNe7a0+CFdPrFAWsGWcd+C2tqqx1uzERzy+HqMoK1zH7jmwna8d1cnXo
dIThfQj8azp0GxLtcaoRKtSjkWC6r0qU7buMf1xCUB9KvNouijEIGkwVraDrjCuD
qfmdv8VbxArEAxwH3AJlQEIX1MyPag==
=gZOj
-----END PGP SIGNATURE-----

--FmkfFOZZ61l6O/yn--

--===============2365650838745988301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2365650838745988301==--
