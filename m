From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC core fixes for v3.15
Date: Wed, 14 May 2014 13:00:53 +0100
Message-ID: <20140514120053.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3432252591357512185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B1AF2610A7
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 14:01:06 +0200 (CEST)
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


--===============3432252591357512185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XZjDCPnRdq/pDFBA"
Content-Disposition: inline


--XZjDCPnRdq/pDFBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2697e4fb9209dfe1d1b24c92d254158f63d4bc8e:

  ASoC: dapm: Fix widget double free with auto-disable DAPM kcontrol (2014-04-21 11:49:53 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.15-rc5-core

for you to fetch changes up to cf86197ec5655ed1f54f1f7ba34a01d576e3737d:

  Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus (2014-05-14 12:52:41 +0100)

----------------------------------------------------------------

ASoC: Core fixes for v3.15

A few things here:

 - Fix the creation of spurious CODEC<->CODEC links which caused DAPM to
   have audio paths which shouldn't be present causing spurious powerups
   and potential audible issues for users.
 - Ensure the suspend->off transition doesn't have spurious transitions
   to prepare added to the sequence.
 - Fix incorrect skipping of PCM suspension for active audio streams.
 - Remove Timur Tabi from the CS4270 maintainers, Cirrus are now doing
   this and Timur no longer has the boards that he was using.

----------------------------------------------------------------
Lars-Peter Clausen (2):
      ASoC: dapm: Skip CODEC<->CODEC links in connect_dai_link_widgets()
      ASoC: dapm: Fix SUSPEND -> OFF bias sequence

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus

Nicolin Chen (1):
      ASoC: pcm: Fix incorrect condition check for case SNDRV_PCM_TRIGGER_SUSPEND

Paul Handrigan (1):
      ASoC: Update Cirrus Logic CODEC maintainers.

 MAINTAINERS          |  6 ------
 sound/soc/soc-dapm.c | 14 ++++++++++----
 sound/soc/soc-pcm.c  |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

--XZjDCPnRdq/pDFBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc1ryAAoJELSic+t+oim9me4P/R0Y8l1fdfbJvIAeJnr5k8nl
4ae6iuMakMYYF/mBT10g2QscqB2lYNLjVhnBS5lU0wo+v1/SWl5/fGpzdL1tcr0l
f5yQueO32oP7Nr1RSylEv+u+hTUzypdYde4oqjHFsBxRxaF7MnSVYr1q+yibiTVG
n53u2BSDEC8qZvwiMeMKq0hy9uMCrW8iZOkcHUTRxgUzWcGrcVY+oyPmhvT14LQR
levgaivnbQHcuhI88O48kEQedleGoRgFQrFMLS+xCx7/slMT55ls8SAu2qlJvDbX
Grks4fTg3y9Eif7gqseCHjFNX1rBomWjJFS8FaxaPHK2I8ahfcF6BSSBLkwullbh
UT+FMM9T3ARSTVwyNCG3WT5Wm1QULZpgS9g/TNkFHMEI1/2SEWIlioJTrR8QsPzz
VbqCVHWCVZUF281aQJKTtQFY2eB883X35VpVQtD1ey+UEiG5O4lhrxChjevGNOLc
dPBWk001vmBs7XVRT2FeBID2ZBKOuoykO1IOtEQNU6SdpRHR4bobe5qFLfia3Pyy
2KCl+TLMc78kfyK53GRXI1qgNE0CR0OPkqbTfERyJXeehI+3A49x+u+VktxIhGTr
7EznszNHgGsjqBi10mtgkiHSFjEJr1T5+kC/9pbig9ms0Bl2BCmYOG2prApXyuAL
2cQCAtSqymSvgpOJHo03
=kuy9
-----END PGP SIGNATURE-----

--XZjDCPnRdq/pDFBA--

--===============3432252591357512185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3432252591357512185==--
