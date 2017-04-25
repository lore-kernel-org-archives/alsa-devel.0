From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v4.11
Date: Tue, 25 Apr 2017 16:31:35 +0100
Message-ID: <20170425153135.4f274gnidplwb5ks@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6730928437652273772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 41603266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 17:31:45 +0200 (CEST)
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


--===============6730928437652273772==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hq4h5hjgcf7326tx"
Content-Disposition: inline


--hq4h5hjgcf7326tx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v4.11-rc7

for you to fetch changes up to dc9617cb81c4130858b6dd026039f42a39e93c18:

  Merge remote-tracking branches 'asoc/fix/intel', 'asoc/fix/topology' and 'asoc/fix/sti' into asoc-linus (2017-04-25 16:25:07 +0100)

----------------------------------------------------------------
ASoC: Fixes for v4.11

A few last minute fixes for v4.11, the STI fix is relatively large but
driver specific and has been cooking in -next for a little while now:

 - A fix from Takashi for some suspend/resume related crashes in the
   Intel drivers.
 - A fix from Mousumi Jana for issues with incorrectly created
   enumeration controls generated from topology files which could cause
   problems for userspace.
 - Fixes from Arnaud Pouliquen for some crashes due to races with the
   interrupt handler in the STI driver.

----------------------------------------------------------------
Arnaud Pouliquen (2):
      ASoC: STI: Fix reader substream pointer set
      ASoC: STI: Fix null ptr deference in IRQ handler

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/intel', 'asoc/fix/topology' and 'asoc/fix/sti' into asoc-linus

Mousumi Jana (1):
      ASoC: topology: Fix to store enum text values

Takashi Iwai (1):
      ASoC: intel: Fix PM and non-atomic crash in bytcr drivers

 sound/soc/intel/boards/bytcr_rt5640.c |  4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c |  2 --
 sound/soc/soc-topology.c              |  1 +
 sound/soc/sti/uniperif.h              |  1 +
 sound/soc/sti/uniperif_player.c       | 35 ++++++++++++++++++++++++-----------
 sound/soc/sti/uniperif_reader.c       | 27 +++++++++++++++++++++++----
 6 files changed, 51 insertions(+), 19 deletions(-)

--hq4h5hjgcf7326tx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj/a9YACgkQJNaLcl1U
h9DLcQf9GsEwB+gF7y/ipp5u4Co8dtzSA5DfqZaaaQ2eLjFNLp5t7picmTNvpPFk
FO7f9hCZArWL090YhcRcvlX+RxtYhppi3dA4SpKP1GSCdOE+yOnT6T9pDqqurNA8
Duak4lM8bTqkmXhShyriUJZtzDjEshgRaz9MeqsF4X9AvCT99IBrkOvPQVQLIhb9
SSgoNSb5Dd53RbB5RzujIM2ou45Av1DrjOsGXJqsvVH9DEzyASCZOMmqDT2XYyk/
+CKGGH3RT0FmpM5uFOd3B1gxQXUYoOZ83wVCjELIAktx3CjOiUKtgXKNxn56Eg0U
cps3o+JVzuBxPLApypU1ULH6AHghkA==
=PypC
-----END PGP SIGNATURE-----

--hq4h5hjgcf7326tx--

--===============6730928437652273772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6730928437652273772==--
