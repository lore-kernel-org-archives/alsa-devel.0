From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.0
Date: Tue, 19 Feb 2019 11:18:41 +0000
Message-ID: <20190219111841.GC6319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5702577815684075515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1350C265532
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 12:18:44 +0100 (CET)
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


--===============5702577815684075515==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 860b454c2c0cbda6892954f5cdbbb48931b3c8db:

  ASoC: samsung: Prevent clk_get_rate() calls in atomic context (2019-02-07 14:34:53 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.0-rc6

for you to fetch changes up to 19dd0777773ab17b4d97f7105e836867c0cdecb4:

  ASoC: simple-card: fixup refcount_t underflow (2019-02-18 18:36:52 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.0

A few small fixes, a driver fix for Samsung, a fix for refcounting of
of_nodes in the simple-card driver that triggered on a lot of systems
and a fix for topology error handling.

----------------------------------------------------------------
Bard liao (1):
      ASoC: topology: free created components in tplg load error

Kuninori Morimoto (1):
      ASoC: simple-card: fixup refcount_t underflow

Sylwester Nawrocki (1):
      ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI

 sound/soc/generic/simple-card.c | 2 +-
 sound/soc/samsung/i2s.c         | 8 +++++++-
 sound/soc/soc-topology.c        | 8 +++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxr5hEACgkQJNaLcl1U
h9AjhAgAhXT7IYef3mveVNF03Hslm3jIJJxP0Pw3u9OY/R5M5cjehnlhacdqrJ0F
Sp9YyQIHua/fuYTSQ6L1M4LyGjf7PIG3eH1J0mtYNVbu6+gtSP4OSy9kJyIGex3t
7D/EaF4QFDqczsPUHCyMRJtl+bDg/hv7MMIUuEVXXK4qbdLMYY5EJcvKgNzDfCxB
GmqY1yn9/YRPswkKR1+qjEh7IC/ADfkBndFweqw3dBma2uXmwzQYIgYkWYTjLu5i
4hUb1pCBrnJgDJJgD/aR3DSsSG32/SlUYEav9NM+42itqen5gaVj2kL//IL2wjH6
d7doqNyUodrObGde4/TOLyi9P3t0xw==
=Z+OA
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

--===============5702577815684075515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5702577815684075515==--
