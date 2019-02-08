From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v5.0
Date: Fri, 8 Feb 2019 12:34:32 +0000
Message-ID: <20190208123432.GC6695@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2484496450989351809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ABCA5267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 13:34:35 +0100 (CET)
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


--===============2484496450989351809==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cb79ef9c6c4413427cd70afbb1f3bc01e9b7abf:

  ASoC: amd: Fix potential NULL pointer dereference (2019-01-15 19:06:23 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v5.0-rc5

for you to fetch changes up to 860b454c2c0cbda6892954f5cdbbb48931b3c8db:

  ASoC: samsung: Prevent clk_get_rate() calls in atomic context (2019-02-07 14:34:53 +0000)

----------------------------------------------------------------
ASoC: Fixes for v5.0

A selection of driver specific fixes here, along with a few core fixes:

 - A fixup for some MFD devices that were broken by the previous fixes
   for deferred probe.
 - A fix for potential out of bounds array accesses when ordering DAPM
   power/up down sequences.
 - Avoid use after free issue when unloading and reloading drivers using
   topologies.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: core: Allow soc_find_component lookups to match parent of_node

Fabio Estevam (1):
      ASoC: MAINTAINERS: fsl: Change Fabio's email address

Guennadi Liakhovetski (1):
      ASoC: topology: fix oops/use-after-free case with dai driver

Jiada Wang (1):
      ASoC: rsnd: ssiu: correct shift bit for ssiu9

Kuninori Morimoto (2):
      ASoC: rsnd: fixup MIX kctrl registration
      ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check

Pierre-Louis Bossart (1):
      ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables

Russell King (1):
      ASoC: hdmi-codec: fix oops on re-probe

Shuming Fan (1):
      ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter

Sylwester Nawrocki (1):
      ASoC: samsung: Prevent clk_get_rate() calls in atomic context

 MAINTAINERS                   |  4 ++--
 sound/soc/codecs/hdmi-codec.c |  4 ++--
 sound/soc/codecs/rt5682.c     |  2 ++
 sound/soc/samsung/i2s.c       | 10 +++++-----
 sound/soc/sh/rcar/core.c      |  8 ++++----
 sound/soc/sh/rcar/ssi.c       |  2 +-
 sound/soc/sh/rcar/ssiu.c      |  2 +-
 sound/soc/soc-core.c          |  9 +++++++--
 sound/soc/soc-dapm.c          | 24 ++++++++++++++++++++++++
 sound/soc/soc-topology.c      |  5 +++++
 10 files changed, 53 insertions(+), 17 deletions(-)

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdd1gACgkQJNaLcl1U
h9DFYgf/eiS58WkUJhALwAKOjgds64dY35Tk4Tb5e4n3FmEnh3JGayZ2ZfRZCIes
uyA3fzXoliZ0TXaWJvVvylFCt0ON87CcIdCw1gpNCPJznW8+aOnE8hOZkd9AdH2C
p/HK6skk6/H7Gl508pnxjFC1KOi3zP7Kkl0a4N2FXbqQ0AdkgAdJcGXni/48lCxj
SePd8Fv+sa9OWX9nMpVhBE/P1hPCz/hNyajuU1J6TRkSIRT4L+t2SLzwVLGvehpe
jgLwwwmiGmTKGEIW5bG0q6n8Es06sUd7k7Qr8YaMb8YeveULRzD0IMBFc4A3WTpR
89QfXMJANkbaUbvC8pvzwssqum6vUg==
=8fq+
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============2484496450989351809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2484496450989351809==--
